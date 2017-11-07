#get resource-level restriction info
SELECT CONCAT('/repositories/', resource.repo_id, '/resources/', resource.id)
	, resource.publish AS resource_pub_status
    , resource.title AS resource_title
    , resource.ead_id AS EAD_ID
    , repository.name as repo_name
    , repository.id as repo_num
FROM resource
JOIN repository on resource.repo_id = repository.id
#filter by repo_id for sake of performance and repo-by-repo review
#WHERE repo_id = 12 #change for each repo
#1 is published, 0 is unpublished
#AND publish = 1 #change for each pub status