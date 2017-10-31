SELECT digital_object.id, 
	digital_object.digital_object_id,
	digital_object.repo_id,
	repository.repo_code
FROM digital_object INNER JOIN repository ON digital_object.repo_id = repository.id
WHERE digital_object.digital_object_id LIKE '%http%';