+++
title = "pipin"
description = "raspberry pi gpio web controller"
date = "2025-04-20"

[taxonomies]
tags = ["rust", "c", "gpio", "raspberry pi"]

[extra]
repo_view = true
comment = true
+++

[GitHub](https://github.com/nuttycream/pipin)

# pipin

![GitHub Release](https://img.shields.io/github/v/release/nuttycream/pipin?label=Release)
![File Size](https://img.badgesize.io/https://github.com/nuttycream/pipin/releases/download/v0.1.0/pipinrs-v0.1.0.zip?label=Download%20Size)

![screen](https://camo.githubusercontent.com/3c797ef3383283529d8954b2735b2c5e3821eff0b8e3c97850d423dcfa71c2e9/68747470733a2f2f692e696d6775722e636f6d2f74497141416a352e706e67)

A simple self contained application to control gpio pins from your browser

## Features

- Toggle individual pins (0-27)
- Wicked fast toggling through WebSockets
- Queue various actions
  - Toggle
  - Delay(ms)
  - Wait For High
  - Wait For Low
  - Pull Down
  - Pull Up
- Loop action sequences
- Small self-contained executable (approx ~1MB)

## Installation

- Download from latest [release](https://github.com/nuttycream/pipin/releases)
- Extract to Raspberry Pi

```sh
# Note: if using ssh, you can download on your main machine and rysnc/scp the executable
# onto the pi. Example:
# rsync
rsync -avz pipin user@hostname:~/pipin
# scp
scp pipin user@pi-host:~/pipin
```

## Usage

- Run the program:

```sh
cd <directory>
sudo ./pipin # sudo is needed for direct registry access
```

- By default it uses port 3000, to use a different port:

```sh
sudo ./pipin 8080 #runs on port 8080
```

- Navigate to webpage; defaults to `0.0.0.0:3000` or `localhost:3000`

```
Note: you can also navigate on any machine connected to the same network,
by using the raspberry pi's IP address and port number,
example: http://192.168.68.70:3000
```

- Press 'Initialize' to setup the GPIO pins
- bobs ur uncle

## To-Do

- [ ] Device address override
- [ ] Pins should show whether they're high or low
- [ ] Individual GPIO pin pulldown/up

## Attribution

gpio.h and gpio.c library was modified from
[gpio direct registry access example](https://elinux.org/RPi_GPIO_Code_Samples#Direct_register_access)
