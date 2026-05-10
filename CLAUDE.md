# corbinfanning.com

Personal site of Corbin Fanning. Built with Astro, deployed on Vercel,
iterated on primarily from the Claude Code mobile/web app.

## Stack

- **Astro 4** — static-first, markdown-driven, content collections.
- **Vercel** — production at https://corbinfanning.com from `master`; every PR
  gets a preview deploy URL.
- **Claude Code** — `.claude/` holds the session-start hook and committed
  permissions. See "Mobile workflow" below.

## Project layout

```
src/
  content/
    config.ts          # Zod schemas for the writing + projects collections
    writing/*.md       # one file per post
    projects/*.md      # one file per project
  layouts/BaseLayout.astro
  pages/
    index.astro        # home
    about.astro
    writing/
      index.astro      # post list
      [...slug].astro  # post detail
    projects/
      index.astro      # project grid
      [...slug].astro  # project detail
  styles/global.css
public/                # static assets (images, resume, etc.)
.claude/
  settings.json        # committed: SessionStart hook + Bash allowlist
  hooks/session-start.sh
```

## Adding a post

Create `src/content/writing/<slug>.md`:

```md
---
title: 'Your title'
description: 'One-line summary.'  # optional
pubDate: 2026-05-09
draft: false                      # set true to hide from indexes
tags: ['tag-a']
---

Body in markdown.
```

Drafts (`draft: true`) are filtered out of the writing index, the home page,
and dynamic routes — they don't render anywhere public, so it's safe to
commit work-in-progress.

## Adding a project

Create `src/content/projects/<slug>.md`:

```md
---
title: 'Project name'
description: 'Short pitch.'
pubDate: 2026-05-09
status: active        # active | shipped | archived | idea
repo: https://...     # optional
demo: https://...     # optional
tags: ['astro']
draft: false
---

Project notes in markdown.
```

## Commands

| Command            | What it does                                    |
| ------------------ | ----------------------------------------------- |
| `npm run dev`      | Local dev server at `http://localhost:4321`     |
| `npm run check`    | `astro check` — type-checks `.astro` files      |
| `npm run build`    | Static build to `dist/`                         |
| `npm run preview`  | Serve the built `dist/` locally                 |

Before opening a PR: run `npm run check && npm run build`. If both pass,
the Vercel preview will too.

## Mobile workflow (Claude Code on the web)

This repo is set up so a session at https://claude.ai/code can do the
"create branch → edit content → check → commit → PR" loop with no laptop:

1. **SessionStart hook** (`.claude/hooks/session-start.sh`) runs on every
   remote session and `npm install`s dependencies so `astro check` and
   `astro build` work without prompting. It only runs when
   `$CLAUDE_CODE_REMOTE=true`, so it's a no-op on your laptop.
2. **Permissions** in `.claude/settings.json` allowlist the common Bash
   commands (npm scripts, read-only git) so Claude doesn't have to ask
   each time on mobile.
3. **No live preview on mobile** — Claude Code mobile/web cannot serve a
   running dev server. The feedback loop is: push the branch → Vercel
   builds a preview deploy → open the preview URL in a browser. Aim to
   `npm run check` and `npm run build` before pushing so the preview
   actually deploys.
4. **Branch convention** — feature work happens on a non-`master` branch;
   merging to `master` deploys to production.

If you change the SessionStart hook or settings, those changes only take
effect on **future** sessions started after the merge to `master`.

## Style + tone

- Default to writing no comments. Keep code short.
- TODOs in placeholder content are spelled `TODO:` in plain text — easy to
  grep when filling in real bio/links/posts.
- One Astro page per route; shared chrome lives in `BaseLayout.astro`.

## Future

- Photos collection (`src/content/photos/`) — schema + page when ready.
- RSS feed for `/writing`.
- OpenGraph images.
