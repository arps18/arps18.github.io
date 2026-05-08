---
title: "Building Welcome Message in CLI"
date: 2022-12-06T00:00:00+00:00
draft: false
tags: ["python", "cli", "terminal"]
categories: ["engineering"]
summary: "Python CLI customization for building welcome messages using PyFiglet."
ShowToc: false
TocOpen: false
---

Python is one of the most popular languages to play around with different things and I like experimenting with the command line. The command line is still one of the best tools for a developer to play around with.

So, I was building a project which worked on CLI, built with Python. While I was almost done finishing my project, I thought there was something missing, something cool.

I wanted to display a welcome message with a bit of enlarged text so a user feels welcome. And while browsing, I came across a wonderful Python module called [Pyfiglet](https://github.com/pwaller/pyfiglet). It is a Python module for converting strings into ASCII text with artistic fonts and can be modified into various patterns as well. Check out [http://www.figlet.org/](http://www.figlet.org/) for more.

It is very simple to use. First, install it:

```bash
pip install pyfiglet
```

Then use it in your script:

```python
import pyfiglet

result = pyfiglet.figlet_format("Welcome!")
print(result)
```

This will render your welcome message as large ASCII art in the terminal — a small touch that makes CLI tools feel a lot more polished.

Do share your thoughts on the same, feedbacks appreciated!
