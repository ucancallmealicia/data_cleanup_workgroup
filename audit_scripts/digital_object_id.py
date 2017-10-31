#!/usr/bin/python

# Use: Check links in digital_object.digital_object_id. Write retrieved URL and HTTP response codes to outfile. Retrieved url is empty string if connection failed.

# Update
datafile = 'digital_object_id_prod_20171023.tsv'
outfile = 'digital_object_id_audit_prod_20171023.tsv'

from check_url import *

# Read header row into headers.
# Read [id, digital_object_id, repo_id, repo_code] into data.
headers = []
data = []
with open(datafile, 'r') as f:
    headers = f.next().strip('\r\n').split('\t')
    for line in f:
        row = line.strip('\r\n').split('\t')
        data.append(row)

# Check urls. Write output.
out = open(outfile, 'w')
output = '\t'.join(headers) + '\t' + 'retrieved_url' + '\t' + 'http_response_code' + '\n'
out.write(output)
for row in data:
    response = check_url(row[1], 5)
    retrieved_url = response[0]
    http_response_code = str(response[1])
    output = '\t'.join(row) + '\t' + retrieved_url + '\t' + http_response_code + '\n'
    out.write(output)
out.close()


