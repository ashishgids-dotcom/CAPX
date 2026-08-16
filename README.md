# CAPX — Flutter Source

Cross-platform (Android + iOS) Clean-Architecture-style Flutter app with
Provider state management, covering three modules behind a triple-tier
dashboard, as specified.

## ⚠️ APK file is NOT included

This is source code only. I cannot compile/sign an APK inside this chat —
there's no Flutter/Android SDK or network access here. You (or your
developer) need to build it locally or in CI. Steps below.

## SDK / toolchain versions — verified via web search on the day of this
update (Aug 2026), not just assumed from training data

| Component        | Version                       |
|-------------------|-------------------------------|
| compileSdk         | 36                             |
| targetSdk          | 36                             |
| minSdk             | 26 (explicit backward compat)  |
| Android Gradle Plugin | **8.10.0** (latest 8.x line — see note below) |
| Kotlin              | 2.1.20                        |
| Gradle wrapper       | 8.11.1                        |
| Java                | 17                             |
| Dart SDK            | >=3.4.0 <4.0.0 (Dart 3.x, sound null safety) |
| Flutter             | >=3.35.0 (tracking recent stable, currently 3.44.x) |

**Why AGP 8.10.0 and not AGP 9.x:** AGP 9.0 shipped in January 2026 and is
genuinely the newest major line — but Flutter's own release notes
currently carry an explicit warning: *"Do not update your Flutter app for
Android to AGP 9 as migrating plugins to AGP 9 and Flutter apps on AGP 9
using plugins is not yet supported."* Flutter's team is still auditing
plugin compatibility with AGP 9. So AGP 8.10.0 (May 2025) is the correct
choice right now — it's the latest AGP 8.x release, and it already
supports compileSdk/targetSdk 36. Once Flutter's official guidance says
AGP 9 is supported, bump `android/settings.gradle.kts` and the Gradle
wrapper together (AGP 9.x needs Gradle 9.x).

## How to build the APK

```bash
# 1. Install Flutter (stable channel) and Android SDK 36 + build-tools.
flutter doctor

# 2. From the project root:
cd capx_app
cp android/local.properties.example android/local.properties
# edit android/local.properties to point sdk.dir / flutter.sdk at your paths

flutter pub get

# 3. Debug APK (fastest, for testing):
flutter build apk --debug

# 4. Release APK (needs a signing key — see below):
flutter build apk --release

# Output APK lands in:
# build/app/outputs/flutter-apk/app-release.apk
```

### Release signing
`android/app/build.gradle.kts` references a keystore at
`android/keystore/release.jks` via env vars `KEYSTORE_PASSWORD`,
`KEY_ALIAS`, `KEY_PASSWORD`. Generate a real keystore with:
```bash
keytool -genkey -v -keystore release.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```
Never commit the `.jks` file or real passwords — `.gitignore` already
excludes them.

## What's implemented

- **Entry & Segmentation**: first-launch language grid (7 languages),
  persisted via `shared_preferences`; persistent 🌐 switcher on the dashboard.
- **Triple-tier dashboard** with the 3 pricing cards + animated marquee
  legal disclaimer footer (`marquee` package).
- **Module A** (₹29): amount + tenure inputs → simulated Razorpay/UPI
  paywall → donut chart (`fl_chart`) allocation output using the exact
  deterministic rules given, icon-mapped zones, localized audio player
  (`just_audio`, expects per-language `.mp3` assets you supply), and the
  Scam Detector calculator with the crimson red fraud-warning box at >15%
  promised returns.
- **Module B** (₹1,499/yr): 4-tab dashboard — PageView-based 5-question
  Shop Health quiz with scoring + gap diagnostics, Marketing Blueprint
  templates, searchable Wholesale Sourcing directory, and GST/ITR
  educational guides.
- **Module C** (₹2,499): startup inputs → dark premium paywall → 4-tab
  dashboard — Pricing Engine + PMF Tester, Sales/Marketing playbooks,
  Distribution/Logistics guidance, and a live KPI tracker (CAC/LTV/MRR/
  Runway) with a `table_calendar`-based consultation scheduler that hands
  off to WhatsApp, plus one-tap PDF blueprint export (`pdf` + `printing`).
- Dio + cache interceptor + Hive store wired into `pubspec.yaml` for future
  API calls with offline-friendly caching on slow networks (no live API
  calls are made yet — everything currently runs on local/mock data).

## Recent updates in this version

- **App renamed to CAPX** everywhere (label, package namespace
  `com.example.capx_app`, launcher icon, all 7 language strings).
- **Toolchain re-verified against current (Aug 2026) stable releases**:
  AGP 8.10.0, Kotlin 2.1.20, Gradle 8.11.1 — the latest AGP 8.x line, kept
  intentionally off AGP 9.x since Flutter's own docs currently warn that
  Flutter + AGP 9 + plugins isn't supported yet.
- **Module B** now shows a dedicated header + footer disclaimer banner
  ("business education / case studies only, not certified legal
  consultation, CAPX not responsible for business outcomes") in all 7
  languages.
- **Module C is no longer just a consultation-call scheduler.** Every
  sub-tab (Product & Price, Sales & Marketing, Distribution & Place,
  Performance) now also carries a "Real-World Problems" section — common,
  concrete founder problems paired with practical next steps, on top of
  the existing calculators (Pricing Engine, PMF Tester, KPI tracker). The
  video-call scheduler is now positioned as a last step ("still stuck?
  book a call") rather than the main event. See
  `lib/features/module_c/data/problem_solution_data.dart` to add/edit
  these.
- **`codemagic.yaml` added** at the project root — lets you build an APK
  straight from GitHub via Codemagic without installing Flutter/Android
  Studio locally. See the separate `CAPX_GitHub_Codemagic_Guide.md`.

- **All 7 languages fully localized** (English, Hindi, Bhojpuri, Marathi,
  Bengali, Tamil, Telugu) — the global legal disclaimer, the "not a
  SEBI-registered adviser" badge, and all core nav strings now have real
  translations in `core/constants/app_strings.dart`, not English fallbacks.
- **Module A disclaimer strengthened**:
  - A mandatory full-screen disclaimer gate (`DisclaimerGateScreen`) now
    sits between the dashboard and Module A's input screen — the user must
    tap "I Understand, Continue" before entering an amount.
  - The output screen now shows a "Not a SEBI-registered adviser ·
    Educational only · Invest at your own risk" badge right next to the
    chart/numbers (not just in the footer marquee), plus the full
    disclaimer text again at the bottom.
  - Added a **Historical Reference Ranges** card showing generic, publicly
    known past-performance ranges per asset zone (FD/Post Office, Index/
    Mutual Funds, Digital Gold), clearly labeled "past data only, not a
    prediction or guarantee." **Deliberately not included:** a "% chance
    your money will grow" figure — a specific success-probability number
    for an individual's investment would itself be a fabricated forecast/
    recommendation with no real statistical basis, which is exactly the
    kind of output that turns this from an educational calculator into
    unlicensed personalized investment advice. See the comment block at
    the top of `features/module_a/widgets/historical_reference_ranges.dart`.
    If you want real historical numbers here, source them from an official
    published rate table and keep them generic/non-personalized.

## Before you ship this publicly — please read

1. **Payment integration is still simulated** — as agreed, wire this up
   once you have your Razorpay/PSP keys ready. The simulated flow already
   sits behind `simulatePayment()` in both `module_a_provider.dart` and
   `module_c_provider.dart`, so real integration is a drop-in replacement. Both paywalls simulate success
   after a 2-second delay. Wire up a real PSP SDK (Razorpay, PhonePe, etc.),
   create orders server-side, and verify payment signatures server-side
   before unlocking paid content for real users.
2. **Module A sits close to regulated investment advice.** Rule-based
   allocation suggestions tied to money a user pays to see can be read as
   SEBI-regulated "investment advisory" in India, disclaimer or not. Have
   this specific module reviewed by a lawyer/compliance professional before
   launch, and consider keeping it framed as a generic educational
   calculator (fixed illustrative examples) rather than a paid personalized
   recommendation.
3. **Module B Tab 4 (GST/ITR) is general education, not certified filing
   advice** — the in-app banner already says this; keep it that way.
4. **Translations**: only English and Hindi UI strings are fully filled in
   (`core/constants/app_strings.dart`). Get the other 5 languages
   professionally translated — especially the legal disclaimer text.
5. **Audio assets**: drop real `module_a_summary_<langcode>.mp3` files into
   `assets/audio/` (e.g. `module_a_summary_hi.mp3`, `_bho.mp3`, `_mr.mp3`...).
6. **Calendly/Zoom integration** is stubbed with placeholder slots and a
   placeholder meeting link — connect a real backend + Calendly webhook
   before relying on it.
7. **Launcher icons** included are simple placeholder circles generated for
   this scaffold — replace with your real branded icon set (ideally via
   `flutter_launcher_icons`) before release.
