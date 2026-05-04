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

GitHub Pages remote:

```text
git@github.com:HollowDobt/gpg.git
```

## Verify

Run the bundled check:

```sh
cd /Users/renxiqing/blog/gpg
./scripts/check-wkd.sh
```
