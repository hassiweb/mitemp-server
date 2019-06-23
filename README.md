# [README] mitemp-server Temperature & Humidity Monitoring System using Xiaomi Bluetooth Sensor and Raspberry Pi
## What is M*iTemp-Server*?
MiTemp-Server is composed of two things: 1. application (hassiweb/mitemp and hassiweb/mitemp-sender) deployment into Raspberry Pi using Ansible 2. instantiation of 
InfluxDB and Grafana docker containers **System architecture and required hardware** 1. [Xiaomi temperature/Humidity Bluetooth 
Sensor](https://www.aliexpress.com/item/Xiaomi-Mijia-Bluetooth-Temperature-Smart-Humidity-Sensor-LCD-Screen-Digital-Thermometer-Moisture-Meter-Mi-APP/32856054922.html?aff_platform=product&cpt=1561275861425&onelink_item_from=32856054922&onelink_thrd=0.015&onelink_page_from=ITEM_DETAIL&onelink_item_to=32856054922&pvid=6831681f-3484-4dfd-818c-e5754f5693b4&onelink_duration=0.764124&sk=0uTUsmc&aff_trace_key=0fee1a23e9064aac95187a77d884387a-1561275861425-08008-0uTUsmc&onelink_status=noneresult&scm=1007.22893.125781.0&terminal_id=0b4ae205e99b45d4ac69148ef39c0a40&onelink_page_to=ITEM_DETAIL) 
2. Raspberry Pi which supports Ethernet (either wired and wireless) and Bluetooth (e.g. 3B+, Zero W, etc.) 3. Linux server 
![](https://paper-attachments.dropbox.com/s_D02AFA1BC265A61F7075157813A2D55B9B5526EFE216F441DA33E837BA2A6FAA_1561275696219_Temp+monitoring+system.png)
## How to use this?
All instructions are run on the Linux server. 1. Clone this repository
    $ git clone https://github.com/hassiweb/mitemp-server
    $ cd mitemp-server 2. Run Docker containers of InfluxDB and Grafana
    $ docker-compose up -d 3. Modify some configurations
    1. Sensor’s MAC address list
        1. File: `[ansible/roles/mitemp/files/mac_list.txt](https://github.com/hassiweb/mitemp-server/blob/master/ansible/roles/mitemp/files/mac_list.txt)`
        2. Description: MAC addresses to be scanned at Raspberry Pies
    2. InfluxDB connection information
        1. File: `[ansible/roles/mitemp/files/influxdb.conf](https://github.com/hassiweb/mitemp-server/blob/master/ansible/roles/mitemp/files/influxdb.conf)`
        2. Description: Information to connect a database in InfluxDB
    3. Time intervals to scan and send temperature and humidity data
        1. File: `[ansible/roles/mitemp/vars/<Raspberry 
Pi](https://github.com/hassiweb/mitemp-server/blob/master/ansible/roles/mitemp/vars/192.168.0.31.yml)``['](https://github.com/hassiweb/mitemp-server/blob/master/ansible/roles/mitemp/vars/192.168.0.31.yml)``[s 
host name/IP address>.yml](https://github.com/hassiweb/mitemp-server/blob/master/ansible/roles/mitemp/vars/192.168.0.31.yml)`
        2. Description: Cron is used to run containers to scan data and send data.  This time intervals are defined in this file.  `mitemp_measurement_cron_min` 
defines the time interval mitemp_measurement_cron_min to run the container to scan data.  `mitemp_sender_cron_min` defines the time interval in minutes to run the 
container to send data.  The format of both variables follows the crontab format.
    4. Inventory for Ansible targets (i.e. Raspberry Pies)
        1. File: `ansible/inventory/inventory.ini`
        2. Description: This follows Ansible definition. 4. Run ansible-playbook
    $ ansible-playbook -i inventory/inventory.ini mitemp_deploy.yml
    After this deployment, Raspberry Pies start scanning and sending data to the InfluxDB on the server.
    You can confirm the data with a commend below:
    $ curl -G 'http://<Your server's host name>:8087/query?pretty=true' --data-urlencode "db=mitemp" --data-urlencode 'q=SELECT * from "<Sensor's MAC address>"' 5. 
Visualize temperature and humidity data on Grafana
    Open Grafana on a browser and type your server’s host name and the port number of the Grafana container (default is 8087).
    With some configurations of Grafana, you can show a dashboard like below.
    
![](https://paper-attachments.dropbox.com/s_D02AFA1BC265A61F7075157813A2D55B9B5526EFE216F441DA33E837BA2A6FAA_1561277404562_Grafana-MiTemp.png)
## License
MIT
## Japanese Information
See my blog below. - [**Raspberry 
Piで温湿度モニタリングシステムの構築**](https://hassiweb-programming.blogspot.com/2019/06/temp-humidity-monitoring-system-using-raspberry-pi.html)
## Contact
- [Twitter](https://twitter.com/hassiweb)
