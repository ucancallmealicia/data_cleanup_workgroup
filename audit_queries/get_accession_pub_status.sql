#get resource-level restriction info
SELECT CONCAT('/repositories/', accession.repo_id, '/accessions/', accession.id)
	, identifier
    , title AS accession_title
	, publish AS accession_pub_status
FROM accession
#filter by repo_id for sake of performance and repo-by-repo review
WHERE repo_id = 12 #change for each repo
#1 is published, 0 is unpublished
AND publish = 1 #change for each pub status