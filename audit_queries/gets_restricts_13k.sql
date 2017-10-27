#still unclear about why there are 2284 more results when incorporating rights_restriction table...seems like an odd number
#so some have the same persistent id but a different rr_id...why?
SELECT repository.name as repo_name
	, resource.title as parent_name
	, ao.display_string as title
	, CONCAT('/repositories/', ao.repo_id, '/archival_objects/', ao.id) AS uri
    , rr.restriction_note_type as rr_note_type
    , rr.begin as begin_date
    , rr.end as end_date
    , ev.value as restriction_type
	, CAST(note.notes as CHAR (15000) CHARACTER SET UTF8) AS text
    , npi.persistent_id as persistent_id
    , rr.id as rr_id
FROM archival_object ao
JOIN note on ao.id = note.archival_object_id
LEFT JOIN rights_restriction rr on rr.archival_object_id = ao.id
LEFT JOIN rights_restriction_type rrt on rr.id = rrt.rights_restriction_id
JOIN resource on ao.root_record_id = resource.id
JOIN repository on ao.repo_id = repository.id
JOIN note_persistent_id npi on npi.note_id = note.id
LEFT JOIN enumeration_value ev on ev.id = rrt.restriction_type_id
WHERE (note.notes LIKE '%"type":"accessrestrict"%' OR note.notes LIKE '%"type":"userestrict"%')
AND note.notes LIKE '%rights_restriction%'
#AND repository.id = 11
#AND rr.id is null
AND rr.id is not null
UNION ALL
SELECT repository.name as repo_name
	, NULL as parent_name
	, resource.title as title
	, CONCAT('/repositories/', resource.repo_id, '/resources/', resource.id) AS uri
    , rr.restriction_note_type as rr_note_type
    , rr.begin as begin_date
    , rr.end as end_date
    , ev.value as restriction_type
	, CAST(note.notes as CHAR (15000) CHARACTER SET UTF8) AS text
    , npi.persistent_id as persistent_id
    , rr.id as rr_id
FROM resource
JOIN note on resource.id = note.resource_id
LEFT JOIN rights_restriction rr on rr.resource_id = resource.id
LEFT JOIN rights_restriction_type rrt on rr.id = rrt.rights_restriction_id
JOIN repository on resource.repo_id = repository.id
LEFT JOIN note_persistent_id npi on npi.note_id = note.id
LEFT JOIN enumeration_value ev on ev.id = rrt.restriction_type_id
WHERE (note.notes LIKE '%"type":"accessrestrict"%' OR note.notes LIKE '%"type":"userestrict"%')
AND note.notes LIKE '%rights_restriction%'
#AND repository.id = 11
UNION ALL
SELECT repository.name as repo_name
	, NULL as parent_name
	, do.title as title
	, CONCAT('/repositories/', do.repo_id, '/digital_objects/', do.id) AS uri
    , NULL as rr_note_type
    , NULL as begin_date
    , NULL as end_date
    , NULL as restriction_type
	, CAST(note.notes as CHAR (15000) CHARACTER SET UTF8) AS text
    , npi.persistent_id as persistent_id
    , NULL as rr_id
FROM digital_object do
JOIN note on do.id = note.digital_object_id
JOIN repository on do.repo_id = repository.id
LEFT JOIN note_persistent_id npi on npi.note_id = note.id
#LEFT JOIN rights_restriction_type rrt on rr.id = rrt.rights_restrictiona_D
WHERE (note.notes LIKE '%"type":"accessrestrict"%' OR note.notes LIKE '%"type":"userestrict"%')
AND note.notes LIKE '%rights_restriction%'
#AND repository.id = 11
