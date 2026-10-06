# mikamoenchmeier.com

My personal website: a rocket that flies from planet to planet as you scroll and lands in Germany.
Designed and directed by me, built with AI-assisted coding.

- `index.html`: the whole site (HTML, CSS and three.js scene in one file)
- `404.html`: "Lost in orbit" page for missing addresses
- `self-landing-rockets.pdf`: write-up of my Year 13 rocket project
- `og.png`, `apple-touch-icon.png`: link preview image and home-screen icon
- `fonts/`: Archivo, self-hosted (SIL Open Font License, see `fonts/OFL.txt`)
- `_redirects`: short links like `/x`, `/discord`, `/github`
- `_headers`: security headers and caching
- `wrangler.jsonc`, `.assetsignore`: Cloudflare Workers hosting config

Hosted on Cloudflare Workers, deployed automatically on every push to `main`.
