# Raycast

Raycast does **not** expose a clean dotfile-friendly config. Its actual state lives in:

```
~/Library/Application Support/com.raycast.macos/   # encrypted sqlite + per-machine state
~/.config/raycast/extensions/                      # compiled extension bundles (build artifacts)
```

None of that is appropriate to commit to git: encrypted DBs are machine-bound, build artifacts are large and rebuilt anyway, and snippets/quicklinks/aliases are stored inside the encrypted DB.

## What we track

- `extensions.txt` — a manifest of installed extension slugs. Lets you reinstall the same set on a new machine.

## How to update the manifest

Run from the repo root after installing/removing extensions:

```bash
find ~/.config/raycast/extensions -maxdepth 2 -name package.json \
  -exec jq -r '.name' {} \; 2>/dev/null | sort -u > raycast/extensions.txt.new
# Review and replace if it looks right
mv raycast/extensions.txt.new raycast/extensions.txt
```

## How to sync everything else

Use **Raycast Cloud Sync** (Settings → Cloud Sync). It's the only first-class way to move snippets, quicklinks, hotkeys, and aliases between machines. Free for personal use.
