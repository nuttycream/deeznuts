+++
title = "Observing through shmem()"
description = "IPC? I pee C as well, thank you very much. My first foray into IPC and shared memory to track interal changes."
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

# The Plan

Now, I already learned a thing or two while drafting up my initial
[pipin](https://github.com/nuttycream/pipin) web server, so I could at least use
that as a foundation for this specific project.

First of all, the entire program including the front end should be
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

I'm doing raw JavaScript this time around since I don't want to deal with with
the HTMX stuff I had to write through in the pipin project.

```
.
├── Cargo.lock
├── Cargo.toml
└── src
    ├── assets
    │   ├── index.html
    │   ├── script.js
    │   └── style.css
    ├── main.rs
    └── sound.rs
```

# Shared Memory

TODO

In C

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

# ALSA and Cross-Compiling

TODO

# As a system daemon

TODO

# Attribution

- [axum](https://github.com/tokio-rs/axum)
- [pipin](https://github.com/nuttycream/pipin)
