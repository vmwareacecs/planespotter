# Network Communications

One of uses of the Planespotter app can be to demonstrate NSX features like micro-segmentation policies. The the app is build with this in mind and uses quick timeouts to show the impact of firewall rule changes and includes a 'healtcheck' function that reports back communication issues between the 'microservices' of the app.

Here's the Communication Matrix of the component amongst each other and to the external world:

| Component / Source     | Component / Destination       | Dest Port | Notes                               |
|:-----------------------|:------------------------------|:----------|:------------------------------------|
| Ext. Clients / Browser | Planespotter Frontend         | TCP/80    |                                     |
| Ext. Clients / Browser | www.airport-data.com          | TCP/80    | Display Aircraft Thumbnail picture  |
| Planespotter Frontend  | Planespotter API/APP          | TCP/80    | The listening port is configurable  |
| Planespotter API/APP   | Planespotter MySQL	         | TCP/3306  | 									   |
| Planespotter API/APP   | Planespotter Redis	         | TCP/6379  | 									   |
| Planespotter API/APP   | www.airport-data.com          | TCP/80    | Find Aircraft Thumbnail pictures    |
| Planespotter API/APP   | public-api.adsbexchange.com   | TCP/443   | Retrieves latest Aircraft position  |
| ADSB-Sync       		 | www.airport-data.com          | TCP/443   | Retr. Acft. Airbone stat. in poll   |
| ADSB-Sync       		 | www.airport-data.com          | TCP/32030 | Retr. Acft. Airbone stat. in stream |
| ADSB-Sync       		 | Planespotter Redis            | TCP/6379  | 	

<img src="https://github.com/vmwareacecs/planespotter/blob/master/docs/planespotter-comms.png">