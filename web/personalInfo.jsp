<%-- 
    Document   : personalInfo
    Created on : Mar 18, 2014, 1:00:41 PM
    Author     : poonkaho
--%>

<%@page import="bean.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <style>
            body {
                width: 100%;
                height: 100%;
                margin: 0px;
            }

            .main {
                left: 0%;
                position: absolute;
                width: 400%;
                height: 100%;
                background-color: rgb(75, 191, 195);
            }

            .controlArrow.next {
                visibility: visible;
                right: 15px;
                border-width: 38.5px 0 38.5px 34px;
                border-color: transparent transparent transparent #fff;
            }

            .controlArrow.prev {
                visibility: hidden;
                left: 15px;
                width: 0;
                border-width: 38.5px 34px 38.5px 0;
                border-color: transparent #fff transparent transparent;
            }

            .controlArrow {
                position: absolute;
                top: 50%;
                cursor: pointer;
                width: 0;
                height: 0;
                border-style: solid;
                margin-top: -38px;
            }

            .page {
                float: left;
            }

            #page1 {
                position: absolute;
                height: 100%;
                width: 25%;
                left:0%;
            }
            #page2 {
                position: absolute;
                height: 100%;
                width: 25%;
                left:25%;
            }
            #page3 {
                position: absolute;
                height: 100%;
                width: 25%;
                left:50%;
            }

            #page4 {
                position: absolute;
                height: 100%;
                width: 25%;
                left:75%;
            }
        </style>
    </head>
    <body>

        <div id="main" class="main">

            <div id="page1" class="page">
                <h1>Personal Profile</h1>
                <%
                    User user = (User) request.getAttribute("user");
                    out.println(user.getUserID());
                    out.println(user.getPreference());
                %>
            </div>
            
            <div id="page2" class="page">
                <h1>Security</h1>
                <button style="position: absolute; top: 30%;">Chang Password</button>
            </div>
            
            <div id="page3" class="page">
                <h1>Store</h1>
            </div>
            
            <div id="page4" class="page">
                <h1>Preference</h1>
            </div>

        </div>
        <div class="controlArrow prev" onclick="left();"></div>
        <div class="controlArrow next" onclick="right();"></div>
        
        <script>
            pos = 0;

            function left() {
                pos += 100;
                x();
            }

            function right() {
                pos -= 100;
                x();
            }

            function x() {
                if (pos <= -300) {
                    $('.controlArrow.next').css({visibility: 'hidden'});
                } else if (pos === 0) {
                    $('.controlArrow.prev').css({visibility: 'hidden'});
                } else {
                    $('.controlArrow.next').css({visibility: 'visible'});
                    $('.controlArrow.prev').css({visibility: 'visible'});
                }

                $('.main').animate({
                    left: '' + pos + '%'
                });
            }
        </script>
    </body>
</html>
