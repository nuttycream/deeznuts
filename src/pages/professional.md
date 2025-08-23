---
layout: ../layouts/Layout.astro
title: "professional"
---

[resume](/resume.pdf)

# To whom it may concern,

My name is John Carter, and I am a programmer with a Bachelor's in Computer
Science from San Francisco State University. I'm also a veteran of the US
AirForce, where I served as a military policeman.

I have been programming since I was 12 years old, starting with ActionScript 3
for Adobe Flash games. Currently, I am proficient with Rust, C-sharp, C, and
Cpp. I mainly work on projects that are back-end, embedded, and low-level, with
the occasional dab at web development with vanilla JS, Typescript, and
frameworks such as Astro.

My most recent and notable projects:

- [pipin](https://github.com/nuttycream/pipin)- A rust based portable
  application to control Raspberry Pi GPIO pins on the web browser. It uses
  Direct Memory Access to manipulate bits within the GPIO memory address. It was
  initially a custom DMA C library which I rewrote in Rust as part of a neat
  excercise to not only learn low level Rust, but also to dive into embedded
  programming.

- [omnibot](https://github.com/nuttycream/omnibot) - A Raspberry Pi powered
  omnidirectional robot. A semester long group project, it was programmed as a
  multi-threaded C program that can autonomously follow a line. It had a built
  in obstacle avoidance and tracking. This also uses a custom DMA C library with
  low level implentations of embedded protocols such as I2C, and SPI.

- [omniscient](https://github.com/nuttycream/omniscient) - A rust based wep app
  to strictly observe the omnibot. It uses IPC, specifically shared memory to
  read from the omnibot's C memory addresses which was a strict limitation as
  Rust code was not allowed in the omnibot's codebase. It also uses ALSA
  bindings to pipe audio at random intervals.

- [nixxy](https://github.com/nuttycream/nixxy) - My NixOS system configuration
  that is purpose built for my use-case, preferences, and desired aesthetic.
  It's made with a nix flake that dynamically loads 'modules' based on the
  designated host system. Each host system is configured with unique settings
  that are made to be declarative and easily reproducible.
