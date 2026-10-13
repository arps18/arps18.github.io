---
title: "Portman"
description: "Your friendly port manager."
summary: "A small, open-source macOS CLI written in Go. See which process is listening on a local TCP port with one command."
url: "/portman/"
ShowToc: false
ShowReadingTime: false
ShowPostNavLinks: false
hideMeta: true
---

<div class="portman-meta" aria-label="Project details">
  <a class="badge active" href="https://github.com/arps18/portman/releases/tag/v0.1.0" target="_blank" rel="noopener noreferrer">v0.1.0</a>
  <span class="badge">macOS</span>
  <span class="badge">Written in Go</span>
  <span class="badge">MIT license</span>
</div>

**Port already in use? Find out what's listening.** Portman shows the process behind a local TCP port with one command, so you can get back to building.

[View on GitHub](https://github.com/arps18/portman) · [Releases](https://github.com/arps18/portman/releases) · [Report an issue](https://github.com/arps18/portman/issues)

## <i class="fi fi-rr-rocket"></i> Install

On macOS, install with [Homebrew](https://brew.sh/):

```sh {linenos=false}
brew install arps18/tap/portman
```

Requires `lsof`. Prebuilt binaries for Apple Silicon and Intel Macs, along with checksums, are also available on the [release page](https://github.com/arps18/portman/releases/latest).

## <i class="fi fi-rr-search"></i> Find a listener

Pass the port you want to inspect:

```sh {linenos=false}
portman 3000
```

You'll see the listening process, its PID, and the address it's bound to. Example output (with identifying details replaced):

```text {linenos=false}
COMMAND   PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
Python  12345 dev     3u  IPv4 0x0000      0t0  TCP 127.0.0.1:3000 (LISTEN)
```

Nothing listening? Portman tells you that too:

```text {linenos=false}
No TCP listeners found on port 3000
```

Use a port between `1` and `65535`. A completed inspection exits with status `0`, even when there are no listeners. Invalid input or an inspection failure exits with status `1`.

Portman currently inspects **TCP listeners on macOS**. Results depend on what `lsof` can see with your permissions. It does not stop processes.

## <i class="fi fi-rr-robot"></i> Use with coding agents

Coding agents with shell access can run Portman when it's installed and on their `PATH`. Add this to your agent's project instructions:

```text {linenos=false}
When a development server reports a port conflict, run
portman <port> to inspect its TCP listeners.
```

No dedicated integration is needed; Portman returns terminal output.

## <i class="fi fi-rr-calendar"></i> Releases & roadmap

<div class="card">
  <div class="card-header">
    <h3><a href="https://github.com/arps18/portman/releases/tag/v0.1.0" target="_blank" rel="noopener noreferrer">v0.1.0 — First release</a></h3>
    <span class="badge active">released</span>
  </div>
  <div class="card-content">
    <p>Inspect a local TCP port on macOS, with Homebrew installation and binaries for Apple Silicon and Intel Macs.</p>
    <p><a href="https://github.com/arps18/portman/commits/v0.1.0" target="_blank" rel="noopener noreferrer">Browse the changelog →</a></p>
  </div>
</div>

Planned next steps from the project's roadmap. These features are **not yet released**, and scope may change:

| Version | Planned work |
| --- | --- |
| v0.2.0 | Help and version commands; clearer errors |
| v0.3.0 | List all visible TCP listeners |
| v0.4.0 | JSON output for scripts and tools |
| v0.5.0 | Stop a listener with confirmation and graceful termination |
| v0.6.0 | Linux support |
| v0.7.0 | Watch a port for listener changes |

[See all releases](https://github.com/arps18/portman/releases) for the latest version and downloads.

## <i class="fi fi-rr-lightbulb"></i> About the project

I'm building Portman as a hobby project to learn Go, testing, CLI design, and operating-system fundamentals. Small tool, real development problem.

The code is [MIT licensed](https://github.com/arps18/portman/blob/main/LICENSE). Want to explore or contribute? Start with the [source and development instructions](https://github.com/arps18/portman#development), or [open an issue](https://github.com/arps18/portman/issues).

[← Back to projects](/projects/)
