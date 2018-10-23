#/usr/bin/python3
#~/anaconda3/bin/python

#Written on a Mac, but might work on a PC. Requires Ruby and the timetwister gem
#This script loops through an input CSV and execute Alex Duryee's Timetwister application against a 
#column of unparsed date expressions. Written for use with the output of a date query against the 
#ArchivesSpace database.

import subprocess, csv, json, ast

def parse(csvin, csvout, command):
    #Initialize counter
    x = 0
    #Opens input file
    file = open(csvin, 'r', encoding='utf-8')
    reader = csv.reader(file)
#    row_count = sum(1 for row in reader)
#    print(row_count)
    next(reader, None)
    #Creates output file
    outfile = open(csvout, 'a', encoding='utf-8', newline='')
    writer = csv.writer(outfile)
    #Writes some headers to output file
    headers = ['date_id', 'URI', 'expression', 'original_string', 'index_dates', 'date_start', 
               'date_end', 'date_start_full', 'date_end_full', 'inclusive_range', 'certainty', 'test_data']
    writer.writerow(headers)
    #Skips header row. Remove this line if there is no header
    #Loops through each line and executes timetwister command via subprocess
    for row in reader:
        #Counter
        x = x + 1
        print('Working on record # ' + str(x))
        data = []
        #This is the order these columns are returned in the output of the date query
        date_id = row[0]
        URI = row[1]
        date_expression = row[2]
        #adding them to the output spreadsheet so they can be related to the timetwister output
        data.insert(0, date_id)
        data.insert(1, URI)
        data.insert(2, date_expression)
        #runs timetwister against each date
        process = subprocess.Popen([command, str(date_expression)], stdout=subprocess.PIPE, encoding='utf-8')
        for line in process.stdout:
            try:
                #obviously hacky, but the subprocess module returns its output as a string. So
                #booleans and null values, as well as any lists, had double quotes around them.
                #ast.literal_eval, eval, and json.dumps all couldn't parse the output. So 
                #I manipulated some strings so they could be turned into a dictionary that I could
                #loop through, extract the values, and put in their own columns. If anyone has a better
                #way of doing this I'm all ears.
                 newstring = line.replace(":[", ":\"[").replace("],", "]\",").replace('null','\"null\"').replace('true', '\"true\"').replace('false', '\"false\"')
                 #Converts string to list containing JSON
                 new_info = ast.literal_eval(newstring)
                 #The output is actually a JSON-like string that is enclosed in a list, since
                 #there are some cases where a single date expression will be parsed into more 
                 #than one date. The JSON for both of these would be stored in a list. So we
                 #need to get inside that list to get at the dictionaries/JSON
                 for member in new_info:
                     #getting at the dictionaries
                     for key, value in member.items():
                         #appending to the list we'll write to the output spreadsheet
                         data.append(value)
            except:
                #sometimes Timetwister doesn't parse a date - unicode error, etc. This 
                #this makes a note of that and moves on. Could output the error message
                #but didn't worry about it since there weren't very many of these errors
                 data.append('Error! could not process date.')
        #writes to new CSV
        writer.writerow(data)
    print('Done!')

if __name__ == '__main__':        
    #If entering just the command does not work, try entering the full path to timetwister
    path = input('Please enter command name or path to command\n(i.e. "timetwister" or "/Users/username/.gem/ruby/2.0.0/bin/timetwister": ')
    #If csv is in same directory as script, or if you're running the script from the csv's directory, 
    #enter just file name (i.e input.csv). If outside directory containing script, enter full path 
    #(i.e. /Users/username/Desktop/input.csv)
    csvinput = input('Please enter path to input csv: ')
    csvoutput = input('Please enter path to output csv: ')
    parse(csvinput, csvoutput, path)