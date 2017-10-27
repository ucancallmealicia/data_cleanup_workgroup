SELECT repository.name as repo_name
	, resource.identifier as parent_id
	, resource.title as parent_title
    , ao.display_string as title
	, CAST(note.notes as CHAR (15000) CHARACTER SET UTF8) AS text
    , CONCAT('/repositories/', ao.repo_id, '/archival_objects/', ao.id) AS uri
    , npi.persistent_id
FROM note
JOIN archival_object ao on ao.id = note.archival_object_id
LEFT JOIN resource on resource.id = ao.root_record_id
LEFT JOIN repository on ao.repo_id = repository.id
#LEFT JOIN rights_restriction rr on rr.archival_object_id = ao.id
LEFT JOIN note_persistent_id npi on npi.note_id = note.id
#JOIN rights_restriction_type rrt on rrt.rights_restriction_id = rr.id
WHERE (note.notes LIKE '%"type":"accessrestrict"%' OR note.notes LIKE '%"type":"userestrict"%')
AND note.notes LIKE '%rights_restriction%'
UNION ALL
SELECT repository.name as repo_name
	, resource.identifier as parent_id 
	, NULL as parent_title
    , resource.title as title
	, CAST(note.notes as CHAR (15000) CHARACTER SET UTF8) AS text
	, CONCAT('/repositories/', resource.repo_id, '/resources/', resource.id) AS uri
    , npi.persistent_id
FROM note
JOIN resource on resource.id = note.resource_id
LEFT JOIN repository on resource.repo_id = repository.id
#LEFT JOIN rights_restriction rr on rr.resource_id = resource.id
LEFT JOIN note_persistent_id npi on npi.note_id = note.id
#LEFT JOIN rights_restriction_type rrt on rrt.rights_restriction_id = rr.id
WHERE (note.notes LIKE '%"type":"accessrestrict"%' OR note.notes LIKE '%"type":"userestrict"%')
AND note.notes LIKE '%rights_restriction%'
