ALTER TABLE users DROP COLUMN subscription_id;
ALTER TABLE users ADD COLUMN subscription_id UUID DEFAULT null;
