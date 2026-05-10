corbinfanning.com
=================

Personal site for Corbin Fanning. Astro + markdown content collections,
deployed on Vercel. Iterated on primarily from the Claude Code mobile/web app.

## Local development

```bash
npm install
npm run dev      # http://localhost:4321
npm run check    # astro check
npm run build    # static output to dist/
```

## Deployment

- Pull requests get automatic Vercel preview deploys.
- Merges to `master` deploy production at https://corbinfanning.com.

## Adding content

- Posts live in `src/content/writing/*.md`.
- Projects live in `src/content/projects/*.md`.
- See [`CLAUDE.md`](./CLAUDE.md) for frontmatter schemas and the mobile
  workflow setup.
