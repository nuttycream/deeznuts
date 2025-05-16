+++
title = "omnichicken"
description = "Raspberry Pi powered three-wheeled omni-directional, line following, obstacle avoidance + obstacle tracking robot"
date = "2025-04-30"

[taxonomies]
tags = ["c", "gpio", "omni-directional", "raspberry pi", "ipc", "chicken"]

[extra]
repo_view = true
comment = true
+++

# [The Omni Chicken](https://github.com/nuttycream/omnibot)

A Raspberry Pi powered three-wheeled omni-directional, line following, obstacle
avoidance + obstacle tracking robot

<p align="center">
<img src="/images/PXL_20250514_000958905.jpg" alt="chicken" style="width: 35%;">
</p>

## Meet the team

While we are all programmers, and this is technically a programming computer
science course, we all specialized in certain aspects. And this is why I we
worked well together and complimented each other's skills.

- [Shoaib Perouz](www.linkedin.com) ([GitHub](https://github.com/sperouz)) -
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
of ideas for this robot, specifically on the type of movement it would use and
some of the more notable ones are:

- 4 legged spider
- bipedal walking humanoid
- two wheeled self balancing humanoid
- crab
- snake

We finally settled on a three-wheeled omnidirectional robot HEAVILY inspired by
this video by [maker.moekoe](https://www.youtube.com/@makermoekoe):

<p align="center" >
    <a href="https://www.youtube.com/watch?v=OIdMkZyhx7E">
<img src="https://img.youtube.com/vi/OIdMkZyhx7E/maxresdefault.jpg"
         alt="chicken" style="width: 75%;">
    </a>
</p>

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

## Initial Design

Ambitions were high for our initial design. The main idea we had to work around
was a three-wheeled omni-directional robot. Here are some of Yuquan's sketches:

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
the Minecraft chicken (and also the robot head). Which became our main design
goal!

`Note: Shoaib didn't know we were serious about the chicken until the last 3 weeks`

## Programming

Now for the meaty part. I'll try to expand on this as much as I can since I
wrote a decent amount of code, but also Shoaib and Bryan also contributed A LOT,
in terms of initial bot navigation and obstacle tracking/avoidance - which I'll
also attempt to expand on. Also note that I consider myself a huge programming
noob which is especially true with C.

My criteria

### GPIO Library

My first goal was to create a robust GPIO library based on a
[Raspberry Pi DRA example](https://elinux.org/RPi_GPIO_Code_Samples#Direct_register_access)
I've been using from my previous assignments.

### Multiple Modes

### Line Following

### Obstacle Tracking

### Obstacle Avoidance
