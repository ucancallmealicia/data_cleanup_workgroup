select ev2.value AS extent_type 
	, e.number as number
	, ev.value AS portion
    , e.container_summary
    , e.physical_details
    , e.dimensions
    , r.title
	, r.ead_id
FROM extent e
LEFT JOIN resource r on r.id = e.resource_id
LEFT JOIN enumeration_value ev on ev.id = e.portion_id
LEFT JOIN enumeration_value ev2 on ev2.id = e.extent_type_id
WHERE r.repo_id = 12 #insert your repo_id here