SELECT note.publish as pub_status
	, npi.persistent_id
	, CONCAT('/repositories/', doc.repo_id, '/digital_object_components/', doc.id) AS URI
	, CAST(note.notes as CHAR (20000) CHARACTER SET UTF8) AS Text
FROM note
LEFT JOIN note_persistent_id npi on note.id = npi.note_id
LEFT JOIN digital_object_component doc on doc.id = note.digital_object_component_id
WHERE doc.repo_id = 12
#AND note.publish = 0
UNION
SELECT note.publish as pub_status
	, npi.persistent_id
 	, CONCAT('/repositories/', resource.repo_id, '/resources/', resource.id) AS URI
	, CAST(note.notes as CHAR (20000) CHARACTER SET UTF8) AS Text
FROM note
LEFT JOIN note_persistent_id npi on note.id = npi.note_id
LEFT JOIN resource on resource.id = note.resource_id
WHERE resource.repo_id = 12
#AND note.publish = 0
UNION
SELECT note.publish as pub_status
	, npi.persistent_id
	, CONCAT('/repositories/', digital_object.repo_id, '/digital_objects/', digital_object.id) AS URI
	, CAST(note.notes as CHAR (20000) CHARACTER SET UTF8) AS Text
FROM note
LEFT JOIN note_persistent_id npi on note.id = npi.note_id
LEFT JOIN digital_object on digital_object.id = note.digital_object_id
WHERE digital_object.repo_id = 12
#AND note.publish = 0
UNION
SELECT note.publish as pub_status
	, npi.persistent_id
	, CONCAT('/repositories/', archival_object.repo_id, '/archival_objects/', archival_object.id) AS URI
    , CAST(note.notes as CHAR (20000) CHARACTER SET UTF8) AS Text
FROM note
LEFT JOIN note_persistent_id npi on note.id = npi.note_id
LEFT JOIN archival_object on archival_object.id = note.archival_object_id
WHERE archival_object.repo_id = 12
#AND note.publish = 0
GROUP BY URI
