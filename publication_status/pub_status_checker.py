#/usr/bin/python3
#~/anaconda3/bin/python

#This script will loop through the sorted publication status records for RUs and tell me if I did something wrong

import master_toolkit as mt

#Open the directory containing the files
#Open each file
dirpath = mt.setdirectory()
#newpath = input('Please enter path to output folder')
outfile = mt.opentxt()
filelist = os.listdir(dirpath)

headers = ['r_ps', 'r_title', 'ao_ps', 'ead_id', 'ao_title', 'ao_level', 'ao_uri',
'r_id', 'nltk', 'restrict_flag']

#using 'will' in this list will return all 'Williams' too, so maybe take out for now
keywords = ['conduct', 'confidential', 'counsel', 'discipline', 'fraud', 'grievance',
'harassment', 'legal', 'police', 'promotion', 'recruitment', 'retention', 'review',
'search', 'shgb', 'suit', 'tenure', 'termination', 'complaint', 'bequest', 'target', 
'trust', 'estate', 'misconduct', 'arrest']

filelist = os.listdir(dirpath)
for file in filelist:
    csvfile = mt.opencsvs(dirpath, file)
#    csvoutfile = opencsvsout(newpath, file)
#    csvoutfile.writerow(headers)
    for row in csvfile:
        ao_ps = row[2]
        ao_title = row[4]
        ao_level = row[5]
        ao_uri = row[6]
        r_id = row[7]
        if ao_ps == '1':
            title_lower = ao_title.lower()
            title_list = title_lower.split()
            for word in title_list:
                if word in keywords:
                    outfile.write(ao_title + ', ' + word + ', ' + ao_uri + ', ' + r_id + ', ' + file + '\n')
        #        row.append(word)
        # if ao_ps == '0':
        #     if ao_level == 'series':
        #         outfile.write(file + ' ' + ao_uri + ' ' + r_id)
        # csvoutfile.writerow(row)





#convert title to lowercase, split into a list, then loop through and then check against 
#keyword

# for name in names:
#     x = 0
#     y = 0
#     if name == '.DS_Store':
#         pass
#     else:
#         file = open(path + '/' + name, 'r', encoding='utf-8')
#         csvin = csv.reader(file)
#         next(csvin, None)
#         for row in csvin:
#             resource_status = row[0]
#             component_status = row[1]
#             if row[0] == '0':
#                 #change so it doesn't write every single time it encounters this...
# #                outfile.write(str(name) + ' is unpublished at the resource level\n')
#                 x = x + 1
#             if row[2] == '0':
# #                outfile.write(str(name) + ' contains unpublished archival objects\n')
#                 y = y + 1
#     outfile.write(str(name) + ' has ' + str(x) + ' unpublished resources and ' + str(y) + ' unpublished archival objects. Yay!\n')
                 
    
#Read in the lines
#Check row[0] for 1s or 0s
#Check row[2] for 1s or 0s
#If there is a 0, alert me somehow that there is one; don't need to pull out, just inform me in some way
#Done.