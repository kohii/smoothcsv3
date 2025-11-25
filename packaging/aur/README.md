# SmoothCSV AUR Assets

Minimal bundle to publish `smoothcsv-bin` on AUR. PKGBUILD sources are 0BSD; the app ships with `LICENSE-SmoothCSV.md`.

## Files
- `PKGBUILD.in` — template using .deb releases, injects `SMOOTHCSV_DIST_CHANNEL=AUR`.
- `generate-aur.sh` — fills the template, downloads artifacts, emits `PKGBUILD` and `.SRCINFO`.
- `LICENSE` — 0BSD for these packaging files.

## Quick use
```bash
# version [pkgrel] [output_dir]
bash packaging/aur/generate-aur.sh 3.9.3
cd packaging/aur/out
makepkg --printsrcinfo > .SRCINFO
```
Env/args: `PKGREL` (defaults to 1), `AUR_PKGNAME`, `AUR_USERNAME`, `AUR_EMAIL`.
The script fails if the same `pkgver` exists with an equal or higher `pkgrel` already in AUR.
