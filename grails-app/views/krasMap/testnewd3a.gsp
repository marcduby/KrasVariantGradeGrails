<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="utf-8">
    <script src="http://d3js.org/d3.v3.js"></script>
    <style>

    body {
        font: 10px verdana;
    }
    .axis path,
    .axis line {
        fill: none;
        stroke: #333;
    }
    .line {
        fill: none;
        stroke: steelblue;
        stroke-width: 1.5px;
    }

    path {
        stroke-width: 3;
        fill: none;
    }
    line {
        stroke: black;
    }
    </style>
</head>

<body>
<div class="dude">
    dude<br/>
    ${resp}
</div>
<div class="chart" id="chart">

</div>

<script type="text/javascript">
    var data = [{
        key: "group1",
        x: [10, 20],
        y: [10, 30],
        label: ["point1", "point2"]
    }, {
        key: "group2",
        x: [5, 10, 25],
        y: [20, 25, 15],
        label: ["point3", "point4", "point5"]
    }];

    var width = 700;
    var height = 500;
    var scatterPlotMargin = {
        top: 90,
        right: 150,
        bottom: 20,
        left: 50
    };
    var color = d3.scale.category10();

    var svg = d3.select("#chart")
            .append("svg")
            .style("width", width)
            .style("height", height);

    var scatterChartContainer = svg.append("g")
            .attr('class', 'scatterCharts')
            .attr("transform", "translate(" + scatterPlotMargin.left + "," + scatterPlotMargin.top + ")");

    var scatterChartXScale = d3.scale.linear()
            .range([0, width - scatterPlotMargin.left - scatterPlotMargin.right])
            .domain([
                d3.min(data.map(function(d) {
                    return d3.min(d.x) * 0.8;
                })),
                d3.max(data.map(function(d) {
                    return d3.max(d.x) * 1.2;
                }))
            ]);

    var scatterChartYScale = d3.scale.linear()
            .range([height - scatterPlotMargin.top - scatterPlotMargin.bottom, 0])
            .domain([
                d3.min(data.map(function(d) {
                    return d3.min(d.y) * 0.8;
                })),
                d3.max(data.map(function(d) {
                    return d3.max(d.y) * 1.2;
                }))
            ]);

    var yAxis = d3.svg.axis()
            .scale(scatterChartYScale)
            .orient("left")
            .innerTickSize(-(width - scatterPlotMargin.left - scatterPlotMargin.right)) //Add some horizontal grid
            .ticks(5);

    // restructure the data to make life easier
    data = data.map(function(d) {
        return {
            key: d.key,
            points: d.label.map(function (l, i) {
                return {
                    label: l,
                    x: d.x[i],
                    y: d.y[i]
                };
            })
        };
    });

    scatterChartContainer.append("g")
            .attr("class", "scatterPlot y axis")
            .attr("transform", "translate(" + 0 + ",0)")
            //.attr("opacity",0.5)
            .style({
                'stroke': 'black',
                'fill': 'none',
                'stroke-width': '1px',
                'opacity': 0.5
            })
            .call(yAxis);

    var scatterPlotGroups = scatterChartContainer.selectAll(".scatterPlotGroup")
            .data(data)
            .enter().append("g")
            .attr("class", "scatterPlotGroup");

    var scatterPlotCircles = scatterPlotGroups.selectAll("circle")
            .data(function(d) { return d.points; })
            .enter().append("circle")
            .attr("cx", function(d) { return scatterChartXScale(d.x); })
            .attr("cy", function(d) { return scatterChartYScale(d.y); })
            .attr("r", 5)
            .attr("fill", function() { return color(d3.select(this.parentNode).datum().key); });

    var data2 = [{points: [{label: "multi", x: 15, y:27}]}, {key: "group2", points: [{label: "single", x: 10, y:29}]}];


    var scatterPlotGroupsGreen= scatterChartContainer.selectAll(".scatterPlotGroupGreen")
            .data(data2)
            .enter().append("g")
            .attr("class", "scatterPlotGroupGreen");

    var scatterPlotCirclesGreen = scatterPlotGroupsGreen.selectAll("circle")
            .data(function(d) { return d.points; })
            .enter().append("circle")
            .attr("cx", function(d) { return scatterChartXScale(d.x); })
            .attr("cy", function(d) { return scatterChartYScale(d.y); })
            .attr("r", function(d) { return (d.label == 'multi' ? 4 : 2); })
            .attr("stroke", function(d) { return (d.label == 'multi' ? "green" : "red"); })
            .attr("stroke-width", function(d) { return (d.label == 'multi' ? "3px" : "2px"); })
            .attr("fill", function(d) { return (d.label == 'multi' ? "white" : "red"); });

</script>
</body>
</html>