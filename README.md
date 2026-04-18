# Arpan Patel — Portfolio Website

A personal portfolio website built with [Hugo](https://gohugo.io) and the [PaperMod](https://github.com/adityatelange/hugo-PaperMod/) theme. Matches the style of [adityatelange.in](https://adityatelange.in) — which, fittingly, is the site of PaperMod's own maintainer.

## ✨ Features

- **Profile mode** homepage with photo, bio, and call-to-action buttons
- **About / Projects / Posts / Tags / Search** — full navigation
- **Fuse.js-powered search** across all content
- **Auto light/dark mode** that follows system preference
- **RSS feed** for blog subscribers
- **Fully responsive** — works on mobile, tablet, desktop
- **SEO-friendly** with JSON-LD, OpenGraph, Twitter cards
- **GitHub Actions deployment** to GitHub Pages on push

---

## 🚀 Quick start

### Prerequisites

You need **Hugo Extended** (not regular Hugo — PaperMod requires the extended version).

```bash
# macOS
brew install hugo

# Linux (Snap)
sudo snap install hugo

# Windows
choco install hugo-extended

# Verify — should say "extended" in the output
hugo version
```

You also need **Git**.

### Setup

```bash
# 1. cd into the project folder
cd arpan-portfolio

# 2. Run the setup script (installs PaperMod theme)
./setup.sh

# 3. Start the dev server
hugo server -D
```

Open [http://localhost:1313](http://localhost:1313) and you're live.

### Add your personal assets

1. **Profile photo** — save as `static/images/profile.png` (150×150px recommended)
2. **Resume PDF** — save as `static/resume.pdf`
3. **Favicon** — save as `static/favicon.ico` (optional — Hugo will work without it)

---

## ✏️ Customization

### Edit your info

- **Site-wide settings:** `hugo.yaml` — title, description, social links, menu items
- **About page:** `content/about/index.md`
- **Projects page:** `content/projects/index.md`
- **Homepage text:** `hugo.yaml` under `profileMode`

### Add a new blog post

```bash
hugo new content posts/my-new-post.md
```

Or just drop a `.md` file in `content/posts/` with this frontmatter:

```yaml
---
title: "Your Post Title"
date: 2026-04-18
draft: false
tags: ["tag1", "tag2"]
summary: "A one-line description for the listing page."
---

Your content here...
```

### Swap themes/colors

PaperMod uses CSS variables. Override them by creating `assets/css/extended/custom.css`. Example:

```css
:root {
    --theme: #ffffff;
    --primary: #1a1a1a;
    --secondary: #666666;
    --tertiary: #eaeaea;
    --content: #333333;
}

.dark {
    --theme: #1d1e20;
    --primary: #d0d0d0;
    --secondary: #aaaaaa;
    --tertiary: #333333;
    --content: #d1d1d1;
}
```

---

## 🌐 Deploy to GitHub Pages

### One-time setup

1. **Create the repo.** Name it `arps18.github.io` (or any name — but that naming gives you a cleaner URL).

2. **Push your code:**
   ```bash
   git add .
   git commit -m "Initial portfolio site"
   git branch -M main
   git remote add origin https://github.com/arps18/arps18.github.io.git
   git push -u origin main
   ```

3. **Enable Pages:** Go to your repo → **Settings → Pages → Source: GitHub Actions**.

4. The included workflow (`.github/workflows/hugo.yaml`) runs automatically on every push to `main`. Your site will be live at `https://arps18.github.io/` within a minute or two.

### Custom domain (optional)

1. Buy a domain (Namecheap, Cloudflare, Porkbun — all fine).
2. In your repo: **Settings → Pages → Custom domain** → enter your domain.
3. Set DNS records at your registrar:
   - **A records** → `185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153`
   - Or **CNAME** → `arps18.github.io` (for subdomains like `www.`)
4. Update `baseURL` in `hugo.yaml` to your new domain.

---

## 📁 Project structure

```
arpan-portfolio/
├── hugo.yaml                    # Main config
├── content/
│   ├── about/index.md           # About page
│   ├── projects/index.md        # Projects page
│   ├── search.md                # Search page (uses Fuse.js)
│   └── posts/                   # Blog posts
│       ├── _index.md
│       ├── sql-optimization.md
│       ├── micronaut-intro.md
│       └── kubernetes-lessons.md
├── static/
│   ├── images/
│   │   └── profile.png          # Your photo (add this)
│   └── resume.pdf               # Your resume (add this)
├── themes/
│   └── PaperMod/                # Theme (added by setup.sh)
├── .github/workflows/
│   └── hugo.yaml                # Auto-deploy workflow
├── setup.sh                     # Setup script
└── README.md                    # This file
```

---

## 🔧 Useful commands

```bash
# Run dev server (auto-reloads on save)
hugo server -D

# Dev server with drafts hidden (production preview)
hugo server

# Build for production
hugo --minify

# Create a new post
hugo new content posts/my-post.md

# Update PaperMod theme later
git submodule update --remote --merge
```

---

## 🙏 Credits

- [Hugo](https://gohugo.io) — the static site generator
- [PaperMod](https://github.com/adityatelange/hugo-PaperMod/) by [Aditya Telange](https://adityatelange.in) — the theme
- Reference site that inspired this: [adityatelange.in](https://adityatelange.in)

---

**License:** MIT. Do whatever you want with the config and content structure.
