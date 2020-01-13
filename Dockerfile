FROM osrm/osrm-backend

ADD canalboat.lua /opt/canalboat.lua

RUN apt-get update && apt-get install -y wget && apt-get clean && \
    mkdir -p /data && \
    wget -c -O /data/england-latest.osm.pbf http://download.geofabrik.de/europe/great-britain-latest.osm.pbf && \
    osrm-extract -p /opt/canalboat.lua /data/england-latest.osm.pbf && \
    osrm-contract /data/england-latest.osrm && \
    osrm-partition /data/england-latest.osrm && \
    osrm-customize /data/england-latest.osrm && \
    rm /data/england-latest.osm.pbf

CMD osrm-routed --algorithm mld /data/england-latest.osrm


