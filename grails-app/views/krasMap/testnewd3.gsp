<%--
  Created by IntelliJ IDEA.
  User: mduby
  Date: 6/3/18
  Time: 11:00 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="utf-8">
    <script src="http://d3js.org/d3.v3.min.js"></script>
</head>

<body>

<div class="chart">

</div>
<script type="text/javascript">
    var data = [{
        key: "group1",
        x: [10, 20],
        y: [10, 30],
        label: ["point1", "point2"]
    }, {
        key: "group2",
        x: [5, 10, 25, 15],
        y: [20, 25, 15, 27],
        label: ["point3", "point4", "point5", "point6"]
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
                    return d3.min(d.x);
                })),
                d3.max(data.map(function(d) {
                    return d3.max(d.x);
                }))
            ]);

    var scatterChartYScale = d3.scale.linear()
            .range([height - scatterPlotMargin.top - scatterPlotMargin.bottom, 0])
            .domain([
                d3.min(data.map(function(d) {
                    return d3.min(d.y);
                })),
                d3.max(data.map(function(d) {
                    return d3.max(d.y);
                }))
            ]);

    var yAxis = d3.svg.axis()
            .scale(scatterChartYScale)
            .orient("left")
            .innerTickSize(-(15)) //Add some horizontal grid
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

    var data2 = [{key: "group3", points: [{label: "point1", x: 15, y:29}]},
        {key: "group4", points: [{label: "point2", x: 10, y:27}]}];

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
            .attr("stroke", function() { return color(d3.select(this.parentNode).datum().key); })
            .attr("stroke-width", "5px")
            .attr("fill", "white");

    var scatterPlotGroupsGreen= scatterChartContainer.selectAll(".scatterPlotGroupGreen")
            .data(data2)
            .enter().append("g")
            .attr("class", "scatterPlotGroupGreen");

    var scatterPlotCirclesGreen = scatterPlotGroupsGreen.selectAll("circle")
            .data(function(d) { return d.points; })
            .enter().append("circle")
            .attr("cx", function(d) { return scatterChartXScale(d.x); })
            .attr("cy", function(d) { return scatterChartYScale(d.y); })
            .attr("r", 3)
            .attr("stroke", "green")
            .attr("stroke-width", "3px")
            .attr("fill", "white");



</script>
</body>
</html>