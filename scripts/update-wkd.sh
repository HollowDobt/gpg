#!/usr/bin/env bash
set -euo pipefail

domain="hlwdot.com"
address="i@hlwdot.com"
fingerprint="447458246875DB43BFEA064EC2C633185D60043FFFDCC01B39E6E1D6ECE0B71D"

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
wkd_root="${repo_root}/.well-known/openpgpkey"
hash="$(gpg-wks-client --print-wkd-hash "${address}" | awk '{print $1}')"

mkdir -p "${wkd_root}/${domain}/hu"
gpg-wks-client -C "${wkd_root}" --install-key "${fingerprint}" "${address}"

printf 'openpgpkey.%s' "${domain}" > "${repo_root}/CNAME"
: > "${repo_root}/.nojekyll"

echo "Updated ${address}"
echo "WKD hash: ${hash}"
echo "URL: https://openpgpkey.${domain}/.well-known/openpgpkey/${domain}/hu/${hash}?l=${address%@*}"
