# BAG: the address - geocode database for The Netherlands

## Set up

Download the BAG XML from: https://www.pdok.nl/nl/atomfeed/inspire-adressen (it's free and open)

Be sure  to have postgis ready.

Clone https://github.com/opengeogroep/NLExtract and follow the instructions to extract the BAG to your local PostGIS installation.

Wait for longer than 4 hours, and apply the adres-tabel.sql script, wait longer.

## Tools

extract.sh gets you the csv output in this folder.
