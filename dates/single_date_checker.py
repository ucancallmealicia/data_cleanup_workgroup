#/usr/bin/python3
#~/anaconda3/bin/python

#This script will loop through the parsed date spreadsheets and find any single dates

import csv

filename = input('Please enter path to input CSV: ')
outfilename = input('Please enter path to output CSV: ')
file = open(filename, 'r', encoding='utf-8')
outfile = open(outfilename, 'a', encoding='utf-8')

headers = ['id', 'expression', 'begin', 'end']

csvin = csv.reader(file)
csvout = csv.writer(outfile)
csvout.writerow(headers)
next(csvin, None)
for row in csvin:
    newrow = []
    date_start = row[2]
    date_end = row[3]
    if date_start == date_end:
        newrow.append(row[:3])
    else:
        csvout.writerow(row)