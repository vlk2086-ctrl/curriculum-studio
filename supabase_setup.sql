-- One table, mirroring the app's existing key/value storage model.
create table if not exists kv_store (
  key text primary key,
  value text not null,
  updated_at timestamptz not null default now()
);

-- Row Level Security must be explicitly enabled and then explicitly opened
-- up, since there's no login system in this app — anyone with the
-- publishable key (which lives in the page's own source, by design) can
-- read and write. This is the tradeoff of "no accounts" we discussed.
alter table kv_store enable row level security;

create policy "anyone can read" on kv_store
  for select using (true);

create policy "anyone can write" on kv_store
  for insert with check (true);

create policy "anyone can update" on kv_store
  for update using (true);

create policy "anyone can delete" on kv_store
  for delete using (true);
