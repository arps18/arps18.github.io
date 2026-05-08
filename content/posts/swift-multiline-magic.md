---
title: "Swift Multiline Magic: Say Goodbye to Annoying Line Breaks!"
date: 2023-05-25T00:00:00+00:00
draft: false
tags: ["swift", "ios", "tips"]
categories: ["engineering"]
summary: "A Swift syntax technique for managing multiline strings without unwanted characters."
ShowToc: false
TocOpen: false
---

If you are new to Swift and find yourself encountering those annoying `\n` characters after each statement in multiline code, fret not. While they indicate a new line, there's a simple trick to remove them and still maintain clean code formatting.

By adding a backslash (`\`) at the end of each line, you can effectively break multiline statements without the unwanted line breaks:

```swift
let greeting = "Hello, " +
               "world!"
```

However, keep in mind that Swift doesn't allow a backslash at the end of the last line in a multiline statement. So, remember to avoid that to prevent any errors.

That's it for this quick tip! Stay tuned for more exciting Swift insights.
