SELECT DISTINCT file_version.file_uri
FROM file_version
WHERE file_version.file_uri LIKE '%http%';