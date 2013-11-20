$(document).ready(function() {
    var graph_data = []
            ,deptha_data = []
            ,depthb_data = []
            ,depthc_data = [];

    getNewData();
    window.setInterval(getNewData, 10000);

    function getNewData() {
        graph_data = [];
        deptha_data = [];
        depthb_data = [];
        depthc_data = [];

        $('div.graph').html('Loading...');
        $.ajax({
            type: 'GET',
            url: "http://localhost:3000/sites/" + siteId + ".json",
            success: function(data) { setData(data); },
            contentType: 'application/json',
            dataType: 'json'
        });
    }

    function setData(data) {

        console.log(data);

        for (i=0; i < data.length; i++) {
            graph_data.push(data[i].soilMoistureData);
        }

        parse_depth_data(graph_data, deptha_data, "deptha");
        parse_depth_data(graph_data, depthb_data, "depthb");
        parse_depth_data(graph_data, depthc_data, "depthc");

        draw_soil_graph(deptha_data, depthb_data, depthc_data);

    }

    function parse_depth_data(allData, depth_data, set_depth) {
        for (i=0; i < allData.length; i++) {

            for (c=0; c < allData[i].length; c++) {
                depth_data.push(allData[i][c][set_depth]);
            }

        }
    }

    // D3 Implementation

    function draw_soil_graph(depth_data_a, depth_data_b, depth_data_c) {
        $('div.graph').html('');
        var data = depth_data_a,
            data_b = depth_data_b,
            data_c = depth_data_c,
            w = 800,
            h = 200,
            margin = 20,
            y = d3.scale.linear().domain([0, d3.max(data)+5]).range([0 + margin, h - margin]),
            x = d3.scale.linear().domain([0, data.length]).range([0 + margin, w - margin])

                console.log(data);
        
        var vis = d3.select(".graph")
            .insert("svg:svg")
            .attr("width", "100%")
            .attr("height", h);
        
        var g = vis.append("svg:g")
            .attr("transform", "translate(0,200)");

        var line = d3.svg.line()
            .x(function(d,i) { return x(i); })
            .y(function(d) { return -1 * y(d); })

        if(data.length > 0) {
            g.append("svg:path").attr("d", line(data)).attr("class", "blue");
            g.append("svg:path").attr("d", line(data_b)).attr("class", "green");
            g.append("svg:path").attr("d", line(data_c)).attr("class", "red");

            g.append("svg:line")
                .attr("x1", x(0))
                .attr("y1", -1 * y(0))
                .attr("x2", x(w))
                .attr("y2", -1 * y(0))
             
            g.append("svg:line")
                .attr("x1", x(0))
                .attr("y1", -1 * y(0))
                .attr("x2", x(0))
                .attr("y2", -1 * y(d3.max(data)))

            g.selectAll(".xLabel")
                .data(x.ticks(5))
                .enter().append("svg:text")
                .attr("class", "xLabel")
                .text(String)
                .attr("x", function(d) { return x(d) })
                .attr("y", 0)
                .attr("text-anchor", "middle")
             
            g.selectAll(".yLabel")
                .data(y.ticks(4))
                .enter().append("svg:text")
                .attr("class", "yLabel")
                .text(String)
                .attr("x", 0)
                .attr("y", function(d) { return -1 * y(d) })
                .attr("text-anchor", "right")
                .attr("dy", 4)

            g.selectAll(".xTicks")
                .data(x.ticks(5))
                .enter().append("svg:line")
                .attr("class", "xTicks")
                .attr("x1", function(d) { return x(d); })
                .attr("y1", -1 * y(0))
                .attr("x2", function(d) { return x(d); })
                .attr("y2", -1 * y(-0.3))
             
            g.selectAll(".yTicks")
                .data(y.ticks(4))
                .enter().append("svg:line")
                .attr("class", "yTicks")
                .attr("y1", function(d) { return -1 * y(d); })
                .attr("x1", x(-0.3))
                .attr("y2", function(d) { return -1 * y(d); })
                .attr("x2", x(0))
        }
        else {
            $('div.graph').html('There is no graph data at this time');
        }

    }

});


