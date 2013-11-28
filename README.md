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

To POST soil moisture data to the database, execute this `curl` request:

curl -v -H "Content-Type: application/json" -X POST -d '{"type":"soilmoisture", "data":{"collection_point_id":1,"collection_time":"2013-03-08 08:58AM","deptha":1,"depthb":1.2,"depthc":1.9}}' 'http://localhost:3000/dc/'

Each soil moisture data bundle belongs to a `collection point`, which belongs to a `site`. You can navigate through this heirarchy from the the home page.

Each `site` has a page that displayes `collection points` and `soilmoisture` data bundles. Add `.json` to the `site` URL get request to return a JSON object representation of that site's data, i.e. `http://localhost:3000/sites/1.json`

This can be used to generate graphs and visualizations.

