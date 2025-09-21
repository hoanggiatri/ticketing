CREATE TABLE IF NOT EXISTS projects (
  id UUID PRIMARY KEY,
  key TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  description TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now (),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now ()
);
CREATE TABLE IF NOT EXISTS issues (
  id UUID PRIMARY KEY,
  project_id UUID NOT NULL REFERENCES projects (id) ON
DELETE CASCADE,
  code INT NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  status TEXT NOT NULL CHECK (status IN ('todo', 'doing', 'done')),
  priority TEXT NOT NULL CHECK (
    priority IN ('low', 'medium', 'high', 'critical')
  ),
  assignee UUID,
  reporter UUID NOT NULL,
  labels TEXT [] NOT NULL DEFAULT '{}',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now (),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now (),
  UNIQUE (project_id, code)
);