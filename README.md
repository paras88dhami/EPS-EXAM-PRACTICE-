# EPS Exam Practice

Flutter application for EPS-TOPIK reading and listening exam practice.

## Phase 1
- Feature-first clean architecture
- Riverpod application root
- GoRouter navigation
- Material 3 theme
- Splash and Home foundations
- Shared reusable widgets
- Development/production environment foundation
- Static analysis, widget test and GitHub Actions CI

## Architecture
```text
lib/
├── app/
│   ├── router/
│   └── theme/
├── core/
│   ├── config/
│   ├── constants/
│   └── errors/
├── features/
│   ├── splash/
│   └── home/
└── shared/
    └── widgets/
```

Future features can own data/, domain/, and presentation/ layers when needed.

## Run
```bash
flutter pub get
flutter run
```

If native platform folders are not present after cloning this foundation branch, generate Android once:
```bash
flutter create . --platforms=android
flutter pub get
flutter run
```

## Planned phases
Phase 2 adds Supabase auth and remote exam-set architecture. Later phases add the exam engine, media/listening, ads/free-attempt gating, offline support, and finally eSewa subscription payments.
