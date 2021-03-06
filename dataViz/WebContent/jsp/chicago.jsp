<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<meta charset="utf-8">

<style>
#boroughs {
  stroke: grey;
	stroke-width: 2px;
	fill: steelblue;
}
</style>

<script src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>

<body>

<script>

var width = 960,
   height = 500;

var svg = d3.select("body").append("svg")
    .attr("width", width)
    .attr("height", height);

  d3.json("/BDA-Proj/json/chicago.json", function(error, nyb) {

  	console.log(nyb)

    var projection = d3.geo.mercator()
  					.center([-73.94, 40.70])
  					.scale(50000)
  					.translate([(width) / 2, (height)/2]);

	var path = d3.geo.path()
			.projection(projection);

	var g = svg.append("g");

	g.append("g")
		.attr("id", "boroughs")
		.selectAll(".state")
		.data(nyb.features)
		.enter().append("path")
		.attr("class", function(d){ return d.properties.name; })
		.attr("d", path);

	});

</script>
</body>
