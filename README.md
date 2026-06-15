# arps18.github.io

Personal site built with [Hugo](https://gohugo.io) + [PaperMod](https://github.com/adityatelange/hugo-PaperMod/).

Live at [arps18.github.io](https://arps18.github.io).

## Stack

- Hugo Extended + PaperMod theme
- GitHub Actions for deploys
- Fuse.js for search
- KaTeX for math, Mermaid for diagrams

## Running locally

Requires Hugo Extended.

```bash
brew install hugo          # macOS
hugo version               # should print "extended"
```

```bash
git submodule update --init --recursive
hugo server -D
```

Opens at `http://localhost:1313`.

## Structure

```
.
├── hugo.yaml                    # site config
├── archetypes/posts.md          # post template
├── assets/css/extended/
│   └── custom.css               # theme overrides
├── content/
│   ├── about/index.md
│   ├── projects/index.md
│   ├── cv.md
│   ├── resources.md
│   ├── shelf.md
│   ├── search.md
│   └── posts/
├── layouts/
│   ├── _default/                # list and profile overrides
│   ├── partials/
│   │   ├── extend_head.html
│   │   └── extend_footer.html
│   └── shortcodes/
│       ├── tip.html
│       └── excalidraw.html
├── static/
│   ├── images/profile.png
│   ├── resume.pdf
│   └── favicon*
└── .github/workflows/hugo.yaml
```

## Writing a post

```bash
hugo new content posts/my-post.md
```

Frontmatter:

```yaml
---
title: "Post title"
date: 2026-01-01
draft: false
tags: []
categories: []
summary: ""
ShowToc: true
TocOpen: false
---
```

## Shortcodes

**Tip callout**

```
{{< tip >}}
Note text here.
{{< /tip >}}
```

**Math** -- inline `\(E = mc^2\)`, block `$$ ... $$`

**Mermaid** -- fenced code block with `mermaid` as the language

## Theming

PaperMod exposes CSS variables. Override in `assets/css/extended/custom.css`:

```css
:root {
  --theme: #faf8f3;
  --primary: #1a1a1a;
}

.dark {
  --theme: #1d1e20;
  --primary: #d0d0d0;
}
```

## Deploy

Pushes to `main` trigger `.github/workflows/hugo.yaml`, which builds and deploys to GitHub Pages.

One-time setup: **Settings > Pages > Source: GitHub Actions**.

### Custom domain

1. Add your domain under **Settings > Pages > Custom domain**.
2. Point DNS at GitHub:
   - A records: `185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153`
   - or CNAME to `arps18.github.io`
3. Update `baseURL` in `hugo.yaml`.

## Commands

```bash
hugo server -D                          # dev server with drafts
hugo server                             # production preview
hugo --minify                           # build
git submodule update --remote --merge   # update PaperMod
```

## License

- Source code (layouts, config, shortcodes): [MIT](LICENSE)
- Blog posts and written content under `content/`: [CC BY 4.0](LICENSE-CONTENT)

PaperMod is also MIT licensed. See its [license](https://github.com/adityatelange/hugo-PaperMod/blob/master/LICENSE).

## Credits

- [Hugo](https://gohugo.io)
- [PaperMod](https://github.com/adityatelange/hugo-PaperMod/) by [Aditya Telange](https://adityatelange.in)
- Icons from [Flaticon](https://www.flaticon.com)
