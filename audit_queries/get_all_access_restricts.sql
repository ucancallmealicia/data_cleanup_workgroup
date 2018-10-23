SELECT repository.name as repo_name 
	, npi.persistent_id as persistent_id
	, CAST(note.notes as CHAR (15000) CHARACTER SET UTF8) AS text
    , ao.display_string as ao_title
    , resource.title as parent_title
    , CONCAT('/repositories/', ao.repo_id, '/archival_objects/', ao.id) AS uri
    , rr.restriction_note_type
    , rr.begin
    , rr.end
    , ev.value as restriction_type
FROM note_persistent_id npi
JOIN note on npi.note_id = note.id
JOIN archival_object ao on note.archival_object_id = ao.id
JOIN resource on ao.root_record_id = resource.id
JOIN repository on ao.repo_id = repository.id
LEFT JOIN rights_restriction rr on rr.archival_object_id = ao.id
LEFT JOIN rights_restriction_type rrt on rrt.rights_restriction_id = rr.id 
LEFT JOIN enumeration_value ev on ev.id = rrt.restriction_type_id
#filter to show only access restrict notes...
WHERE note.notes LIKE '%"type":"accessrestrict"%'
#this line is to get rid of some of the duplicate results related to inheritance of machine-actionable restrictions
#still about 85 extras - these are the ones with two access restrict notes or ones with two MARs
AND (rr.restriction_note_type is null or rr.restriction_note_type LIKE 'accessrestrict')
UNION
SELECT repository.name as repo_name 
	, npi.persistent_id as persistent_id
	, CAST(note.notes as CHAR (15000) CHARACTER SET UTF8) AS text
    , NULL as ao_title
    , resource.title as title
    , CONCAT('/repositories/', resource.repo_id, '/resources/', resource.id) AS uri
    , rr.restriction_note_type
    , rr.begin
    , rr.end
    , ev.value as restriction_type
FROM note_persistent_id npi
JOIN note on npi.note_id = note.id
JOIN resource on note.resource_id = resource.id
JOIN repository on resource.repo_id = repository.id
LEFT JOIN rights_restriction rr on rr.resource_id = resource.id
LEFT JOIN rights_restriction_type rrt on rrt.rights_restriction_id = rr.id
LEFT JOIN enumeration_value ev on ev.id = rrt.restriction_type_id
#filter to show only access restrict notes...
WHERE note.notes LIKE '%"type":"accessrestrict"%'
#this line is to get rid of some of the duplicate results related to inheritance of machine-actionable restrictions
#still about 85 extras - these are the ones with two access restrict notes or ones with two MARs
AND (rr.restriction_note_type is null or rr.restriction_note_type LIKE 'accessrestrict')
