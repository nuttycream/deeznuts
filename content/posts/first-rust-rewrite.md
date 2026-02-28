---
title: "My First C to Rust Rewrite"
description: "Rewrite it in Rust lives! My first Rust rewrite from a GPIO C DRA Library."
date: "2025-06-01"
---

# But why?

Let me first preface this by saying that this is the first time I have ever
**used** a Raspberry Pi, as well as worked on any sort of embedded project.
[pipin](https://github.com/nuttycream/pipin) was meant to be a small project
that helped me learn how to write a Rust web server. But I needed something
_relevant_ to my current studies, so I can double the learning and self-motivate
myself into actually completing it.

# In C

The first iteration of the C code came from a
[DRA (Direct Registry Access) sample](https://elinux.org/RPi_GPIO_Code_Samples#Direct_register_access)
from the interwebs.

{% note(clickable=true, hidden=true, header="Expand To View") %}

```c
//
//  How to access GPIO registers from C-code on the Raspberry-Pi
//  Example program
//  15-January-2012
//  Dom and Gert
//  Revised: 15-Feb-2013

// Access from ARM Running Linux

#define BCM2708_PERI_BASE        0x20000000
#define GPIO_BASE                (BCM2708_PERI_BASE + 0x200000) /* GPIO controller */

#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <unistd.h>

#define PAGE_SIZE (4*1024)
#define BLOCK_SIZE (4*1024)

int  mem_fd;
void *gpio_map;

// I/O access
volatile unsigned *gpio;

// GPIO setup macros. Always use INP_GPIO(x) before using OUT_GPIO(x) or SET_GPIO_ALT(x,y)
#define INP_GPIO(g) *(gpio+((g)/10)) &= ~(7<<(((g)%10)*3))
#define OUT_GPIO(g) *(gpio+((g)/10)) |=  (1<<(((g)%10)*3))
#define SET_GPIO_ALT(g,a) *(gpio+(((g)/10))) |= (((a)<=3?(a)+4:(a)==4?3:2)<<(((g)%10)*3))
#define GPIO_SET *(gpio+7)  // sets   bits which are 1 ignores bits which are 0
#define GPIO_CLR *(gpio+10) // clears bits which are 1 ignores bits which are 0
#define GET_GPIO(g) (*(gpio+13)&(1<<g)) // 0 if LOW, (1<<g) if HIGH
#define GPIO_PULL *(gpio+37) // Pull up/pull down
#define GPIO_PULLCLK0 *(gpio+38) // Pull up/pull down clock

void setup_io();

void printButton(int g)
{
  if (GET_GPIO(g)) // !=0 <-> bit is 1 <- port is HIGH=3.3V
    printf("Button pressed!\n");
  else // port is LOW=0V
    printf("Button released!\n");
}

int main(int argc, char **argv)
{
  int g,rep;

  // Set up gpi pointer for direct register access
  setup_io();

  // Switch GPIO 7..11 to output mode

 /************************************************************************\
  * You are about to change the GPIO settings of your computer.          *
  * Mess this up and it will stop working!                               *
  * It might be a good idea to 'sync' before running this program        *
  * so at least you still have your code changes written to the SD-card! *
 \************************************************************************/

  // Set GPIO pins 7-11 to output
  for (g=7; g<=11; g++)
  {
    INP_GPIO(g); // must use INP_GPIO before we can use OUT_GPIO
    OUT_GPIO(g);
  }

  for (rep=0; rep<10; rep++)
  {
     for (g=7; g<=11; g++)
     {
       GPIO_SET = 1<<g;
       sleep(1);
     }
     for (g=7; g<=11; g++)
     {
       GPIO_CLR = 1<<g;
       sleep(1);
     }
  }

  return 0;

} // main

//
// Set up a memory regions to access GPIO
//
void setup_io()
{
   /* open /dev/mem */
   if ((mem_fd = open("/dev/mem", O_RDWR|O_SYNC) ) < 0) {
      printf("can't open /dev/mem \n");
      exit(-1);
   }

   /* mmap GPIO */
   gpio_map = mmap(
      NULL,             //Any adddress in our space will do
      BLOCK_SIZE,       //Map length
      PROT_READ|PROT_WRITE,// Enable reading & writting to mapped memory
      MAP_SHARED,       //Shared with other processes
      mem_fd,           //File to map
      GPIO_BASE         //Offset to GPIO peripheral
   );

   close(mem_fd); //No need to keep mem_fd open after mmap

   if (gpio_map == MAP_FAILED) {
      printf("mmap error %d\n", (int)gpio_map);//errno also set!
      exit(-1);
   }

   // Always use volatile pointer!
   gpio = (volatile unsigned *)gpio_map;

} // setup_io
```

{% end %}

This example was daunting to me at first because I barely remember anything
about bitwise manipulation from my assembly class. But from the explanations our
Professor gave, it's pretty straightforward (if I'm being honest, no not
really - the syntax is still jarring for me).

## mmap() in C

I genuinely didn't know what the hell this thing did at first - yes laugh all
you want. It says in its name for crying out loud `mmap` - Memory Map. But I
genuinely thought the map it was talking about was the data structure map.

```c
gpio_map = mmap(
    NULL,
    BLOCK_SIZE,
    PROT_READ|PROT_WRITE,
    MAP_SHARED,
    mem_fd,
    GPIO_BASE
);
```

I know it may be pretty trivial for a lot of you nerds but this genuinely helped
me understand how memory works and how it can be used and shared. It also made
me realize that `mmap()` is a Unix specific system call for managing memory and
that it needs to be consistent across architectures, regardless of programming
language.

## Bitwise Operations

Here's my shoddy attempt to break one of those bitwise operations down.

```c
#define INP_GPIO(g) *(gpio+((g)/10)) &= ~(7<<(((g)%10)*3))
```

First off, handling the left side of the macro

```c
(g)/10
```

Using integer division to get the GPIO selector register.

_Why?_ Well we need to get the register index starting from `GPFSEL0`, so when
we do something like `g = 15 -> 15/10 = 1` which tells us to use `GPFSEL1`.

```c
*(gpio+((g)/10)) &=
```

Using the proper `GPFSEL` register, we add the `gpio` address - giving us the
full scope of the target GPIO pin we want to modify.

```c
((g)%10)*3
```

For `(g)%10`, this gets us the pin within the register, we can then shift by
multiplying by 3 - since each pin uses 3 bits for function selection. So
something like `g = 15 -> 15%10 = 5 * 3 = 15` for bit position 15.

```c
~(7<<(((g)%10)*3))
```

This part was tricky to understand for me, I knew what we're left shifting, but
why 7? Well 7 in binary is 111 or three 1-bits. GPIO functions specifically use
3 bits per pin, and we want to clear all 3 bits. So, left shifting by three
1-bits creates a [bitmask](<https://en.wikipedia.org/wiki/Mask_(computing)>) which
essentially creates a mask or what I refer to as a sort of 'group' for the bits
I'm left shifting from. And finally, the negate `~` symbol effectively inverts
all bits within the mask.

```c
*(gpio+((g)/10)) &= ~(7<<(((g)%10)*3))
```

Putting it all together gives us what is essentially, get the pin using the
`gpio` address, and `GPFSEL` register. The right side of the expression uses
bitwise and inverts the mask to clear only the 3 bits for the target GPIO pin,
effectively setting that GPIO function to `000` - input mode.

# In Rust

Turning these bitwise operations in Rust is relatively simple. The part that I'm
not so keen on is that I'll have to use `unsafe` Rust. I have never programmed
in `unsafe` before - this is also probably be a good time to say that my
experience in Rust solely come from simple game development with
[bevy](https://bevyengine.org) and making GUI's with
[egui](https://github.com/emilk/egui).

But I'm up for the challenge, I was starting to get addicted to programming - in
fact this project helped propel me into both embedded development but also
specifically Rust embedded development.

The first thing we need to cover is **how the are we gonna access GPIO memory?**
and this is the part where `unsafe` Rust comes in.

## mmap() in Rust

"There exists a Rust crate for everything" I don't know if such a saying is a
thing but it should because luckily for us there are multiple memory map
equivalent libraries/crates that offer a near one-to-one equivalent to its C
counterpart. Which makes sense right, since `mmap()` is a pretty important Unix
system call in the low level world and Rust is considered a low-level
programming language.

I eventually went with the `nix` crate, not to be confused with `nix` the
package manager for `NixOS`. This gives me access to their `mmap()` function:

```rust
match mmap(
    None,
    block_size,
    ProtFlags::PROT_READ | ProtFlags::PROT_WRITE,
    MapFlags::MAP_SHARED,
    dev_mem,
    gpio_address
) {}
```

It's very similar to how `mmap()` in C works, this made it easier for me to
recreate the things I needed to map for the GPIO address.

## read_volatile() and write_volatile()

For the C code, when we access hardware registers, we use the `volatile` keyword
to specifically tell the compiler it shouldn't optimize these memory accesses.
Without this `volatile` keyword, the compiler might assume that memory doesn't
change between reads, or that writes don't matter if we don't read the result
back.

In C you can just straight up slap a `volatile` on anything and call it a day:

```c
volatile unsigned *gpio;
```

I was a little stumped for a bit reading up on `unsafe` Rust but this
[Stack Overflow answer](https://stackoverflow.com/a/35010896/17123405) helped
clear the fog. Simply, unlike C, in Rust we have to be somewhat more specific
about what operation we want to make `volatile`. Specifically using
[write_volatile](https://doc.rust-lang.org/std/ptr/fn.write_volatile.html) and
[read_volatile](https://doc.rust-lang.org/std/ptr/fn.read_volatile.html) to read
and write respectively.

```rust
unsafe {
    write_volatile(some_ptr, value);
    let new_value = read_volatile(some_ptr);
}
```

I can then wrap these functions into more robust helper functions:

```rust
unsafe fn read_register(&self, offset: usize) -> Result<u32, GpioError> {
    if let Some(atomic_ptr) = &self.gpio_map {
        let base = atomic_ptr.load(Ordering::SeqCst);
        let reg = base.add(offset);
        Ok(read_volatile(reg))
    } else {
        Err(GpioError::ReadRegister)
    }
}

unsafe fn write_register(&self, offset: usize, value: u32) -> Result<(), GpioError> {
    if let Some(atomic_ptr) = &self.gpio_map {
        let base = atomic_ptr.load(Ordering::SeqCst);
        let reg = base.add(offset);
        write_volatile(reg, value);
        Ok(())
    } else {
        Err(GpioError::WriteRegister)
    }
}
```

You also probably noticed the `atomic_ptr` type. Well, this is another problem I
tried very hard to understand and it took me a while. But this is what happens
when a noob meets thread safe Rust.

I don't want to dive too deep into this because this write-up is mostly about
rewriting a GPIO C library in Rust, and not a creating a web server in Rust
write-up. But basically, my `gpio_map` is of type `Option<AtomicPtr<u32>>`, and
to modify this I need to gain access to it by using the line:

```rust
atomic_ptr.load(Ordering::SeqCst);
```

The `Ordering::SeqCst` is meant to specify the most safest way to obtaining the
ptr, but apparently it's slow. But speed doesn't matter that much in this case.
But I do this all because I need to access this single `gpio_map` in a thread
safe manner to prevent the usual multi-threaded pitfalls that comes with making
an Axum web server.

## Rust Bitwise Operations

Now, from here it's pretty damn straight forward, we can use the same operations
we had from the C code and simply call those two helper functions:
`write_register()` and `read_register()`.

I even pulled those offsets out to make em somewhat more readable for me:

```rust
const GPIO_SET_OFFSET: usize = 7;
const GPIO_CLR_OFFSET: usize = 10;
const GPIO_LEV_OFFSET: usize = 13;
const GPIO_PULL_OFFSET: usize = 37;
const GPIO_PULLCLK0_OFFSET: usize = 38;
```

And now that same C macro for setting the GPIO pin to input mode can be written
as:

```rust
unsafe {
    let reg = (pin / 10) as usize;
    let bit = ((pin % 10) * 3) as usize;

    let mut reg_value = self.read_register(reg)?;

    reg_value &= !(7 << bit);

    self.write_register(reg, reg_value)?;
}
```

## Complete Rust Rewrite

Ripped straight from [pipin](https://github.com/nuttycream/pipin), I might've
accidentally stripped important shit, but you should be able to get the general
gist.

{% note(clickable=true, hidden=true, header="Expand To View") %}

```rust
use crate::errors::GpioError;
use nix::{
    libc::O_SYNC,
    sys::mman::{mmap, munmap, MapFlags, ProtFlags},
};
use std::{
    fs::OpenOptions,
    num::NonZero,
    os::unix::fs::OpenOptionsExt,
    ptr::{read_volatile, write_volatile, NonNull},
    sync::atomic::{AtomicPtr, Ordering},
    thread::sleep,
    time::Duration,
};

const BLOCK_SIZE: usize = 4096;
const GPIO_SET_OFFSET: usize = 7;
const GPIO_CLR_OFFSET: usize = 10;
const GPIO_LEV_OFFSET: usize = 13;
const GPIO_PULL_OFFSET: usize = 37;
const GPIO_PULLCLK0_OFFSET: usize = 38;

// https://pinout.xyz/
#[derive(Copy, Clone, Debug)]
pub enum PinType {
    Power5v,  // red
    Power3v3, // orange
    Gnd,      // black

    Gpio, // green
    I2c,  // blue
    Spi,  // pink
    Uart, // purple
    Pcm,  // yellow
}

#[derive(Copy, Clone, Debug)]
pub enum PullType {
    None = 0,
    Down = 1,
    Up = 2,
}

#[derive(Copy, Clone, Debug)]
pub enum PinDirection {
    Input,
    Output,
}

#[derive(Copy, Clone, Debug)]
pub enum PinLevel {
    High,
    Low,
}

#[derive(Clone, Debug)]
pub enum PinColumn {
    Left,
    Right,
}

#[derive(Clone, Debug)]
pub struct Pin {
    // ui stuff
    pub number: Option<i32>,
    pub pin_type: PinType,
    pub label: String,
    pub column: PinColumn,

    //physical state
    pull: PullType,
    level: PinLevel,
    direction: PinDirection,
}

pub struct Gpio {
    pub initialized: bool,
    pub pins: Vec<Pin>,

    gpio_map: Option<AtomicPtr<u32>>,
}

impl Gpio {
    pub fn new() -> Self {
        Gpio {
            gpio_map: None,
            initialized: false,
            pins: default_pins(),
        }
    }

    fn validate_input(&self, pin: i32) -> Result<i32, GpioError> {
        if !self.initialized {
            return Err(GpioError::NotInitialized);
        }

        if !(0..=27).contains(&pin) {
            return Err(GpioError::InvalidPin(pin));
        }

        Ok(pin)
    }

    // https://stackoverflow.com/a/44510388/17123405
    // helper func to read a volatile register
    unsafe fn read_register(&self, offset: usize) -> Result<u32, GpioError> {
        if !self.initialized || self.gpio_map.is_none() {
            return Err(GpioError::NotInitialized);
        }

        // get from the base pointer and
        // add the offset
        if let Some(atomic_ptr) = &self.gpio_map {
            let base = atomic_ptr.load(Ordering::SeqCst);
            let reg = base.add(offset);

            // then read
            Ok(read_volatile(reg))
        } else {
            Err(GpioError::NotInitialized)
        }
    }

    // helper func to write a volatile register
    unsafe fn write_register(
        &self,
        offset: usize,
        value: u32,
    ) -> Result<(), GpioError> {
        if !self.initialized || self.gpio_map.is_none() {
            return Err(GpioError::NotInitialized);
        }

        // get from the base ptr and
        // add the offset
        if let Some(atomic_ptr) = &self.gpio_map {
            let base = atomic_ptr.load(Ordering::SeqCst);
            let reg = base.add(offset);

            // write
            write_volatile(reg, value);

            Ok(())
        } else {
            Err(GpioError::NotInitialized)
        }
    }

    pub fn setup(&mut self) -> Result<(), GpioError> {
        if self.initialized {
            println!("GPIO device already initialized.");
            return Ok(());
        }

        /*
        for pin_data in default_pins() {
            self.pins.insert(pin_data.number, pin_data);
        }
        */

        unsafe {
            let block_size = match NonZero::new(BLOCK_SIZE) {
                Some(val) => val,
                None => {
                    println!("Somehow failed to create NonZero BLOCK_SIZE");
                    return Err(GpioError::Setup);
                }
            };

            // 0 since we're using
            // /dev/gpiomem
            // if we want manual control,
            // we'll have to
            // use /dev/mem and
            // detect_peripheral_address()
            // but requires sudo
            // rather than gpio group
            // `groups`
            // `sudo usermod -a -G gpio <user>`
            let gpio_address = 0;

            let dev_mem = match OpenOptions::new()
                .read(true)
                .write(true)
                .custom_flags(O_SYNC)
                .open("/dev/gpiomem")
            {
                Ok(dev_mem) => {
                    println!("Opened /dev/gpiomem");
                    dev_mem
                }
                Err(e) => {
                    println!("Failed to open /dev/gpiomem: {e}");
                    return Err(GpioError::Setup);
                }
            };

            match mmap(
                None,
                block_size,
                ProtFlags::PROT_READ | ProtFlags::PROT_WRITE,
                MapFlags::MAP_SHARED,
                dev_mem,
                gpio_address,
            ) {
                Ok(map) => {
                    println!(
                        "Memory mapped successfully -> casting to gpio_map"
                    );

                    // AtomicPtr since NonNull cant be
                    // shared across
                    // tokio threads
                    let ptr = map.cast::<u32>().as_ptr();
                    self.gpio_map = Some(AtomicPtr::new(ptr));

                    println!("Finished init gpio_map");
                }
                Err(e) => {
                    println!("Failed to mmap: {e}");
                    return Err(GpioError::Setup);
                }
            };
        }

        self.initialized = true;
        Ok(())
    }

    pub fn reset(&mut self) -> Result<(), GpioError> {
        if !self.initialized {
            return Err(GpioError::NotInitialized);
        }

        // reseting all pins to input
        for pin in 0..28 {
            self.set_direction(pin, PinDirection::Input)?;
            self.set_level(pin, PinLevel::Low)?;
            self.set_pull_type(pin, PullType::None)?;
        }

        Ok(())
    }

    pub fn terminate(&mut self) -> Result<(), GpioError> {
        if !self.initialized {
            return Err(GpioError::NotInitialized);
        }

        // should we reset all pins before terminating?
        // self.reset()?;

        if let Some(atomic_ptr) = &self.gpio_map {
            unsafe {
                let ptr = atomic_ptr.load(Ordering::SeqCst);
                if !ptr.is_null() {
                    if let Some(non_null) = NonNull::new(ptr as *mut _) {
                        munmap(non_null.cast(), BLOCK_SIZE).ok();
                        println!("Unmapping memory on terminate");
                    }
                }
            }
        }

        self.gpio_map = None;
        self.initialized = false;

        Ok(())
    }

    // wrapper for set_level() for toggling
    pub fn toggle(&mut self, pin: i32) -> Result<PinLevel, GpioError> {
        self.validate_input(pin)?;

        let current_level = self.get_level(pin)?;

        match current_level {
            PinLevel::High => {
                self.set_level(pin, PinLevel::Low)?;
                Ok(PinLevel::Low)
            }
            PinLevel::Low => {
                self.set_level(pin, PinLevel::High)?;
                Ok(PinLevel::High)
            }
        }
    }

    pub fn set_direction(
        &mut self,
        pin: i32,
        direction: PinDirection,
    ) -> Result<(), GpioError> {
        self.validate_input(pin)?;

        unsafe {
            let reg = (pin / 10) as usize;
            let bit = ((pin % 10) * 3) as usize;

            // read
            let mut reg_value = self.read_register(reg)?;

            // clear
            reg_value &= !(7 << bit);

            // then set bits based on dir
            match direction {
                PinDirection::Output => {
                    reg_value |= 1 << bit;
                }
                PinDirection::Input => {
                    // should do nothing here
                    // since clearing it
                }
            }

            // wriet it back
            self.write_register(reg, reg_value)?;
        }

        for p in &mut self.pins {
            if let Some(num) = p.number {
                if num == pin {
                    p.direction = direction;
                    break;
                }
            }
        }

        Ok(())
    }

    pub fn set_level(
        &mut self,
        pin: i32,
        level: PinLevel,
    ) -> Result<(), GpioError> {
        self.validate_input(pin)?;

        // set to output first
        // i assume this will only be triggered
        // when we want to output a signal no?
        self.set_direction(pin, PinDirection::Output)?;

        unsafe {
            match level {
                PinLevel::High => {
                    println!("Setting Pin Level to High");
                    self.write_register(GPIO_SET_OFFSET, 1 << pin)?;
                }
                PinLevel::Low => {
                    println!("Setting Pin Level to Low");
                    self.write_register(GPIO_CLR_OFFSET, 1 << pin)?;
                }
            }
        }

        // pins aren't mapped 1 to 1 on
        // physical pins to the vector index
        // so using something like pins[pin]
        // fails and sets the wrong
        // pin idx
        // todo: better way to handle this
        for p in &mut self.pins {
            if let Some(num) = p.number {
                if num == pin {
                    p.level = level;
                    break;
                }
            }
        }

        Ok(())
    }

    pub fn set_pull_type(
        &mut self,
        pin: i32,
        pull_type: PullType,
    ) -> Result<(), GpioError> {
        self.validate_input(pin)?;
        // todo: let's make this an optional param
        let wait_time = 100;

        unsafe {
            // clear
            self.write_register(GPIO_PULL_OFFSET, 0)?;

            // use std sleep
            // should be good enough hopefully
            sleep(Duration::from_micros(wait_time));

            // now pull
            self.write_register(GPIO_PULL_OFFSET, pull_type as u32)?;
            sleep(Duration::from_micros(wait_time));

            // clock it if not none
            match pull_type {
                PullType::None => println!("Not going to clock for NONE"),
                PullType::Down | PullType::Up => {
                    self.write_register(GPIO_PULLCLK0_OFFSET, 1 << pin)?;
                    sleep(Duration::from_micros(wait_time));
                }
            }

            // then clear again
            self.write_register(GPIO_PULL_OFFSET, 0)?;
            self.write_register(GPIO_PULLCLK0_OFFSET, 0)?;
        }

        for p in &mut self.pins {
            if let Some(num) = p.number {
                if num == pin {
                    p.pull = pull_type;
                    break;
                }
            }
        }

        Ok(())
    }

    pub fn get_level(&self, pin: i32) -> Result<PinLevel, GpioError> {
        self.validate_input(pin)?;

        unsafe {
            let level = self.read_register(GPIO_LEV_OFFSET)?;
            if (level & (1 << pin)) != 0 {
                Ok(PinLevel::High)
            } else {
                Ok(PinLevel::Low)
            }
        }
    }
}

// WOOOH RUST DROP trait automatically gets called, useful
// for cleanup
impl Drop for Gpio {
    fn drop(&mut self) {
        if !self.initialized {
            return;
        }

        let atomic_ptr = match &self.gpio_map {
            Some(ptr) => ptr,
            None => return,
        };

        let ptr = atomic_ptr.load(Ordering::SeqCst);
        if ptr.is_null() {
            return;
        }

        unsafe {
            if let Some(non_null) = NonNull::new(ptr as *mut _) {
                munmap(non_null.cast(), BLOCK_SIZE).ok();
                println!("Unmapping memory")
            }
        }
    }
}
```

{% end %}

# Final Thoughts

In conclusion, I did learn a decent amount of information, from `mmap()`,
bitwise operations, and Rust specific idioms as well as `unsafe` Rust. It was
all fun, if I'm being honest. And I do want to expand this... At first, but now
I realize the amount of stuff I have to implement to get a decent fully featured
GPIO controller going is going to be monumental. Maybe I'll tackle it some day
but for now, I'm just going to `cargo add rppal` and call it a day.

# Attribution

- [Blinking LED using GPIO Mem](https://leiradel.github.io/2019/01/30/Using-the-GPIO.html)
- [BCM2835 GPIO Programming](https://www.glennklockwood.com/embedded/bmc2835-gpio.html)
- [Raspberry Pi BCM2835 Datasheet](https://datasheets.raspberrypi.com/bcm2835/bcm2835-peripherals.pdf)
