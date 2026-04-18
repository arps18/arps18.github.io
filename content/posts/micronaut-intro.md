---
title: "Building REST APIs with Micronaut: A Practical Introduction"
date: 2026-02-10T14:00:00-05:00
draft: false
tags: ["micronaut", "java", "rest", "microservices"]
categories: ["engineering"]
summary: "Why I picked Micronaut over Spring Boot for microservices — and what I learned along the way."
ShowToc: true
TocOpen: false
---

I've been building REST APIs with [Micronaut](https://micronaut.io) for about a year now, and I keep getting asked why I didn't just use Spring Boot. Here's the honest answer.

## What Micronaut does differently

Micronaut does dependency injection and AOP at **compile time**, not runtime. That means:

- **Faster startup** — typically under a second, compared to 5-10s for equivalent Spring apps
- **Lower memory footprint** — critical when you're running many microservices in Kubernetes
- **No reflection overhead** — better performance in steady state

For container-heavy architectures where you're scaling pods up and down constantly, those startup times matter a lot.

## A minimal example

Here's what a basic controller looks like:

```java
@Controller("/api/users")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @Get("/{id}")
    public HttpResponse<User> getUser(@PathVariable Long id) {
        return userService.findById(id)
            .map(HttpResponse::ok)
            .orElse(HttpResponse.notFound());
    }

    @Post
    public HttpResponse<User> createUser(@Body @Valid UserRequest request) {
        User created = userService.create(request);
        return HttpResponse.created(created);
    }
}
```

If you've used Spring before, this will look familiar. The annotations are similar, the mental model is similar. The difference is all under the hood.

## Where it shines

- **Serverless** — cold starts are dramatically shorter
- **Microservices on Kubernetes** — faster pod readiness means quicker rollouts
- **GraalVM native images** — Micronaut was designed with this in mind from day one

## Where Spring still wins

- **Ecosystem.** Spring has a library for everything. Micronaut is catching up but it's not there yet.
- **Team familiarity.** If your team already knows Spring inside and out, retraining has a cost.
- **Stack Overflow answers.** Still much more for Spring problems.

## My take

Pick Micronaut when startup time, memory, or native compilation matters. Pick Spring when ecosystem depth or team familiarity matters. There's no universally right answer — and that's fine.
