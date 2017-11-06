select CAST(note.notes as CHAR (500000) CHARACTER SET UTF8) AS Text
	, CONCAT('/repositories/', resource.repo_id, '/resources/', resource.id) AS URI
from resource
JOIN note on note.resource_id = resource.id
WHERE resource.repo_id = 14
UNION ALL
select CAST(note.notes as CHAR (500000) CHARACTER SET UTF8) AS Text
	, CONCAT('/repositories/', ao.repo_id, '/archival_objects/', ao.id) AS URI
from archival_object ao
JOIN note on note.archival_object_id = ao.id
WHERE ao.repo_id = 14
UNION ALL
select CAST(note.notes as CHAR (500000) CHARACTER SET UTF8) AS Text
	, CONCAT('/repositories/', do.repo_id, 'digital_objects/', do.id) AS URI
from digital_object do 
JOIN note on note.digital_object_id = do.id
WHERE do.repo_id = 14
UNION ALL
select CAST(note.notes as CHAR (500000) CHARACTER SET UTF8) AS Text
	, CONCAT('/repositories/', doc.repo_id, '/digital_object_components/', doc.id) AS URI
from digital_object_component doc
JOIN note on note.digital_object_component_id = doc.id
WHERE doc.repo_id = 14

