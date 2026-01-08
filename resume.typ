#set text(
  font: "IBM Plex Sans",
  size: 9pt,
)

#grid(
  columns: (auto, 1fr),
  align: (left + horizon, right + top),
  [#text(size: 26pt, weight: "bold")[John Nacion]],
  [
    #link("https://johnnacion.dev")[johnnacion.dev]\
    #link("https://github.com/nuttycream")[github.com/nuttycream]\
    #link("mailto:me@johnnacion.dev")[me\@johnnacion.dev]
  ],
)

#line(length: 100%)

== Education
- Bachelor of Science, Computer Science - San Francisco State University (2025)
- Associate of Science, Computer Science - Diablo Valley College (2022)

== Software
- Vim/Neovim, GNU/Linux, NixOS
- Rust, C\#, C, C++

== Projects
==== #link(
  "https://github.com/cube-cult/gai",
)[gai - Version Control using Large Language Models]
- Created and maintain a CLI program that communicates with LLM providers to dynamically create commits, rebase, amend/edit existing commits, find a queryable commit, as well as intelligent remote syncing.
- Rust, git, LLM, Linux, CLI, TUI

==== #link("https://github.com/cube-cult/sussg")[sussg - Static Site Generator]
- Created and maintain a personalized static site generator that supports minijinja templates. It creates HTML pages out of Markdown files which includes frontmatter support.
- Rust, HTML, Markdown, ssg, minijinja, live-reload, Linux

==== #link(
  "https://github.com/nuttycream/llmao",
)[llmao - LLM Provider Abstraction Library]
- Created and maintain a large language model provider abstraction library that outlines generic Rust traits for a wide range of LLM providers including but not limited to OpenAI, Gemini, Anthropic Claude, etc. It natively supports capabilities such as structed output extraction and standard prompting.
- Rust, cargo, LLM, library

==== #link(
  "https://github.com/nuttycream/pipin",
)[pipin - GPIO Controller Web-Application]
- Created and maintain a GPIO controller web-app built on a Rust backend and an async Tokio runtime. The underlying GPIO controls are made with unsafe Direct Memory Address manipulation on the gpiomem device. Specifically built for Raspberry Pi's it can also accept any GPIO device with a valid address.
- Rust, DMA, GPIO, Linux

==== OmniDirectional Robot with Obstacle Avoidance/Tracking
- Created a three-wheeled self-propelled robot designed to autonomously follow lines with varying ied colors using omnidirectional movement. Built with C using a custom DMA library that supported GPIO, I2C, and SPI device interfaces. It used ultrasonic sound sensors to detect, track and avoid obstacles using a dynamic calculated path.
- C, DMA, GPIO, i2c, SPI, PWM, Linux

==== Robot Observer and Controller Web Application
- Created an accompanying observer application that communicated with a robot using IPC, specifically shared memory to access underlying robot information. Primarily used for the OmniDirectional Robot above. It was made using a Rust web backend and bindgen generated C bindings for the original robot program.
- Rust, IPC, SHMEM

== Work Experience
==== Robotics TeleOperator - #link("https://armstrong.ai")[armstrong.ai] [2025 - Present]
- Asynchronously observed multiple robots using a propietary dashboard and monitored terminal output for any obvious anomalies.
- Diagnosed and triaged robot issues to maintain 24/7 robot uptime.

==== Security Forces - United States AirForce [2015 - 2018]
- Entry Controller for the second largest non-nuclear joint installation within the Department of Defense.
- Maintained security of the local SCIF and performed route clearance for visiting high-ranking officials.
- Responded to and investigated over 100+ unannounced alarm activations, incidents, criminal offense and traffic mishaps/accidents
