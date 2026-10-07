# EPS Exam Practice

Flutter EPS-TOPIK practice application.

## Completed foundations
- Phase 1: clean feature-first architecture, Riverpod, GoRouter, Material 3, CI
- Phase 2: Supabase auth, dynamic exam sets, schema and RLS
- Phase 3: exam engine, 50-minute timer, reading/listening questions, answer state, scoring/results, test ads and eSewa sandbox configuration

## Phase 3 ad flow
Free test -> rewarded TEST ad -> exam -> submit -> interstitial TEST ad -> result.

A banner TEST ad is shown on the practice-set browser, not during the exam.

## Run
```bash
flutter create . --platforms=android
flutter pub get
flutter run --dart-define=SUPABASE_URL=https://YOUR_PROJECT.supabase.co --dart-define=SUPABASE_ANON_KEY=YOUR_CLIENT_KEY
```

See `docs/SUPABASE_SETUP.md` and `docs/PHASE3.md`.

## Still required
Migrate existing EPS-TEST content/media, configure Android/iOS AdMob app IDs in native projects, validate CI on generated native project files, add offline downloads, then implement verified premium/eSewa entitlements.
