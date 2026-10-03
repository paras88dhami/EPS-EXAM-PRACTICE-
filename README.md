# EPS Exam Practice

Flutter EPS-TOPIK reading and listening practice application.

## Phase 1
Feature-first architecture, Riverpod, GoRouter, Material 3, splash/home, tests and CI.

## Phase 2
- Supabase configuration via dart-define
- Email/password auth repository and UI
- Dynamic published exam-set list
- Exam/question schema
- Row Level Security
- Automatic user profiles
- Setup documentation

## Run
```bash
flutter create . --platforms=android
flutter pub get
flutter run
```

With Supabase:
```bash
flutter run --dart-define=SUPABASE_URL=https://YOUR_PROJECT.supabase.co --dart-define=SUPABASE_ANON_KEY=YOUR_CLIENT_KEY
```

See `docs/SUPABASE_SETUP.md`.

## Next
Phase 3 builds the 40-question reading/listening exam engine and migrates EPS-TEST content. Ads, offline support and eSewa remain later phases.
