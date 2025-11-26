# SmoothCSV AUR Assets

Minimal bundle to publish `smoothcsv-bin` on AUR. PKGBUILD sources are 0BSD; the app ships with `LICENSE-SmoothCSV.md`.

## Files
- `PKGBUILD.in` — template using .deb releases, injects `SMOOTHCSV_DIST_CHANNEL=AUR`.
- `generate-aur.sh` — fills the template, downloads artifacts, emits `PKGBUILD` and `.SRCINFO`.
- `LICENSE` — 0BSD for these packaging files.

## Quick use
```bash
# version [pkgrel] [output_dir]
bash packaging/aur/generate-aur.sh 3.9.3 1 packaging/aur/out
cd packaging/aur/out
makepkg --printsrcinfo > .SRCINFO
```
