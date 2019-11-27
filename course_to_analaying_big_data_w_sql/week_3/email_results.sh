#!/bin/bash 
impala-shell \
--quiet \
--delimited \
--output_delimiter=','\
--print_header \
-q 'SELECT * FROM fly.flights
WHERE air_time =0;' \
-o zero_air_time.csv
mail \
-a zero_air_time.csv \
-s 'flights with zero air_time' \
'Do you know why zero_air_time is zero in these rows?'
