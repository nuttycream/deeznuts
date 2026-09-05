#set text(
  font: "IBM Plex Serif",
  size: 8pt,
)

#show heading.where(level: 2): set block(above: 1em, below: 1em)
#show heading.where(level: 3): set block(above: 1em, below: 0.9em)

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

== Summary
USAF veteran and now Test Engineer with a B.S. in Computer Science: automated test and Rust/C tooling on one side, cleanroom optics integration and non-conformance traceability on the other.

== Skills
#grid(
  columns: (auto, auto),
  align: (left, left),
  gutter: 5pt,
  [*Languages & Software:*], [Rust, C/C++, C\#, Python, Git, GNU/Linux, NixOS, Vim/Neovim, embedded GPIO/I2C/SPI, DMA],

  [*Test Equipment:*],
  [Oscilloscopes, DMM, accelerometers, electron and optical microscopes, electronic leak detectors, pressure gauges, calipers, torque and precision hand tools],

  [*Manufacturing & Quality:*],
  [ISO 9001, Class 100/10K cleanroom, ESD, SOP/work-instruction compliance, non-conformance (NC) logging, test traceability, root-cause analysis],
)

== Experience
=== Test Engineer II (Broadband Plasma Division, Illumination Group) - KLA #h(1fr) May 2026 - Present
- Execute integration and acceptance testing on broadband-plasma wafer-inspection tools, running automated test scripts and analyzing output against engineering specs to disposition optical and electro-mechanical sub-assemblies.
- Isolate defects that span software, optics, and hardware boundaries; characterize failures with oscilloscopes, accelerometers, and leak detectors, then drive rework and re-test until the assembly passes spec.
- Log, triage, and escalate non-conformances through KLA's internal test/quality software; work directly with Mechanical Design Engineers to close root causes and make ship dates for fabs including TSMC, Samsung, SK Hynix, and Micron.
- Capture test data, defects, and rework with full traceability, and surface recurring failure patterns to engineering for process improvement.
- Assemble and align precision optical and mechanical components to arcsecond angular and micrometer-to-nanometer positional tolerances in an ISO 9001, Class 100/10K cleanroom under ESD controls.
=== R&D Operator II - The Bot Company #h(1fr) Feb 2026 - May 2026
- Operated robotic platforms across multiple field sites, executing structured data-collection protocols to capture ground-truth training data for early-stage AI models.
- Ranked among the top operators on every daily metric (data volume, accuracy, throughput) in a performance-driven environment.
=== Robotics Operator - armstrong.ai #h(1fr) Jun 2025 - Jan 2026
- Operated multiple robots asynchronously through a proprietary dashboard and command-line tools for system-level control.
- Diagnosed and resolved day-to-day operational issues, coordinating with on-site technicians in real time to maintain continuous 24/7 uptime.
=== Security Forces - United States Air Force #h(1fr) Jun 2015 - Jun 2018
- Entry Controller for the second-largest non-nuclear joint installation in the Department of Defense; maintained security of the local SCIF and performed route clearance for visiting senior officials.
- Responded to and investigated 100+ unannounced alarm activations, incidents, criminal offenses, and traffic incidents.

== Projects
=== Rust GPIO Controller Web-Application #h(1fr) #link("https://github.com/nuttycream/pipin")[GitHub]
- Maintain a GPIO controller web-app with a Rust backend on an async Tokio runtime. GPIO control is implemented through direct memory-mapped register access on the gpiomem device; built for Raspberry Pi but accepts any GPIO device with a valid base address.
=== Omnidirectional Robot with Obstacle Avoidance/Tracking #h(1fr) #link("https://johnnacion.dev/posts/my-academic-magnum-opus/")[Article]
- Built a three-wheeled robot that autonomously follows multi-colored lines using omnidirectional movement. Written in C on a custom DMA library supporting GPIO, I2C, and SPI; ultrasonic sensors detect, track, and avoid obstacles along a dynamically computed path.
=== Cross-platform GUI to Modify Game Saves #h(1fr) #link("https://github.com/nuttycream/SH-Save-Editor")[GitHub]
- Developed an open-source save editor for a popular PC game with 50k+ downloads across modding forums and GitHub. C\# with Avalonia; parses and modifies XML via System.Xml with XPath and dotNET's task-based async library.
=== Version Control Automation using Large Language Models #h(1fr) #link("https://github.com/cube-cult/gai")[GitHub]
- Built a CLI that drives local and hosted LLM providers to generate commit messages from diffs using commit message conventions, plan rebases against a target branch, amend commits, and find commits via natural-language queries.

== Education
#grid(
  columns: (auto, 1fr),
  align: (left, right),
  gutter: 5pt,
  [Bachelor of Science, Computer Science], [San Francisco State University, 2025],
)
