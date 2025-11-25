#!/usr/bin/env bash
set -euo pipefail

# Generates a PKGBUILD and .SRCINFO for SmoothCSV AUR binary package.
# Usage: ./packaging/aur/generate-aur.sh [version] [pkgrel] [output_dir]
# - version: defaults to apps/desktop/package.json version (without leading v)
# - pkgrel: defaults to 1 (or $PKGREL if exported)
# - output_dir: defaults to packaging/aur/out

REPO_ROOT="$(git rev-parse --show-toplevel)"
VERSION="${1:-$(node -e "console.log(require('${REPO_ROOT}/apps/desktop/package.json').version)")}" 
PKGREL_INPUT="${2:-${PKGREL:-1}}"
OUTPUT_DIR="${3:-${REPO_ROOT}/packaging/aur/out}"
PKGNAME="${AUR_PKGNAME:-smoothcsv-bin}"
MAINTAINER_NAME="${AUR_MAINTAINER_NAME:-${AUR_USERNAME:-kohii}}"
MAINTAINER_EMAIL="${AUR_MAINTAINER_EMAIL:-${AUR_EMAIL:-kohii.tokyo@gmail.com}}"
MAINTAINER_LINE="${MAINTAINER_NAME} <${MAINTAINER_EMAIL}>"

TEMPLATE="${REPO_ROOT}/packaging/aur/PKGBUILD.in"
PKGBUILD_PATH="${OUTPUT_DIR}/PKGBUILD"

mkdir -p "$OUTPUT_DIR"

validate_pkgrel() {
  local pkgrel="$1"
  if [[ "$pkgrel" =~ ^[0-9]+$ && "$pkgrel" -ge 1 ]]; then
    return 0
  fi
  echo "Invalid PKGREL: ${pkgrel}. Must be a positive integer." >&2
  return 1
}

check_existing_release() {
  local tmpdir
  tmpdir=$(mktemp -d)

  if git -C "$tmpdir" clone --depth 1 "https://aur.archlinux.org/${PKGNAME}.git" repo >/dev/null 2>&1; then
    local srcinfo="$tmpdir/repo/.SRCINFO"
    if [[ -f "$srcinfo" ]]; then
      local current_ver current_rel
      current_ver=$(awk -F"= " '/^pkgver = /{print $2; exit}' "$srcinfo")
      current_rel=$(awk -F"= " '/^pkgrel = /{print $2; exit}' "$srcinfo")
      if [[ "$current_ver" == "$VERSION" ]]; then
        if [[ "$PKGREL" -le "$current_rel" ]]; then
          rm -rf "$tmpdir"
          echo "Error: pkgver=${VERSION} has existing pkgrel=${current_rel} in AUR (${PKGNAME}); provided pkgrel=${PKGREL} must be greater." >&2
          exit 1
        fi
      fi
    fi
  fi

  rm -rf "$tmpdir"
}

validate_pkgrel "$PKGREL_INPUT"
PKGREL="$PKGREL_INPUT"
check_existing_release

download_and_hash() {
  local deb_arch="$1"
  local filename="SmoothCSV_${VERSION}_${deb_arch}.deb"
  local url="https://github.com/kohii/smoothcsv3/releases/download/v${VERSION}/${filename}"

  echo "Downloading ${url}" >&2
  curl -L --fail -o "${OUTPUT_DIR}/${filename}" "$url"
  sha256sum "${OUTPUT_DIR}/${filename}" | awk '{print $1}'
}

echo "Generating PKGBUILD for version=${VERSION}, pkgrel=${PKGREL}, pkgname=${PKGNAME}"

SHA256_X86_64=$(download_and_hash "amd64")
SHA256_AARCH64=$(download_and_hash "arm64")

MAINTAINER_LINE_ESCAPED=${MAINTAINER_LINE//\//\/}

sed \
  -e "s/@PKGNAME@/${PKGNAME}/g" \
  -e "s/@PKGVER@/${VERSION}/g" \
  -e "s/@PKGREL@/${PKGREL}/g" \
  -e "s/@MAINTAINER_LINE@/${MAINTAINER_LINE_ESCAPED}/g" \
  -e "s/@SHA256_X86_64@/${SHA256_X86_64}/g" \
  -e "s/@SHA256_AARCH64@/${SHA256_AARCH64}/g" \
  "$TEMPLATE" > "$PKGBUILD_PATH"

cp "${REPO_ROOT}/packaging/aur/LICENSE" "${OUTPUT_DIR}/LICENSE"

pushd "$OUTPUT_DIR" >/dev/null
makepkg --printsrcinfo > .SRCINFO
popd >/dev/null

echo "PKGBUILD generated at: $PKGBUILD_PATH"
echo "SHA256 x86_64: $SHA256_X86_64"
echo "SHA256 aarch64: $SHA256_AARCH64"
