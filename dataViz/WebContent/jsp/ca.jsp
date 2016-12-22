<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<meta charset="utf-8">
<head>
	<title></title>

<script src="//d3js.org/d3.v3.min.js"></script>
<script src="//d3js.org/topojson.v1.min.js"></script>

<style>
.subunit.santa.clara {
	fill: rgba(255, 201, 147, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.mateo {
	fill: rgba(255, 201, 147, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.alameda {
	fill: rgba(255, 211, 91, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.Tehama {
	fill: rgba(255, 233, 210, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.Alameda {
	fill: rgba(255, 190, 125, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.Los.Angeles {
	fill: rgba(255, 157, 60, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.San.Francisco {
	fill: rgba(255, 224, 191, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.San.Bernardino {
	fill: rgba(255, 172, 93, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.Inyo {
	fill: rgba(255, 222, 189, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.Siskiyou {
	fill: rgba(255, 216, 176, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.Solano {
	fill: rgba(255, 241, 227, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.Napa {
	fill: rgba(255, 201, 147, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.Sonoma {
	fill: rgba(255, 216, 176, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.San.Bernardino {
	fill: rgba(255, 193, 132, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.San.Diego {
	fill: rgba(255, 168, 81, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.Kern {
	fill: rgba(255, 186, 117, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.Ventura {
	fill: rgba(255, 193, 132, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.Placer {
	fill: rgba(255, 198, 140, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.Tuolumne {
	fill: rgba(255, 166, 77, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.Mendocino {
	fill: rgba(255, 240, 225, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.Monterey {
	fill: rgba(255, 185, 115, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.Mono {
	fill: rgba(255, 177, 100, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.Humboldt {
	fill: rgba(255, 193, 132, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.Fresno {
	fill: rgba(255, 216, 176, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.Lassen {
	fill: rgba(255, 192, 130, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.Shasta {
	fill: rgba(255, 192, 130, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.Sutter {
	fill: rgba(255, 192, 130, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.Yolo {
	fill: rgba(255, 192, 130, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit.Merced {
	fill: rgba(255, 181, 106, 1.0);
	stroke: white;
	stroke-linejoin: round;
}
.subunit {
	fill: rgba(200, 200, 255, 1.0);
	stroke: white;
	stroke-width: 1px;
}
.subunit:hover {
	opacity: 0.7;
	fill: lightyellow;
}
.exterior-boundary {
	fill: none;
	stroke: black;
	stroke-linejoin: round;
	stroke-width: 2px;
}
div.tooltip {
	position: absolute;
	text-align: center;
	width: 75px;
	padding: 2px;
	font: 12px sans-serif;
	color: white;
	background: black;
	border: 0px;
	border-radius: 8px;
	pointer-events: none;
}
</style>

</head>
<body>
	<h1>California Tweets Setiment Analysis</h1>
	<div id = "map"></div>

<script>
	var width = 650,
		height = 600;
	var  projection = d3.geo.mercator()
			.scale(1000 * 2)
			.center([-120, 36])
			.translate([width/2, height/2]);
	
	var path = d3.geo.path()
		.projection(projection);
	var svg = d3.select("#map").append("svg")
		.attr("width", width)
		.attr("height", height);
	
	d3.json("/BDA-Proj/tsv/ca.json", function(error, ca){
		//console.log(ca.objects.caCounties); //for navigating the data in the console
		svg.append("path")
			.datum(topojson.feature(ca, ca.objects.subunits))
			.attr("class", "land")
			.attr("d", path);
		//bind feature data to the map
		svg.selectAll(".subunit")
			  .data(topojson.feature(ca, ca.objects.subunits).features)
			.enter().append("path")
			.attr("class", function(d) { return "subunit " + d.properties.name; })
			.attr("d", path)
			.on("mouseover", function(d){ //tooltip
				div.transition()
					.duration(200)
					.style("opacity", .9);
				div.html(d.properties.fullName)
					.style("left", (d3.event.pageX) + 10 + "px")
					.style("top", (d3.event.pageY - 30) + "px"); 
			})
			.on("mouseout", function(d) { 
				div.transition()
					.duration(500)
					.style("opacity", 0.0);
			});
		//exterior border
		svg.append("path")
			.datum(topojson.mesh(ca, ca.objects.subunits, function(a, b) { return a === b;}))
			.attr("d", path)
			.attr("class", "exterior-boundary");
		//tooltop declaration
		var div = d3.select("#map").append("div")
			.attr("class", "tooltip")
			.style("opacity", 0);
		
	});

	//36.980106, -119.317593
</script>

</body>