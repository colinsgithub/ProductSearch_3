<!DOCTYPE html>
<%@page import="bean.Store"%>
<%@page import="java.util.ArrayList"%>
<html>
    <head>
        <title>Product Search</title>
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
        <meta charset="utf-8">
        <style>
            html, body, #map-canvas {
                height: 100%;
                margin: 0px;
                padding: 0px
            }

            body {
                min-width: 1200px;
            }

            .labels {
                color: black;
                font-family: "Lucida Grande", "Arial", sans-serif;
                font-size: 10px;
                font-weight: bold;
                text-align: center;
                width: 40px;
                white-space: nowrap;
            }


            #returnToMap {
                padding: 5px;
                text-align:center;
                width: 110px;
                color: white;
                font-size: 15px;
                font-family: 'Passion One', cursive;
                -webkit-transition: 0.4s;
                transition: 0.4s;
                cursor: pointer;
                visibility:hidden; 
                position: absolute;
                right: 5px;
                bottom: 5%;
                background-color: rgb(0, 0, 0);
            }

            .buttonHover {
                text-align: center;
                cursor: pointer;
                background-color: rgb(81,81,81);
                box-shadow: 0px -10px 30px -15px black inset;
            }

            .controls {
                margin-top: 16px;
                border: 1px solid transparent;
                border-radius: 2px 0 0 2px;
                box-sizing: border-box;
                -moz-box-sizing: border-box;
                height: 32px;
                outline: none;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
            }

            #pac-input {

                background-color: #fff;
                padding: 0 11px 0 13px;
                width: 400px;
                font-family: Roboto;
                font-size: 15px;
                font-weight: 300;
                text-overflow: ellipsis;
            }

            #pac-input:focus {
                border-color: #4d90fe;
                margin-left: -1px;
                padding-left: 14px;  /* Regular padding-left + 1. */
                width: 401px;
            }

            .pac-container {
                font-family: Roboto;
            }

            #type-selector {
                color: #fff;
                background-color: #4d90fe;
                padding: 5px 11px 0px 11px;
            }

            #type-selector label {
                font-family: Roboto;
                font-size: 13px;
                font-weight: 300;
            }

            #mainContent {
                border-left: 1px solid #f7f7f7;
                box-shadow: 0 2px 60px rgba(0, 0, 0, 0.3);
                position: absolute; 
                width: 40%; 
                height: 100%;
                top: 0px; 
                right: -50%; 
                background:#cbcbcb url(image/bg.png);
                z-index: 3;
                overflow-y:auto;
                padding-bottom:15px;
            }

            .storeBox {
                height: 50px;
                width: 100%;
                background: -webkit-linear-gradient(top, rgba(200,200,200,1) 0%,rgba(191,191,191,1) 100%);
            }

            #rightArrow {
                -webkit-filter: blur(1px); /* Chrome, Opera */
                -moz-filter: blur(1px);
                -ms-filter: blur(1px);    
                filter: blur(1px);
            }

            #rightArrow:hover {
                -webkit-filter: blur(0px); /* Chrome, Opera */
                -moz-filter: blur(0px);
                -ms-filter: blur(0px);    
                filter: blur(0px);
            }

            .ui-dialog .ui-state-error { padding: .3em; }
            .validateTips { border: 1px solid transparent; padding: 0.3em; }
        </style>
        <style>
            .sort {
                padding: 5px;
                text-align:center;
                width: 110px;
                color: white;
                font-size: 15px;
                font-family: 'Passion One', cursive;
                -webkit-transition: 0.4s;
                transition: 0.4s;
                cursor: pointer;
                background-color: rgb(0, 0, 0);
                display: inline-block;
            }

            .sort:hover {
                background-color: rgb(81, 81, 81);
            }

            #Grid .mix{
                opacity: 0;
                display: none;
                box-shadow: 0 1px 1px #dcdcdc;
                margin-bottom:10px;
                padding: 0px 80px 0px 40px;  
            }

            .pace {
                -webkit-pointer-events: none;
                pointer-events: none;
                -webkit-user-select: none;
                -moz-user-select: none;
                user-select: none;
            }

            .pace-inactive {
                display: none;
            }

            .pace .pace-progress {
                background: #29d;
                position: fixed;
                z-index: 2000;
                top: 0;
                left: 0;
                height: 2px;

                -webkit-transition: width 1s;
                -moz-transition: width 1s;
                -o-transition: width 1s;
                transition: width 1s;
            }

            .pace .pace-progress-inner {
                display: block;
                position: absolute;
                right: 0px;
                width: 100px;
                height: 100%;
                box-shadow: 0 0 10px #29d, 0 0 5px #29d;
                opacity: 1.0;
                -webkit-transform: rotate(3deg) translate(0px, -4px);
                -moz-transform: rotate(3deg) translate(0px, -4px);
                -ms-transform: rotate(3deg) translate(0px, -4px);
                -o-transform: rotate(3deg) translate(0px, -4px);
                transform: rotate(3deg) translate(0px, -4px);
            }

            .pace .pace-activity {
                display: block;
                position: fixed;
                z-index: 2000;
                top: 30px;
                right: 15px;
                width: 14px;
                height: 14px;
                border: solid 2px transparent;
                border-top-color: #29d;
                border-left-color: #29d;
                border-radius: 10px;
                -webkit-animation: pace-spinner 400ms linear infinite;
                -moz-animation: pace-spinner 400ms linear infinite;
                -ms-animation: pace-spinner 400ms linear infinite;
                -o-animation: pace-spinner 400ms linear infinite;
                animation: pace-spinner 400ms linear infinite;
            }

            @-webkit-keyframes pace-spinner {
                0% { -webkit-transform: rotate(0deg); transform: rotate(0deg); }
            100% { -webkit-transform: rotate(360deg); transform: rotate(360deg); }
            }
            @-moz-keyframes pace-spinner {
                0% { -moz-transform: rotate(0deg); transform: rotate(0deg); }
            100% { -moz-transform: rotate(360deg); transform: rotate(360deg); }
            }
            @-o-keyframes pace-spinner {
                0% { -o-transform: rotate(0deg); transform: rotate(0deg); }
            100% { -o-transform: rotate(360deg); transform: rotate(360deg); }
            }
            @-ms-keyframes pace-spinner {
                0% { -ms-transform: rotate(0deg); transform: rotate(0deg); }
            100% { -ms-transform: rotate(360deg); transform: rotate(360deg); }
            }
            @keyframes pace-spinner {
                0% { transform: rotate(0deg); transform: rotate(0deg); }
            100% { transform: rotate(360deg); transform: rotate(360deg); }
            }
        </style>


        <script src="js/pace.min.js"></script>
        <link href='http://fonts.googleapis.com/css?family=Passion+One' rel='stylesheet' type='text/css'>
        
        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
        

        <script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyBQTZl_t-QrF8ExPfToPAjeclIf1DUZ2jc&sensor=true"></script>
        
        <script src="http://maps.google.com/maps/api/js?sensor=false&v=3&libraries=geometry"></script>

        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places"></script>

        <script src="http://google-maps-utility-library-v3.googlecode.com/svn/tags/markerwithlabel/1.0.1/src/markerwithlabel.js" type="text/javascript"></script>



        <%--source from JQuery UI--%>
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

        <script src="js/jquery.mixitup.min.js"></script>

        <script>
            //init slider bar
            $(function() {
                $("#slider").slider({
                    value: 500,
                    min: 0,
                    max: 1200,
                    step: 1,
                    slide: function(event, ui) {
                        cityCircle.setRadius(ui.value);
                    },
                    stop: function(event, ui) {
                        $("#distance").val(ui.value);
                        map.setCenter(cityCircle.getCenter());
                        lopStore();
                        changeZoom();
                    }
                });
                $("#distance").val($("#slider").slider("value"));
            });
            //input slider bar's value
            $(document).ready(function() {
                $('#returnToMap').hover(
                        function(event) {
                            $(event.target).css('background-color', 'rgb(81, 81, 81)');
                        }, function(event) {
                    $(event.target).css('background-color', 'rgb(0, 0, 0)');
                });
                $("#distance").change(function() {
                    $("#slider").slider({
                        value: $("#distance").val()
                    });
                    cityCircle.setRadius(parseInt($("#distance").val()));
                    map.setCenter(cityCircle.getCenter());
                    lopStore();
                    changeZoom();
                });
            });</script>


        <script>
            var rendererOptions = {
                draggable: true
            };
            var directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);
            var directionsService = new google.maps.DirectionsService();
            var map;

            function initialize() {
                if (navigator.geolocation) {

                    var mapOptions = {
                        zoom: 16,
                        disableDefaultUI: true,
                        panControl: true,
                        streetViewControl: true
                    };
                    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

                    geoLocation();
                } else {
                    // Browser doesn't support Geolocation
                    handleNoGeolocation(false);
                }

                searchBoxDefault();
                //markers's meaning
                //markerList();
                //
                //
                //directionsDisplay.setMap(map);
                //directionsDisplay.setPanel(document.getElementById('directionsPanel'));
                //google.maps.event.addListener(directionsDisplay, 'directions_changed', function() {
                //  computeTotalDistance(directionsDisplay.getDirections());
                //});
                //calcRoute();

                //detect the event of zoom level changed
                google.maps.event.addListener(map, 'zoom_changed', zoomChanged);
            }

            function lopStore() {
                deleteOverlays(); //remove previous markers
                /*
                 $('#mainContent #Grid').remove(); //removre stores list
                 $('#mainContent #sortList').remove();
                 $('#mainContent').append(
                 '<div id="sortList" style=" margin: 10px;">' +
                 '<table><tr>' +
                 '<td><div class="sort" style="visibility:visible;position:absolute;" data-sort="data-name" data-order="desc">Name Desc</div>' +
                 '<div class="sort" style="visibility:hidden;" data-sort="data-name" data-order="asc">Name Asc</div></td>' +
                 '<td><div class="sort" style="visibility:visible;position:absolute;" data-sort="data-rank" data-order="desc">Rank Desc</div>' +
                 '<div class="sort" style="visibility:hidden;" data-sort="data-rank" data-order="asc">Rank Asc</div></td>' +
                 '<td><div class="sort" style="visibility:visible;position:absolute;" data-sort="data-distance" data-order="desc">Distance Desc</div>' +
                 '<div class="sort" style="visibility:hidden;" data-sort="data-distance" data-order="asc">Distance Asc</div><td>' +
                 //'<td><div class="sort" data-sort="default" data-order="asc">Default</div></td>' +
                 '</tr><table></div>');
                 $('#mainContent').append("<ul style='padding-left: 0px;' id='Grid'></ul>");
                 $('.sort').click(function(event) {
                 $(event.target).siblings('div').css('visibility', 'visible');
                 $(event.target).css('visibility', 'hidden');
                 });
                 */

            <%
                String lat = "";
                String lng = "";
                String storeName = "";
                String storeId = "";
                ArrayList<Store> stores = null;
                int size = 0;

                if (request.getAttribute("stores") != null) {
                    stores = (ArrayList<Store>) request.getAttribute("stores");
                    size = stores.size();

                    for (int x = 0; x < 4; x++) {
                        lat = "" + stores.get(x).getLatitude();
                        lng = "" + stores.get(x).getLongitude();
                        storeName = stores.get(x).getStoreName();

                        storeId = "" + stores.get(x).getStoreID();
                        //out.println("varstoreName = " + stores.get(x).getStoreName());
                        out.println("var latLngB = new google.maps.LatLng('" + lat + "', '" + lng + "', 10);");
                        out.println("storeName = \"" + storeName + "\";");
                        out.println("storeId = \"" + storeId + "\";");
                        out.println("storeRank = '" + stores.get(x).getRank() + "'");
                        out.println("storePhoneNumber = '" + stores.get(x).getPhoneNumber() + "'");
                        out.println("storeAddress = '" + stores.get(x).getAddress() + "'");
                        //out.println("verfiyRange(radius, latLngWithInRangeArray, latLngB, storeName, storeId);");
                        out.println("dropMarker(latLngB);");

                    }
                    out.println("$('#Grid').mixitup();");
                }
            %>
            }


            var markersArray = [];
            function dropMarker(latLngB) {

                if (markerFilterList[idenClassOfStore(storeRank)] === null) {
                    return;
                }
                //filter marker

                var pinColor = colorOfMarker(storeRank);
                var pinImage = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|" + pinColor,
                        new google.maps.Size(21, 34),
                        new google.maps.Point(0, 0),
                        new google.maps.Point(10, 34));
                //distanceWithMarker1 = google.maps.geometry.spherical.computeDistanceBetween(marker1.getPosition(), latLngB);

                var distance = google.maps.geometry.spherical.computeDistanceBetween(map.getCenter(), latLngB);
                //if (distance < cityCircle.getRadius()) {
                var marker = new MarkerWithLabel({
                    map: map,
                    position: latLngB,
                    content: 'Store',
                    name: storeName,
                    distance: parseInt(),
                    cover: "storeImg/logo.jpg",
                    rank: storeRank,
                    icon: pinImage,
                    labelContent: "1",
                    labelAnchor: new google.maps.Point(20, 30),
                    labelClass: "labels", // the CSS class for the label
                    labelStyle: {opacity: 1}
                });

                markersArray.push(marker);
                /*
                 google.maps.event.addListener(marker, 'click', function() {
                 //alert('Marker Click');
                 cityCircle.setCenter(marker.getPosition());
                 //map.panTo(marker.getPosition());
                 map.setZoom(map.getZoom() + 1);
                 
                 });
                 
                 var markerRecord = true;
                 if (markersArray.length !== 0) {
                 for (i in markersArray) {
                 
                 var distanceBetStores = google.maps.geometry.spherical.computeDistanceBetween(markersArray[i].getPosition(), marker.getPosition());
                 if (distanceBetStores < (cityCircle.getRadius() * 0.15)) {
                 markersArray[i].labelContent = parseInt(markersArray[i].labelContent) + 1;
                 markersArray[i].setIcon(new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|" + "ffffff",
                 new google.maps.Size(21, 34),
                 new google.maps.Point(0, 0),
                 new google.maps.Point(10, 34)));
                 //Change the overlayed marker to another color
                 markersArray[i][0].push(marker);
                 //window.console.log(markersArray[i]);
                 marker.setMap(null);
                 markerRecord = false;
                 var infoList = "<div style='height:165px;overflow-x:auto'><table style='width:250px;margin:7px;'>";
                 for (x in markersArray[i][0]) {
                 infoList +=
                 "<tr>" +
                 "<td rowspan='3'><img style='width:50px;border-radius: 10px;' src='" + markersArray[i][0][x].cover + "'/></td>" +
                 "<td style='font-size:20px;height:20px;'>" + markersArray[i][0][x].name + "</td>" +
                 "</tr>" +
                 "<tr>" +
                 "<td style='display: flex;'><img style='height:25px;' src='icon/compasses.png'/><div style='height:25px;margin-left:10px;'>" + markersArray[i][0][x].distance + "m<div></td>" +
                 "</tr>" +
                 "<tr><td><div class='rank'><div id='score' style='cursor:pointer;width:100px;'>";
                 var displayRank = parseInt(parseInt(markersArray[i][0][x].rank) / 100 * 5);
                 var grade = ["Bad", "Poor", "Regular", "Good", "Gorgeous"];
                 for (var x = 0; x < displayRank; x++) {
                 infoList += "<img style='width:20px;' src='lib/img/star-on.png' alt='1' title='" + grade[x] + "'>";
                 }
                 for (var x = displayRank; x < 5; x++) {
                 infoList += "<img style='width:20px;' src='lib/img/star-off.png' alt='1' title='" + grade[x] + "'>";
                 }
                 
                 infoList += "</div></td></tr>";
                 }
                 infoList += "</table></div>";
                 addListOfInfoWindow(markersArray[i], infoList);
                 break;
                 }
                 
                 }
                 }
                 
                 
                 if (markerRecord) {
                 marker[0] = []; //marker creates a list to record others markers which is overlayed 
                 marker[0].push(marker); //a list should incude the main marker;
                 markersArray.push(marker);
                 
                 var infoString =
                 "<table id='storeInfoWindwo' style='width:330px;margin:10px;'>" +
                 "<tr>" +
                 "<td rowspan='7'><img  style = 'margin-right: 15px;' src='storeImg/logo.jpg' width='130px' height='130px'/></td>" +
                 "<td style='font-size:30px;'>" + storeName + "</td>" +
                 "</tr>" +
                 "<tr><td><div class='rank'><div id='score' style='cursor:pointer;width:100px;'>";
                 var displayRank = parseInt(parseInt(marker.rank) / 100 * 5);
                 var grade = ["bad", "poor", "regular", "good", "gorgeous"];
                 for (var x = 0; x < displayRank; x++) {
                 infoString += "<img style='width:20px;' src='lib/img/star-on.png' alt='1' title='" + grade[x] + "'>";
                 }
                 for (var x = displayRank; x < 5; x++) {
                 infoString += "<img style='width:20px;' src='lib/img/star-off.png' alt='1' title='" + grade[x] + "'>";
                 }
                 
                 infoString += "<tr><td style='display: flex;'><img style='height:25px;' src='icon/compasses.png'/><div style='margin: auto 0px auto 10px;'>" + parseInt(distanceWithMarker1) + "m</div></td></tr>";
                 infoString += "</div></td></tr>" +
                 "<tr><td><button id='enterStore' storeId='" + storeId + "' onclick='directEnterStore(this);'>Enter Store</button></td></tr>" +
                 "<tr><td><button onclick='sizeCenterPane();'>Stores List</button></td></tr>" +
                 //"<tr><td><a href=\"javascript:calcRoute(this);" + "\" x='" + "happy" + "'>Direct</a></td></tr>" +
                 "<tr><td><button id='comment' storeId='" + storeId + "' onclick='comment(this);'>Comment</button></td></tr>" +
                 "</table>";
                 infoString += "<img style='width:25px;' src='icon/follow.png' onclick='addToFollowList(this);'>";
                 addInfoWindow(marker, infoString);
                 }
                 
                 //all stores with radius
                 createListOfStores(parseInt(distance));
                 */


                //    }



            }

            function addToFollowList(obj) {
                alert(obj);
            }

            function directEnterStore(obj) {
                //directly enter store
                sizeCenterPane();
                //viewMoreDetail(obj);
            }

            function colorOfMarker(x) {
                if (parseInt(parseInt(x) / 100 * 5) === 5)
                    return markerColorList[1];
                else if (parseInt(parseInt(x) / 100 * 5) === 4)
                    return markerColorList[2];
                else if (parseInt(parseInt(x) / 100 * 5) === 3)
                    return markerColorList[3];
                else
                    return markerColorList[3];
            }

            function idenClassOfStore(x) {
                if (parseInt(parseInt(x) / 100 * 5) === 5)
                    return 0;
                else if (parseInt(parseInt(x) / 100 * 5) === 4)
                    return 1;
                else if (parseInt(parseInt(x) / 100 * 5) === 3)
                    return 2;
                else
                    return 2;
            }

            function showRightArrow(obj) {
                var x = $(obj).find('#rightArrow');
                if ($(obj).find('#rightArrow').is(':hidden'))
                    x.show();
                else
                    x.hide();
            }


            function createListOfStores(distance) {
                $('#mainContent #Grid').append(
                        "<li onmouseout='showRightArrow(this);' onmouseover='showRightArrow(this);' class='mix' id='rowStore' data-name='" + storeName + "' data-rank='2' data-distance='" + parseInt(distanceWithMarker1) + "'>" +
                        "<div style='display: inline;'>" +
                        "<table>" +
                        "<tr><td></td><td style='font-size:34px;font-family: Roboto;'>" + storeName + "</td>" +
                        "<td rowspan='5' width='32px;'><img onclick='viewMoreDetail(this);' id='rightArrow' storeId='" + storeId + "' style='display:none;' src='image/rightArrow.png'><td></tr>" +
                        "<tr><td rowspan='4'><img style='width:90px;margin-right: 10px;' src='storeImg/logo.jpg'/></td>" +
                        "<td style='font-size:17px;font-family: Roboto;display: flex;'><img style='height:25px;' src='icon/compasses.png'/><div style='height:25px;margin-left:10px;'>" + parseInt(distanceWithMarker1) + "m</div></td></tr>" +
                        "<tr><td style='font-size:17px;font-family: Roboto;display: flex;'><img style='margin-top: auto;height: 25px;margin-bottom: auto;' src='icon/location.png'/><div style='width:70%;margin-left:10px;'>" + storeAddress + "</div></td></tr>" +
                        "<tr><td style='font-size:17px;font-family: Roboto;display: flex;'><img style='height:25px;' src='icon/contact.png'/><div style='height:25px;margin-left:10px;'>" + storePhoneNumber + "</div></td></tr>" +
                        "</table>" +
                        "</div>" +
                        "<div style='text-align: right;'><button storeId='" + storeId + "' onclick='viewMoreDetail(this);'>More...</button></div>" +
                        "</li >");
            }

            var infoWindowList = []; //for each time only open a info window
            function addInfoWindow(marker, message) {
                var infoWindow = new google.maps.InfoWindow({
                    content: message
                });
                infoWindowList.push(infoWindow);
                google.maps.event.addListener(marker, 'mouseover', function() {
                    closeAllInfoWindow();
                    infoWindow.open(map, marker);
                });
                /*
                 google.maps.event.addListener(marker, 'mouseout', function() {
                 infowindow.close();
                 });
                 */
                return infoWindow;
            }

            function addListOfInfoWindow(marker, message) {
                var infoWindow = new google.maps.InfoWindow({
                    content: message
                });
                infoWindowList.push(infoWindow);
                google.maps.event.addListener(marker, 'mouseover', function() {
                    closeAllInfoWindow();
                    infoWindow.open(map, marker);
                });
                /*
                 google.maps.event.addListener(marker, 'mouseout', function() {
                 infowindow.close();
                 });
                 */
                return infoWindow;
            }

            function closeAllInfoWindow() {
                for (i in infoWindowList) {
                    infoWindowList[i].close();
                }
            }

            markerFilterList = ["Gorgeous", "Good", "Regular"];
            function markerFilter(obj) {
                if (obj.checked === false) {
                    for (var i in markerFilterList) {
                        if (markerFilterList[i] === $(obj).val()) {
                            markerFilterList[i] = null;
                            //set null to filter the result
                        }
                    }
                } else {
                    if ($(obj).val() === "Gorgeous") {
                        markerFilterList[0] = "Gorgeous";
                    }
                    else if ($(obj).val() === "Good") {
                        markerFilterList[1] = "Good";
                    }
                    else if ($(obj).val() === "Regular") {
                        markerFilterList[2] = "Regular";
                    }
                }
                lopStore();
                //alert(markerFilterList[0]);

            }

            markerColorList = ["marker/centre.png", "fa220f", "e1ff00", "ff9100"];
            function markerList() {
                //the list of marker
                map.controls[google.maps.ControlPosition.RIGHT_BOTTOM].push(document.getElementById('legend'));
                var legend = document.getElementById('legend');
                var path = "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=|";
                var value = ["Current", "Gorgeous", "Good", "Regular"];
                for (var i = 0; i < markerColorList.length; i++) {
                    var div = document.createElement('div');
                    div.style.display = 'table';
                    if (i === 0) {
                        //div.innerHTML = '<input type="checkbox" checked="checked" id="markerFilter" onchange="markerFilter(this);" name="markerFilter" value="' + value[i] + '" style="height:40px;"/>';
                        div.innerHTML += '<img src="' + markerColorList[i] + '" height="50px" width="50"/>' + '<div style="display: table-cell;vertical-align: middle;">' + value[i] + '</div>';
                    } else {
                        div.innerHTML = '<input type="checkbox" checked="checked" id="markerFilter" onchange="markerFilter(this);" name="markerFilter" value="' + value[i] + '" style="height:40px;width:20px;"/>';
                        div.innerHTML += '<img src="' + path + markerColorList[i] + '" height="40px" width="25"/>' + '<div style="display: table-cell;vertical-align: middle;">' + value[i] + '</div>';
                    }
                    legend.appendChild(div);
                }
            }

            changeZoomBySlide = false;
            //identify zoom changed by event or slide
            function changeZoom() {
                var z = 75;
                for (y = 0; y < 20; y++) {
                    if (z * Math.pow(2, y) >= parseInt($("#distance").val())) {
                        changeZoomBySlide = true;
                        map.setZoom(19 - y);
                        break;
                    }
                }
            }

            function zoomChanged() {
                if (changeZoomBySlide) {
                    changeZoomBySlide = false;
                    return;
                }
                var zoom_level = map.getZoom();
                /*if (map.getZoom() < 10) {
                 
                 zoom_level = 10;
                 map.setZoom(10);
                 }
                 */

                var z = 75;
                var nRadius = z * Math.pow(2, 19 - zoom_level);
                cityCircle.setRadius(nRadius);
                $("#slider").slider({
                    value: nRadius
                });
                $("#distance").val(nRadius);
                //map.panTo(marker1.getPosition());
                map.panTo(cityCircle.getCenter());
                lopStore();
            }

            function geoLocation() {
                navigator.geolocation.getCurrentPosition(function(position) {
                    var pos = new google.maps.LatLng(position.coords.latitude,
                            position.coords.longitude);

                    map.setCenter(pos);
                    setCircle(500, pos);
                    /*
                     marker1 = new MarkerWithLabel({
                     position: pos,
                     draggable: true,
                     raiseOnDrag: true,
                     map: map,
                     icon: {
                     size: new google.maps.Size(55, 55),
                     scaledSize: new google.maps.Size(55, 55),
                     url: "marker/centre.png"
                     }
                     });
                     var iw1 = new google.maps.InfoWindow({
                     content: "Home For Sale"
                     });
                     google.maps.event.addListener(marker1, "click", function(e) {
                     //iw1.open(map, this);
                     });
                     google.maps.event.addListener(marker1, "dragend", function(e) {
                     cityCircle.setCenter(marker1.getPosition());
                     map.panTo(marker1.getPosition());
                     map.setCenter(marker1.getPosition());
                     lopStore();
                     });
                     */
                    lopStore();
                }, function() {
                    handleNoGeolocation(true);
                });
            }

            function setCircle(radius, pos) {
                var populationOptions = {
                    strokeColor: '#FF0000',
                    strokeOpacity: 0.8,
                    strokeWeight: 2,
                    fillColor: '#FF0000',
                    fillOpacity: 0.20,
                    map: map,
                    center: pos,
                    radius: radius,
                    editable: true
                            //Circle can be edited
                };
                // Add the circle for this city to the map.
                cityCircle = new google.maps.Circle(populationOptions);

                google.maps.event.addListener(cityCircle, "radius_changed", function(e) {
                    //alert(cityCircle.getRadius());
                    //alert();

                    $("#slider").slider({
                        value: cityCircle.getRadius()
                    });
                    $("#distance").val(parseInt(cityCircle.getRadius()));

                    lopStore();
                    changeZoom();

                });

                google.maps.event.addListener(cityCircle, "center_changed", function() {
                    //cityCircle.setCenter(marker1.getPosition());
                    map.panTo(cityCircle.getCenter());
                    map.setCenter(cityCircle.getCenter());
                    lopStore();
                });
            }

            function handleNoGeolocation(errorFlag) {
                if (errorFlag) {
                    var content = 'Error: The Geolocation service failed.';
                } else {
                    var content = 'Error: Your browser doesn\'t support geolocation.';
                }

                var options = {
                    map: map,
                    position: new google.maps.LatLng(60, 105),
                    content: content
                };
                var infowindow = new google.maps.InfoWindow(options);
                map.setCenter(options.position);
            }

            function sizeCenterPane() {
                $('#Grid').mixitup();

                $('#mainContent').animate({right: '5px'});
                $('#map-canvas').animate({left: '-20%'});
                //$('#distanceBar').animate({right: '45%'});
                $('#listsStores').attr('src', 'icon/arrow-right.png').attr('onclick', 'sizeLeftPane();');
            }

            function sizeLeftPane() {
                //$('#distanceBar').animate({top: '23px'});
                $('#mainContent').animate({right: '-50%'});
                $('#map-canvas').animate({left: '0%'});
                //$('#distanceBar').animate({right: '5%'});
                $('#listsStores').attr('src', 'icon/arrow-left.png').attr('onclick', 'sizeCenterPane();');
            }

            function clearOverlays() {
                if (markersArray) {
                    for (i in markersArray) {
                        markersArray[i].setMap(null);
                    }
                }
            }

            // Shows any overlays currently in the array
            function showOverlays() {
                if (markersArray) {
                    for (i in markersArray) {
                        markersArray[i].setMap(map);
                    }
                }
            }

            // Deletes all markers in the array by removing references to them
            function deleteOverlays() {
                if (markersArray) {
                    for (i in markersArray) {
                        markersArray[i].setMap(null);
                    }
                    markersArray.length = 0;
                }
            }

            function searchBoxDefault() {
                var input = /** @type {HTMLInputElement} */(
                        document.getElementById('pac-input'));
                var types = document.getElementById('type-selector');
                map.controls[google.maps.ControlPosition.TOP_CENTER].push(input);
                map.controls[google.maps.ControlPosition.TOP_CENTER].push(types);
                var autocomplete = new google.maps.places.Autocomplete(input);
                autocomplete.bindTo('bounds', map);
                var infowindow = new google.maps.InfoWindow();
                var markerPlace = new google.maps.Marker({
                    map: map
                });
                google.maps.event.addListener(autocomplete, 'place_changed', function() {
                    infowindow.close();
                    markerPlace.setVisible(false);
                    var place = autocomplete.getPlace();
                    if (!place.geometry) {
                        return;
                    }

                    // If the place has a geometry, then present it on a map.
                    if (place.geometry.viewport) {
                        map.fitBounds(place.geometry.viewport);
                    } else {
                        map.setCenter(place.geometry.location);
                        map.setZoom(17); // Why 17? Because it looks good.
                    }
                    markerPlace.setIcon(/** @type {google.maps.Icon} */({
                        url: place.icon,
                        size: new google.maps.Size(71, 71),
                        origin: new google.maps.Point(0, 0),
                        anchor: new google.maps.Point(17, 34),
                        scaledSize: new google.maps.Size(35, 35)
                    }));
                    markerPlace.setPosition(place.geometry.location);
                    markerPlace.setVisible(true);
                    var address = '';
                    if (place.address_components) {
                        address = [
                            (place.address_components[0] && place.address_components[0].short_name || ''),
                            (place.address_components[1] && place.address_components[1].short_name || ''),
                            (place.address_components[2] && place.address_components[2].short_name || '')
                        ].join(' ');
                    }

                    infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
                    infowindow.open(map, markerPlace);
                });
                // Sets a listener on a radio button to change the filter type on Places
                // Autocomplete.
                function setupClickListener(id, types) {
                    var radioButton = document.getElementById(id);
                    google.maps.event.addDomListener(radioButton, 'click', function() {
                        autocomplete.setTypes(types);
                    });
                }

                setupClickListener('changetype-all', []);
                setupClickListener('changetype-establishment', ['establishment']);
                setupClickListener('changetype-geocode', ['geocode']);
            }

            function calcRoute(object) {
                //var origin = marker1.getPosition();
                /*var destination = marker1.getPosition();
                 var request = {
                 origin: origin,
                 destination: destination,
                 //waypoints: [{location: 'Bourke, NSW'}, {location: 'Broken Hill, NSW'}],
                 travelMode: google.maps.TravelMode.DRIVING
                 };
                 directionsService.route(request, function(response, status) {
                 if (status == google.maps.DirectionsStatus.OK) {
                 directionsDisplay.setDirections(response);
                 }
                 });
                 */
            }

            function computeTotalDistance(result) {
                var total = 0;
                var myroute = result.routes[0];
                for (var i = 0; i < myroute.legs.length; i++) {
                    total += myroute.legs[i].distance.value;
                }
                total = total / 1000.0;
                document.getElementById('total').innerHTML = total + ' km';
            }

            function viewPersonalInfo() {
            }

            google.maps.event.addDomListener(window, 'load', initialize);</script>


    </head>


    <body style=" overflow-x: hidden;overflow-y: hidden; ">


        <input id="pac-input" class="controls" type="text" style=" left: 15px;" placeholder="Enter a Product/Location">

        <div id="type-selector" class="controls">
            <input type="radio" name="type" id="changetype-all" checked="checked">
            <label for="changetype-all">All</label>

            <input type="radio" name="type" id="changetype-establishment">
            <label for="changetype-establishment">Product</label>

            <input type="radio" name="type" id="changetype-geocode">
            <label for="changetype-geocode">Location</label>
        </div>

        <div id="map-canvas"></div>
        <div id="directionsPanel" style="float:right;width:30%;height:100%">
            <p>Total Distance: <span id="total"></span></p>
        </div>

        <div id="distanceBar" style="display: inline-flex; position: absolute; z-index: 2;right: 45px;top: 23px;">
            <div id="slider" style="width: 150px;margin: auto 0 auto 0;"></div>
            <input type="text" placeholder="Distance" id="distance" style="border:0; color:#f6931f; font-weight:bold; margin-left: 15px;width: 50px;"/>
            <div style="border:0; color:#f6931f;">m</div>
        </div>
        <div id="legend" style="background: white;padding: 15px"></div>
        <div id="menu" style="text-align: right; position: absolute;right: 10px; bottom:35%; z-index: 4;">
            <div><img id="personalInfo" src="icon/profle.png" style=" height: 45px; padding: 5px 0px 5px 0px;" /></div>
            <div><img id="favList" src="icon/follow.png" style=" height: 45px;padding: 5px 0px 5px 0px;"/></div>
            <div><img id="chat" src="icon/chat.png" style=" height: 45px;padding: 5px 0px 5px 0px"/></div>
            <div id="uiDirect"><img id="listsStores" src="icon/arrow-left.png" style=" height: 45px; top: 50%;padding: 5px 0px 5px 0px;" onclick="sizeCenterPane();"/></div>
            <div><img id="zoomin" src="icon/zoomin.png" style=" height: 45px;padding: 5px 0px 5px 0px"/></div>
            <div><img id="zoomout" src="icon/zoomout.png" style=" height: 45px;padding: 5px 0px 5px 0px"/></div>
        </div>
        <script>
            $('#menu img').mouseenter(
                    function(event, ui) {
                        $(event.target).animate({
                            height: '60px'
                        }, 100);
                    }).mouseleave(
                    function(event, ui) {
                        $(event.target).animate({
                            height: '45px'
                        }, 100);
                    });

            /*
             
             $("#personalInfo").click(function() {
             $.ajax({
             url: 'HandleUser?action=getInfo',
             type: 'POST',
             success: function(login) {
             if (login === "false") {
             $(function() {
             var userId = $("#userId"),
             password = $("#password"),
             allFields = $([]).add(userId).add(password),
             tips = $(".validateTips");
             
             
             $("#dialog-form").dialog({
             autoOpen: false,
             height: 300,
             width: 380,
             modal: true,
             buttons: {
             "Login": function() {
             var bValid = true;
             allFields.removeClass("ui-state-error");
             
             if (bValid) {
             $.ajax({
             url: 'HandleUser?action=login&userId=' + userId.val() + '&password=' + password.val(),
             type: 'POST',
             success: function(response) {
             var isLogin = Boolean(response);
             if (isLogin) {
             $(this).dialog("close");
             $("#dialog-personalInfo").dialog();
             } else {
             $(".validateTips").html("ID or Password is not correct.");
             }
             }
             });
             
             }
             },
             Cancel: function() {
             $(this).dialog("close");
             $(".validateTips").html("");
             }
             },
             close: function() {
             allFields.val("").removeClass("ui-state-error");
             }
             });
             });
             
             $("#dialog-form").dialog("open");
             $("#dialog-form").parent().position({
             of: $("#personalInfo"),
             my: "right" + " " + "top",
             at: "left" + " " + "center",
             collision: "fit" + " " + "fit"
             });
             
             } else {
             window.console.log(login);
             }
             },
             fail: function() {
             alert('error');
             }
             });
             
             
             
             });
             */


        </script>

        <div id="mainContent">

            <div id="storeBox" class="storeBox"></div>


            <div id="returnToMap" class="button">Return To Map</div>
        </div>
        <script>
            //select a store in stores list
            function viewMoreDetail(obj) {
                $('#mainContent').scrollTop(0);
                $('#storeBox').animate({height: '100%'});
                $('#specificStore').animate({right: '0%'});
                $('#mainContent').animate({right: '70%'});
                $('#returnToMap').css({visibility: 'visible'});
                window.console.log($(obj).attr('storeId'));
                $.ajax({
                    url: 'HandleStore?action=getAStore&storeId=' + $(obj).attr('storeId'),
                    success: function(data) {
                        window.console.log(data);
                    },
                    fail: function() {
                        alert('error');
                    }
                });
            }

            //return to map UI
            $('#returnToMap').click(function() {
                $('#storeBox').animate({height: '30px'});
                $('#specificStore').animate({right: '-70%'});
                $('#mainContent').animate({right: '0%'});
                $('#returnToMap').css({visibility: 'hidden'});
            });
        </script>
        <div id="specificStore" style="box-shadow: rgba(0, 0, 0, 0.298039) 0px 2px 60px;position: absolute; width: 70%; height: 100%;top: 0px; right: -70%;background-color: window;z-index: 3;">

        </div>

        <div id="dialog-form" title="Login">
            <p class="validateTips" style=" height: 10px; color:  red;"></p>
            <form>
                <fieldset>
                    <label for="userId">User ID</label>
                    <input type="text" name="userId" id="userId" class="text ui-widget-content ui-corner-all">
                    <label for="password">Password</label>
                    <input type="password" name="password" id="password" value="" class="text ui-widget-content ui-corner-all">
                </fieldset>
            </form>
        </div>
        <div id="dialog-personalInfo" title="Your Info">


        </div>

    </body>
</html>