---
title: "Projects"
url: "/projects"
summary: "A curated list of my personal projects"
ShowToc: false
ShowReadingTime: false
hideMeta: true
---

A curated list of things I've built — across distributed systems, systems programming, and IoT. Most of these started as experiments and grew from there.

<div class="projects-container">

<div class="card">
  <div class="card-header">
    <h3><a href="https://github.com/arps18/Project-Andromex" target="_blank" rel="noopener">Project Andromex — Minimal Compiler in Go</a></h3>
    <span class="badge active">active</span>
  </div>
  <div class="card-content">
    <p>A minimal compiler written in Go to understand how programming languages are tokenized, parsed, and evaluated.</p>
    <p><strong>Tech:</strong> Go · Compilers · Lexer · REPL · AST</p>
    <ul>
      <li>Lexer that converts source code into a well-defined token type system</li>
      <li>Interactive REPL for real-time experimentation with the language</li>
      <li>Extensible architecture planned for AST parsing, semantic analysis, and code generation</li>
    </ul>
  </div>
</div>

<div class="card">
  <div class="card-header">
    <h3><a href="https://github.com/arps18/Paxos" target="_blank" rel="noopener">Paxos — Fault-Tolerant Distributed Key-Value Store</a></h3>
  </div>
  <div class="card-content">
    <p>A fault-tolerant, replicated key-value store using the Paxos consensus algorithm, resilient against replica failures.</p>
    <p><strong>Tech:</strong> Java · Paxos · Java RMI · Distributed Systems · Consensus</p>
    <ul>
      <li>Full Paxos implementation with Proposer, Acceptor, and Learner roles based on Lamport's work</li>
      <li>Supports GET, PUT, DELETE operations with multiple replicas and dynamic client requests</li>
      <li>Simulated acceptor thread failures to demonstrate fault tolerance</li>
    </ul>
  </div>
</div>

<div class="card">
  <div class="card-header">
    <h3><a href="https://github.com/arps18/QuickLauncher" target="_blank" rel="noopener">QuickLauncher — Social Media Browser Extension</a></h3>
  </div>
  <div class="card-content">
    <p>A simple, customizable browser extension for one-click access to all your social media profiles.</p>
    <p><strong>Tech:</strong> HTML · CSS · JavaScript · Browser Extension · Chrome · Firefox</p>
    <ul>
      <li>One-click access to multiple social media profiles from the browser toolbar</li>
      <li>Fully customizable — swap in personal images and custom links</li>
      <li>Cross-browser compatible (Chrome, Edge, Firefox) with simple load-unpacked install</li>
    </ul>
  </div>
</div>

<div class="card">
  <div class="card-header">
    <h3><a href="https://github.com/arps18/Crypto-Track" target="_blank" rel="noopener">Crypto-Track — Real-time Cryptocurrency Tracker</a></h3>
  </div>
  <div class="card-content">
    <p>A real-time cryptocurrency price tracker web app — track prices of cryptocurrencies on the go.</p>
    <p><strong>Tech:</strong> JavaScript · HTML · CSS · REST APIs</p>
    <ul>
      <li>Real-time cryptocurrency price monitoring with automatic updates on refresh</li>
      <li>Clean web-based interface built with vanilla JS, HTML, and CSS</li>
      <li>Live demo deployed on Netlify</li>
    </ul>
  </div>
</div>

<div class="card">
  <div class="card-header">
    <h3><a href="https://github.com/arps18/gym_management_SQL" target="_blank" rel="noopener">Gym Management — DBMS Demonstration</a></h3>
  </div>
  <div class="card-content">
    <p>A DBMS demonstration script showcasing structured data management with Python — modeled on the Marino Center Gym.</p>
    <p><strong>Tech:</strong> Python · SQL · Triggers · Functions · CRUD</p>
    <ul>
      <li>Demonstrates core DBMS concepts: triggers, stored functions, and constraints</li>
      <li>Full CRUD operations with an interactive command-line interface via <code>demo.py</code></li>
      <li>Educational resource for learning SQL and database management principles</li>
    </ul>
  </div>
</div>

<div class="card">
  <div class="card-header">
    <h3><a href="https://github.com/arps18/PageRank-spark" target="_blank" rel="noopener">PageRank — Spark & Hadoop MapReduce</a></h3>
  </div>
  <div class="card-content">
    <p>PageRank algorithm implemented in both Apache Spark and Hadoop MapReduce to demonstrate distributed computation paradigms.</p>
    <p><strong>Tech:</strong> Scala · Apache Spark · Hadoop · MapReduce · AWS EMR</p>
    <ul>
      <li>Spark implementation using RDD-based API with dangling page handling</li>
      <li>Comparative Hadoop MapReduce implementation for performance analysis</li>
      <li>Supports standalone Hadoop, pseudo-distributed, and AWS EMR execution environments</li>
    </ul>
  </div>
</div>

<div class="card">
  <div class="card-header">
    <h3><a href="https://github.com/arps18/Twitter-Follower-Count" target="_blank" rel="noopener">Twitter Follower Count — Distributed Processing</a></h3>
  </div>
  <div class="card-content">
    <p>Distributed data processing pipeline using Hadoop MapReduce and Spark for large-scale follower count analysis.</p>
    <p><strong>Tech:</strong> Scala · Hadoop · Apache Spark · MapReduce · AWS EMR · Maven</p>
    <ul>
      <li>Hadoop MapReduce and Spark implementations for distributed follower data processing</li>
      <li>Supports standalone, pseudo-distributed, and AWS EMR execution environments</li>
      <li>Makefile-driven build and deployment pipeline with Maven dependency management</li>
    </ul>
  </div>
</div>

<div class="card">
  <div class="card-header">
    <h3><a href="https://github.com/arps18/Daily-Finance" target="_blank" rel="noopener">Market Radar — Automated Daily Stock Screener</a></h3>
  </div>
  <div class="card-content">
    <p>An automated daily stock screening service that delivers curated investment opportunities to your inbox every weekday morning at 7 AM Central.</p>
    <p><strong>Tech:</strong> Python · GitHub Actions · SMTP · yfinance · Anthropic Claude API · RSI · Moving Averages</p>
    <ul>
      <li>Two-tier screening: 10 blue-chip movers and 10 under-the-radar picks from 500+ stocks, diversified across 5+ sectors</li>
      <li>Optional LLM enhancement via Claude or OpenAI for AI-synthesized news context alongside technical signals (~$0.003/day)</li>
      <li>Fully automated via GitHub Actions on a weekday schedule — zero manual intervention required</li>
    </ul>
  </div>
</div>

<div class="card">
  <div class="card-header">
    <h3><a href="https://github.com/arps18/iOS-Demo_App" target="_blank" rel="noopener">iOS Demo App</a></h3>
  </div>
  <div class="card-content">
    <p>A Swift-based iOS demo application built as an early exploration of iOS development patterns.</p>
    <p><strong>Tech:</strong> Swift · iOS · Xcode · UIKit</p>
    <ul>
      <li>Standard Xcode project structure with unit tests and UI tests</li>
      <li>Demonstrates foundational iOS app architecture patterns</li>
    </ul>
  </div>
</div>

<div class="card">
  <div class="card-header">
    <h3><a href="https://github.com/arps18" target="_blank" rel="noopener">Distributed Key-Value Store Server</a></h3>
  </div>
  <div class="card-content">
    <p>A distributed key-value store with client-server communication supporting both UDP and TCP protocols.</p>
    <p><strong>Tech:</strong> Java · UDP · TCP · Socket Programming · Multithreading</p>
    <ul>
      <li>Supported both UDP and TCP protocols, achieving a 98% success rate for seamless client-server interaction</li>
      <li>Utilized hash maps for efficient storage and retrieval of up to 10,000 key-value pairs, with average access time of 5ms</li>
      <li>Implemented multithreading for concurrent client handling</li>
    </ul>
  </div>
</div>

<div class="card">
  <div class="card-header">
    <h3><a href="https://github.com/arps18" target="_blank" rel="noopener">Unix-like File System</a></h3>
  </div>
  <div class="card-content">
    <p>A POSIX-compliant file system implementation in C with inode-based metadata management.</p>
    <p><strong>Tech:</strong> C · POSIX · System Calls · Pointers · Linked Lists</p>
    <ul>
      <li>Implemented file creation, deletion, reading, writing, and directory traversal</li>
      <li>Designed modular structures for <code>readdir</code>, <code>read</code>, and <code>write</code> operations, reducing implementation complexity by 30%</li>
      <li>Inode-based metadata management for efficient file tracking</li>
    </ul>
  </div>
</div>

<div class="card">
  <div class="card-header">
    <h3><a href="https://github.com/arps18" target="_blank" rel="noopener">Scudo Systems — Real-time GPS Tracking</a></h3>
  </div>
  <div class="card-content">
    <p>Co-founded venture building IoT tracking hardware and the software that powers it.</p>
    <p><strong>Tech:</strong> Python · Raspberry Pi · IoT · REST APIs</p>
    <ul>
      <li>Developed a custom software system for real-time tracking with 90% accuracy</li>
      <li>Restructured GPS algorithm to provide 10-meter radius accurate location</li>
      <li>Conducted extensive testing for production readiness with 40% faster response times</li>
    </ul>
  </div>
</div>

<div class="card">
  <div class="card-header">
    <h3><a href="https://www.irjet.net" target="_blank" rel="noopener">Parkup — Smart Parking System</a></h3>
  </div>
  <div class="card-content">
    <p>Research project for an intelligent parking management system, published in IRJET.</p>
    <p><strong>Tech:</strong> IoT · Sensors · Cloud · Research</p>
    <ul>
      <li>Co-authored and published in the International Research Journal of Engineering and Technology</li>
      <li>Focused on real-time parking slot availability using sensor networks</li>
    </ul>
  </div>
</div>

<div class="card">
  <div class="card-header">
    <h3><a href="https://github.com/arps18" target="_blank" rel="noopener">Flutter Shortcut Widget</a></h3>
  </div>
  <div class="card-content">
    <p>Open-source contribution to Flutter's widget ecosystem through the "Adopt a Widget" campaign.</p>
    <p><strong>Tech:</strong> Flutter · Dart · Open Source</p>
    <ul>
      <li>Contributed documentation, examples, and bug fixes for the shortcut widget</li>
      <li>Helped other Flutter developers adopt the widget more easily</li>
    </ul>
  </div>
</div>

</div>

*Want to see more? My [GitHub](https://github.com/arps18) has the full collection.*
