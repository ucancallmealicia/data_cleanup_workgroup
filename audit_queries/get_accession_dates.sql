SELECT accession.display_string
	, ev2.value as date_type
    , ev3.value as date_certainty
    , ev4.value as date_calendar
    , ev5.value as date_era
    , ev6.value as date_label
    , date.expression as date_expression
    , date.begin as begin_date
    , date.end as end_date
    , date.accession_id
FROM date
LEFT JOIN accession on accession.id = date.accession_id
LEFT JOIN enumeration_value ev2 on ev2.id = date.date_type_id
LEFT JOIN enumeration_value ev3 on ev3.id = date.certainty_id
LEFT JOIN enumeration_value ev4 on ev4.id = date.calendar_id
LEFT JOIN enumeration_value ev5 on ev5.id = date.era_id
LEFT JOIN enumeration_value ev6 on ev6.id = date.label_id
WHERE accession.repo_id = 12 #your repo id goes here
