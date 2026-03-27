#set text(
  font: "IBM Plex Serif",
  size: 8pt,
)

#grid(
  columns: (auto, 1fr),
  align: (left + horizon, right + top),
  [#text(size: 23pt, weight: "bold")[John Nacion]],
  [
    #link("https://johnnacion.dev")[johnnacion.dev]\
    #link("https://github.com/nuttycream")[github.com/nuttycream]\
    #link("mailto:me@johnnacion.dev")[me\@johnnacion.dev]
  ],
)

#line(length: 100%)

== Education
#grid(
  columns: (auto, 1fr),
  align: (left + horizon, right + top),
  gutter: 5pt,
  [Bachelor of Science, Computer Science],
  [San Francisco State University, 2025],

  [Associate of Science, Computer Science], [Diablo Valley College, 2022],
)

== Skills
#grid(
  columns: (auto, 1fr),
  align: (left + horizon, right + top),
  gutter: 5pt,
  [*Languages:*], [Rust, C, C++, C\#],
  [*Tools:*], [Vim/Neovim, Git, GNU/Linux, NixOS],
)

== Experience
==== R&D Operator - The Bot Company #h(1fr) Feb 2026 - Present
- Operated robotic platforms across multiple field sites to capture ground-truth training data for early-stage AI systems.
- Executed structured data collection protocols in varied, real-world environments to support iterative model development.
==== Robotics TeleOperator - armstrong.ai #h(1fr) June 2025 - Jan 2026
- Teleoperated multiple robots asynchronously using an advanced operations dashboard and command-line tools for deeper system-level control.
- Diagnosed, triaged, and resolved day-to-day operational issues to maintain continuous 24/7 robot uptime.
- Coordinated closely with on-site technicians to address customer questions, troubleshoot issues in real time, and ensure timely resolution of on-site operational concerns.

==== Security Forces - United States Air Force #h(1fr) Jun 2015 - Jun 2018
- Entry Controller for the second largest non-nuclear joint installation within the Department of Defense.
- Maintained security of the local SCIF and performed route clearance for visiting high-ranking officials.
- Responded to and investigated over 100 unannounced alarm activations, incidents, criminal offenses, and traffic incidents.

== Projects
==== #link("https://github.com/cube-cult/gai")[gai - Version Control using Large Language Models] #h(1fr) 2025 - Present
- Developed a CLI program that communicates with local and popular LLM providers to: generate commits by analyzing diffs, creating a rebase plan by comparing HEAD to a specified branch, amend existing commits with LLM-generated messages, find commits via natural language queries, and intelligently sync with remotes using LLM based analysis.

==== #link("https://github.com/cube-cult/sussg")[sussg - Static Site Generator] #h(1fr) 2025 - Present
- A personalized static site generator that supports minijinja templates. It creates HTML pages out of Markdown files and includes frontmatter support. Built natively for Linux, it's a CLI that can initialize an entire static website, support live-reload edits, and build clean HTML and CSS.

==== #link("https://github.com/nuttycream/llmao")[llmao - Rust LLM Provider Abstraction Library] #h(1fr) 2025 - Present
- Developed a large language model provider abstraction library for generic Rust traits that abstracts a wide range of LLM providers. It natively supports capabilities such as structured output extraction and standard prompting.

==== #link("https://github.com/nuttycream/pipin")[pipin - Rust GPIO Controller Web-Application] #h(1fr) 2025 - Present
- Maintaining a GPIO controller web-app built on a Rust backend and an async Tokio runtime. The underlying GPIO controls are made with unsafe Direct Memory Address manipulation on the gpiomem device. Specifically built for Raspberry Pis, it can also accept any GPIO device with a valid address.

==== #link("https://johnnacion.dev/posts/my-academic-magnum-opus/")[OmniChicken - OmniDirectional Robot with Obstacle Avoidance/Tracking] #h(1fr) 2025
- Built a three-wheeled self-propelled robot designed to autonomously follow lines with varied colors using omnidirectional movement. Built with C using a custom DMA library that supported GPIO, I2C, and SPI device interfaces. It used ultrasonic sound sensors to detect, track, and avoid obstacles using a dynamically calculated path.
- Programmed an accompanying observer application that communicated with the robot using IPC, specifically shared memory to access underlying robot information. Made using a Rust web backend and bindgen-generated C bindings for the original OmniChicken binary.

==== #link("https://github.com/nuttycream/SH-Save-Editor")[SHSE - Cross-platform GUI to modify Game Saves] #h(1fr) 2020 - 2022
- Developed a open-source save game editor for a popular PC video game and garnered over 50k downloads through various Game modding forums and GitHub. It was made with C\# using avalonia as the GUI framework. It parsed and modified XML data using dotNET's built-in task-based asynchronous library, as well as the built-in System.XML namespace with XPath support.

