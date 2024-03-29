#!/bin/sh
wget -nc -nc https://download.geofabrik.de/europe/austria-latest.osm.pbf
wget -nc https://download.geofabrik.de/europe/croatia-latest.osm.pbf
wget -nc https://download.geofabrik.de/europe/cyprus-latest.osm.pbf
wget -nc https://download.geofabrik.de/europe/czech-republic-latest.osm.pbf
wget -nc https://download.geofabrik.de/europe/france-latest.osm.pbf
wget -nc https://download.geofabrik.de/europe/germany-latest.osm.pbf
wget -nc https://download.geofabrik.de/europe/hungary-latest.osm.pbf
wget -nc https://download.geofabrik.de/europe/italy-latest.osm.pbf
wget -nc https://download.geofabrik.de/europe/liechtenstein-latest.osm.pbf
wget -nc https://download.geofabrik.de/europe/montenegro-latest.osm.pbf
wget -nc https://download.geofabrik.de/europe/netherlands-latest.osm.pbf
wget -nc https://download.geofabrik.de/europe/poland-latest.osm.pbf
wget -nc https://download.geofabrik.de/europe/romania-latest.osm.pbf
wget -nc https://download.geofabrik.de/europe/slovakia-latest.osm.pbf
wget -nc https://download.geofabrik.de/europe/slovenia-latest.osm.pbf
wget -nc https://download.geofabrik.de/europe/spain-latest.osm.pbf
wget -nc https://download.geofabrik.de/europe/switzerland-latest.osm.pbf
osmium merge austria-latest.osm.pbf croatia-latest.osm.pbf cyprus-latest.osm.pbf czech-republic-latest.osm.pbf france-latest.osm.pbf germany-latest.osm.pbf hungary-latest.osm.pbf italy-latest.osm.pbf liechtenstein-latest.osm.pbf montenegro-latest.osm.pbf netherlands-latest.osm.pbf poland-latest.osm.pbf romania-latest.osm.pbf slovakia-latest.osm.pbf slovenia-latest.osm.pbf spain-latest.osm.pbf switzerland-latest.osm.pbf -o europe-selected.osm.pbf
# osmium merge *-latest.osm.pbf -o europe-selected.osm.pbf