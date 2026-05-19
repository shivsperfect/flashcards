ALTER TABLE IF EXISTS gocourse.flashcards RENAME TO notes;
ALTER INDEX IF EXISTS idx_flashcards_created_at RENAME TO idx_notes_created_at;
ALTER SEQUENCE IF EXISTS gocourse.flashcards_id_seq RENAME TO notes_id_seq;
