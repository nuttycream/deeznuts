#set text(
  font: "IBM Plex Serif",
  size: 8pt,
)

#show heading.where(level: 2): set block(above: 0.5em, below: 0.5em)
#show heading.where(level: 3): set block(above: 0.75em, below: 0.8em)

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
USAF veteran and Test Engineer with a B.S. in Computer Science. Integrate and test precision optical and electro-mechanical sub-assemblies in a cleanroom, isolate faults across software, optics, and hardware using automated test frameworks and log analysis, and build embedded and systems tooling in Rust.

#line(length: 100%)

== Skills
#grid(
  columns: (auto, auto),
  align: (left, left),
  gutter: 5pt,
  [*Languages & Software:*],
  [Rust, C/C++, C\#, Python, Bash, Git, GNU/Linux, embedded GPIO/I2C/SPI, DMA, memory-mapped I/O],

  [*Test Equipment:*],
  [Oscilloscopes, DMM, accelerometers (vibration measurement), electronic leak detectors (vacuum integrity), pressure gauges, optical and electron microscopes, calipers, torque and precision hand tools],

  [*Manufacturing & Quality:*],
  [ISO 9001, Class 100/10K cleanroom, ESD, SOP/work-instruction compliance, non-conformance (NC) logging and escalation, test traceability, root-cause analysis],
)

#line(length: 100%)

== Experience
=== Test Engineer II (Broadband Plasma Division, Illumination Group) - KLA #h(1fr) May 2026 - Present
- Execute automated acceptance-test scripts using an internal Java/Jython test framework on broadband-plasma wafer-inspection tools; configure test parameters and flags per build, then analyze output against engineering specs to disposition optical and electro-mechanical sub-assemblies.
- Debug test failures by tracing Jython/Java stack traces and application logs to the failing module, then determine whether the root cause is in the test software, the optics, or the hardware before escalating.
- Characterize hardware faults with oscilloscopes, accelerometers, and leak detectors; drive rework and re-test until the assembly passes spec.
- Log, triage, and escalate non-conformances in KLA's internal test/quality software; work directly with Mechanical Design Engineers to close root causes and hold ship dates for TSMC, Samsung, SK Hynix, and Micron.
- Record test data, defects, and rework with full traceability; surface recurring failure patterns to engineering for process improvement.
- Assemble and align precision optical and mechanical components to arcsecond angular and micrometer-to-nanometer positional tolerances under ESD controls.

=== R&D Operator II - The Bot Company #h(1fr) Feb 2026 - May 2026
- Executed structured data-collection protocols on robotic platforms across multiple field sites, producing ground-truth training data for early-stage AI models.
- Top-ranked operator on every daily metric specifically for data volume, accuracy, and throughput.

=== Robotics Systems Operator - armstrong.ai #h(1fr) Jun 2025 - Jan 2026
- Controlled a fleet of robots asynchronously via a telemetry dashboard and command-line tools for system-level control.
- Diagnosed hardware and software faults in real time with on-site technicians to maintain continuous 24/7 uptime.

=== Security Forces - United States Air Force #h(1fr) Jun 2015 - Jun 2018
- Entry Controller for the second-largest non-nuclear joint installation in the DoD; secured the local SCIF and performed route clearance for senior officials.
- Responded to and investigated 100+ alarm activations, incidents, and criminal offenses.

#line(length: 100%)

== Projects
=== Rust GPIO Controller Web-Application #h(1fr) #link("https://github.com/nuttycream/pipin")[GitHub]
- Maintain a GPIO controller web-app with a Rust backend on an async Tokio runtime; GPIO control via direct memory-mapped register access on the gpiomem device. Built for Raspberry Pi, accepts any GPIO device with a valid base address.
=== Omnidirectional Robot with Obstacle Avoidance/Tracking #h(1fr) #link("https://johnnacion.dev/posts/my-academic-magnum-opus/")[Article]
- Built a three-wheeled robot that autonomously follows multi-colored lines. Written in C on a custom DMA library supporting GPIO, I2C, and SPI; ultrasonic sensors detect, track, and avoid obstacles along a dynamically computed path.
=== Cross-platform GUI to Modify Game Saves #h(1fr) #link("https://github.com/nuttycream/SH-Save-Editor")[GitHub]
- Open-source save editor for a popular PC game, 50k+ downloads across forums and GitHub. Made in C\# with Avalonia; parses and modifies XML via System.Xml with XPath and dotNET's task-based async library.
=== Version Control Automation using Large Language Models #h(1fr) #link("https://github.com/cube-cult/gai")[GitHub]
- Built a CLI that uses local and hosted LLM providers to generate convention-compliant commit messages from diffs, plan rebases, amend commits, and find commits via natural-language queries.

#line(length: 100%)

== Education
#grid(
  columns: (auto, 1fr),
  align: (left, right),
  gutter: 5pt,
  [Bachelor of Science, Computer Science], [San Francisco State University, 2025],
)
