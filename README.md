# PlatoDNS — Standalone (no jailbreak)

A self-contained dylib version of PlatoDNS. No MobileSubstrate / ElleKit, no
PreferenceLoader, no Settings app plugin — it runs entirely inside the host
app it's injected into, and adds its own floating menu.

## What it does

- Adds a small draggable 🔒 bubble on top of the host app.
- Tapping the bubble opens a menu with:
  - **Generate DoH profile** — builds a Cloudflare DNS-over-HTTPS `.mobileconfig`
    and opens the system Share Sheet.
  - **Generate DoT profile** — same, for DNS-over-TLS.
  - **Check DNS latency** — a plain `getaddrinfo()` timing check shown as an alert.
  - **Close** — dismisses the menu.

## What it does *not* do

- It does **not** silently change the system DNS resolver. iOS requires a
  user-approved configuration profile for that, and this tool only gets you
  as far as generating the file and handing it to the Share Sheet — you still
  install it yourself in **Settings → General → VPN & Device Management**.
- It does **not** hook or touch any networking code belonging to the host
  app. It only draws its own UI and writes its own temp file.

## Build (Theos)

```bash
export THEOS=~/theos
make package ARCHS="arm64 arm64e"
```

Output: `.theos/obj/PlatoDNS.dylib` (and `PlatoDNS.deb` if you want one, via
`make package`, though the `.deb` isn't needed for the no-jailbreak flow).

## Install (no jailbreak)

Inject `PlatoDNS.dylib` into any IPA using Sideloadly, ESign, or Feather —
the same way as any other standalone injected dylib. Open the app, tap the
🔒 bubble, and use the menu.

## Notes

- Switching DNS profile: remove the old profile in Settings before
  installing a new one (same iOS limitation as the original PreferenceLoader
  version).
- The latency check measures basic resolver timing via `getaddrinfo`; it is
  not a guarantee of the exact encrypted DNS server path.
