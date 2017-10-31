#!/usr/bin/python

# Use: Check links in file_version.file_uri. Write retrieved URL and HTTP response codes to outfile. Retrieved url is empty string if connection failed.

# Update
datafile = 'file_uri_prod_20171023.tsv'
outfile = 'file_uri_audit_prod_20171023.tsv'

from check_url import *

# Read header row into headers.
# Read file_uri into data.
header = ''
data = []
with open(datafile, 'r') as f:
    header = f.next().strip('\r\n')
    for line in f:
        uri = line.strip('\r\n')
        if len(uri) > 0:
            data.append(uri)

# Check urls. Write output.
out = open(outfile, 'w')
output = header + '\t' + 'retrieved_url' + '\t' + 'http_response_code' + '\n'
out.write(output)
for uri in data:
    response = check_url(uri, 5)
    retrieved_url = response[0]
    http_response_code = str(response[1])
    output = uri + '\t' + retrieved_url + '\t' + http_response_code + '\n'
    out.write(output)
out.close()


