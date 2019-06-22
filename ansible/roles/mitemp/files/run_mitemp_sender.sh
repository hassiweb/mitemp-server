#!/bin/sh

export MITEMP_DATA="/home/pi/mitemp/data"
export INFLUXDB_CONF="/home/pi/mitemp/conf"

sudo docker run -v $MITEMP_DATA:/data -v $INFLUXDB_CONF:/app/mitemp-sender/conf hassiweb/mitemp-sender python3 sender.py /data /app/mitemp-sender/conf/influxdb.conf
rm $MITEMP_DATA/*.json
