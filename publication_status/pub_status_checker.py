#/usr/bin/python3
#~/anaconda3/bin/python

#This script will loop through the sorted publication status records for RUs and tell me if I did something wrong

import csv
import os

#Open the directory containing the files
#Open each file
path = input('Please enter path to folder you"d like to check: ')
names = os.listdir(path)
#print(names)

outfile = open('/Users/aliciadetelich/Dropbox/mssa/output.txt', 'a')

for name in names:
    x = 0
    y = 0
    if name == '.DS_Store':
        pass
    else:
        file = open(path + '/' + name, 'r', encoding='utf-8')
        csvin = csv.reader(file)
        next(csvin, None)
        for row in csvin:
            resource_status = row[0]
            component_status = row[1]
            if row[0] == '0':
                #change so it doesn't write every single time it encounters this...
#                outfile.write(str(name) + ' is unpublished at the resource level\n')
                x = x + 1
            if row[2] == '0':
#                outfile.write(str(name) + ' contains unpublished archival objects\n')
                y = y + 1
    outfile.write(str(name) + ' has ' + str(x) + ' unpublished resources and ' + str(y) + ' unpublished archival objects. Yay!\n')
                
        
        
    
#Read in the lines
#Check row[0] for 1s or 0s
#Check row[2] for 1s or 0s
#If there is a 0, alert me somehow that there is one; don't need to pull out, just inform me in some way
#Done.