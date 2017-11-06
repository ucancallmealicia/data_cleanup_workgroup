#get resource-level restriction info
SELECT CONCAT('/repositories/', resource.repo_id, '/resources/', resource.id)
	, publish AS resource_pub_status
    , title AS resource_title
    , ead_id AS EAD_ID
FROM resource
#filter by repo_id for sake of performance and repo-by-repo review
WHERE repo_id = 12 #change for each repo
#1 is published, 0 is unpublished
AND publish = 1 #change for each pub status