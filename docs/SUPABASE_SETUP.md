# Supabase Phase 2 Setup

1. Create a Supabase project.
2. Run `supabase/migrations/001_phase2_schema.sql` in SQL Editor.
3. Keep Email authentication enabled.
4. Copy Project URL and the client-safe anon/publishable key.
5. Never put the service-role/secret key in Flutter.

Run:
```bash
flutter run --dart-define=SUPABASE_URL=https://YOUR_PROJECT.supabase.co --dart-define=SUPABASE_ANON_KEY=YOUR_CLIENT_KEY
```

## Adding sets
Insert an `exam_sets` row, add questions, then set `is_published=true`. New published sets appear without a Play Store update.

## Security
RLS allows reads of published content but no client writes. Premium restrictions are added later; `is_free` is currently metadata, not payment security.
