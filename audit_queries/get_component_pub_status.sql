#this query filters by archival object, but also shows the resource-level publication status for each object
SELECT resource.publish AS resource_pub_status
    , resource.title AS resource_title
    , ao.publish AS component_pub_status
    , resource.ead_id AS EAD_ID
    , ao.display_string AS component_title
    , ev.value AS component_level
FROM archival_object ao
LEFT JOIN resource on ao.root_record_id = resource.id
LEFT JOIN enumeration_value ev on ev.id = ao.level_id
#filter by repo_id for sake of performance and repo-by-repo review
WHERE ao.repo_id = 12 #change for each repo
#1 is published, 0 is unpublished
AND ao.publish = 0 #change for each pub status
