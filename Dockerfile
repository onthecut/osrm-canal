FROM osrm/osrm-backend

ADD canalboat.lua /opt/canalboat.lua

RUN apt-get update && apt-get install -y wget && apt-get full-upgrade -y && apt-get clean && \
    mkdir -p /data && \
    wget -c -O /data/great-britain-latest.osm.pbf http://download.geofabrik.de/europe/great-britain-latest.osm.pbf && \
    osrm-extract -p /opt/canalboat.lua /data/great-britain-latest.osm.pbf && \
    osrm-contract /data/great-britain-latest.osrm && \
    osrm-partition /data/great-britain-latest.osrm && \
    osrm-customize /data/great-britain-latest.osrm && \
    rm /data/great-britain-latest.osm.pbf

CMD osrm-routed --algorithm mld /data/great-britain-latest.osrm


