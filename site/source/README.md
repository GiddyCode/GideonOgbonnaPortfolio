# Gideon Ogbonna portfolio — publication v2

Static portfolio for https://gideonogbonna.dev. The original portfolio checkout is preserved; publication uses an isolated release checkout of GiddyCode/GideonOgbonnaPortfolio.

## Development

```sh
npm run build
npm run check
npm run dev
# In another terminal:
npm run check:browser
```

Python 3 builds `dist/` from `content.json`, `galleries.json`, `src/` and `assets/`. Node/Playwright are development-only dependencies. All runtime fonts, icons and images are local. No account, API, analytics or backend is required.

## Publication v2

- Ten client/team projects, two personal projects, eleven project-detail pages and a résumé.
- Distinct, original screenshot collages for the supplied projects, plus accessible screen enlargement and downloadable compositions.
- Added RightQ Welcomer, Eduportal, Storri.ai and Bloverse without inventing employment dates or project outcomes.
- Skill icons immediately beneath the portrait; progressive section motion with native scrolling and reduced-motion support.
- Redesigned footer with email copying and contact/navigation links.
- Canonical URLs, sitemap, real 404 and existing Cloudflare security headers.

The 59 supplied images were reviewed. Only 39 explicitly selected non-sensitive images were prepared; clinical, identifying and unrelated screens were excluded. Review contact sheets and original uploads stay outside the public release. Source screen filenames may be inaccurate: the file labelled GladeFinance in the Superpow folder depicts Superpow and is assigned correctly.

V1 remains archived under `../releases`. The prior internal prototype versions are historical; this release is labelled **v2.0.0** as requested. Production stays on Cloudflare Pages, using `main` and `site/public` in the existing repository. No DNS or account-access changes are needed.
