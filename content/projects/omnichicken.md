+++
title = "omnichicken"
description = "Raspberry Pi powered three-wheeled omni-directional, line following, obstacle avoidance + obstacle tracking robot"
date = "2025-04-30"

[taxonomies]
tags = ["c", "gpio", "omni-directional", "raspberry pi", "ipc", "chicken", "minecraft", "jockey", "jack black", "steve"]
+++

# [The Omni Chicken](https://github.com/nuttycream/omnibot)

A Raspberry Pi powered three-wheeled omni-directional, line following, obstacle
avoidance + obstacle tracking robot

<p align="center">
<img src="/images/PXL_20250514_000958905.jpg" alt="chicken" style="width: 50%;">
</p>

## Meet the team

While we are all programmers, and this is technically a programming computer
science course, we all specialized in certain aspects. And this is why I we
worked well together and complimented each other's skills.

- [Shoaib Perouz](https://linkedin.com) ([GitHub](https://github.com/sperouz)) -
  engineer
- [Yuquan Xu](www.linkedin.com) ([GitHub](https://github.com/yyyuquan)) -
  physics
- [Bryan Yao](www.linkedin.com) ([GitHub](https://github.com/bryao)) - 3d
  modeler/designer
- [John Carter](www.linkedin.com/in/john-carter-from-mars)
  ([GitHub](https://github.com/nuttycream)) - programmer

## But why?

This all started as a group project for our Embedded Linux programming class by
SFSU's best professor, Robert Bierman! We got to work by brainstorming a bunch
of ideas for this robot, specifically on the type of movement we would use and
some of the more notable ideas are:

- 4 legged spider
- bipedal walking humanoid
- two wheeled self balancing humanoid
- crab
- snake

We finally settled on a three-wheeled omnidirectional robot HEAVILY inspired by
this video by [maker.moekoe](https://www.youtube.com/@makermoekoe):

{{ youtube(id="OIdMkZyhx7E")}}

This design was not only fairly unique in the hobby space (at least from what
I've seen) but also never been done in our Professor's class yet.

You see, while the Professor planned to give extra points on who can finish the
fastest, there was a some things that I was weary off if we were to go for
speed:

1. the track was laid out in cloth making grip difficult (especially with our
   wheels)
2. the ground was also uneven, too many bumps and debris that may launch our bot
   up if we go to fast
3. and lastly, there was another group, a VERY VERY talented group who were
   aiming to have the fastest time.

And while I'm confident in my team and my own abilities, attempting to be the
fastest just posed too many uncontrolled variables. So we changed direction...

Instead of being the fastest, we chose to be the most flashiest! The silliest,
yet still functional robot. We wanted to make an impact but not by being the
fastest, but by just being different. So we stuck to our 3-wheeled
omnidirectional design, and started coming up with ideas on the shell and how we
can make it even cooler!

## Design

Ambitions were high for our initial design. The main idea we had to work around
was a three-wheeled omni-directional robot. Here are some of Yuquan's sketches:

<p align="center">
<img src="/images/Omni-Cake_1.png" alt="chicken" style="width: 75%;">
</p>

This is the very first instance of the bot that we drew up in class. Aptly
nicknamed the omni-cake, because of our idea of sandwiching components in
between layers. This served as an initial design idea, along with where to mount
the sensors, motors, pi along with its components, and how it would traverse.

<p align="center">
<img src="/images/615_Final_Proj.webp" alt="chicken" style="width: 75%;">
</p>

As you can see we initially thought of going for a Da Vinci Tank, it seemed like
the most ergonomic and simplest design. It was balanced, and can fit all of
components pretty neatly.

Another suggestion, by yours truly, was to make it similar to the shape of a...
yeah you'll see here in a moment.

<p align="center">
<img src="/images/615_Final_Proj_2.webp" alt="chicken" style="width: 75%;">
</p>

Note the top left one, yea, that was my suggestion. And as you probably already
know we DEFINITELY did not choose that.

However, from Yuquan's extra doodles, he created something that caught our eye,
the Minecraft chicken (and also the robot head). An amazing and hilarious idea
because of both the recent popular Minecraft movie and the arguably even more
popular dumb [chicken jockey meme](https://www.youtube.com/watch?v=EY4h38NaXwU).
This now became our main design goal, and something we want to fully commit to.

`Note: Shoaib didn't know we were serious about the chicken until the last 3 weeks XD`

### Version 1

<p align="center">
<img src="/images/IMG_0100.jpg" alt="chicken" style="width: 25%;">
<img src="/images/IMG_0101.jpg" alt="chicken" style="width: 25%;">
</p>

Version 1, all parts were sourced by Shoaib and assembled by him. His design was
meant to be a prototype but was ultimately used as a base for overall robot.
Note the mechanum omni wheels. Because they weren't true omnidirectional wheels,
they were a major headache for us. It's a cute little thing though.

### True Omni-Wheels

<p align="center">
<img src="/images/IMG_5158.jpg" alt="chicken" style="width: 25%;">
<img src="/images/image-5.png" alt="chicken" style="width: 35%;">
</p>

Bryan managed to find some TRUE omnidirectional wheels, sourced from
[robotics](https://robot.com) supplier, it initially costed ~60 bucks for three
wheels. But because of the tariffs made the price balloon up to 100 USD. They
were at least kind enough to also provide 3D models of them.

### 3D Printed Chicken Body

<p align="center">
<img src="/images/chicken-body.jpg" alt="chicken" style="width: 35%;">
</p>

Professor Bierman, gave every group a chance to have 3D parts printed. And
because we're pretty damn greedy, we took up a decent amount of both material,
and time to have our LARGE chicken body printed.

## Physics

Physics was mainly handled by our resident genius Bryan. He came up with not
only the math needed for vector direction control, but he analyzed and took
direct inspiration from actual [research papers](#attribution) so we can have
proper 3 wheeled omnidirectional traversal.

<p align="center">
<img src="/images/image-3.png" alt="chicken" style="width: 25%;">
<img src="/images/image-4.png" alt="chicken" style="width: 25%;">
</p>

Initial sketches for obstacle tracking. Our initial idea was to essentially
'encircle' the obstacle by strafing around it, keeping the robot's front facing
the object the entire time. On the surface, it sound pretty easy right? Just set
a point in front of the robot and traverse around it. But in reality, it's not
so easy...

### Vectoring

### Obstacle Tracking

## The Code

Note that I consider myself a huge programming noob which is especially true
with C, so I won't be able to explain a lot of the technical stuff in a good
way, but I'll try my best.

My design philosophy for how I wanna go about this boils down to:

- Robust: kill on panic, handle errors gracefully, minimal (at the very least)
  memory leaks
- Modular: plug and play, use previous assignments, can operate independent of
  one another
- Readable: should be able to understand code with minimal documentation
- Easily Modifiable:
  - [Flat directory structure](https://i.imgur.com/rMWmbyc.png): no directory
    hierarchy
  - Can jump around relatively quickly with neovim

In terms of the architecture, I've made this neat little diagram to help when we
first started to program it:

<p align="center">
<img src="/images/excalidraw-architecture.png" alt="chicken" style="width: 75%;">
    <br>
Note: this diagram is from an older design that's missing a decent amount of 'modules'
</p>

The C program, nicknamed omnibot manages the whole thing, the control surfaces,
sensor reading, the whole shebang. That Rust part you see will be touched on
[later](#shared-memory).

### GPIO Library

My first goal was to create a robust GPIO library based on a
[Raspberry Pi DRA example](https://elinux.org/RPi_GPIO_Code_Samples#Direct_register_access)
I've been using from my previous assignments. Modifying this, I got rid of all
the preprocessor macros - mainly because they were quite frankly unreadable for
me in that syntax, which is rich coming from a Rust enjoyer.

Wrapping those bit macros into **more** useful functions:

```c
extern int setup_gpio();
extern int terminate_gpio();
extern int toggle_gpio(int gpio_pin); // helper function for quick toggling
extern int set_gpio_level(int gpio_pin, int gpio_level);
extern int get_gpio_level(int gpio_pin);
extern int set_gpio_pull(int gpio_pin, int pull_level);
```

Now... I'm gonna be honest, it currently does not look like above and we
currently have some redundant functions like `set_gpio_inp/set_gpio_out`. And
yes, I can probably switch it right now... but I haven't done that here yet, and
only did it for my Rust rewrite.

In terms of robustness, I kinda wish C had the pattern matching Rust had. But
for the sake of not overcomplicating the code, I just wrote some utility
functions like `validate_gpio_pin`

Also, I did not realize I wasn't suppose to be using `/dev/mem` - which requires
`sudo` level access and manually specifying the GPIO address. After learning
from this
[pi forums post](https://forums.raspberrypi.com/viewtopic.php?t=167446), I
switched to `/dev/gpiomem`, and got rid of a function that would look for the
device address.

### Multi Modal

### Shared Memory

## Attribution
