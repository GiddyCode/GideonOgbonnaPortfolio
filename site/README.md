# Portfolio v2

Live: https://gideonogbonna.dev/

`public/` is the generated Cloudflare Pages site. `source/` contains the reproducible static-site source, original approved assets and local validation scripts.

Build from `site/source` with `npm run build` and `npm run check`. Preview with `npm run dev`. To release a rebuild, copy the generated `source/dist/` contents to `site/public/`, retaining `public/_headers`, then commit to `main`. Cloudflare Pages builds with `exit 0` and serves `site/public`.

Version 2 adds distinct app-screen collages, separate historical client projects, accessible full-screen galleries, responsive motion, a portrait-aligned skills tray and redesigned contact/footer. Private source screenshots and review contact sheets are excluded from the repository. Existing Flutter prototype files are unchanged.
