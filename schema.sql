-- Jalankan di Supabase: SQL Editor > New query > Run
create table contacts(
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  name text not null, company text, email text, phone text,
  status text default 'Lead', photo_url text, created_at timestamptz default now());
create table deals(
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  title text not null, contact_id uuid references contacts on delete cascade,
  value numeric default 0, stage text default 'Baru', created_at timestamptz default now());
create table tickets(
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  subject text not null, contact_id uuid references contacts on delete cascade,
  priority text default 'Sedang', status text default 'Terbuka',
  attachment_url text, created_at timestamptz default now());
create table tasks(
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  text text not null, due date, done boolean default false, created_at timestamptz default now());
create table activities(
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users on delete cascade,
  contact_id uuid references contacts on delete cascade,
  note text not null, created_at timestamptz default now());

-- Keamanan: setiap user hanya bisa melihat dan mengubah datanya sendiri
do $$ declare t text; begin
  foreach t in array array['contacts','deals','tickets','tasks','activities'] loop
    execute format('alter table %I enable row level security', t);
    execute format('create policy "own %1$s" on %1$I for all using (user_id = auth.uid()) with check (user_id = auth.uid())', t);
  end loop;
end $$;
