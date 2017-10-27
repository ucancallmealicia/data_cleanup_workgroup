SELECT DISTINCT repository.name
	, resource.identifier as parent_id 
	, NULL as parent_title
    , resource.title as title
	, rr.begin as begin_date
	, rr.end as end_date 
	, ev.value as restriction_type
    , CONCAT('/repositories/', resource.repo_id, '/resources/', resource.id) AS uri
	, rr.id as rr_id
	, rr.restriction_note_type as note_type
    , npi.persistent_id
from rights_restriction rr
LEFT JOIN rights_restriction_type rrt on rrt.rights_restriction_id = rr.id
LEFT JOIN enumeration_value ev on ev.id = rrt.restriction_type_id
JOIN resource on resource.id = rr.resource_id
LEFT JOIN repository on repository.id = resource.repo_id
JOIN note on note.resource_id = resource.id
LEFT JOIN note_persistent_id npi on npi.parent_id = resource.id
WHERE (note.notes LIKE '%"type":"accessrestrict"%' OR note.notes LIKE '%"type":"userestrict"%')
UNION
SELECT DISTINCT repository.name
	, resource.identifier as parent_id 
	, resource.title as parent_title
    , resource.title as title
	, rr.begin as begin_date
	, rr.end as end_date 
	, ev.value as restriction_type
    , CONCAT('/repositories/', resource.repo_id, '/archival_objects/', resource.id) AS uri
	, rr.id as rr_id
	, rr.restriction_note_type as note_type
    , npi.persistent_id
from rights_restriction rr
LEFT JOIN rights_restriction_type rrt on rrt.rights_restriction_id = rr.id
JOIN archival_object ao on rr.archival_object_id = ao.id
JOIN resource on ao.root_record_id = resource.id
LEFT JOIN enumeration_value ev on ev.id = rrt.restriction_type_id
LEFT JOIN repository on repository.id = resource.repo_id
LEFT JOIN note_persistent_id npi on npi.parent_id = ao.id
JOIN note on note.resource_id = resource.id
WHERE (note.notes LIKE '%"type":"accessrestrict"%' OR note.notes LIKE '%"type":"userestrict"%')
#JOIN note_persistent_id npi on note.id = npi.note_id