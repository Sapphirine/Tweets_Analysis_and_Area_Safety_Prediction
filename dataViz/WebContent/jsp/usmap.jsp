<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<meta charset="utf-8">
<title>US States Plain</title>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet">
<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css" rel="stylesheet">
<link href="/BDA-Proj/css/d3.geomap.css" rel="stylesheet">
</head>
<body>
<div class="container" id="main">
    <h1>US Tweets Sentiment Analysis Map</h1>
    <div id="map"></div>
</div>
<script src="/BDA-Proj/js/d3.v3.min.js"></script>
<script src="https://d3js.org/d3-geo-projection.v1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/topojson/2.2.0/topojson.js"></script>
<script src="/BDA-Proj/js/d3.geomap.js"></script>
<script>
var map = d3.geomap.choropleth()
    .geofile('/BDA-Proj/tsv/USA.json')
    .projection(d3.geo.albersUsa)
    .column('sentiment_score')
    .unitId('flips')
    .scale(1000)
    .legend(true);
d3.csv('/BDA-Proj/tsv/output.csv', function(error, data) {
    d3.select("#map")
        .datum(data)
        .call(map.draw, map);
});
</script>