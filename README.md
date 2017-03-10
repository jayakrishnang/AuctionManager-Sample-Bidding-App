#AuctionManager- A sample bidding application

This is a sample bidding application built for conducting online auctions.

The application was successfully used to host the Ruby Cricket League 2017 Auction.

Have a look! Good day!

Necessary scripts to be run:
To run sync listener:
      rackup sync.ru -E production -o IPADDRESS
  eg: rackup sync.ru -E production -o 192.168.43.229

To run server:
      rails s -b IPADDRESS -p 3000 
  eg: rails s -b 172.16.147.79 -p 3000
  
Also, please modify the sync.yml file in config folder: change the IPADDRESS to your needs. 
