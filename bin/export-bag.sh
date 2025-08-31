#!/bin/bash

DATABASE="stetl"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd ${SCRIPT_DIR}/../bag_csv

echo "CREATE INDEX adres_postcode ON adres (postcode varchar_pattern_ops);" | psql -d ${DATABASE} -U postgres

echo "\\copy (select distinct substring(postcode from 1 for 4) as pp4 from adres where postcode ~ '^[0-9]{4}' order by pp4) to 'postcodes4pp.csv';" | psql -d ${DATABASE} -U postgres


{ cat postcodes4pp.csv; ls -1 [0-9]*csv | sed 's/\.csv$//'; } | sort -u -n | while read i; do
	echo "\\copy (select distinct openbareruimtenaam, huisnummer, huisletter, huisnummertoevoeging, postcode, woonplaatsnaam, gemeentenaam, provincienaam, typeadresseerbaarobject, cast(ST_X(ST_Transform(geopunt, 4326)) as numeric(9,6)) as longitude, cast(ST_Y(ST_Transform(geopunt, 4326)) as numeric(8,6)) as latitude from adres where postcode like '$i%' order by postcode, openbareruimtenaam, huisnummer, huisletter, huisnummertoevoeging) to '$i.csv' csv header;"
done | psql -d stetl -U postgres

