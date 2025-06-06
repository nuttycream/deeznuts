+++
title = "Creating an observer web application through shmem()"
description = "IPC? I pee C as well, thank you very much. My first foray into IPC and shared memory to monitor a Raspberry Pi robot."
date = "2025-06-06"

[taxonomies]
tags = ["c", "rust", "axum", "shared memory", "raspberry pi", "ipc"]
+++

# Preface

[Omniscient](https://github.com/nuttycream/omniscient) is a relatively small
project, but a project I learned A LOT from. Specifically, how
[IPC (Interprocess Communication Works)](https://en.wikipedia.org/wiki/Inter-process_communication)
and Linux `shmem()` - shared memory works.

This started because I wanted to do something **EXTRA** for the programming
portion of me and my group's [omnichicken](/posts/my-academic-magnum-opus).

So I had a bright idea to create something ridiculously complex and unneeded - a
self-contained observer for the robot where I can monitor what the robot is
doing at a given moment.

# Front-End Overview

Now, I already learned a thing or two while drafting up my initial
[pipin](https://github.com/nuttycream/pipin) web server, so I could at least use
that as a foundation for this specific project.

First of all, the entire program including the front-end should be
self-contained - as in, you wouldn't need to reference a separate front-end,
where ever the binary goes the entire program with it, web server and all.

I can do this relatively easy in Axum like so:

```rust
async fn serve_html() -> Html<&'static str> {
    let html = include_str!("./assets/index.html");
    Html(html)
}
```

Repeat that process for any other assets I want to _embed_: `styles.css`, and
`script.js`.

From what I gather, this pretty much converts whatever is passed inside the
`include_str!()` macro into a string literal during comp-time. The string is
then rendered based on whatever `header::CONTENT_TYPE` we set to.

For the `serve_html()` function above, it's already a built-in from Axum so it
can literally just infer that specific content type. For others however, I need
to specify the content type as well as return with a `IntoResponse` trait.

```rust
async fn serve_js() -> impl IntoResponse {
    let js = include_str!("./assets/script.js");
    ([(header::CONTENT_TYPE, "application/javascript")], js)
}
```

Also, I'm doing raw JavaScript this time around since I don't want to deal with
the HTMX stuff I had to wad through in the pipin project. That means I'll be
processing `JSON` instead, which in my opinion is much easier, especially with
[serde_json](https://github.com/serde-rs/json).

Setting up the WebSocket client for the front-end JavaScript side was pretty
trivial. There's a crap ton of tutorials out there and I went with the
relatively simple
[Mozilla Dev Docs](https://developer.mozilla.org/en-US/docs/Web/API/WebSockets_API/Writing_WebSocket_client_applications).
Client connection looked like so:

```javascript
const protocol = window.location.protocol === "https:" ? "wss:" : "ws:";
const ws_url = `${protocol}//${window.location.host}/ws`;

socket = new WebSocket(ws_url);

socket.addEventListener("open", (_) => {
  console.log("Connected to WebSocket server");
});

socket.addEventListener("message", (event) => {
  const message = event.data;
  process_msg(message);
});

socket.addEventListener("close", (_) => {
  console.log("Disconnected from WebSocket server");
});
```

It was extremely straightforward in terms of the JavaScript receiving side, I'll
go over the sending side (Rust back-end) later on. But I basically get a giant
blob of `JSON` and just parse that message, it's as simple as:

```javascript
const data = JSON.parse(msg);

document.getElementById("mem").textContent = data.shared_mem;
document.getElementById("bot-mode").textContent = data.bot_mode;
// repeat for the other important data ...
```

## UI/UX

I initially drafted the UI in [Excalidraw](https://excalidraw.com) to get a good
idea of how I wanted the layout to look. Something like this:

<p align="center">
    <img src="/images/omniscient.png" alt="omni" style="width: 70%;">
</p>

Creating a circle was pretty simple, there's hordes of tutorials online but it's
pretty much just `border-radius: 50%`:

```css
circle {
  width: 400px;
  height: 400px;
  border: 3px solid var(--border);
  border-radius: 50%;
  position: relative;
  background-color: darkgray;
}
```

Positioning all of it was a doozy though since changing the CSS would involve a
recompile - since they are embedded into the program itself as strings at
comp-time.

The final result looked something like this:

<p align="center">
    <img src="https://camo.githubusercontent.com/0a86b7462b79d420c774f20d4db1a106fbb4955aefb3edb9499d2535e1853caa/68747470733a2f2f692e696d6775722e636f6d2f476c4a776174632e706e67" alt="omni" style="width: 70%;">
</p>

There was very little interactivity, in fact there's only one button in the
entire UI - and that was for toggling the chicken sounds. This was intentional,
because as you may remember, this web server is only meant to **observe** the
robot, not actually control it.

# IPC

Here's the meaty part, the shared memory and how the C code will interact with
the Rust code. Or should I say not interact at all as the shared memory will be
the data that the C will write to and the Rust will read from.

At first, I didn't really know what type of IPC I wanted to try for this
project, the usual suspects were `unix sockets`, `message queues`, and
`shared memory`. Ultimately, I went with shared memory because it seemed the
fastest, and the most straight forward (at least in my head). Just reserve some
spot of memory, mark it as specific to ours, write to it and then read from it
whenever there are new updates. Seems easy enough right?

Here's what that shared memory struct looks like in both languages:

```c
typedef struct {
    int ver;
    int direction;
    int motor_power[3];
    int bot_mode;
    int obstacle;
    int go_left;
    int go_right;
    int sensor_mode;
    int sensors[4];
} Shared;
```

In Rust:

```rust
#[repr(C)]
#[derive(Debug, Clone, Copy)]
struct Shared {
    ver: i32,
    direction: i32,
    motor_power: [i32; 3],
    bot_mode: i32,
    obstacle: i32,
    obstacle_mode: i32,
    go_left: i32,
    go_right: i32,
    sensor_mode: i32,
    sensors: [i32; 5],
}
```

The key part is the `#[repr(c)]` which from the
[docs](https://doc.rust-lang.org/nomicon/other-reprs.html) basically say: _"It
has a fairly simple intent: do what C does"_. And though I'm not using an FFI
here, having the same order, size, and type padding for fields is probably a
really good thing when accessing that same piece of memory that the C code
writes to.

### Writing the Shared Memory in C

{% note(clickable=true, hidden=true, header="Expand To View") %}

```c
int create_shared(Shared *shared) {
    int fd = shm_open(MEM_NAME, O_CREAT | O_RDWR, 0644);
    if (fd < 0) {
        fprintf(stderr, "error: failed to shmmmopen\n");
        return -1;
    }

    if (ftruncate(fd, MEM_SIZE)) {
        fprintf(stderr, "error: failed to ftruncate\n");
        close(fd);
        return -1;
    }

    void *mem = mmap(NULL, MEM_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    if (mem == MAP_FAILED) {
        fprintf(stderr, "error: mmap shared\n");
        close(fd);
        return -1;
    }

    memcpy(mem, shared, MEM_SIZE);

    return fd;
}

int update_shared(int fd, Shared *shared) {
    void *mem = mmap(NULL, MEM_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    if (mem == MAP_FAILED) {
        fprintf(stderr, "error: mmap failed\n");
        return -1;
    }

    shared->ver++;

    memcpy(mem, shared, MEM_SIZE);

    if (munmap(mem, MEM_SIZE) != 0) {
        fprintf(stderr, "error: munmap failed\n");
        return -1;
    }

    return 0;
}

int terminate_shared(int fd) {
    close(fd);
    return shm_unlink(MEM_NAME);
}
```

{% end %}

Example usage:

```c
Shared shared = {
    .ver = 0,
    .direction = -1,
    // ...
};

shared_fd = create_shared(&shared);

// updating it
update_shared(shared_fd, &shared);
```

## Reading the Shared Memory in Rust

```rust
fn open_shared_mem() -> Result<Shmem, Box<dyn Error>> {
    let mem = ShmemConf::new()
        .os_id("omnigod")
        .size(size_of::<Shared>())
        .open()?;

    Ok(mem)
}

fn read_shared_mem(mem: &Shmem) -> Shared {
    let ptr = mem.as_ptr() as *const Shared;
    unsafe { ptr.read() }
}
```

# ALSA and Cross-Compiling

TODO

# As a system daemon

TODO

# Attribution

- [axum](https://github.com/tokio-rs/axum)
- [pipin](https://github.com/nuttycream/pipin)
- [websockets](https://developer.mozilla.org/en-US/docs/Web/API/WebSocket)
- [ipc wikipedia](https://en.wikipedia.org/wiki/Inter-process_communication)
- [man shm_open](https://www.man7.org/linux/man-pages/man3/shm_open.3.html)
- [posix shared memory api](https://www.geeksforgeeks.org/posix-shared-memory-api/)
