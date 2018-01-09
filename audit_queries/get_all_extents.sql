SELECT CONCAT('/repositories/', resource.repo_id, '/resources/', resource.id) AS uri
	, ev2.value as extent_type
    	, e.container_summary
    	, resource.title as title
	, ev.value as portion
	, e.number
    	, resource.repo_id as repo_id
    	, e.id as extent_id
FROM resource
JOIN extent e on resource.id = e.resource_id
LEFT JOIN enumeration_value ev on ev.id = e.portion_id
LEFT JOIN enumeration_value ev2 on ev2.id = e.extent_type_id
UNION ALL
SELECT CONCAT('/repositories/', accession.repo_id, '/accessions/', accession.id) AS uri
	, ev2.value as extent_type
    	, e.container_summary
    	, accession.title as title
	, ev.value as portion
	, e.number 
    	, accession.repo_id as repo_id
    	, e.id as extent_id
FROM accession
JOIN extent e on accession.id = e.accession_id
LEFT JOIN enumeration_value ev on ev.id = e.portion_id
LEFT JOIN enumeration_value ev2 on ev2.id = e.extent_type_id
UNION ALL
SELECT CONCAT('/repositories/', ao.repo_id, '/archival_objects/', ao.id) AS uri
	, ev2.value as extent_type
    	, e.container_summary
    	, ao.title as title
	, ev.value as portion
	, e.number
    	, ao.repo_id as repo_id
    	, e.id as extent_id
FROM archival_object ao
JOIN extent e on ao.id = e.archival_object_id
LEFT JOIN enumeration_value ev on ev.id = e.portion_id
LEFT JOIN enumeration_value ev2 on ev2.id = e.extent_type_id
UNION ALL
SELECT CONCAT('/repositories/', do.repo_id, '/digital_objects/', do.id) AS uri
	, ev2.value as extent_type
    	, e.container_summary
    	, do.title as title
	, ev.value as portion
	, e.number
    	, do.repo_id as repo_id
    	, e.id as extent_id
FROM digital_object do
JOIN extent e on do.id = e.digital_object_id
LEFT JOIN enumeration_value ev on ev.id = e.portion_id
LEFT JOIN enumeration_value ev2 on ev2.id = e.extent_type_id
UNION ALL
SELECT CONCAT('/repositories/', doc.repo_id, '/digital_object_components/', doc.id) AS uri
	, ev2.value as extent_type
    	, e.container_summary
    	, doc.title as title
	, ev.value as portion
	, e.number
    	, doc.repo_id as repo_id
    	, e.id as extent_id
FROM digital_object_component doc
JOIN extent e on doc.id = e.digital_object_component_id
LEFT JOIN enumeration_value ev on ev.id = e.portion_id
LEFT JOIN enumeration_value ev2 on ev2.id = e.extent_type_id
UNION ALL
SELECT NULL as uri
	, ev2.value as extent_type
    	, e.container_summary
    	, deaccession.id as title
	, ev.value as portion
	, e.number
    	, NULL as repo_id
    	, e.id as extent_id
FROM deaccession
JOIN extent e on deaccession.id = e.deaccession_id
LEFT JOIN enumeration_value ev on ev.id = e.portion_id
LEFT JOIN enumeration_value ev2 on ev2.id = e.extent_type_id
