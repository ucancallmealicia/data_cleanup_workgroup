#/usr/bin/python3
#~/anaconda3/bin/python

import requests
import json
import csv

#uri refers to top container uri...
headers = ['uri', 'barcode', 'container_profile', 'indicator', 
           'location_uri', 'location_start_date', 'type', 'ils_holding_id']


def login():
    api_url = input('Please enter the ArchivesSpace API URL: ')
    username = input('Please enter your username: ')
    password = input('Please enter your password: ')
    auth = requests.post(api_url+'/users/'+username+'/login?password='+password).json()
    #if session object is returned then login was successful; if not it failed.
    if 'session' in auth:
        session = auth["session"]
        headers = {'X-ArchivesSpace-Session':session, 'Content_Type':'application/json'}
        print('Login successful!')
        return (api_url, headers)
    else:
        print('Login failed! Check credentials and try again')
        return

def opencsvdict():
    '''This function opens a csv file in DictReader mode'''
    input_csv = input('Please enter path to CSV: ')
    file = open(input_csv, 'r', encoding='utf-8')
    csvin = csv.DictReader(file)
    return csvin

def prelim():
    values = login()
    store = []
    print('Retrieving container profile data. This may take a moment')
    id_list = requests.get(values[0] + '/container_profiles?all_ids=True', headers=values[1]).json()
    for id in id_list:
        profile_dict = {}
        id_json = requests.get(values[0] + '/container_profiles/' + str(id), headers=values[1]).json()
        for key, value in id_json.items():
             if key == 'name':
                 profile_dict['name'] = value
             if key == 'uri':
                 profile_dict['uri'] = value
             store.append(profile_dict)
    print('Containers retrieved!')
    return [values, store]
    
def update_tc_components():
    vals = prelim()
    cp_list = vals[1]
    csvfile = opencsvdict()
    for row in csvfile:
        record_uri = row['uri']
        record_json = requests.get(vals[0][0] + record_uri, headers=vals[0][1]).json()
        for key, value in row.items():
            #so you can add a container location. There is another ref key in the collection key/val,
            #but you shouldn't need to add that, it will automatically show up when ao instance
            #is created
            #This doesn't include a way to indicate series or active restrictions 
            # either, but you don't need that either (creating an instance will do that)
            for member in record_json['container_locations']:
                if key == 'location_start_date':
                    member['start_date'] = value
                if key == 'location_uri':
                    member['ref'] = value
            #Looks up container profile name and adds uri if found
            if key == 'container_profile':
                print(value)
                for keyval in cp_list:
                    if value in keyval.values():
                        record_json['container_profile'] = {'ref': keyval.get('uri')}
            #all other top container values can be modified this way - barcode, indicator, type, ils holding ID, etc. This is
            #more useful for records with more key/value pairs - i.e. resources, archival objects, etc.
            else:
                record_json[key] = value
        record_data = json.dumps(record_json)
        record_update = requests.post(vals[0][0] + record_uri, headers=vals[0][1], data=record_data).json()
        print(record_update)

update_tc_components()