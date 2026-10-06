# mikamoenchmeier.com

My personal website: a rocket that flies from planet to planet as you scroll and lands in Germany.
Designed and directed by me, built with AI-assisted coding.

## Branches

| Branch        | What it's for               | Where you see it            |
| ------------- | --------------------------- | --------------------------- |
| `development` | Work in progress            | dev.mikamoenchmeier.com     |
| `beta`        | Ready for testing           | beta.mikamoenchmeier.com    |
| `main`        | The live website            | mikamoenchmeier.com         |

Day to day: work on `development`, commit, push.

- `tools/promote.sh beta`: move `development` → `beta` for testing
- `tools/promote.sh main v2.2`: move `beta` → `main` (goes live) and tag the version
- `tools/sync.sh`: line the branches up again (run automatically after a promote)

## Files

- `index.html`: the whole site (HTML, CSS and three.js scene in one file)
- `404.html`: "Lost in orbit" page for missing addresses
- `self-landing-rockets.pdf`: write-up of my Year 13 rocket project
- `og.png`, `apple-touch-icon.png`: link preview image and home-screen icon
- `fonts/`: Archivo, self-hosted (SIL Open Font License, see `fonts/OFL.txt`)
- `_redirects`: short links like `/x`, `/discord`, `/github`
- `_headers`: security headers and caching
- `wrangler.jsonc`, `.assetsignore`: Cloudflare Workers hosting config
- `tools/`: the branch workflow scripts (not published on the website)

Hosted on Cloudflare Workers. `main` deploys to the live site; `beta` and `development` deploy to preview addresses.
