#/usr/bin/python3
#~/anaconda3/bin/python

#This script will loop through the parsed date spreadsheets and split different date
#types into their own spreadsheets

#should combine all date editing stuff into a single program

import csv

csvinput = input('Please enter path to input CSV: ')
csvoutput1 = input('Please enter path to output csv1: ')
csvoutput2 = input('Please enter path to output csv2: ')
csvoutput3 = input('Please enter path to output csv3: ')
csvoutput4 = input('Please enter path to output csv4: ')

file = open(csvinput, 'r', encoding='utf-8')
reader = csv.reader(file)
next(reader, None)
#Creates output files
outfile1 = open(csvoutput1, 'a', encoding='utf-8', newline='')
writer1 = csv.writer(outfile1)
outfile2 = open(csvoutput2, 'a', encoding='utf-8', newline='')
writer2 = csv.writer(outfile2)
outfile3 = open(csvoutput3, 'a', encoding='utf-8', newline='')
writer3 = csv.writer(outfile3)
outfile4 = open(csvoutput4, 'a', encoding='utf-8', newline='')
writer4 = csv.writer(outfile4)

headers1 = ['id', 'expression', 'begin', 'date_type_id']
headers2 = ['id', 'expression', 'begin', 'end', 'date_type_id']
headers3 = ['id', 'expression', 'end', 'date_type_id']
#forgot to give this to Lyrasis...
headers4 = ['id', 'expression', 'begin', 'date_type_id']

writer1.writerow(headers1)
writer2.writerow(headers2)
writer3.writerow(headers3)
writer4.writerow(headers4)

for row in reader:
    newrow = []
    date_start = row[2]
    date_end = row[3]
    if date_start == date_end:
        row.insert(3, '903')
        newrow.append(row[:4])
        writer1.writerows(newrow)
    elif date_start == 'null':
        #this seems silly but it works...
        for item in row:
            if item != 'null':
                newrow.append(item)
        newrow.append('905')
        writer3.writerow(newrow)
    elif date_end == 'null':
        for item in row:
            if item != 'null':
                newrow.append(item)
        newrow.append('905')
        writer4.writerow(newrow)
    else:
        row.append('905')
        writer2.writerow(row)