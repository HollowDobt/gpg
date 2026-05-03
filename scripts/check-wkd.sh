#!/usr/bin/env bash
set -euo pipefail

domain="hlwdot.com"
address="i@hlwdot.com"
hash="yoshewjxwxj3dtezbu34waxgwahxoo4n"
url="https://openpgpkey.${domain}/.well-known/openpgpkey/${domain}/hu/${hash}?l=${address%@*}"
tmpdir="$(mktemp -d)"

cleanup() {
  rm -rf "${tmpdir}"
}
trap cleanup EXIT

echo "DNS:"
dig "openpgpkey.${domain}" +nostats +nocomments +nocmd

echo
echo "CAA:"
dig "openpgpkey.${domain}" CAA +short

echo
echo "GitHub Pages:"
gh api repos/HollowDobt/gpg/pages

echo
echo "GitHub Pages health:"
gh api repos/HollowDobt/gpg/pages/health

echo
echo "WKD HTTPS:"
curl --noproxy '*' -fsS -D "${tmpdir}/headers" -o "${tmpdir}/key" "${url}"
cat "${tmpdir}/headers"
cmp -s ".well-known/openpgpkey/${domain}/hu/${hash}" "${tmpdir}/key"

echo
echo "GnuPG locate:"
gpg --homedir "${tmpdir}/gnupg" --locate-keys "${address}"
