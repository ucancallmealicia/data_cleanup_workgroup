import csv
import json
 
csvin = input('Please enter path to input CSV: ')

#add way to run script on all files in a folder; same with pandas script
#extract persistent IDs, text

file = open(csvin, 'r', encoding='utf-8')
reader = csv.reader(file)
next(reader, None)

output_file = input('Please enter path to output CSV: ')
newfile = open(output_file, 'a', encoding='utf-8', newline='')
writer = csv.writer(newfile)

#headers = ['repo_name', 'persistent_id', 'note_text_json', 'component_title', 'resource_title', 'URI', 'restriction_type', 'begin', 'end', 'local_type', 'text_extract']
headers = ['uri', 'persistent_id', 'note_text']
writer.writerow(headers)

for row in reader:
    note_text = row[0]
    if note_text != '':
        new_dict = json.loads(note_text)
        for key, value in new_dict.items():
    #        print(key, value)
            if key == 'subnotes':
                for member in value:
                    for subkey, subvalue in member.items():
                        if subkey == 'content':
                            row.append(subvalue)
                            writer.writerows([row[1:]])
    else:
        row.append('no note')
        writer.writerows([row[1:]])
        continue
#    type(new_dict)


print('All Done! Check outfile for results')