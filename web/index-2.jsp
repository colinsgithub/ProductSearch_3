<%@page import="java.util.List"%>
<%@page import="bean.Comment"%>
<%@page import="javax.persistence.Query"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
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
                min-height: 600px;

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

            .ui-dialog {
                -webkit-box-shadow: 0 6px 12px rgba(0, 0, 0, 0.175);
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.175);
            }

            .ui-dialog-titlebar {
                background: none;
                border: none;
            }
            .ui-dialog .ui-state-error { 
                padding: .3em; 
            }

            .validateTips { 
                border: 1px solid transparent; 
                padding: 0.3em; }

            #returnToMap:hover {
                background-color:rgb(81, 81, 81);
            }

            .loading {
                position: absolute;
                background: #29d;
                z-index: 2000;
                top: 0;
                left: 0;
                height: 2px;
                width: 100%;
                -webkit-transition: width 1s;
                -moz-transition: width 1s;
                -o-transition: width 1s;
                transition: width 1s;
            }

            .pace-inactive {
                display: none;
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


            .menu img {
                cursor: pointer;
                height: 45px;
                border-radius: 60px;
                -moz-border-radius: 60px;
                -webkit-border-radius: 50px;
                -webkit-box-shadow: 4px 3px 5px rgba(0, 0, 0, 0.300);
                box-shadow: 4px 3px 5px rgba(0, 0, 0, 0.300);
            }


            .controlArrow.next {
                display: none;
                right: 15px;
                border-width: 38.5px 0 38.5px 34px;
                border-color: transparent transparent transparent #fff;
            }

            .controlArrow {
                cursor: pointer;
                width: 0;
                height: 0;
                border-style: solid;
            }

        </style>


        <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?v=3.exp&key=AIzaSyBQTZl_t-QrF8ExPfToPAjeclIf1DUZ2jc&key=AIzaSyBQTZl_t-QrF8ExPfToPAjeclIf1DUZ2jc&libraries=geometry,places&sensor=false"></script>

        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <%-- draw bar api--%>

        <script src="js/markerwithlabel.js"></script>
        <script src="js/pace.min.js"></script>

        <link href='http://fonts.googleapis.com/css?family=Passion+One' rel='stylesheet' type='text/css'>



        <%--css for nested--%>
        <link href="css/nested.css" rel="stylesheet" type="text/css" media="screen" />

        <%--source from JQuery UI--%>

        <link rel="stylesheet" href="css/loadingBar.css">
        <link rel="stylesheet" href="css/jquery-ui.css">
        <link rel="stylesheet" href="css/dialog.css">


        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>


        <%--javascript for mixitup--%>
        <script src="js/jquery.mixitup.min.js"></script>

        <%--javascript for nested--%>
        <script src="js/jquery.nested.js"></script>
        <script src="js/makeboxes.js"></script>


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
                $("#distance").change(function() {
                    $("#slider").slider({
                        value: $("#distance").val()
                    });
                    cityCircle.setRadius(parseInt($("#distance").val()));
                    map.setCenter(cityCircle.getCenter());
                    lopStore();
                    changeZoom();
                });
                //animation for menu button
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
            });</script>


        <script>
            var rendererOptions = {
                draggable: true
            };
            var directionsDisplay = new google.maps.DirectionsRenderer(rendererOptions);
            var directionsService = new google.maps.DirectionsService();
            var map;
            var markersArray = [];
            function initialize() {
                if (navigator.geolocation) {

                    var mapOptions = {
                        zoom: 16,
                        disableDefaultUI: true,
                        panControl: true,
                        streetViewControl: true
                    };
                    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
                    geoLocation(); //current location

                } else {
                    // Browser doesn't support Geolocation
                    handleNoGeolocation(false);
                }

                searchBoxDefault();
                //markers's meaning
                markerList();
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

                    for (int x = 0; x < stores.size(); x++) {
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
                        out.println("storeAvatar = '" + stores.get(x).getStoreAvatar() + "'");

                        EntityManagerFactory factory = Persistence.createEntityManagerFactory("ProductSearch_3PU");
                        EntityManager em = factory.createEntityManager();
                        em.getTransaction().begin();

                        //Store store = em.find(Store.class, storeId);
                        
                        Query query = em.createQuery("select c.rank, count(c.rank) from Comment c where c.commentPK.storeID = :storeID group by c.rank");
                        query.setParameter("storeID", Integer.parseInt(storeId));
                        //get a sorted comment list
                        List countList = query.getResultList();
                        
                        
                        
                        em.getTransaction().commit();
                        em.close();
                        factory.close();

                        

                        
                        //out.println("verfiyRange(radius, latLngWithInRangeArray, latLngB, storeName, storeId);");
                        out.println("dropMarker(latLngB);");

                    }

                    out.println("createList();");
                }
            %>
            }



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


                distanceWithMarker1 = google.maps.geometry.spherical.computeDistanceBetween(marker1.getPosition(), latLngB);

                var distance = google.maps.geometry.spherical.computeDistanceBetween(map.getCenter(), latLngB);
                if (distance < cityCircle.getRadius()) {

                    var marker = new MarkerWithLabel({
                        map: map,
                        position: latLngB,
                        content: 'Store',
                        name: (storeName).toUpperCase(),
                        distance: parseInt(distanceWithMarker1),
                        cover: storeAvatar,
                        storeID: storeId,
                        rank: storeRank,
                        icon: pinImage,
                        storeAddress: storeAddress,
                        storePhoneNumber: storePhoneNumber,<%--shape: {
                            coords: [0, 0, 20],
                            type: "circle"
                        },
            --%>
                        labelContent: "1",
                        labelAnchor: new google.maps.Point(20, 30),
                        labelClass: "labels", // the CSS class for the label
                        labelStyle: {opacity: 1}
                    });
                    google.maps.event.addListener(marker, 'click', function() {
                        //alert('Marker Click');
                        cityCircle.setCenter(marker.getPosition());
                        //map.panTo(marker.getPosition());
                        //map.setZoom(map.getZoom() + 1);
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
                                marker.setMap(null);
                                markerRecord = false;
                                break;
                            }
                        }
                    }
                    if (markerRecord) {
                        marker[0] = []; //marker creates a list to record others markers which is overlayed 
                        //marker[0].push(marker); //a list should incude the main marker;
                        markersArray.push(marker);
                    }

                    //all stores with radius
                    //createListOfStores(parseInt(distance));
                }



            }

            grade = ["Bad", "Poor", "Regular", "Good", "Gorgeous"];
            function createList() {
                if (markersArray.length === 0)// no marker on map, then return
                    return;

                for (var i in markersArray) {
                    //window.console.log(markersArray[i][0].length);
                    if (markersArray[i][0].length === 0) {
                        var infoString =
                                "<table id='storeInfoWindwo' style='width:330px;margin:10px;'>" +
                                "<tr>" +
                                "<td rowspan='7'><img  style = 'border-radius: 6px;margin: 0 5px 0 10px;' src='" + markersArray[i].cover + "' width='130px' height='130px'/></td>" +
                                "<td style='font-size:30px;'>" + markersArray[i].name + "</td>" +
                                "</tr>" +
                                "<tr><td><div class='rank'><div id='score' style='cursor:pointer;width:100px;'>";
                        var displayRank = parseInt(parseInt(markersArray[i].rank) / 100 * 5);

                        for (var x = 0; x < displayRank; x++) {
                            infoString += "<img style='width:20px;' src='lib/img/star-on.png' alt='1' title='" + grade[x] + "'>";
                        }
                        for (var x = displayRank; x < 5; x++) {
                            infoString += "<img style='width:20px;' src='lib/img/star-off.png' alt='1' title='" + grade[x] + "'>";
                        }

                        infoString += "<tr><td style='display: flex;'><img style='height:25px;' src='icon/compasses.png'/><div style='margin: auto 0px auto 10px;'>" + markersArray[i].distance + "m</div></td></tr>";
                        infoString += "</div></td></tr>" +
                                "<tr><td><button id='enterStore' storeId='" + markersArray[i].storeID + "' onclick='directEnterStore(this);'>Enter Store</button></td></tr>" +
                                "<tr><td><button onclick='sizeCenterPane();'>Stores List</button></td></tr>" +
                                //"<tr><td><a href=\"javascript:calcRoute(this);" + "\" x='" + "happy" + "'>Direct</a></td></tr>" +
                                "<tr><td><button id='comment' storeId='" + markersArray[i].storeID + "' onclick='comment(this);'>Comment</button></td></tr>" +
                                "</table>";
                        infoString += "<a style='width:25px;height:25px;' storeId='" + markersArray[i].storeID + "' onclick='addToFollowList(this);'><img style='width:25px;' src='icon/heart.png' ></a>";
                        var infoWindow = addInfoWindow(markersArray[i], infoString);


                    } else {

                        var infoList =
                                "<div id='storeInfoWindowList' style='height:300px;overflow-x:auto'>" +
                                //'<div id="chart_div"></div>' +
                                "<table style='width:250px;margin:7px;'>";

                        var sort_by = function(field, reverse, primer) {
                            var key = primer ?
                                    function(x) {
                                        return primer(x[field]);
                                    } :
                                    function(x) {
                                        return x[field];
                                    };
                            reverse = [-1, 1][+!!reverse];
                            return function(a, b) {
                                return a = key(a), b = key(b), reverse * ((a > b) - (b > a));
                            };
                        };

                        var MarkerListForInfoBox = [];
                        MarkerListForInfoBox.push(markersArray[i]);

                        for (var x in markersArray[i][0]) {
                            MarkerListForInfoBox.push(markersArray[i][0][x]);
                        }

                        MarkerListForInfoBox.sort(sort_by('rank', false, parseInt));


                        markersArray[i]['Regular'] = 0;
                        markersArray[i]['Good'] = 0;
                        markersArray[i]['Gorgeous'] = 0;
                        // for generate bar chart for reference

                        for (var x in MarkerListForInfoBox) {
                            infoList +=
                                    "<tr>" +
                                    "<td rowspan='3'><img style='margin:10px 10px 10px 0;width:75px;border-radius: 5px;' src='" + MarkerListForInfoBox[x].cover + "'/></td>" +
                                    "<td style='font-size:20px;height:20px;'>" + MarkerListForInfoBox[x].name + "</td>" +
                                    "</tr>" +
                                    "<tr>" +
                                    "<td style='display: flex;'><img style='height:25px;' src='icon/compasses.png'/><div style='height:25px;margin-left:10px;'>" + MarkerListForInfoBox[x].distance + "m<div></td>" +
                                    "</tr>" +
                                    "<tr><td><div class='rank'><div id='score' style='cursor:pointer;width:100px;'>";
                            var displayRank = parseInt(parseInt(MarkerListForInfoBox[x].rank) / 100 * 5);

                            if (displayRank <= 3) {
                                markersArray[i]['Regular']++;
                            } else if (displayRank === 4) {
                                markersArray[i]['Good']++;
                            } else {
                                markersArray[i]['Gorgeous']++;
                            }

                            for (var x = 0; x < displayRank; x++) {
                                infoList += "<img style='width:20px;' src='lib/img/star-on.png' alt='1' title='" + grade[x] + "'>";
                            }
                            for (var x = displayRank; x < 5; x++) {
                                infoList += "<img style='width:20px;' src='lib/img/star-off.png' alt='1' title='" + grade[x] + "'>";
                            }

                            infoList += "</div></td></tr>";
                        }
                        infoList += "</table></div>";

                        var listOfInfoWindow = addListOfInfoWindow(markersArray[i], infoList);
                    }
                }
                createMarkersPageList();
                //right panel data 
            }

            function comment(obj) {
                var storeId = $(obj).attr('storeId');

                $("#dialog-commentList").dialog({
                    autoOpen: false,
                    height: 600,
                    width: 1000,
                    draggable: false,
                    modal: true,
                    resizable: false,
                    minHeight: 200,
                    minWidth: 455,
                    maxWidth: 1100,
                    maxHeight: 570,
                    buttons: {
                        "Comment": function() {
                            var box = document.createElement('div');
                            box.className = 'box size42';

                            $(box).append('<div style="margin:10px;float: right;">' +
                                    '<textarea id="comment" style="resize:none;" rows="6" cols="40" placeholder="Your Comment..."></textarea><br>' +
                                    '<input type="radio" name="commentType" value="positive">Positive<br>' +
                                    '<input type="radio" name="commentType" value="negative">Negative' +
                                    '<button style="float: right;" storeId="' + storeId + '" onclick="submitComment(this);">Comment</button></div>');

                            $("#comment-display").prepend(box).nested("prepend", box);
                        },
                        "Close": function() {
                            $(this).dialog("close");
                        }
                    },
                    close: function() {

                    }
                });

                $("#dialog-commentList").dialog("open");
                /*
                 $("#dialog-commentList").parent().position({
                 of: $(".gm-style-iw").parent(),
                 my: "centre" + " " + "top",
                 at: "centre" + " " + "top",
                 collision: "fit" + " " + "fit"
                 });
                 */
                $("#loading").remove();
                $("#dialog-commentList").parent().prepend("<div id='loading' class='loading' style='display: none;'></div>");

                //get comment from servlet

                $("#comment-display").empty();
                //clear older data

                getCommentFirstTime = function() {
                    $.ajax({
                        url: 'HandleComment?action=getComment&storeId=' + storeId,
                        type: 'POST',
                        data: {
                            startIndex: 0,
                            endIndex: 9
                        },
                        // pass comment for load part of comment list 
                        success: function(response) {
                            var json = JSON.parse(response);

                            for (var x in json['comments']) {
                                var userId = json['comments'][x]['userId'];
                                var userName = json['comments'][x]['userName'];
                                var feedback = json['comments'][x]['feedback'];
                                var postedDate = json['comments'][x]['postedDate'];

                                /*
                                 $("#comment-display").append("<a href=HandleUser?action=viewOtherUser&userId=" + userId + ">" + userName + "</a>");
                                 $("#comment-display").append("<div style=''>" + feedback + "</div>");
                                 */
                                $("#comment-display").append(
                                        '<div class="' + randomSize(feedback.length) + '">' +
                                        '<div style="display: flex;"><img style="margin: 5px;height:50px; id="personalInfo" src="icon/profle.png" title="User Photo"/>' +
                                        '<div><a href=HandleUser?action=viewOtherUser&userId=' + userId + '>' + userName + '</a>' +
                                        '<br/>' + postedDate + '</div></div><cpan>' + feedback + '</cpan></div>');
                            }

                            $("#comment-display").nested({
                                resizeToFit: false,
                                minWidth: 100,
                                gutter: 5
                            });

                            $("#dialog-commentList").scroll(loadMore);

                            var isLastIndex = json['isLastIndex'];
                            var startIndex = json['startIndex'];
                            var endIndex = json['endIndex'];
                            function loadMore() {
                                if ($("#dialog-commentList").scrollTop() + $("#dialog-commentList").height() > $("#comment-display").height() - 1) {
                                    if (!isLastIndex) {
                                        var commentListRequest = makeBoxes(startIndex, endIndex, json['storeId']);
                                        isLastIndex = commentListRequest[0]['isLastIndex'];
                                        startIndex = commentListRequest[0]['startIndex'];
                                        endIndex = commentListRequest[0]['endIndex'];

                                    }
                                }
                            }
                        }
                    });
                };

                getCommentFirstTime();
            }



            function addToFollowList(obj) {
                $.ajax({
                    url: 'HandleTag?action=addTag&' + 'storeId=' + obj.getAttribute('storeId'),
                    type: 'POST',
                    success: function(response) {
                        var isLogin = (response === 'false');
                        if (isLogin) {
                            BookmarkApp.addBookmark(obj);
                            //$('#personalInfo').click();
                        } else {
                            alert(response);
                        }
                    }
                });
            }

            BookmarkApp = function() {
                var isIEmac = false; /*@cc_on @if(@_jscript&&!(@_win32||@_win16)&&(@_jscript_version<5.5)) isIEmac=true; @end @*/
                var isMSIE = (-[1, ]) ? false : true;
                var cjTitle = document.title; // Bookmark title 
                var cjHref = location.href;   // Bookmark url

                function hotKeys() {
                    var ua = navigator.userAgent.toLowerCase();
                    var str = '';
                    var isWebkit = (ua.indexOf('webkit') != -1);
                    var isMac = (ua.indexOf('mac') != -1);

                    if (ua.indexOf('konqueror') != -1) {
                        str = 'CTRL + B'; // Konqueror
                    } else if (window.home || isWebkit || isIEmac || isMac) {
                        str = (isMac ? 'Command/Cmd' : 'CTRL') + ' + D'; // Netscape, Safari, iCab, IE5/Mac
                    }
                    return ((str) ? 'Press ' + str + ' to bookmark this page.' : str);
                }

                function isIE8() {
                    var rv = -1;
                    if (navigator.appName == 'Microsoft Internet Explorer') {
                        var ua = navigator.userAgent;
                        var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
                        if (re.exec(ua) != null) {
                            rv = parseFloat(RegExp.$1);
                        }
                    }
                    if (rv > -1) {
                        if (rv >= 8.0) {
                            return true;
                        }
                    }
                    return false;
                }

                function addBookmark(a) {
                    try {
                        if (typeof a == "object" && a.tagName.toLowerCase() == "a") {
                            a.style.cursor = 'pointer';
                            if ((typeof window.sidebar == "object") && (typeof window.sidebar.addPanel == "function")) {
                                window.sidebar.addPanel(cjTitle, cjHref, ""); // Gecko
                                return false;
                            } else if (isMSIE && typeof window.external == "object") {
                                if (isIE8()) {
                                    window.external.AddToFavoritesBar(cjHref, cjTitle); // IE 8                    
                                } else {
                                    window.external.AddFavorite(cjHref, cjTitle); // IE <=7
                                }
                                return false;
                            } else if (window.opera) {
                                a.href = cjHref;
                                a.title = cjTitle;
                                a.rel = 'sidebar'; // Opera 7+
                                return true;
                            } else {
                                alert(hotKeys());
                            }
                        } else {
                            throw "Error occured.\r\nNote, only A tagname is allowed!";
                        }
                    } catch (err) {
                        alert(err);
                    }
                }

                return {
                    addBookmark: addBookmark
                };
            }();

            function cancelTag(obj) {
                $.ajax({
                    url: 'HandleTag?action=cancelTag&' + 'tagId=' + $(obj).parent().attr('tagId'),
                    type: 'POST',
                    success: function(response) {
                        var isLogin = (response === 'false');
                        if (isLogin) {
                            $('#personalInfo').click();
                        } else {
                            $.ajax({
                                url: 'HandleTag?action=getTags',
                                type: 'POST',
                                success: function(response) {
                                    $("#tag-display").empty();
                                    var tags = JSON.parse(response);
                                    for (var x = 0; x < tags['tags'].length; x++) {
                                        var storeName = (tags['tags'][x]['storeName']).toUpperCase();
                                        var tagId = (tags['tags'][x]['tagId']);
                                        $("#tag-display").append("<div tagId='" + tagId + "'>" + storeName + "<img src='icon/hear4.png' onclick='cancelTag(this);'/></div>");
                                    }
                                    $("#dialog-tagList").parent().append("<div id='loading' class='loading' style='display: none;'></div>");
                                }
                            });
                        }
                    }
                });
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

            function RightArrow(obj) {
                var x = $(obj).find('#rightArrow');
                if ($(obj).find('#rightArrow').is(':hidden')) {
                    x.show();
                }
                else {
                    x.hide();
                }
            }

            function sortList(obj) {
                var pageDisplayed = [];

                for (var x in markerPageArray) {
                    for (var y in markerPageArray[x])
                        pageDisplayed.push(markerPageArray[x][y]);
                }

                //sort field function;
                var sort_by = function(field, reverse, primer) {
                    var key = primer ?
                            function(x) {
                                return primer(x[field]);
                            } :
                            function(x) {
                                return x[field];
                            };
                    reverse = [-1, 1][+!!reverse];
                    return function(a, b) {
                        return a = key(a), b = key(b), reverse * ((a > b) - (b > a));
                    };
                };

                var sortBy;
                if (parseInt($(obj).attr('sortBy')) === 0) {
                    sortBy = false;
                    $(obj).attr('sortBy', 1);
                } else {
                    sortBy = true;
                    $(obj).attr('sortBy', 0);
                }


                if ($(obj).html() === 'Name')
                    pageDisplayed.sort(sort_by($(obj).attr('sortKey'), sortBy, function(a) {
                        return a.toUpperCase();
                    }));
                else if ($(obj).html() === 'Distance' || $(obj).html() === 'Rank') {
                    pageDisplayed.sort(sort_by($(obj).attr('sortKey'), sortBy, parseInt));
                }

                markerPageArray = [];// each page means an array

                var page = [];
                var countColumn = 0;
                for (var x = 0; x < pageDisplayed.length; x++) {
                    countColumn++;
                    page.push(pageDisplayed[x]);

                    if (countColumn === 5) {
                        markerPageArray.push(page);
                        page = [];
                        countColumn = 0;
                    }
                }
                if (page.length !== 0)
                    markerPageArray.push(page);

                createListOfStores();
            }


            function createMarkersPageList() {
                markerPageArray = [];// each page means an array
                var page = [];
                var countColumn = 0;
                for (var x = 0; x < markersArray.length; x++) {
                    countColumn++;
                    page.push(markersArray[x]);
                    if (countColumn === 5) {
                        markerPageArray.push(page);
                        page = [];
                        countColumn = 0;
                    }
                    if (markersArray[x][0].length !== 0) {
                        for (var y = 0; y < markersArray[x][0].length; y++) {
                            countColumn++;
                            page.push(markersArray[x][0][y]);

                            if (countColumn === 5) {
                                markerPageArray.push(page);
                                page = [];
                                countColumn = 0;
                            }
                        }
                    }
                }
                if (page.length !== 0)
                    markerPageArray.push(page);

                createListOfStores();
            }

            function createListOfStores() {
                //create a sort bar
                $('#mainContent #Grid').remove(); //removre stores list
                $('#mainContent').append("<ul style='padding-left: 0px;' id='Grid'></ul>");


                $('#pageBox').remove();

                var pageButton = "<div id='pageBox'><button onclick=changeListPage(this);>1</button>";
                for (var x = 2; x <= markerPageArray.length; x++) {
                    pageButton += "<button onclick=changeListPage(this)>" + x + "</button>";
                }
                pageButton += "</div>";

                var pageDisplayed = markerPageArray[0];

                for (var x = 0; x < pageDisplayed.length; x++) {

                    $('#mainContent #Grid').append(
                            "<li onmouseout='RightArrow(this);' onmouseover='RightArrow(this);' class='mix' id='rowStore' data-name='" + pageDisplayed[x].name + "' data-rank='2' data-distance='" + pageDisplayed[x].distanceWithMarker1 + "'>" +
                            "<div style='display: inline;'>" +
                            "<table style='width:380px;'>" +
                            "<tr><td></td><td style='font-size:25px;font-family: Roboto;'>" + pageDisplayed[x].name + "</td>" +
                            "<td rowspan='5' width='40px;font-weight: 600;'><div id='rightArrow' class='controlArrow next' storeId='" + pageDisplayed[x].storeId + "' onclick='viewMoreDetail(this);'></div><td></tr>" +
                            "<tr><td rowspan='4'><img style='width:90px;margin-right: 10px;border-radius: 5px;' src='" + pageDisplayed[x].cover + "'/></td>" +
                            "<td style='font-size:15px;font-family: Roboto;display: flex;'><img style='height:25px;' src='icon/compasses.png'/><div style='height:25px;margin-left:10px;'>" + pageDisplayed[x].distance + "m</div></td></tr>" +
                            "<tr><td style='font-size:15px;font-family: Roboto;display: flex;'><img style='margin-top: auto;height: 25px;margin-bottom: auto;' src='icon/location.png'/><div style='width:70%;margin-left:10px;'>" + pageDisplayed[x].storeAddress + "</div></td></tr>" +
                            "<tr><td style='font-size:15px;font-family: Roboto;display: flex;'><img style='height:25px;' src='icon/contact.png'/><div style='height:25px;margin-left:10px;'>" + pageDisplayed[x].storePhoneNumber + "</div></td></tr>" +
                            "</table>" +
                            "</div>" +
                            "</li >"
                            );
                }
                $('#Grid').mixitup();
                $('#mainContent').append(pageButton);
            }

            function changeListPage(obj) {
                $('#mainContent #Grid').remove(); //removre stores list
                $('#mainContent').append("<ul style='padding-left: 0px;' id='Grid'></ul>");

                var pageNum = parseInt($(obj).html()) - 1;

                var pageDisplayed = markerPageArray[pageNum];

                for (var x = 0; x < pageDisplayed.length; x++) {

                    $('#mainContent #Grid').append(
                            "<li onmouseout='RightArrow(this);' onmouseover='RightArrow(this);' class='mix' id='rowStore' data-name='" + pageDisplayed[x].name + "' data-rank='2' data-distance='" + pageDisplayed[x].distanceWithMarker1 + "'>" +
                            "<div style='display: inline;'>" +
                            "<table style='width:380px;'>" +
                            "<tr><td></td><td style='font-size:25px;font-family: Roboto;'>" + pageDisplayed[x].name + "</td>" +
                            "<td rowspan='5' width='40px;font-weight: 600;'><div id='rightArrow' class='controlArrow next' storeId='" + pageDisplayed[x].storeId + "' onclick='viewMoreDetail(this);'></div><td></tr>" +
                            "<tr><td rowspan='4'><img style='width:90px;margin-right: 10px;' src='" + pageDisplayed[x].cover + "'/></td>" +
                            "<td style='font-size:15px;font-family: Roboto;display: flex;'><img style='height:25px;' src='icon/compasses.png'/><div style='height:25px;margin-left:10px;'>" + pageDisplayed[x].distance + "m</div></td></tr>" +
                            "<tr><td style='font-size:15px;font-family: Roboto;display: flex;'><img style='margin-top: auto;height: 25px;margin-bottom: auto;' src='icon/location.png'/><div style='width:70%;margin-left:10px;'>" + pageDisplayed[x].storeAddress + "</div></td></tr>" +
                            "<tr><td style='font-size:15px;font-family: Roboto;display: flex;'><img style='height:25px;' src='icon/contact.png'/><div style='height:25px;margin-left:10px;'>" + pageDisplayed[x].storePhoneNumber + "</div></td></tr>" +
                            "</table>" +
                            "</div>" +
                            "</li >"
                            );
                }
                $('#Grid').mixitup();
                $('#pageBox').appendTo('#mainContent');

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
                 infoWindow.close();
                 });
                 */
                return infoWindow;
            }

            function addListOfInfoWindow(marker, message) {
                window.console.log(marker);
                var infoWindow = new google.maps.InfoWindow({
                    content: message
                });
                infoWindowList.push(infoWindow);
                google.maps.event.addListener(marker, 'click', function() {
                    closeAllInfoWindow();

                    infoWindow.open(map, marker);

                    draw(marker);

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

            markerColorList = ["marker/centre.png", "fa220f", "3366cc", "ff9100"];
            function markerList() {
                //the list of marker
                map.controls[google.maps.ControlPosition.LEFT_BOTTOM].push(document.getElementById('legend'));
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
                closeAllInfoWindow();
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

            function zoomIn() {
                var zoomLevel = parseInt(map.getZoom()) + 1;
                map.setZoom(zoomLevel);
            }

            function zoomOut() {
                var zoomLevel = parseInt(map.getZoom()) - 1;
                map.setZoom(zoomLevel);
            }

            function openFavList() {
                $('#dialog-tagList').dialog({
                    autoOpen: false,
                    height: 350,
                    width: 350,
                    draggable: false,
                    modal: true,
                    resizable: false,
                    close: function() {
                        $('#tag-display').empty();
                        $('.loading').remove();
                    }
                });

                $.ajax({
                    url: 'HandleTag?action=getTags',
                    type: 'POST',
                    success: function(response) {
                        var isLogin = (response === 'false');
                        if (isLogin) {
                            $('#personalInfo').click();
                        } else {

                            var tags = JSON.parse(response);

                            for (var x = 0; x < tags['tags'].length; x++) {
                                var storeName = (tags['tags'][x]['storeName']).toUpperCase();
                                var tagId = (tags['tags'][x]['tagId']);
                                $("#tag-display").append("<div tagId='" + tagId + "'>" + storeName + "<img src='icon/hear4.png' onclick='cancelTag(this);'/></div>");
                            }
                            $("#dialog-tagList").parent().prepend("<div id='loading' class='loading' style='display: none;'></div>");
                            $('#dialog-tagList').dialog('open');
                            $("#dialog-tagList").parent().position({
                                of: $("#favList").parent(),
                                my: "right" + " " + "top",
                                at: "left" + " " + "top",
                                collision: "fit" + " " + "fit"
                            });
                        }
                    }
                });
            }

            google.maps.event.addDomListener(window, 'load', initialize);</script>

        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script type="text/javascript">
            google.load("visualization", "1", {packages: ["corechart"]});

            function draw(marker) {

                data = google.visualization.arrayToDataTable([
                    ['Genre', 'Gorgeous', 'Good', 'Regular', {role: 'annotation'}],
                    ['',
                        marker['Gorgeous'],
                        marker['Good'],
                        marker['Regular'],
                        '']
                ]);

                options = {
                    width: 300,
                    height: 50,
                    legend: {position: 'top', maxLines: 5},
                    bar: {groupWidth: '75%'},
                    colors: ["fa220f", "3366cc", "ff9100"],
                    isStacked: true
                };

                var newDiv = document.createElement('div');

                var bar = new google.visualization.BarChart(newDiv);

                bar.draw(data, options);

                $('#storeInfoWindowList').parent().prepend(newDiv);
            }

        </script>
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
        <div id="menu" class="menu" style="text-align: right; position: absolute;right: 10px; top:15%; z-index: 4;">
            <div style=" height: 65px;"><img id="personalInfo" src="icon/profle.png" title="Personal Profile"/></div>
            <div style=" height: 65px;"><img id="favList" onclick="openFavList();" src="icon/follow.png" title="Tap List"/></div>
            <div style=" height: 65px;"><img id="chat" src="icon/chat.png" title="Chat"/></div>
            <div id="uiDirect"  style=" height: 65px;"><img id="listsStores" src="icon/arrow-left.png" onclick="sizeCenterPane();" title="Store List"/></div>
            <div style=" height: 65px;"><img id="zoomin" onclick="zoomIn();" src="icon/zoomin.png" title="Zoom In"/></div>
            <div style=" height: 65px;"><img id="zoomout" onclick="zoomOut();" src="icon/zoomout.png" title="Zoom Out"/></div>
        </div>
        <script>
            $("#personalInfo").click(function() {
                $.ajax({
                    url: 'HandleUser?action=getInfo',
                    type: 'POST',
                    success: function(login) {
                        if (login === "false") {

                            var userId = $("#userId"),
                                    password = $("#password"),
                                    allFields = $([]).add(userId).add(password),
                                    tips = $(".validateTips");
                            $("#dialog-form").dialog({
                                autoOpen: false,
                                height: 400,
                                width: 350,
                                draggable: false,
                                modal: true,
                                resizable: false,
                                buttons: {
                                    "Log In": function() {
                                        var bValid = true;
                                        allFields.removeClass("ui-state-error");
                                        if (bValid) {
                                            $.ajax({
                                                url: 'HandleUser?action=login&userId=' + userId.val() + '&password=' + password.val(),
                                                type: 'POST',
                                                success: function(response) {
                                                    var isLogin = (response === 'true');
                                                    if (isLogin) {
                                                        $("#dialog-form").dialog("close");
                                                        $(".validateTips").html("");
                                                    } else {
                                                        $(".validateTips").html("ID or Password is not correct.");
                                                    }
                                                }
                                            });
                                        }
                                    },
                                    Cancel: function() {
                                        $(this).dialog("close");
                                    }
                                },
                                close: function() {
                                    $("#dialog-form").parent().empty();
                                    allFields.val("").removeClass("ui-state-error");
                                    $(".validateTips").html("");
                                    $('.loading').remove();
                                }
                            });
                            $("#dialog-form").dialog("open");
                            $("#dialog-form").parent().position({
                                of: $("#personalInfo").parent(),
                                my: "right" + " " + "top",
                                at: "left" + " " + "top",
                                collision: "fit" + " " + "fit"
                            });
                            $("#dialog-form").parent().prepend("<div id='loading' class='loading' style='display: none;'></div>");
                            $("#dialog-form").parent().append('<div class="loginByOthers"><img src="icon/fb.png"/><img src="icon/twitter.png"/><img src="icon/googleplus.png"/></div>');
                        } else {
                            $("#personalInfo-display").empty();
                            $("#dialog-personalInfo").dialog({
                                height: 400,
                                width: 350,
                                modal: true,
                                resizable: false,
                                draggable: false,
                                buttons: {
                                    'More': function() {
                                        window.location.href = "HandleUser?action=getUserInfo";
                                    },
                                    'Logout': function() {

                                        $.ajax({
                                            url: 'HandleUser?action=logout',
                                            type: 'POST',
                                            success: function(response) {
                                                var isLogout = (response === 'true');
                                                if (isLogout) {
                                                    $("#dialog-personalInfo").dialog("close");
                                                    $(".loading").remove();
                                                    alert("logout successfully");
                                                }
                                            }});
                                    }
                                }
                            });
                            $("#dialog-personalInfo").parent().position({
                                of: $("#personalInfo").parent(),
                                my: "right" + " " + "top",
                                at: "left" + " " + "top",
                                collision: "fit" + " " + "fit"
                            });
                            var json = JSON.parse(login);

                            $("#personalInfo-display").append('<div>User ID:' + json['user']['userID'] + '</div>');
                            $("#personalInfo-display").append('<div>User Name:' + (json['user']['userName']).toString().toUpperCase() + '</div>');
                            $("#personalInfo-display").append('<div>Credit:' + json['user']['credit'] + '</div>');
                            $("#personalInfo-display").append('Email Address:<div>' + json['user']['email'] + '</div>');
                            $("#personalInfo-display").parentsUntil('#ui-dialog').prepend("<div id='loading' class='loading' style='display: none;'></div>");
                        }
                    },
                    fail: function() {
                        alert('error');
                    }
                });
            });</script>

        <div id="mainContent">
            <div id="chart_div"></div>
            <div id="storeBox" class="storeBox"></div>
            <div id="sortList" style=" margin: 10px;">
                <table>
                    <tr>
                    <button sortKey="name" sortBy="0" onclick="sortList(this);">Name</button>
                    <button sortKey="distance" sortBy="0" onclick="sortList(this);">Distance</button>
                    <button sortKey="rank" sortBy="0" onclick="sortList(this);">Rank</button>
                    </tr>
                </table>
            </div>

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
            });</script>
        <div id="specificStore" style="box-shadow: rgba(0, 0, 0, 0.298039) 0px 2px 60px;position: absolute; width: 70%; height: 100%;top: 0px; right: -70%;background-color: window;z-index: 3;">

        </div>

        <div id="dialog-form" class="diaglog-form">
            <div class="login-title">Log In</div>
            <p class="validateTips" style=" height: 10px; color:  red;"></p>
            <form>
                <input type="text" name="userId" id="userId" placeholder="User ID" class="text ui-widget-content ui-corner-all">
                <input type="password" name="password" id="password" placeholder="Password" value="" class="text ui-widget-content ui-corner-all">
            </form>

        </div>
        <div id="dialog-personalInfo">
            <div class="login-title">Personal Profile</div>
            <div id="personalInfo-display" class="personalInfo-display"></div>
        </div>

        <div id="dialog-tagList">
            <div class="login-title">Your Favorite</div>
            <div id="tag-display" class="tag-display"></div>
        </div>

        <div id="dialog-commentList">
            <div class="login-title">Store Comment</div>

            <div id="comment-display" class="comment-display">

            </div>
        </div>

        <script>
            //loading bar for all ajax request
            $(document).bind("ajaxSend", function() {
                $("#loading").show();
            }).bind("ajaxComplete", function() {
                $("#loading").hide();
            }
            );
        </script>
    </body>
</html>