UPDATE date, dateTemp
SET date.begin=dateTemp.begin, date.end=dateTemp.end, date.date_type_id=dateTemp.date_type_id
WHERE date.id = dateTemp.id AND dateTemp.id <> 0