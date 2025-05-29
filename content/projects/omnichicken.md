+++
title = "omnichicken"
description = "Raspberry Pi powered three-wheeled omni-directional, line following, obstacle avoidance + obstacle tracking robot"
date = "2025-04-30"

[taxonomies]
tags = ["c", "gpio", "omni-directional", "raspberry pi", "ipc", "chicken", "minecraft"]
+++

# [The Omni Chicken](https://github.com/nuttycream/omnibot)

A Raspberry Pi-powered three-wheeled omnidirectional, line following, obstacle
avoidance + obstacle tracking robot

<p align="center">
<img src="/images/chicken.jpg" alt="chicken" style="width: 50%;">
</p>

## Meet the team

While we are all programmers, and this is by all means a programming computer
science course, we all specialize in certain aspects. This is why I strongly
believe we worked so well together because we complemented each other's skill
sets and specializations.

- [Shoaib Perouz](https://www.linkedin.com/in/shoaib-perouz-769329a/)
  ([GitHub](https://github.com/sperouz)) - engineer
- [Yuquan Xu](https://www.linkedin.com/in/yuquan-xu-846852149/)
  ([GitHub](https://github.com/yyyuquan)) - physics
- [Bryan Yao](www.linkedin.com) ([GitHub](https://github.com/bryao)) - 3d
  modeler/designer
- [John Carter](https://www.linkedin.com/in/john-carter-from-mars)
  ([GitHub](https://github.com/nuttycream)) - programmer

## But why?

This all started as a group project for our Embedded Linux programming class by
SFSU's best professor, Robert Bierman! We got to work by brainstorming a bunch
of ideas for this robot, specifically on the type of movement we would use, and
Some of the more notable ideas were:

- 4-legged spider
- bipedal walking humanoid
- Two-wheeled self-balancing humanoid
- crab
- snake

We finally settled on a three-wheeled omnidirectional robot HEAVILY inspired
from this video by [maker.moekoe](https://www.youtube.com/@makermoekoe):

{{ youtube(id="OIdMkZyhx7E")}}

This design was not only fairly simple (at least on the surface) but also never
been done in our Professor's class yet.

You see, while the Professor planned to give extra points to those who could
finish the fastest, there were some things that I was wary of if we were to go
for speed:

1. The track was laid out in a cloth, making grip difficult (especially with our
   wheels)
2. The ground was also uneven, with too many bumps and debris that may launch
   our bot Up if we go too fast
3. and lastly, there was another group, a VERY VERY talented group who were
   aiming to have the fastest time.

And while I'm confident in my team and my abilities, attempting to be the
fastest just posed too many uncontrolled variables. So we changed direction...

Instead of being the fastest, we chose to be the flashiest! The silliest, yet
still functional robot. We wanted to make an impact, but not by being the
fastest, but by just being different. So we stuck to our 3-wheeled
omnidirectional design, and started coming up with ideas on the shell and how we
can make it even cooler!

> I also learned later on that the Professor gives extra points for creativity!

## Design

Ambitions were high for our initial design. The main idea we had to work around
was a three-wheeled omnidirectional robot. Here are some of Yuquan's sketches:

<p align="center">
<img src="/images/Omni-Cake_1.png" alt="chicken" style="width: 75%;">
</p>

This is the very first instance of the bot that we drew up in class. Aptly
nicknamed the omni-cake, because of our idea of sandwiching components in
between layers. This served as an initial design idea, along with where to mount
the sensors, motors, pi along with its components, and how it would traverse.

<p align="center">
<img src="/images/615_Final_Proj.PNG" alt="chicken" style="width: 75%;">
</p>

As you can see, we initially thought of going for a Da Vinci Tank, which seemed
like the most ergonomic and simplest design. It was balanced and could fit all
of the components pretty neatly.

Another suggestion, by yours truly, was to make it similar to the shape of a...
Yeah, you'll see here in a moment.

<p align="center">
<img src="/images/615_Final_Proj_2.PNG" alt="chicken" style="width: 75%;">
</p>

Note the top left one, yeah, that was my suggestion. And as you probably already
know we did not choose that.

However, from Yuquan's extra doodles, he created something that caught our eye:
The Minecraft chicken (and also the robot head). An amazing and hilarious idea
because of both the recent popular Minecraft movie and the arguably even more
popular dumb [chicken jockey meme](https://www.youtube.com/watch?v=EY4h38NaXwU).
This has now become our main design goal, and something we want to fully commit
to.

> Shoaib didn't know we were serious about the chicken until we were a month
> into our project XD

### Version 0.5

<p align="center">
<img src="/images/20250415_161605.jpg" alt="chicken" style="width: 50%;">
</p>

Our very first build, all parts were sourced by Shoaib and assembled by him. His
design was meant to be a prototype but was ultimately used as a base for the
overall robot. Note the mechanum omni wheels. Because they weren't true
omnidirectional wheels, they were a major headache for us. It's a cute little
thing, though.

### Version 1

<p align="center">
<img src="/images/IMG_0100.jpg" alt="chicken" style="width: 25%;">
<img src="/images/IMG_0101.jpg" alt="chicken" style="width: 25%;">
</p>

Version 1, parts added by Shoaib to include the raspberry pi top plate,
effectively making a _cake_. This 3 plate design carried us pretty far, but it
started to become pretty heavy and constrained in terms of space and structural
rigidity. So we had to get a little _creative_ in terms of how the components
and wiring it all up.

### True Omni-Wheels

<p align="center">
<img src="/images/IMG_5158.jpg" alt="chicken" style="width: 25%;">
<img src="/images/image-5.png" alt="chicken" style="width: 35%;">
</p>

Bryan managed to find some **true** omnidirectional wheels, sourced from
[robotics](https://robot.com) supplier, which initially cost ~60 bucks for three
wheels. But because of the tariffs, the price ballooned to 100 USD. They were at
least kind enough to also provide 3D models of them.

### 3D Printed Chicken Body

<p align="center">
<img src="/images/chicken-body.jpg" alt="chicken" style="width: 35%;">
</p>

Professor Bierman gave every group a chance to have 3D parts printed. And
because we're pretty damn greedy, we took up a decent amount of both material,
and time to have our LARGE chicken body printed. The total cost of the print was
around ~$30. But Professor Bierman gave it to us for free! Which was honestly a
pretty sweet deal considering how big and how long it took to print.

### Version 2

<p align="center">
<img src="/images/20250513_202837.jpg" alt="chicken" style="width: 50%;">
</p>

Now... I know what you're thinking... That's a whole lotta wires! But trust me,
it's completely functional. Cable management is not our specialty, but cleaning
it all up could come later. At this point, the bot was completely functional; it
was missing some _optional_ features that I wanted to implement, but it could
line-follow and avoid an obstacle at this point in our project.

## Physics

Physics was mainly handled by our resident genius, Bryan. He came up with not
only the math needed for vector direction control, but he analyzed and took
direct inspiration from actual [research papers](#attribution) so we can have
proper 3-wheeled omnidirectional traversal.

<p align="center">
<img src="/images/image-3.png" alt="chicken" style="width: 25%;">
<img src="/images/image-4.png" alt="chicken" style="width: 25%;">
</p>

Initial sketches for obstacle tracking. Our initial idea was to essentially
'encircle' the obstacle by strafing around it, keeping the robot's front facing
the object the entire time. On the surface, it sounds pretty easy, right? Just
set a point in front of the robot and traverse around it. But in reality, it's
not so easy...

## The Code

Note that I consider myself a huge programming noob which is especially true
with C, so I won't be able to explain a lot of the technical stuff in a good
way, but I'll try my best.

My design philosophy for how I wanna go about this boils down to:

- Robust: kill on panic, handle errors gracefully, zero (no promises) memory
  leaks
- Modular: plug and play, use previous assignments, can operate independently of
  one another
- Readable: should be able to understand code with minimal documentation
- Easily Modifiable:
  - [Flat directory structure](https://i.imgur.com/rMWmbyc.png): no directory
    hierarchy
  - Can jump around relatively quickly within Neovim

In terms of the architecture, I've made this initial diagram to help when we
First started to program it:

<p align="center">
<img src="/images/excalidraw-architecture.png" alt="chicken" style="width: 75%;">
    <br>
Note: This diagram is from an older design that's missing a decent amount of 'modules'
</p>

The C program, nicknamed omnibot, manages the whole thing, the control surfaces,
sensor reading, and the whole shebang. That Rust part you see will be touched on
[later](#shared-memory).

### GPIO Library

My first goal was to create a robust GPIO library based on a
[Raspberry Pi DRA example](https://elinux.org/RPi_GPIO_Code_Samples#Direct_register_access)
I've been using it from my previous assignments. Modifying this, I got rid of
all the preprocessor macros - mainly because they were quite frankly unreadable
for me in that syntax, which is rich coming from a Rust enjoyer.

Wrapping those macros into **more** useful functions:

```c
extern int setup_gpio();
extern int terminate_gpio();
extern int toggle_gpio(int gpio_pin); // helper function for quick toggling
extern int set_gpio_level(int gpio_pin, int gpio_level);
extern int get_gpio_level(int gpio_pin);
extern int set_gpio_pull(int gpio_pin, int pull_level);
```

Now... I'm gonna be honest, it does not completely look like above, and we
currently have some redundant functions like `set_gpio_inp/set_gpio_out`. And
yes, I can probably switch those right now... but I haven't done that here yet,
and only did it for my [Rust rewrite](https://github.com/nuttycream/pipin).

In terms of readability, I kinda wish C had the pattern matching Rust had. But
For the sake of not overcomplicating the code, I just wrote a utility functions
like `validate_gpio_pin` for robustness(?).

Also, I did not realize I wasn't supposed to be using `/dev/mem`, which requires
`sudo` level access and manually specifying the GPIO address. After learning
from this
[pi forums post](https://forums.raspberrypi.com/viewtopic.php?t=167446), I
switched to `/dev/gpiomem`, and got rid of a function that would look for the
device address.

From this:

```c
int find_gpio_addr() {
    // cat /proc/iomem | grep gpio
    // ....
}

int setup_gpio() {
    int gpio_addr = find_gpio_addr();

    if ((mem_fd = open("/dev/mem", O_RDWR | O_SYNC)) < 0) {
        // ...
    }

    gpio_map = mmap(
        NULL,                   // Any address in our space will do
        BLOCK_SIZE,             // Map length
        PROT_READ | PROT_WRITE, // Enable reading & writting to mapped memory
        MAP_SHARED,             // Shared with other processes
        mem_fd,                 // File to map
        gpio_addr
    );
    // ....
}
```

To:

```c
// no longer need find_gpio_addr
int setup_gpio() {
    if (fd = open("/dev/gpiomem", O_RDWR | O_SYNC) < 0) {
        // ...
    }

    gpio_map = mmap(
        NULL,                   // Any address in our space will do
        BLOCK_SIZE,             // Map length
        PROT_READ | PROT_WRITE, // Enable reading & writting to mapped memory
        MAP_SHARED,             // Shared with other processes
        mem_fd,                 // File to map
        0                       // GPIO address location
    );
    // ....
}
```

Which felt cleaner, and overall much safer in terms of giving the program `sudo`
level access to `/dev/mem`.

### Multi Modal

One of the architectural design decisions I came up with was to have multiple
modes for not only the bot itself, but also obstacle modes, sensor modes, and
traversal modes.

Switching between these modes was handled by a multithreaded terminal controller
`term.h` that modified the [shared memory struct](#shared-memory). (I honestly
don't know if this is a good idea, but it seems to work, so
[wynaut](https://pokemondb.net/pokedex/wynaut)?)

Here are what they look like:

```c
// 0 -> line following
// 1 -> obstacle mode
// 2 -> manual control
// 3 -> wander mode
int bot_mode;

// 0 -> obstacle tracking
// 1 -> obstacle avoidance
int obstacle_mode;

// 0 -> four sensor mapped logic
// 1 -> five sensor weighted average
// 2 -> two sensor simple mode
int sensor_mode;
```

### Reading from Sensors

Reading from sensor data is multithreaded, and will continue while the main
thread (where all the logic and mode handling is). Reading from sensors is
pretty trivial, and making it multi-threaded is not that hard if I may say so
myself.

```c
// 0 - no
// 1 - yes
extern volatile int go_left;
extern volatile int go_right;
extern volatile int found_line;

extern volatile int obstacle_detected;

void *detect_obstacle(void *args);
void *detect_line(void *args);
```

### Shared Memory

Remember the Rust web server in the architecture diagram? Yeah, so I decided to
have some EXTRA bit of fun and create a web server that can monitor the status
of the bot while it was running and doing _bot stuff_. I did a fair amount of
research to try and find the most optimal way to communicate between the C
program and the Rust web server. I went through the rabbit hole of
[ipc](https://en.wikipedia.org/wiki/Inter-process_communication). From Unix
sockets and message queues, the most straightforward to me was
[shared memory](https://en.wikipedia.org/wiki/Shared_memory). Since it used
[mmap](https://www.man7.org/linux/man-pages/man2/mmap.2.html), and I've already
somewhat learned about how to use `mmap` from my work on modifying the GPIO
direct registry access library.

<p align="center">
<img src="/images/image.png" alt="chicken" style="width: 50%;">
</p>

There's probably a more optimal way of doing shared memory, but for the sake of
my sanity, I went with a simple option to just throw everything in a struct to
pass around. What that looks like:

In C:

```c
typedef struct {
    int ver;
    in direction;
    int motor_power[3];
    int bot_mode;
    int obstacle;
    int obstacle_mode;
    int go_left;
    int go_right;
    int sensor_mode;
    int sensors[5];
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

Lucky for me, shared memory on Rust is pretty straightforward, there exists a
[crate](https://github.com/elast0ny/shared_memory) just for it, which I'm pretty
sure uses the [*nix](https://github.com/nix-rust/nix) and
[libc](https://github.com/rust-lang/libc) crates for Linux-specific sys calls
like mmap().

To read more about how the Rust side works, you can take a gander at this
[project post](/projects/omniscient), where I go somewhat more in-depth.

## Attribution

- [Raspberry Pi GPIO C DRA Example](https://elinux.org/RPi_GPIO_Code_Samples#Direct_register_access) -
  used as a basis for a custom GPIO C library
- [WaveShare Motor Driver Hat Demo](https://www.waveshare.com/motor-driver-hat.htm) -
  used for I2C and PWM functionality
- [Three-Omnidirectional Wheels with PID](https://github.com/Said-taoussi/Three-Omnidirectional-Wheels-with-PID-Control) -
  used as a cross-reference for PID controls
- [3-wheel-omni Vectoring Arduino Example](https://github.com/manav20/3-wheel-omni/blob/master/Vectoring/Vectoring.ino) -
  used as a cross-reference for vector calculations
