#Python 3

#Written for a Mac. Test compatibility with PC

#Requirements - Ruby, timetwister

#This script uses a Python wrapper to execute Alex Duryee's Timetwister application against a CSV containing a 
#column of unparsed date expressions. Written for use with the output of a date query against the ArchivesSpace database

import subprocess
import csv
import json
import pandas as pd

#Takes the CSV input, column in which the date expression is located (column numbering starts with 0, so
#column A would be signified by row[0], column B by row[1], etc.), and the command (i.e. timetwister)
#as arguments
def parse(csvin, csvout, column_no, command):
    file = open(csvin, 'r', encoding='utf-8')
    outfile = open(csvout, 'a', encoding='utf-8', newline='')
    reader = csv.reader(file)
    writer = csv.writer(outfile)
    #Skips header row. Remove this line if there is no header
    next(reader, None)
    #Loops through each line
    for row in reader:
        data = []
        date_expression = row[int(column_no)]
        date_id = row[0]
        URI = row[2]
        data.insert(0, date_id)
        data.insert(1, URI)
        data.insert(2, date_expression)
        process = subprocess.Popen([command, str(date_expression)], stdout=subprocess.PIPE, encoding='utf-8')
        for line in process.stdout:
#            print(line)
            data.insert(3, line)
#            writer.writerow([line])
        writer.writerow(data)
    print('Done!')

#This function takes the output of parse() and separates into columns; these columns are
#then appended to a new copy of the original input spreadsheet
def process_outfile(csvout, newfile):
#    file = open(csvin, 'r', encoding='utf-8')
    outfile = open(csvout, 'r', encoding='utf-8')
    newcsvfile = open(newfile, 'w', encoding='utf-8')
    reader = csv.reader(outfile)
#    reader_two = csv.reader(file)
    writer = csv.writer(newcsvfile)
    headers = ['date_id', 'URI', 'expression', 'original_string', 'index_dates', 'date_start', 'date_end', 'date_start_full', 'date_end_full', 'inclusive_range', 'certainty', 'test_data']
    writer.writerow(headers)
    for row in reader:
        newdata = []
        date_id = row[0]
        URI = row[1]
        expression = row[2]
        try:
            date_info = row[3]
        except:
            continue
        newdata.insert(0, date_id)
        newdata.insert(1, URI)
        newdata.insert(2, expression)
        if date_info != '':
            newstring = date_info.replace(":[", ":\"[")
            newnewstring = newstring.replace("],", "]\",")
            newest_string = newnewstring.replace('null','\"null\"')
            last_string = newest_string.replace('true', '\"true\"')
            final_string = last_string.replace('false', '\"false\"')
            new_info = eval(final_string)
            for member in new_info:
                for key, value in member.items():
                    newdata.append(value)
            writer.writerows([newdata])
        else:
            writer.writerows([newdata])
        
#If entering just the command does not work, try entering the full path to timetwister
#path = input('Please enter command name or path to command\n(i.e. "timetwister" or "/Users/username/.gem/ruby/2.0.0/bin/timetwister": ')
#If csv is in same directory as script, enter just file name (i.e input.csv). If outside directory containing
#script, enter full path (i.e. /Users/username/Desktop/input.csv)
csvinput = input('Please enter path to input csv: ')
csvoutput = input('Please enter path to output csv: ')
column = input('In what column are your date expressions? (NOTE: columns are numbered 0-n): ')

parse(csvinput, csvoutput, column, path)
input('Done parsing dates! Press Enter to continue')

newcsv = input('Please enter path to a new CSV file: ')

process_outfile(csvoutput, newcsv)


