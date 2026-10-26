# Portfolio website

This directory contains the redesigned public portfolio. The original Flutter prototype remains intact at the repository root; the recovery Git bundle was saved separately before edits.

The website is a static case-study portfolio, not a web version of the Voice to Action mobile app. It makes no calls to the app backend, OpenAI, Supabase or Recall, and contains no service credentials. Demo requests open a user-reviewed email draft; no form sends automatically.

## Local preview

From the repository root:

```sh
python3 -m http.server 4173 --bind 127.0.0.1 --directory site/public
```

Visit http://127.0.0.1:4173/. The resume destination is `/projects/voice-to-action/`. The site works without a build tool or JavaScript; JavaScript only enhances email copying and the case-study reading-progress indicator.

## Cloudflare Pages (Free)

Connect only `GiddyCode/GideonOgbonnaPortfolio`. Keep Namecheap as the registrar. Deploy the Pages preview before changing the domain's DNS.

- Production branch: `main`
- Framework preset: None
- Build command: blank (or `exit 0` if a command is required)
- Build output directory: `site/public`
- Root directory: repository root (leave blank)
- Environment variables: none
- Functions/Workers/database: none

The `_headers` file defines response security headers. The real `404.html` provides a missing-page response instead of a single-page-app fallback. There is no analytics or external font request.

For the apex `gideonogbonna.dev`, Cloudflare Pages requires a Cloudflare DNS zone and its assigned nameservers. Import and review existing DNS records, including any email records, before replacing Namecheap nameservers. Never invent nameserver values. Review DNSSEC if present before a nameserver migration. Associate the custom domain through Pages before pointing records; wait for active HTTPS and verify both the Pages address and custom-domain route.

Official references:
- https://developers.cloudflare.com/pages/get-started/git-integration/
- https://developers.cloudflare.com/pages/configuration/custom-domains/

## Content and assets

The public GitHub profile and Gemini AI Chat README supplied the background and public-code references. Voice to Action case-study content comes from the project's specification, architecture, privacy, evaluation and dated verification logs. Test results describe recorded runs as of 26 October 2026, not fresh benchmarks or AI accuracy figures. No professional tenure, employer results or store counts have been invented.

- `voice-home.png`: current owner-approved Android screen; contains no account email or note content.
- `voice-recording.png` / `voice-review.png`: development captures, labeled accordingly on the page.
- `manrope.ttf`: existing project font, distributed with `MANROPE-OFL.txt`.
- `mark.svg`: code-native portfolio monogram, independent of the app logo.

The source mobile project remains private. Contact links offer requested demo/source access; no APK/video links are shown until those artifacts are ready. Physical iOS testing/TestFlight remain pending.

## Before wider sharing

Review personal bio and selected-work presentation with Gideon. Replace development captures when a new screenshot set is available. Add the real walkthrough and release-signed Android download only after those artifacts are produced and reviewed. Do not expose keys, app login files or private environment files when adding any deployment automation.
