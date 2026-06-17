-- Add unique handle (username) to users for clean public URLs.
-- Add is_public flag to agent_cards for visibility control.

ALTER TABLE users ADD COLUMN IF NOT EXISTS handle VARCHAR(32) UNIQUE;

-- Back-fill existing users from the local part of their email.
UPDATE users SET handle = split_part(email, '@', 1) WHERE handle IS NULL;

ALTER TABLE users ALTER COLUMN handle SET NOT NULL;

ALTER TABLE agent_cards ADD COLUMN IF NOT EXISTS is_public BOOLEAN NOT NULL DEFAULT TRUE;
