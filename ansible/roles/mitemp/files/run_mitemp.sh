#!/bin/sh

export MITEMP_DIR="/home/pi/mitemp"

while read line
do
  echo $line
  sudo docker run --net host -v $MITEMP_DIR/data:/data -v /etc/localtime:/etc/localtime:ro hassiweb/mitemp python3 mitemp/mitemp.py --backend bluepy poll $line /data
done < $MITEMP_DIR/mac_list.txt

