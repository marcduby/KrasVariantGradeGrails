<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Phenotypic Annotation of KRAS Mutations</title>
    <style type="text/css" media="screen">
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
    #status {
        background-color: #eee;
        border: .2em solid #fff;
        margin: 2em 2em 1em;
        padding: 1em;
        width: 12em;
        float: left;
        -moz-box-shadow: 0px 0px 1.25em #ccc;
        -webkit-box-shadow: 0px 0px 1.25em #ccc;
        box-shadow: 0px 0px 1.25em #ccc;
        -moz-border-radius: 0.6em;
        -webkit-border-radius: 0.6em;
        border-radius: 0.6em;
    }

    .ie6 #status {
        display: inline; /* float double margin fix http://www.positioniseverything.net/explorer/doubled-margin.html */
    }

    #status ul {
        font-size: 0.9em;
        list-style-type: none;
        margin-bottom: 0.6em;
        padding: 0;
    }

    #status li {
        line-height: 1.3;
    }

    #status h1 {
        text-transform: uppercase;
        font-size: 1.1em;
        margin: 0 0 0.3em;
    }

    #page-body {
/*        margin: 2em 1em 1.25em 18em; */
/*        margin: 1em 10em 1em 10em;    */
        margin: 1em 7em 1em 7em;
    }

    h2 {
        margin-top: 1em;
        margin-bottom: 0.3em;
        font-size: 1em;
    }

    p {
        line-height: 1.5;
        margin: 0.25em 0;
    }

    #controller-list ul {
        list-style-position: inside;
    }

    #controller-list li {
        line-height: 1.3;
        list-style-position: inside;
        margin: 0.25em 0;
    }

    @media screen and (max-width: 480px) {
        #status {
            display: none;
        }

        #page-body {
            margin: 0 1em 1em;
        }

        #page-body h1 {
            margin-top: 0;
        }
    }
        div.formWrapper {
            font-size: 16px;
            padding-top: 5px;
            padding-bottom: 5px;
        }
        div.bold {
            font-weight: bold;
        }
        div.title {
            font-size: 24px;
            font-weight: bold;
        }
    </style>
    <g:render template="googleAnalytics"/>
    <g:render template="d3"/>
</head>
<body>
<a href="#page-body" class="skip"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
<div id="page-body" role="main" class="formWrapper">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <g:form name="myForm" action="proteinSearch" id="1">
                    <div class="formWrapper">
                        <div class="description">Systematic characterization of transforming potential of any missense variant of <span class="miterItalic">KRAS</span>.
                        <br/>See <a href="https://www.nature.com/ng/" target="newWindow">paper link</a> for details.</div>
                        <div class="apptitle-black description">KRAS</div>
                        <p class="bold-text">Enter Variant</p>
                        <input id="searchbox" value="${lastQuery}" name="query" class="form-control input-lg awesomebar searchbox" type="text" placeholder="Search for a protein change or variant"/>
                        <p class="text-muted small-text">
                            Examples - Protein change <a href="#" title='Numbering with respect to KRAS isoform 2B'><g:img dir="images" file="question2.png" width="17" height="17"/></a>:
                            <g:link action="proteinSearch" controller="krasMap" params="[query: 'p.G13P', prevalence: '1.0e-5']">p.G13P</g:link> or
                            <g:link action="proteinSearch" controller="krasMap" params="[query: 'p.Gly13Pro', prevalence: '1.0e-5']">p.Gly13Pro</g:link>,

                        </p>

                    <g:if test="${false}">
                        <p class="bold-text">Enter Disease Prevalence  <a href="#" title="Disease prevalence of familial partial lipodystrophy 3 (FPLD3) in the general population is 1:100,000 (default) to 1:1,000,000. In specialist clinics this can be as high as 1:5 (0.20)."><g:img dir="images" file="question2.png" width="17" height="17"/></a></p>
                        <input id="prevalencebox" name="prevalence" class="form-control input-lg awesomebar prevalencebox" type="text" placeholder="Enter disease prevalence" value="${lastPrevalence ? lastPrevalence : '1.0e-5'}"/>
                    </g:if>
                    </div>
                    <div class="formWrapper">
                        <input type="submit" name="submit">
                    </div>
                </g:form>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="formWrapper bold">
                    <g:if test="${proteinResult != null}">
                        <g:if test="${proteinResult.getVariantDisplay()}">
                            <div class="row reduced-width">
                                <div class="col-md-4">
                                    <table class="table">
                                        <thead>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td>Variant</td>
                                            <td>${proteinResult.getVariantDisplay()}</td>
                                        </tr>
                                        <g:if test="${proteinResult.isResultStopCodon()}">
                                            <tr>
                                                <td>Modified codon</td>
                                                <td>is a stop codon</td>
                                            </tr>
                                        </g:if>
                                        <tr>
                                            <td>Reference amino acid</td>
                                            <td>${proteinResult.getAminoAcidReference()}</td>
                                        </tr>
                                        <tr>
                                            <td>Mutation</td>
                                            <td>${proteinResult.getScientificAlleleCode()}</td>
                                        </tr>
                                        <tr>
                                            <td>Combined phenotype score  <a href="#" title="Also referred to as phenotype score in Giacomelli et al. 2017, quantitative measure of the ability of PPARG containing the variant to stimulate CD36 across multiple agonist conditions and doses."><g:img dir="images" file="question2.png" width="17" height="17"/></a></td>
                                            <td><g:formatNumber number="${proteinResult.getHeatAmount()}" type="number" maxFractionDigits="3" /></td>
                                        </tr>

                                        <tr>
                                            <td># of IARC somatic mutations (human tumors)  <a href="#" title="Add # IARC somatic mutations text here"><g:img dir="images" file="question2.png" width="17" height="17"/></a></td>
                                            <td>${proteinResult.getSomaticIarcMutationCount()}</td>
                                        </tr>

                                        </tbody>
                                    </table>
                                </div>
                                <div class="col-md-8">

                                </div>
                            </div>

                        </g:if>
                        <g:else>
<!--                            <div class="row reduced-width"> -->
                            <div class="row some-reduced-width">
                                <div class="col-md-11">
                                    <table class="table">
                                        <thead>
                                        </thead>
                                        <tbody>
                                        <tr class="tightrow">
                                            <td>Reference amino acid</td>
                                            <td>${proteinResult.getAminoAcidReference()}</td>
                                        </tr>

                                        <tr class="tightrow">
                                            <td>Protein change <a href="#" title="Numbering with respect to KRAS isoform 2B"><g:img dir="images" file="question2.png" width="17" height="17"/></a></td>
                                            <td>${proteinResult.getScientificAlleleCode()}</td>
                                        </tr>

                                        <tr class="tightrow">
                                            <td>Number of nucleotide substitution</td>
                                            <td>${proteinResult.getNumberNucleotideSubstitution()}</td>
                                        </tr>

                                        <tr class="tightrow">
                                            <td>Experimental function score  <a href="#" title="Z-score calculated from log2 fold change of Day 7 abundance compared to Day 0 abundance; also referred to transforming potential in Ly et al. 2018."><g:img dir="images" file="question2.png" width="17" height="17"/></a></td>
                                            <td><g:formatNumber number="${proteinResult.getHeatAmount()}" type="number" maxFractionDigits="3" /></td>
                                        </tr>

                                        <tr class="tightrow">
                                            <td># of COSMIC somatic mutations (human tumors)  <a href="#" title="Forbes et al. Nucleic Acids Res. 2017. Data release v84. Accessed April 2018. https://cancer.sanger.ac.uk/cosmic"><g:img dir="images" file="question2.png" width="17" height="17"/></a></td>
                                            <td><g:formatNumber number="${proteinResult.getNumberSomaticMutationsCosmic()}" type="number" maxFractionDigits="0" /></td>
                                        </tr>

                                        <tr class="tightrow">
                                            <td># of GENIE somatic mutations (human tumors)  <a href="#" title="AACR Project GENIE Consortium. Cancer Discov. 2017. Data release 3.0. Accessed April 2018. Gao et al. Sci Signal. 2013. http://www.cbioportal.org/genie"><g:img dir="images" file="question2.png" width="17" height="17"/></a></td>
                                            <td><g:formatNumber number="${proteinResult.getNumberSomaticMutationsGenie()}" type="number" maxFractionDigits="0" /></td>
                                        </tr>

                                        <tr class="tightrow">
                                            <td># of TCGA somatic mutations (human tumors)  <a href="#" title="TCGA Research Network. Accessed April 2018. Gao et al. Sci Signal. 2013. http://www.cbioportal.org/"><g:img dir="images" file="question2.png" width="17" height="17"/></a></td>
                                            <td><g:formatNumber number="${proteinResult.getNumberSomaticMutationsTcga()}" type="number" maxFractionDigits="0" /></td>
                                        </tr>

                                        <tr class="tightrow">
                                            <td># of ExAC germline mutations (unselected individuals)  <a href="#" title="Lek et al. Nature. 2016. Data release 1.0. Accessed April 2018. http://exac.broadinstitute.org/"><g:img dir="images" file="question2.png" width="17" height="17"/></a></td>
                                            <td><g:formatNumber number="${proteinResult.getNumbergermlineMutationsExac()}" type="number" maxFractionDigits="0" /></td>
                                        </tr>

                                        </tbody>
                                    </table>
                                </div>
                                <div class="col-md-1">

                                </div>
                            </div>
                        </g:else>
                    </g:if>

                    <g:if test="${errorMessage}">
                        ${errorMessage}
                    </g:if>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div id="lineDiv" class="lineDiv"></div>
            </div>
        </div>
    </div>
</div>

<g:if test="${proteinResult != null}">

    <script type="text/javascript">
        var data = [{
            key: "group1",
            x: [-1, 5],
            y: [-8, 10],
            label: ["point1", "point2"]
        }];

        var dataRankScale = [{
            key: "rank",
            x: [-200, 4000],
            y: [-8, 10],
            label: ["point1", "point2"]
        }];

        var width = 700; //700;
        var height = 330; //500;

        // this is for the COSMIC chart
        var scatterPlotMargin = {
            top: 20,
            right: 20,
            bottom: 50,
            left: 350
        };
        var w = width - scatterPlotMargin.left - scatterPlotMargin.right;
        var h = height - scatterPlotMargin.top - scatterPlotMargin.bottom;

        // this is for the rank chart
        var rankPlotMargin = {
            top: 20,
            right: 410,
            bottom: 50,
            left: 40
        };
        var wRank = width - rankPlotMargin.left - rankPlotMargin.right;
        var hRank = height - rankPlotMargin.top - rankPlotMargin.bottom;

        var color = d3.scale.category10();

        var svg = d3.select("#lineDiv")
                .append("svg")
                .style("width", width)
                .style("height", height).attr("width", window.innerWidth).attr("height",window.innerHeight);

        // COSMIC plot
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
                .innerTickSize(7) //Add some horizontal grid
                .ticks(5);

        var xAxis = d3.svg.axis()
                .scale(scatterChartXScale)
                .orient("bottom")
                .innerTickSize(7)
                .ticks(5);


        scatterChartContainer.append("g")
                .attr("class", "scatterPlot y axis")
                .attr("transform", "translate(" + 0 + ",0)")
                //.attr("opacity",0.5)
                .style({
                    'stroke': 'black',
                    'fill': 'none',
                    'stroke-width': '1px',
                    'opacity': 1.0
                })
                .call(yAxis);

        scatterChartContainer.append("g")
                .attr("class", "scatterPlot x axis")
                //                .attr("transform", "translate(" + 0 + ",0)")
                .attr("transform", "translate(0," + h + ")")
                //.attr("opacity",0.5)
                .style({
                    'stroke': 'black',
                    'fill': 'none',
                    'stroke-width': '1px',
                    'opacity': 1.0
                })
                .call(xAxis);

        // Rank plot
        var rankChartContainer = svg.append("g")
                .attr('class', 'scatterChartsRank')
                .attr("transform", "translate(" + rankPlotMargin.left + "," + rankPlotMargin.top + ")");

        var rankChartXScale = d3.scale.linear()
                .range([0, width - rankPlotMargin.left - rankPlotMargin.right])
                .domain([
                    d3.min(dataRankScale.map(function(d) {
                        return d3.min(d.x);
                    })),
                    d3.max(dataRankScale.map(function(d) {
                        return d3.max(d.x);
                    }))
                ]);

        var rankChartYScale = d3.scale.linear()
                .range([height - rankPlotMargin.top - rankPlotMargin.bottom, 0])
                .domain([
                    d3.min(dataRankScale.map(function(d) {
                        return d3.min(d.y);
                    })),
                    d3.max(dataRankScale.map(function(d) {
                        return d3.max(d.y);
                    }))
                ]);

        var yAxisRank = d3.svg.axis()
                .scale(rankChartYScale)
                .orient("left")
                .innerTickSize(7) //Add some horizontal grid
                .ticks(5);

        var xAxisRank = d3.svg.axis()
                .scale(rankChartXScale)
                .orient("bottom")
                .innerTickSize(7)
                .ticks(5);


        rankChartContainer.append("g")
                .attr("class", "scatterChartsRank y axis")
                .attr("transform", "translate(" + 0 + ",0)")
                //.attr("opacity",0.5)
                .style({
                    'stroke': 'black',
                    'fill': 'none',
                    'stroke-width': '1px',
                    'opacity': 1.0
                })
                .call(yAxisRank);

        rankChartContainer.append("g")
                .attr("class", "scatterChartsRank x axis")
                //                .attr("transform", "translate(" + 0 + ",0)")
                .attr("transform", "translate(0," + h + ")")
                //.attr("opacity",0.5)
                .style({
                    'stroke': 'black',
                    'fill': 'none',
                    'stroke-width': '1px',
                    'opacity': 1.0
                })
                .call(xAxisRank);

        //        var scatterPlotGroups = scatterChartContainer.selectAll(".scatterPlotGroup")
        //                .data(data)
        //                .enter().append("g")
        //                .attr("class", "scatterPlotGroup");
        //
        //        var scatterPlotCircles = scatterPlotGroups.selectAll("circle")
        //                .data(function(d) { return d.points; })
        //                .enter().append("circle")
        //                .attr("cx", function(d) { return scatterChartXScale(d.x); })
        //                .attr("cy", function(d) { return scatterChartYScale(d.y); })
        //                .attr("r", 5)
        //                .attr("fill", function() { return color(d3.select(this.parentNode).datum().key); });

        <g:if test="${resp}">
            var data2 = [<g:applyCodec encodeAs="none">${resp}</g:applyCodec>];
        </g:if>
        <g:else>
            var data2 = [{points: [{label: "Multiple", x: 17, y:22}, {label: "Single", x: 22, y:27}]}];
        </g:else>

        <g:if test="${respRank}">
            var dataRank = [<g:applyCodec encodeAs="none">${respRank}</g:applyCodec>];
        </g:if>
        <g:else>
            var dataRank = [{points: [{label: 1, x: 1500, y: 7}, {label: 1, x: 2700, y:4}]}];
        </g:else>

        // COSMIC plot
        // plot the multiple/single points
        var scatterPlotGroupsGreen= scatterChartContainer.selectAll(".scatterPlotGroupGreen")
                .data(data2)
                .enter().append("g")
                .attr("class", "scatterPlotGroupGreen");

        var scatterPlotCirclesGreen = scatterPlotGroupsGreen.selectAll("circle")
                .data(function(d) { return d.points; })
                .enter().append("circle")
                .attr("cx", function(d) { return scatterChartXScale(d.x); })
                .attr("cy", function(d) { return scatterChartYScale(d.y); })
                .attr("r", function(d) { return (d.label == 1 ? 4 : 2); })
                .attr("stroke", function(d) { return (d.label == 1 ? "green" : "blue"); })
                .attr("stroke-width", function(d) { return (d.label == 1 ? "3px" : "2px"); })
                .attr("fill", function(d) { return (d.label == 1 ? "white" : "blue"); });

        // Rank plot
        // plot the multiple/single points
        var scatterPlotGroupsGreyRank = rankChartContainer.selectAll(".scatterPlotGroupGrey")
                .data(dataRank)
                .enter().append("g")
                .attr("class", "scatterPlotGroupGrey");

        var scatterPlotCirclesGreyRank = scatterPlotGroupsGreyRank.selectAll("circle")
                .data(function(d) { return d.points; })
                .enter().append("circle")
                .attr("cx", function(d) { return rankChartXScale(d.x); })
                .attr("cy", function(d) { return rankChartYScale(d.y); })
                .attr("r", 4)
                .attr("stroke", "grey")
                .attr("stroke-width", 2)
                .attr("fill", "white");

        // START - plot the selected point
        var dataSelected = [{points: [{label: 1, x: ${proteinResult.getLogNumberSomaticMutationsCosmic()}, y: ${proteinResult.getHeatAmount()}, rank: ${proteinResult.getRank()}}]}];
        <g:if test="${proteinResult.getLogNumberSomaticMutationsCosmic() >= 0}">

            var scatterPlotGroupsRed= scatterChartContainer.selectAll(".scatterPlotGroupRed")
                    .data(dataSelected)
                    .enter().append("g")
                    .attr("class", "scatterPlotGroupRed");

            var scatterPlotCirclesRed = scatterPlotGroupsRed.selectAll("circle")
                    .data(function(d) { return d.points; })
                    .enter().append("circle")
                    .attr("cx", function(d) { return scatterChartXScale(d.x); })
                    .attr("cy", function(d) { return scatterChartYScale(d.y); })
                    .attr("r", 5)
                    .attr("stroke", "red")
                    .attr("stroke-width", "5px")
                    .attr("fill", "white");

        </g:if>

        var scatterPlotGroupsRedRank = rankChartContainer.selectAll(".scatterPlotGroupRankRed")
                .data(dataSelected)
                .enter().append("g")
                .attr("class", "scatterPlotGroupRankRed");

        var scatterPlotCirclesRedRank = scatterPlotGroupsRedRank.selectAll("circle")
                .data(function(d) { return d.points; })
                .enter().append("circle")
                .attr("cx", function(d) { return rankChartXScale(d.rank); })
                .attr("cy", function(d) { return rankChartYScale(d.y); })
                .attr("r", 5)
                .attr("stroke", "red")
                .attr("stroke-width", "5px")
                .attr("fill", "white");
        // END - plot the selected point

        var labels = svg.append("g")
                .attr("class", "labels");

        // COSMIC labels
        labels.append("text")
                .attr("transform", "translate(0," + (h + scatterPlotMargin.top) + ")")
                .attr("x", scatterPlotMargin.left + (w/3))
                .attr("style","font-size:20px;")
                .attr("dx", "-1.0em")
                .attr("dy", "2.0em")
                .text("COSMIC Incidence (log10)");

        labels.append("text")
                .attr("transform", "rotate(-90)")
                .attr("y", scatterPlotMargin.left - 40)
                .attr("x", -90)
                .attr("style","font-size:20px;")
                .attr("dy", ".71em")
                .style("text-anchor", "end")
                .text("Functional Score");

        labels.append("text")
                .attr("transform", "translate(0," + (h + scatterPlotMargin.top) + ")")
                .attr("x", scatterPlotMargin.left + (w/3))
                .attr("style","font-size:15px;")
                .attr("dy", "-3.0em")
                .style("stroke", "green")
                .text("Multiple nucleotide substitution");

        labels.append("text")
                .attr("transform", "translate(0," + (h + scatterPlotMargin.top) + ")")
                .attr("x", scatterPlotMargin.left + (w/3))
                .attr("style","font-size:15px;")
                .attr("dy", "-1.5em")
                .style("stroke", "blue")
                .text("Single nucleotide substitution");

        labels.append("text")
                .attr("transform", "translate(0," + (h + scatterPlotMargin.top) + ")")
                .attr("x", scatterPlotMargin.left + (w/3))
                .attr("style","font-size:15px;")
                .attr("dy", "-4.5em")
                .style("stroke", "red")
                .text("${proteinResult.getScientificAlleleCode()}");

        // Rank labels
        labels.append("text")
                .attr("transform", "translate(0," + (h + rankPlotMargin.top) + ")")
                .attr("x", rankPlotMargin.left + (wRank/2))
                .attr("style","font-size:20px;")
                .attr("dx", "-1.0em")
                .attr("dy", "2.0em")
                .text("Rank");

        labels.append("text")
                .attr("transform", "rotate(-90)")
                .attr("y", rankPlotMargin.left - 40)
                .attr("x", -90)
                .attr("style","font-size:20px;")
                .attr("dy", ".71em")
                .style("text-anchor", "end")
                .text("Functional Score");

        labels.append("text")
                .attr("transform", "translate(0," + (h + rankPlotMargin.top) + ")")
                .attr("x", rankPlotMargin.left + (wRank/3))
                .attr("style","font-size:15px;")
                .attr("dy", "-4.5em")
                .style("stroke", "red")
                .text("${proteinResult.getScientificAlleleCode()}");

    </script>

</g:if>

<script>
    $(function() {
        $( document ).tooltip({
            position: { my: "left+15 center", at: "right center" },
            tooltipClass: "info-tooltip"
        });

    });
</script>
</body>
</html>
