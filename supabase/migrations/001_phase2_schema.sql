create extension if not exists pgcrypto;
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text, created_at timestamptz not null default now()
);
create table if not exists public.exam_sets (
  id uuid primary key default gen_random_uuid(),
  set_number integer not null unique check (set_number > 0),
  title text not null, description text,
  is_free boolean not null default false,
  is_published boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create table if not exists public.questions (
  id uuid primary key default gen_random_uuid(),
  exam_set_id uuid not null references public.exam_sets(id) on delete cascade,
  question_number integer not null check (question_number > 0),
  section text not null check (section in ('reading', 'listening')),
  question_text text, image_path text, audio_path text,
  options jsonb not null default '[]'::jsonb,
  correct_answer integer not null, explanation text,
  created_at timestamptz not null default now(),
  unique (exam_set_id, question_number)
);
alter table public.profiles enable row level security;
alter table public.exam_sets enable row level security;
alter table public.questions enable row level security;
create policy "users read own profile" on public.profiles for select to authenticated using ((select auth.uid()) = id);
create policy "users update own profile" on public.profiles for update to authenticated using ((select auth.uid()) = id) with check ((select auth.uid()) = id);
create policy "published sets are readable" on public.exam_sets for select to anon, authenticated using (is_published = true);
create policy "published set questions are readable" on public.questions for select to anon, authenticated using (
  exists (select 1 from public.exam_sets where exam_sets.id = questions.exam_set_id and exam_sets.is_published = true)
);
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = ''
as $$
begin
  insert into public.profiles (id, display_name) values (new.id, new.raw_user_meta_data ->> 'display_name');
  return new;
end;
$$;
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created after insert on auth.users for each row execute procedure public.handle_new_user();
