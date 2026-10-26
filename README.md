# Gideon Ogbonna — Portfolio

Personal portfolio and mobile/Applied AI case studies. The redesigned website is in [`site/public`](site/public), ready for Cloudflare Pages Free without a build step. See [setup and hosting](site/README.md).

**Live portfolio:** https://gideon-ogbonna-portfolio.pages.dev/

**Live case study:** https://gideon-ogbonna-portfolio.pages.dev/projects/voice-to-action/

See [deployment status](site/DEPLOYMENT.md) for the custom-domain progress.

## Preview the website

```sh
python3 -m http.server 4173 --bind 127.0.0.1 --directory site/public
```

Open http://127.0.0.1:4173/. Voice to Action case study: http://127.0.0.1:4173/projects/voice-to-action/.

Cloudflare Pages: framework None, production branch `main`, build command blank, output directory `site/public`, no environment variables. DNS and custom-domain setup follow a verified preview deployment.

## Original Flutter portfolio

The original 2023 Flutter prototype remains in `lib`, `web` and the platform directories. It is preserved for reference; its Dart constraint is >=2.19.6 <3.0.0, and it is not the source deployed by the new static website. The Git history retains the original implementation.

## Project boundaries

The portfolio documents Voice to Action as a mobile project. It is not a browser demo and does not grant access to the private app backend. Live testing requires individual approval. No credentials, private logins or runtime backups belong in this repository.
