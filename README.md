# hlwdot.com WKD

Static advanced Web Key Directory (WKD) for `i@hlwdot.com`.

Published WKD URL:

```text
https://openpgpkey.hlwdot.com/.well-known/openpgpkey/hlwdot.com/hu/yoshewjxwxj3dtezbu34waxgwahxoo4n?l=i
```

## Layout

```text
.well-known/openpgpkey/hlwdot.com/policy
.well-known/openpgpkey/hlwdot.com/hu/yoshewjxwxj3dtezbu34waxgwahxoo4n
CNAME
.nojekyll
scripts/update-wkd.sh
scripts/check-wkd.sh
```

The advanced WKD method for `hlwdot.com` requires the host
`openpgpkey.hlwdot.com`.

## Update The Key

Import or create the updated public key in the local GnuPG keyring first.
Then update the WKD files:

```sh
cd /Users/renxiqing/blog/gpg
./scripts/update-wkd.sh
git status --short
git add .well-known/openpgpkey CNAME .nojekyll scripts/update-wkd.sh
git commit -m 'Update WKD key'
git push origin main
git push github main
```

If the email address or fingerprint changes, edit `address` and
`fingerprint` in `scripts/update-wkd.sh`, run the script, and commit the
script change with the generated WKD files.

## Deployment

Primary remote:

```text
git@git.hlwdot.com:i/gpg.git
```

GitHub Pages remote:

```text
git@github.com:HollowDobt/gpg.git
```

GitHub Pages serves the `main` branch from `/`.

DNS:

```text
openpgpkey.hlwdot.com CNAME hollowdobt.github.io
```

When using Cloudflare DNS, keep this record DNS-only. Do not enable the
Cloudflare proxy for a GitHub Pages target.

## Verify

Run the bundled check:

```sh
cd /Users/renxiqing/blog/gpg
./scripts/check-wkd.sh
```

Useful individual checks:

```sh
dig openpgpkey.hlwdot.com +short
dig openpgpkey.hlwdot.com CAA +short
gh api repos/HollowDobt/gpg/pages
gh api repos/HollowDobt/gpg/pages/health
curl -I https://openpgpkey.hlwdot.com/.well-known/openpgpkey/hlwdot.com/policy
gpg --homedir "$(mktemp -d)" --locate-keys i@hlwdot.com
```

After GitHub Pages issues the certificate, enforce HTTPS:

```sh
gh api repos/HollowDobt/gpg/pages -X PUT -F https_enforced=true
```

For branch-based GitHub Pages publishing, GitHub stores the custom domain in
the root `CNAME` file and can create commits when the custom domain is changed
from the Pages settings/API. After changing the custom domain, fetch
`github/main` before making local edits.
