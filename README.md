# New Age Factories — Website

Single-page marketing site for **New Age Factories LLC**, a digital product
studio building mobile apps, websites, e-commerce, digital solutions and
networking — and the team behind **Ojra**, a ride-hailing platform for riders
and drivers.

Built with Flutter Web. Dark neon UI, custom phone mockups for the Ojra
product showcase, scroll reveals and a validated `mailto:` contact form.

## Run locally

```bash
flutter pub get
flutter run -d chrome
```

## Build

```bash
flutter build web --release
```

Output lands in `build/web`. Serve it with any static host:

```bash
python3 -m http.server 8099 --directory build/web
```

## Project layout

```
lib/
  main.dart              app entry, page assembly, nav scrolling
  content.dart           company/contact constants
  theme.dart             colors, type scale, shared styles
  sections/              hero, services, product (Ojra), process, studio, contact
  widgets/               nav, footer, phone mockups, shared components
web/
  index.html             boot screen, fonts, SEO/OG metadata, JSON-LD
  manifest.json          PWA metadata
assets/images/           color-graded photography (no people, no animals)
assets/fonts/            Space Grotesk, Inter, JetBrains Mono
```

## Ojra on Google Play

Both apps are published and linked from the site:

- Rider — <https://play.google.com/store/apps/details?id=com.ojra.rider>
- Driver — <https://play.google.com/store/apps/details?id=com.ojra.driver>

The product section adapts to the visitor's device. On phones and tablets the
store buttons open Google Play directly. On desktop the two listings are shown
as scannable QR codes (and each card opens an enlarged code on click). The URLs
live in `lib/content.dart`.

## Contact

The contact form validates the fields, then opens a prefilled email draft with
the visitor's default mail client. There is no backend submission.

The address lives in `lib/content.dart`:

```dart
const String kContactEmail = 'hello@newagefactories.com';
```

Replace it with the real inbox before going live, and update the matching
`Organization` JSON-LD entry in `web/index.html`.

## Before deploying

- Point the production domain at the build output.
- Set absolute URLs (or a canonical domain) for `og:image` / `twitter:image`
  in `web/index.html` if the site is served from a subpath.
- The bundled photography comes from Unsplash; keep attribution in line with
  the Unsplash license if the assets are reused elsewhere.

## Checks

```bash
flutter analyze
flutter test
```# ojra_site
