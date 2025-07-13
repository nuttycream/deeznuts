+++
title = "I use nix btw"
description = "NixOS is the greatest thing since sliced bread"
date = "2025-07-10"

[taxonomies]
tags = ["nix", "linux"]
+++

# some background

I've been a [GNU/Linux](https://stallman-copypasta.github.io/) enthusiast for
quite a while. My first foray into Linux was around 2011, when I installed
Ubuntu back when it was using Unity as its default DE.

I don't entirely remember why I installed it, but if I had to guess it was
around my script kiddie days and I probably wanted to be an _1337_h4xor_ (elite
hacker in leetspeak - yes I know it's cringe).

Since then I always knew about Linux but never really dove too deep into the
whole operating system. Until of course around 2018, where I wanted to get back
into it because I was bored of the same old windows.

> I had a pretty sick Windows config back then with a custom rainmeter skin

# what was easy

Getting initially started is actually pretty straightforward compared to other
distros like Arch, Gentoo, etc. Mainly because the NixOS org have an official
installer and an example configuration that comes with it. It was as easy as
writing the installer on a usb drive and booting into it.

Here was how my initial journey went...

I wanted a pure and clean set-up so I went with the `minimal` preset.

> You can choose between the different desktop environment presets like 'Gnome',
> 'KDE', or other popular tiling window managers.

The `minimal` preset boots you into a `TTY` session, no window manager, no login
daemon, nothing - which is what I like to see coming from my previous arch
endeavours.

I had the wiki open on my phone and quickly scanned through the documentation to
connect my wifi through `nmcli`.

I then hit my first road bump. How do I install anything here? I'm used to just
doing a good ol `sudo dnf install <package>` but now I obviously don't have
`dnf`. And this is where Nix differs from traditional distros and package
managers.

Everything I wanted to do on the system, involved rewriting a configuration
file. Since this was the initial setup, the config file was found in
`/etc/nixos/`:

```bash
[j@lappy:/etc/nixos]$ tree
.
├── configuration.nix
└── hardware-configuration.nix
```

Unfortunately, NixOS doesn't come pre-installed with `vi` so I had to use `nano`
(🤮) to edit the initial `configuration.nix`.

A brief intro to what a `.nix` file is:

- NixOS uses the `nix` expression language to manage the entire system. And
  `nix` lang is a purely functional language. Whereby, according to
  [Wikipedia](https://en.wikipedia.org/wiki/Purely_functional_programming): "a
  style of building the structure and elements of computer programs--that treats
  all computation as the evaluation of mathematical functions." whatever the
  hell that means. I'll go over this more [later](#what-was-hard).
- Simply put, we gotta declare some stuff

In NixOS, we can declare the packages that we want by adding them into this nix
option:

```nix
# List packages installed in system profile. To search, run:
# $ nix search wget
environment.systemPackages = with pkgs; [
    # Do not forget to add an editor to edit configuration.nix! 
    # The Nano editor is also installed by default.
    neovim 
    git
];
```

As you can see, I first installed `neovim` and `git`. The bare minimum programs
I need to get the ball rolling.

Why these two programs you might ask?

- `neovim`: I **DO NOT** want to use nano for editing text
- `git`: To clone a system `flake.nix` example from GitHub

# what was hard

The `Nix` language was not easy for me to understand at first. Probably because
I had very little experience with functional languages like `Nix` or `Haskell`.
Luckily, I was extremely motivated to learn, why you may ask? Because I wanted
to be part of the cool kids club.

# now what?

It's simple really, I have _nixified_ my entire workflow both for personal and
work.

# resources

- [NixOS](https://nixos.org/)
- [nix.dev tutorials](https://nix.dev/tutorials/first-steps/)
- [nix options](https://search.nixos.org/options)
- [nix packages](https://search.nixos.org/packages)
- [official nixos wiki](https://wiki.nixos.org/wiki/NixOS_Wiki)
- [misterio77's starter configs](https://github.com/Misterio77/nix-starter-configs)
- [sodiboos setup](https://github.com/sodiboo/system)
- [my setup](https://github.com/nuttycream/nixxy)
