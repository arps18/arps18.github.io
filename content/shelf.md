---
title: "Shelf"
url: "/shelf/"
summary: "Books, papers, and articles worth your time"
ShowToc: true
TocOpen: false
ShowReadingTime: false
hideMeta: true
disableAnchoredHeadings: false
---

A running collection of things I've read and found worth keeping around — books that shaped how I think, papers that sharpened my technical depth, and articles I return to. Updated as I read.

## 📚 Books

### Currently Reading

- **Designing Data-Intensive Applications** — _Martin Kleppmann_
  The book on distributed systems. Replication, partitioning, consistency models, stream processing — explained in a way that actually sticks. If you build backend systems, this is non-negotiable.

### Finished & Recommended

- **Clean Code** — _Robert C. Martin_
  Dated in places, dogmatic in others, but the core instincts around naming, function size, and commenting are habits that stayed with me.

- **The Pragmatic Programmer** — _David Thomas, Andrew Hunt_
  Timeless. "DRY," "orthogonality," broken-windows theory applied to code — concepts I reach for constantly.

- **Grokking Algorithms** — _Aditya Bhargava_
  The best visual introduction to algorithms I've found. Gave to a friend learning to code and they finished it in a weekend.

- **Atomic Habits** — _James Clear_
  Not a tech book, but the framing around small, compounding changes shaped how I approach long projects.

### To Read

- **Database Internals** — _Alex Petrov_
- **System Design Interview (Vol. 1 & 2)** — _Alex Xu_
- **The Phoenix Project** — _Gene Kim, Kevin Behr, George Spafford_
- **Site Reliability Engineering** — _Betsy Beyer et al._ (the Google SRE book, free online)

---

## 📄 Papers

Research papers that taught me something durable about systems.

- **[The Google File System](https://static.googleusercontent.com/media/research.google.com/en//archive/gfs-sosp2003.pdf)** _(Ghemawat, Gobioff, Leung — 2003)_
  The ancestor of HDFS and, indirectly, most modern distributed storage. Reading the original is worth the hour.

- **[MapReduce: Simplified Data Processing on Large Clusters](https://static.googleusercontent.com/media/research.google.com/en//archive/mapreduce-osdi04.pdf)** _(Dean, Ghemawat — 2004)_
  Alongside GFS, this is the paper that gave us the big-data era.

- **[Dynamo: Amazon's Highly Available Key-Value Store](https://www.allthingsdistributed.com/files/amazon-dynamo-sosp2007.pdf)** _(DeCandia et al. — 2007)_
  Consistent hashing, vector clocks, eventual consistency — the foundation for Cassandra, Riak, and DynamoDB.

- **[Bigtable: A Distributed Storage System for Structured Data](https://static.googleusercontent.com/media/research.google.com/en//archive/bigtable-osdi06.pdf)** _(Chang et al. — 2006)_
  The design still shows up everywhere. Reading this clarified a lot about how HBase and Cassandra actually work underneath.

- **[In Search of an Understandable Consensus Algorithm (Raft)](https://raft.github.io/raft.pdf)** _(Ongaro, Ousterhout — 2014)_
  Consensus, finally explained so a human can follow it. If Paxos left you confused, read Raft.

- **Parkup: Smart Parking System** _(Patel, co-author — IRJET, 2021)_
  My own contribution — an IoT-based parking management system published in the International Research Journal of Engineering and Technology.

---

## 📰 Articles

Short-form writing I've bookmarked and returned to.

### Engineering & Systems

- **[How Discord Stores Trillions of Messages](https://discord.com/blog/how-discord-stores-trillions-of-messages)** — a great real-world Cassandra-to-ScyllaDB migration story.
- **[The Twelve-Factor App](https://12factor.net/)** — old but still the cleanest statement of how cloud-native apps should be built.
- **[Latency Numbers Every Programmer Should Know](https://gist.github.com/jboner/2841832)** — Jeff Dean's classic. Memorize at least the orders of magnitude.
- **[Google's Site Reliability Engineering Book](https://sre.google/sre-book/table-of-contents/)** — free online, endlessly referenced.

### Career & Craft

- **[Things You Should Never Do, Part I](https://www.joelonsoftware.com/2000/04/06/things-you-should-never-do-part-i/)** — Joel Spolsky on rewrites. Two decades later, still right.
- **[What I Wish Someone Had Told Me](https://blog.samaltman.com/what-i-wish-someone-had-told-me)** — Sam Altman's distilled advice. Short, dense, good.
- **[Do Things That Don't Scale](http://paulgraham.com/ds.html)** — Paul Graham, aimed at founders but applicable to engineers too.

### Distributed Systems Deep Dives

- **[Notes on Distributed Systems for Young Bloods](https://www.somethingsimilar.com/2013/01/14/notes-on-distributed-systems-for-young-bloods/)** — Jeff Hodges. Opinionated, practical, quotable.
- **[Fallacies of Distributed Computing Explained](https://pages.cs.wisc.edu/~zuyu/files/fallacies.pdf)** — the eight fallacies every distributed-systems engineer eventually re-discovers the hard way.

---

_Have a recommendation? [Email me](mailto:arpanpatel.contact@gmail.com) — always taking suggestions._
