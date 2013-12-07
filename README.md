Server
======

The server which receives the data from the RaspberryPi, stores it, and presents it to the web.

Installation
-----------

To initialize:
`rake db:create`
`rake db:migrate`
`rake db:seed`

You might also want to POST some data points using the`curl` request below.

login with user@example.com/changeme

Usage
-----------

To POST node data to the database, execute this `curl` request:

curl -v -H "Content-Type: application/json" -X POST -d '{"site_id":"1","node_readings":[{"id":"1","timestamp":"2013-12-07 04:05:06","channel":"001","soil1":"1.2","soil2":"1.3","soil3":"1.4","temp":"58","voltage":"1.4"}]}' 'http://localhost:3000/dc/'


This can be used to generate graphs and visualizations.

