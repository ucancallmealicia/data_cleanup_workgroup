SELECT CONVERT(note.notes USING utf8)
FROM note
WHERE CONVERT(note.notes USING utf8) LIKE '%href=%';

