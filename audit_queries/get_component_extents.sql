select CONCAT('/repositories/', ao.repo_id, '/archival_objects/', ao.id) AS component_URI
	, CONCAT('/repositories/', r.repo_id, '/resources/', r.id) AS resource_URI
	, ev2.value AS extent_type 
	, e.number as number
	, ev.value AS portion
    , e.container_summary
    , e.physical_details
    , e.dimensions
    , r.title
	, r.ead_id
    , ao.display_string
FROM extent e
LEFT JOIN archival_object ao on ao.id = e.archival_object_id
LEFT JOIN resource r on r.id = ao.root_record_id
LEFT JOIN enumeration_value ev on ev.id = e.portion_id
LEFT JOIN enumeration_value ev2 on ev2.id = e.extent_type_id
WHERE r.repo_id = 12 #insert your repo_id here