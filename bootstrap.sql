-- updated by
CREATE TABLE documents (
  id INT PRIMARY KEY NOT NULL,
  content jsonb,
  updated_by text DEFAULT current_setting('application_name')
);
CREATE OR REPLACE FUNCTION set_last_update_author()
RETURNS TRIGGER AS $$
BEGIN
    -- Set the updated_by column to the current client's application_name
    NEW.updated_by := current_setting('application_name');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_app_name_trigger
BEFORE UPDATE ON documents
FOR EACH ROW
EXECUTE FUNCTION set_last_update_author();

-- last update
ALTER TABLE documents
ADD COLUMN last_updated TIMESTAMPTZ
DEFAULT CURRENT_TIMESTAMP;

CREATE OR REPLACE FUNCTION update_last_updated_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.last_updated := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_last_updated
BEFORE UPDATE ON documents
FOR EACH ROW
EXECUTE FUNCTION update_last_updated_column();
