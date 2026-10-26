# Deployment status — 26 October 2026

## Live

- Cloudflare Pages Free: https://gideon-ogbonna-portfolio.pages.dev/
- Mobile case study: https://gideon-ogbonna-portfolio.pages.dev/projects/voice-to-action/
- Source: https://github.com/GiddyCode/GideonOgbonnaPortfolio
- Production branch: `main`; automatic Git deployments enabled.
- Build command: `exit 0`; output directory: `site/public`; no environment variables or server functions.
- Cloudflare GitHub installation is restricted to the portfolio repository.

Deployed source commit: `539d24e`. The homepage and case study load in the browser with all screenshot assets. The custom missing-page page also displays correctly. Desktop, 390 px and 320 px local layouts were inspected; no horizontal overflow was detected. Local link/anchor/image checks and JavaScript syntax checks passed. Command-line requests using Python's default user agent were rejected by Cloudflare (1010), so those requests are not recorded as successful HTTP checks.

## Custom domain activated

`gideonogbonna.dev` remains registered at Namecheap. A Free Cloudflare DNS zone is prepared with the existing records imported and a local backup retained outside version control. The three existing MX records are retained. Non-website hostnames are set to DNS-only rather than being placed behind the HTTP proxy.

Assigned Cloudflare nameservers:

- `grant.ns.cloudflare.com`
- `sandra.ns.cloudflare.com`

The owner approved the registrar change; Namecheap saved both assigned nameservers. Cloudflare reports the zone active and both `gideonogbonna.dev` and `www.gideonogbonna.dev` Active / SSL enabled in Pages. Public DNS checks through Cloudflare and Google resolvers show the new delegation, and an HTTPS request to the apex returned 200 with certificate verification and security headers. The local system resolver still returned the previous hosting IP during verification, so the in-app browser encountered the cached old certificate; no certificate warning was bypassed. No paid hosting subscription was added.

Primary portfolio: https://gideonogbonna.dev/

Resume case-study link: https://gideonogbonna.dev/projects/voice-to-action/

The original Flutter prototype remains intact in this repository. The Voice to Action app remains a native mobile project; this website contains its case study rather than an interactive web replica. The recorded mobile walkthrough and release-signed APK download are not published yet.
