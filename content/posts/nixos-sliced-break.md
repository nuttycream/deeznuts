---
title: "I use nix btw"
description: "NixOS is the greatest thing since sliced bread"
date: "2025-07-10"

template: post
---

<p align="center">
<img src="https://camo.githubusercontent.com/c958fa2f4764a20326ef1a4ac8f6c825e1bb6def38cf3749a429c11014aba633/68747470733a2f2f692e696d6775722e636f6d2f414532314c704e2e706e67" alt="nixos" style="width: 75%;">
</p>

# Background

I've been a [GNU/Linux](https://stallman-copypasta.github.io/) enthusiast for
quite a while. My first foray into Linux was when I installed Ubuntu back when
it was using Unity as its default DE.

I don't entirely remember why I installed it, but if I had to guess it was
around my script kiddie days and I probably wanted to be an _1337_h4xor_ (elite
hacker in leetspeak - yes I know it's cringe).

Since then I always knew about Linux but never really dove too deep into the
whole operating system. Until of course around 2018, where I wanted to get back
into it because I was bored of the same old windows.

> I had a pretty sick Windows config back then with a custom rainmeter skin

# What was easy

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

Emphasis on cloning an example system `flake.nix`. You see, while you can edit
the `configuration.nix` in `/etc/nixos/` for your system config, it gets kinda
messy if you want to replicate it elsewhere. That's where `flakes` come in.

A _flake_, according to [zero-to-nix](https://zero-to-nix.com/concepts/flakes/)
is a directory that outputs nix expressions to build, run, create dev
environments, or even entire systems. FYI, you'll be using this pretty
frequently to make reproducible dev environments for your projects.

This single _flake_ directory can be pushed to something like GitHub to make it
where I can host my entire system online. And if I have a new system, I can
simply clone my setup and run `sudo nixos rebuild switch --flake`.

_Bada bing bada boom_ my entire setup, with my preferred configs/programs are
now installed into a new system - giving me the reproducible aspect of NixOS.

# What was hard

The `Nix` language was not easy for me to understand at first. Probably because
I had very little experience with functional languages like `Nix` or `Haskell`.
Luckily, I was extremely motivated to learn, why you may ask? So I can tell
everyone _'I use nix btw'_.

There are a decent amount of ways you can learn the language, there's the
[nix-tour](https://nixcloud.io/tour/?id=introduction/nix) for more of an
interactive learning experinece, if that's more of your thing. I chose the
simpler route of just diving head first into the language. By using the starter
configs and other example configs. I learned how a `.nix` file is evaluated.

I thought about trying to explain you the basics of what the language has, but I
feel like I'd be unintentionally mis-informing you, since I myself am a noob at
it. So instead I'll go over my own system config and how I made it.

The basis for my flake.nix was straight up ripped from
[sodiboo's](https://github.com/sodiboo/system) config so special thanks to them.
You should also visit their repo for a better grasp of how this setup works.

From my understanding, the flake scans for `.mod.nix` files and loads them
through the `mapAttrsToList()` function where each module is loaded through
`import("${mod_file}")`, and saves me the trouble of explicitly specifying the
module. Each `.mod.nix` file can also define configs for different systems or
inherit different _layers_.

The key thing I definitely wanted is how inheritance is handled. Specifically
configurations found in `_inheritance.mod.nix` and what it exactly its being
used for. That's all handled by Sodiboo's merge function:

```nix
merge = prev: this: {
    modules = prev.modules or [] ++ this.modules or [];
    home_modules = prev.home_modules or [] ++ this.home_modules or [];
} // (optionalAttrs (prev ? system || this ? system) {
    system = prev.system or this.system;
});
```

Too be clear, I'm pretty sure this sort of combines configs rather than create
inheritance. And when they are merged, the `modules` and `home_modules` arrays
are concatted as well as the system specific config, I believe this is what
`optionalAttrs` handles.

The setup also uses `zipAttrsWith` to automatically combine all modules by
machine name. So if multiple .mod.nix files define configs for the same machine
like _desky_, they get automatically combined using the merge function through
folding.

This all sort of lets me use a _layered_ config setup where machines can inherit
the configs they would need, I can also specify a config on a per machine level.

In practice, this is what it would look like:

```nix
desky = merge configs.universal configs.personal
lappy = merge configs.universal configs.personal
```

This automatically creates and combines configs as like so:

- modules -> `universal.modules ++ personal.modules`
- home_modules -> `universal.home_modules ++ personal.home_modules`

To put it all together, declaring a new module is as simple as:

```nix
# some.mod.nix

{...} : {
    universal.modules = [
        ({pkgs, lib, ...} : {
            # ...
        });
    ];

    # and/or
    personal.modules = [{
        # ...
    }];

    # for specific hosts
    lappy.modules = [];
    desky.modules = [];

    # same goes for home_modules
    universal.home_modules = [];
    personal.home_modules = [];
    lappy.home_modules = [];
}
```

# Now what?

It's simple really, I have _nixified_ my entire workflow both for personal and
work. I've been `nix'd` on January of 2025 and haven't looked back since.

Truthfully, it's an _**annoying operating system**_ that gets in the way more
often than any other distro. But its the philosophy and the way of thinking that
makes it different. Having directory specific packages + dependencies makes it
easier to manage projects, create reproducibility, and reliability.

Quite frankly, it would be an understatement to say that I'm addicted. In fact I
get a _dopamine_ rush whenever I have to fiddle with my configs.

# Resources

- [NixOS](https://nixos.org/)
- [nix.dev tutorials](https://nix.dev/tutorials/first-steps/)
- [zero to nix](https://zero-to-nix.com/concepts/flakes/)
- [nix options](https://search.nixos.org/options)
- [nix packages](https://search.nixos.org/packages)
- [official nixos wiki](https://wiki.nixos.org/wiki/NixOS_Wiki)
- [misterio77's starter configs](https://github.com/Misterio77/nix-starter-configs)
- [sodiboos setup](https://github.com/sodiboo/system)
- [my setup](https://github.com/nuttycream/nixxy)
