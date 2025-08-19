<%--<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>--%>

<%--  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>--%>
<%--      <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">--%>
<%--      <html>--%>
<%--      <html class="no-js" lang="zxx">--%>

<%--      <head>--%>
<%--        <meta charset="utf-8" />--%>
<%--        <meta http-equiv="x-ua-compatible" content="ie=edge" />--%>
<%--        <title>Power Trading System</title>--%>
<%--        <meta name="description" content="" />--%>
<%--        <meta name="viewport" content="width=device-width, initial-scale=1" />--%>

<%--        <!-- Include jQuery -->--%>
<%--        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>--%>

<%--        <!-- Include jQuery UI -->--%>
<%--        <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />--%>
<%--        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>--%>

<%--        <!-- <link rel="manifest" href="site.webmanifest"> -->--%>
<%--        <link rel="shortcut icon" type="image/x-icon" href="img/favicon.png" />--%>
<%--        <!-- Place favicon.ico in the root directory -->--%>

<%--        <!-- CSS here -->--%>
<%--        <link rel="stylesheet" href="css/bootstrap.min.css" />--%>
<%--        <link rel="stylesheet" href="css/owl.carousel.min.css" />--%>
<%--        <link rel="stylesheet" href="css/magnific-popup.css" />--%>
<%--        <link rel="stylesheet" href="css/font-awesome.min.css" />--%>
<%--        <link rel="stylesheet" href="css/themify-icons.css" />--%>
<%--        <link rel="stylesheet" href="css/nice-select.css" />--%>
<%--        <link rel="stylesheet" href="css/flaticon.css" />--%>
<%--        <link rel="stylesheet" href="css/gijgo.css" />--%>
<%--        <link rel="stylesheet" href="css/animate.css" />--%>
<%--        <link rel="stylesheet" href="css/slicknav.css" />--%>
<%--        <link rel="stylesheet" href="css/style.css" />--%>
<%--        <link href="//fonts.googleapis.com/css?family=Open+Sans:400,600,700,300|Titillium+Web:200,300,400"--%>
<%--          rel="stylesheet" type="text/css" />--%>
<%--        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.0/fullcalendar.min.css">--%>
<%--        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">--%>
<%--        <!-- <link rel="stylesheet" href="css/responsive.css"> -->--%>

<%--<style type="text/css">--%>
<%--    div#map_container {--%>
<%--        width: 100%;--%>
<%--        height: 500px;--%>
<%--        border-radius: 5px;--%>
<%--    }--%>
<%--    --%>
<%--    .center {--%>
<%--                display: flex;--%>
<%--                justify-content: center;--%>
<%--                align-items: center;--%>
<%--                height: 10vh;--%>
<%--            }--%>
<%--    </style>  --%>

<%--        <style>--%>
<%--          #content,--%>
<%--          #rates_holder {--%>
<%--            display: none;--%>
<%--            /* Hide content by default */--%>
<%--          }--%>

<%--          #loading,--%>
<%--          #full_loading {--%>
<%--            display: none;--%>
<%--            /* Show loading animation by default */--%>
<%--            text-align: center;--%>
<%--          }--%>

<%--          .spinner {--%>
<%--            border: 4px solid rgba(0, 0, 0, 0.1);--%>
<%--            border-radius: 50%;--%>
<%--            border-top: 4px solid #3498db;--%>
<%--            width: 40px;--%>
<%--            height: 40px;--%>
<%--            animation: spin 1s linear infinite;--%>
<%--            margin: 20px auto;--%>
<%--          }--%>

<%--          @keyframes spin {--%>
<%--            0% {--%>
<%--              transform: rotate(0deg);--%>
<%--            }--%>

<%--            100% {--%>
<%--              transform: rotate(360deg);--%>
<%--            }--%>
<%--          }--%>

<%--          .caret-icon {--%>
<%--            font-size: 1.0em;--%>
<%--            margin-right: 5px;--%>
<%--            cursor: pointer;--%>

<%--          }--%>

<%--          .avbl_section {--%>
<%--            display: flex;--%>
<%--          }--%>

<%--          .date_holder {--%>
<%--            margin-top: 10px;--%>
<%--            margin-bottom: 10px;--%>
<%--            width: 25%;--%>
<%--          }--%>

<%--          .date_container {--%>
<%--            display: flex;--%>
<%--            width: 400%;--%>
<%--          }--%>

<%--          .full_container {--%>
<%--            overflow-x: scroll;--%>
<%--          }--%>

<%--          .fulldate_container {--%>
<%--            display: flex;--%>
<%--            width: 400%;--%>
<%--          }--%>

<%--          .fulldate_holder {--%>
<%--            margin-top: 10px;--%>
<%--            margin-bottom: 10px;--%>
<%--          }--%>

<%--          /* .date_box {--%>
<%--            height: 50px;--%>
<%--            width: 50px;--%>
<%--            border-radius: 6px;--%>
<%--            border: 2px solid #d1d0d0;--%>
<%--            text-align: center;--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            justify-content: center;--%>
<%--            margin-left: auto;--%>
<%--            margin-right: auto;--%>
<%--            font-size: 0.7em;--%>
<%--            font-family: Verdana, Geneva, Tahoma, sans-serif;--%>
<%--          }--%>
<%-- */--%>
<%--          .date_box {--%>
<%--            height: 50px;--%>
<%--            width: 50px;--%>
<%--            border-radius: 50%;--%>
<%--            border: 2px solid #d1d0d0;--%>
<%--            text-align: center;--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            justify-content: center;--%>
<%--            margin-left: auto;--%>
<%--            margin-right: auto;--%>
<%--            font-size: 0.7em;--%>
<%--            font-family: Verdana, Geneva, Tahoma, sans-serif;--%>
<%--          }--%>

<%--          .available {--%>
<%--            background-color: rgb(3, 213, 3);--%>
<%--          }--%>

<%--          .unavailable {--%>
<%--            background-color: rgb(252, 22, 22);--%>
<%--          }--%>


<%--          .eve_available {--%>
<%--            background-image: linear-gradient(to right, rgba(3, 213, 3, 0) 50%, rgb(3, 213, 3) 50%);--%>
<%--          }--%>

<%--          .eve_unavailable {--%>
<%--            background-image: linear-gradient(to right, rgba(3, 213, 3, 0) 50%, rgb(252, 22, 22) 50%);--%>

<%--          }--%>

<%--          .mor_available {--%>
<%--            background-image: linear-gradient(to right, rgb(3, 213, 3) 50%, rgba(3, 213, 3, 0) 50%);--%>

<%--          }--%>

<%--          .mor_unavailable {--%>
<%--            background-image: linear-gradient(to right, rgb(252, 22, 22) 50%, rgba(3, 213, 3, 0) 50%);--%>

<%--          }--%>

<%--          .rate_tbl {--%>
<%--            width: 50%;--%>
<%--            border-collapse: collapse;--%>
<%--            margin-bottom: 20px;--%>
<%--          }--%>

<%--          th {--%>
<%--            background-color: #4F81BD;--%>
<%--            color: white;--%>
<%--          }--%>

<%--          th,--%>
<%--          td {--%>
<%--            border: 1px solid #dddddd;--%>
<%--            padding: 8px;--%>
<%--            text-align: left;--%>
<%--          }--%>

<%--          td {--%>
<%--            color: #003868;--%>
<%--          }--%>

<%--          /* Alternate row colors */--%>
<%--          tr:nth-child(even) {--%>
<%--            background-color: #f2f2f2;--%>
<%--          }--%>

<%--          .center {--%>
<%--            display: flex;--%>
<%--            align-items: center;--%>
<%--            justify-content: center;--%>
<%--          }--%>

<%--          .people_container {--%>
<%--            margin-top: 15px;--%>
<%--            width: 100%;--%>
<%--            display: block;--%>
<%--            align-items: center;--%>
<%--            justify-content: center;--%>
<%--          }--%>

<%--          .people_title {--%>
<%--            margin-top: 20px;--%>
<%--          }--%>

<%--          .visitorCount {--%>
<%--            width: 100%;--%>
<%--            margin-left: auto;--%>
<%--            margin-right: auto;--%>
<%--          }--%>

<%--          .booking_container {--%>
<%--            width: 60%;--%>
<%--          }--%>

<%--          .boxed-btn3 {--%>
<%--            cursor: pointer;--%>
<%--          }--%>

<%--          .btn_unavailable {--%>
<%--            cursor: not-allowed;--%>
<%--          }--%>

<%--          .btn_available {--%>
<%--            cursor: pointer;--%>
<%--          }--%>

<%--          .instructions {--%>
<%--            margin-left: 10%;--%>
<%--            margin-top: 5%;--%>
<%--            margin-bottom: 5%;--%>
<%--          }--%>

<%--          .errorMsg {--%>
<%--            color: red;--%>
<%--            margin-bottom: 3px;--%>
<%--            font-weight: 400;--%>
<%--          }--%>

<%--          .dateDisplay {--%>
<%--            color: #fff;--%>
<%--            text-decoration: none;--%>
<%--            font-family: "Roboto", "Helvetica", "Arial", sans-serif;--%>
<%--          }--%>

<%--          @media screen and (min-width: 200px) and (max-width: 900px) {--%>
<%--            .fulldate_container {--%>
<%--              width: 400%;--%>
<%--            }--%>

<%--            .avbl_section {--%>
<%--              display: block;--%>
<%--            }--%>

<%--            .date_container {--%>
<%--              width: 400%;--%>
<%--            }--%>

<%--            .date_holder {--%>
<%--              padding-left: 35%;--%>
<%--              width: 50%;--%>
<%--            }--%>

<%--            .instructions {--%>
<%--              margin-left: 4%;--%>
<%--              margin-right: 4%;--%>
<%--            }--%>
<%--          }--%>

<%--          @media screen and (max-width: 768px) {--%>
<%--            .rates_holder {--%>
<%--              margin-top: 10px;--%>
<%--              margin-left: auto;--%>
<%--              margin-right: auto--%>
<%--            }--%>
<%--          }--%>

<%--          @media screen and (min-width: 200px) and (max-width: 900px) {--%>
<%--            .fulldate_container {--%>
<%--              width: 100%;--%>
<%--            }--%>

<%--            .avbl_section {--%>
<%--              display: block;--%>
<%--            }--%>

<%--            .date_container {--%>
<%--              width: 100%;--%>
<%--            }--%>

<%--            .date_holder {--%>
<%--              padding-left: 0;--%>
<%--              width: 100%;--%>
<%--            }--%>

<%--            .date_box {--%>
<%--              width: 80px;--%>
<%--              height: 80px;--%>
<%--              font-size: 0.8em;--%>
<%--            }--%>

<%--            .instructions {--%>
<%--              margin-left: 4%;--%>
<%--              margin-right: 4%;--%>
<%--            }--%>
<%--          }--%>


<%--          .date_holder p[id^="room_id_"] {--%>
<%--            margin-left: 2%;--%>
<%--          }--%>

<%--          .fulldate_holder {--%>
<%--            display: flex;--%>
<%--            flex-wrap: wrap;--%>
<%--            justify-content: space-between;--%>
<%--          }--%>

<%--          #full_container .fulldate_holder .date_box {--%>
<%--            margin: 3px;--%>
<%--          }--%>

<%--          @media screen and (min-width: 200px) and (max-width: 900px) {--%>

<%--            .date_box {--%>
<%--              width: 80px;--%>
<%--              height: 80px;--%>
<%--              font-size: 0.8em;--%>
<%--            }--%>
<%--          }--%>
<%--        </style>--%>
<%--        --%>
<%--        <script type="text/javascript">--%>

<%--     </script>--%>
<%--        --%>
<%--      </head>--%>

<%--      <body>--%>
<%--        <!-- header-start -->--%>
<%--        <header>--%>
<%--          <div class="header-area">--%>
<%--            <div id="sticky-header" class="main-header-area">--%>
<%--              <div class="container-fluid p-0">--%>
<%--                <div class="row align-items-center no-gutters">--%>
<%--                  <div class="col-xl-5 col-lg-6">--%>
<%--                    <div class="main-menu d-none d-lg-block">--%>
<%--                      <nav>--%>
<%--                        <ul id="navigation">--%>
<%--                          <li><a href="WelcomePTS">home</a></li>--%>
<%--                          <li><a href="WelcomePTS">LogOut &nbsp;<i style="font-size: 20px;"--%>
<%--                                                                class="fa fa-sign-out fa-lg"></i></a></li>--%>
<%--                  </ul>--%>
<%--                      </nav>--%>
<%--                    </div>--%>
<%--                  </div>--%>
<%--                  <div class="col-xl-2 col-lg-2">--%>
<%--                    <div class="logo-img">--%>
<%--                      <a href="WelcomeCBRS">--%>
<%--                        <img src="img/logo.png" alt="" />--%>
<%--                      </a>--%>
<%--                    </div>--%>
<%--                  </div>--%>
<%--                  <div class="col-12">--%>
<%--                    <div class="mobile_menu d-block d-lg-none"></div>--%>
<%--                  </div>--%>
<%--                  <div class="dateDisplayContainer col-xl-12 col-lg-12 main-menu" id="dateDisplayContainer">--%>
<%--                    <span class="dateDisplay" id="datetimeDisplay"></span>--%>
<%--                  </div>--%>
<%--                </div>--%>
<%--              </div>--%>
<%--            </div>--%>
<%--          </div>--%>
<%--        </header>--%>
<%--        <!-- header-end -->--%>

<%--        <!-- bradcam_area_start -->--%>
<%--        <div class="room_details_bradcam_area room_details_breadcam_bg">--%>
<%--          <h3>Upload Files</h3>--%>
<%--        </div>--%>
<%--        <!-- bradcam_area_end -->--%>

<%--        <div>--%>
<%--          <!-- Booking_area_start -->--%>
<%--          <div class="offers_area padding_top">--%>
<%--            <div class="container">--%>
<%--              <div class="row">--%>
<%--                <!-- left coloumn -->--%>
<%--                <div class="col-xl-6 col-md-6">--%>
<%--                <form:form id ="myForm"  method="post"   enctype="multipart/form-data" action="UploadingMeterReadingFileS"--%>
<%--											modelAttribute="model">--%>
<%--      --%>
<%--                  <div class="card">--%>
<%--                    <div class="card-body">--%>
<%--                      &lt;%&ndash; <h3 class="card-title">Select date range</h3>--%>
<%--                      <form action="#">--%>
<%--                        <div class="row">--%>
<%--                          <div class="col-xl-6 mb-3">--%>
<%--                            <label for="Check-In">From</label>--%>

<%--                            <input class="form-control" id="datepicker" placeholder="From" readonly />--%>
<%--                          </div>--%>
<%--                          <div class="col-xl-6 mb-3">--%>
<%--                            <label for="Check-Out">To</label>--%>

<%--                            <input class="form-control" id="datepicker2" placeholder="To" readonly />--%>
<%--                          </div>--%>

<%--                        </div>--%>
<%--                      </form>--%>
<%-- &ndash;%&gt;--%>
<%--                        <form:input path="checkedIn" type="hidden" class="form-control" id="checkedIn" name="checkedIn"--%>
<%--                          value="0" readonly="true"></form:input>--%>
<%--                        <form:input path="checkedOut" type="hidden" class="form-control" id="checkedOut"--%>
<%--                          name="checkedOut" value="0" readonly="true"></form:input>--%>
<%--                        <div class="room-type" id="payUnit">--%>
<%--                          <label for="dutyRooms">Distribution License</label>--%>
<%--                          <div class="input-group">--%>
<%--                            <form:select id="division" class="form-control" path="division" >--%>
<%--                              <form:option value="NONE" label="<<select>>" />--%>
<%--<form:option value="DD1" label="Distribution Division 1" />--%>
<%--<form:option value="DD2" label="Distribution Division 2" />--%>
<%--<form:option value="DD3" label="Distribution Division 3" />--%>
<%--<form:option value="DD4" label="Distribution Division 4" />--%>
<%--<form:option value="LECO" label="LECO" />--%>

<%--                              <form:options items="${model.payingList}" />--%>
<%--                            </form:select>--%>
<%--                          </div>--%>
<%--                          <!-- <div class="col-xl-12 mb-3 mt-2 center ">--%>
<%--                            <button class="boxed-btn3" id="booking_btn" onclick="requestreport()">--%>
<%--                              Upload--%>
<%--                            </button>--%>
<%--                          </div> -->--%>
<%--                        </div>--%>
<%--                    --%>
<%--                    <div class="room-type" id="payUnit">--%>
<%--                          <label for="dutyRooms">Province</label>--%>
<%--                          <div class="input-group">--%>
<%--                            <form:select id="province" class="form-control" path="province" onkeypress="">--%>
<%--                              <form:option value="NONE" label="<<select>>" />--%>
<%--<form:option value="WPS1L" label="LECO REGION WPS 1" />--%>
<%--<form:option value="WPS2L" label="LECO REGION WPS 2" />--%>
<%--<form:option value="WPNL" label="LECO REGION WPN" />--%>
<%--<form:option value="SP1L" label="LECO REGION SP1" />--%>

<%--                              <form:options items="${model.provinceList}" />--%>
<%--                            </form:select>--%>
<%--                          </div>--%>
<%--                          <!-- <div class="col-xl-12 mb-3 mt-2 center ">--%>
<%--                            <button class="boxed-btn3" id="booking_btn" onclick="requestreport()">--%>
<%--                              Upload--%>
<%--                            </button>--%>
<%--                          </div> -->--%>
<%--                        </div>--%>
<%--                    &lt;%&ndash;  <div class="room-type" id="payUnit">--%>
<%--                          <label for="dutyRooms">Distribution License</label>--%>
<%--                          <div class="input-group">--%>
<%--                            <form:select id="province" class="form-control" path="province" onkeypress="">--%>
<%--                              <form:option value="NONE" label="<<select>>" />--%>
<%--<form:option value="WPS1L" label="LECO REGION WPS 1" />--%>
<%--<form:option value="WPS2L" label="LECO REGION WPS 2" />--%>
<%--<form:option value="WPNL" label="LECO REGION WPN" />--%>
<%--<form:option value="SP1L" label="LECO REGION SP1" />--%>

<%--                              <form:options items="${model.payingList}" />--%>
<%--                            </form:select>--%>
<%--                          </div>--%>
<%--                          <!-- <div class="col-xl-12 mb-3 mt-2 center ">--%>
<%--                            <button class="boxed-btn3" id="booking_btn" onclick="requestreport()">--%>
<%--                              Upload--%>
<%--                            </button>--%>
<%--                          </div> -->--%>
<%--                        </div>--%>
<%-- &ndash;%&gt;                        --%>
<%--                        <div class="room-type" id="payUnit">--%>
<%--                          <label for="dutyRooms">Area</label>--%>
<%--                          <div class="input-group">--%>
<%--                            <form:select id="area" class="form-control" path="area" onkeypress="">--%>
<%--                              <form:option value="NONE" label="<<select>>" />--%>
<%--<form:option value="DIVULA" label="DIVULAPITIYA" />--%>
<%--<form:option value="GAMPAH" label="GAMPAHA" />--%>
<%--<form:option value="JAELA" label="JA-ELA" />--%>
<%--<form:option value="KELANI" label="KELANIYA" />--%>
<%--<form:option value="KIRIND" label="KIRINDIWELA" />--%>
<%--<form:option value="NEGOMB" label="NEGOMBO" />--%>
<%--<form:option value="VEYANG" label="VEYANGODA" />--%>


<%--                              <form:options items="${model.payingList}" />--%>
<%--                            </form:select>--%>
<%--                          </div>--%>
<%--                          <!-- <div class="col-xl-12 mb-3 mt-2 center ">--%>
<%--                            <button class="boxed-btn3" id="booking_btn" onclick="requestreport()">--%>
<%--                              Upload--%>
<%--                            </button>--%>
<%--                          </div> -->--%>
<%--                        </div>--%>
<%--                        --%>
<%--                         <div class="room-type" id="payUnit">--%>
<%--                          <label for="dutyRooms">Grid</label>--%>
<%--                          <div class="input-group">--%>
<%--                            <form:select id="grid" class="form-control" path="grid" onkeypress="">--%>
<%--                              <form:option value="NONE" label="<<select>>" />--%>
<%--<form:option value="NEG-BMT" label="Boundary Meters" />--%>
<%--<form:option value="NEG-NEG" label="Negombo" />--%>
<%--<form:option value="NEG-KAT" label="Katunayaka" />--%>
<%--<form:option value="NEG-PRI" label="KALUTARA" />--%>
<%--<form:option value="NEG-MUN" label="Munnakkarei BM" />--%>
<%--<form:option value="NEG-BBB" label="Browns Beach BM" />--%>


<%--                              <form:options items="${model.payingList}" />--%>
<%--                            </form:select>--%>
<%--                          </div>--%>
<%--                          <!-- <div class="col-xl-12 mb-3 mt-2 center ">--%>
<%--                            <button class="boxed-btn3" id="booking_btn" onclick="requestreport()">--%>
<%--                              Upload--%>
<%--                            </button>--%>
<%--                          </div> -->--%>
<%--                        </div>--%>
<%--                        --%>
<%--                        <div class="room-type" id="payUnit">--%>
<%--                          <label for="dutyRooms">Meter Points</label>--%>
<%--                          <div class="input-group">--%>
<%--                            <form:select id="meterpoint" class="form-control" path="meterpoint" onkeypress="">--%>
<%--                              <form:option value="NONE" label="<<select>>" />--%>
<%--<form:option value="211279868" label="Munnakkarei BM" />--%>


<%--                              <form:options items="${model.payingList}" />--%>
<%--                            </form:select>--%>
<%--                          </div>--%>
<%--                          <!-- <div class="col-xl-12 mb-3 mt-2 center ">--%>
<%--                            <button class="boxed-btn3" id="booking_btn" onclick="requestreport()">--%>
<%--                              Upload--%>
<%--                            </button>--%>
<%--                          </div> -->--%>
<%--                        </div>--%>
<%--                        --%>
<%--                        --%>
<%--                        <div class="room-type" id="payUnit">--%>
<%--                          <label for="dutyRooms">File Type</label>--%>
<%--                          <div class="input-group">--%>
<%--                            <form:select id="filetype" class="form-control" path="filetype" onkeypress="">--%>
<%--                            <form:option value="NONE" label="<<select>>" />--%>
<%--                              <form:option value="LOAD_PROFILE" label="LOAD PROFILE" />--%>
<%--<form:option value="ENERGY_PROFILE" label="ENERGY PROFILE" />--%>


<%--                              <form:options items="${model.payingList}" />--%>
<%--                            </form:select>--%>
<%--                          </div>--%>
<%--                           <!-- <div class="col-xl-12 mb-3 mt-2 center ">--%>
<%--                            <button class="boxed-btn3" id="booking_btn" onclick="requestreport()">--%>
<%--                              Upload--%>
<%--                            </button>--%>
<%--                          </div> --> --%>
<%--                        </div>--%>
<%--                        --%>
<%--                        <div class="room-type" id="payUnit">--%>
<%--                          <label for="dutyRooms">Bill Cycle</label>--%>
<%--                          <div class="input-group">--%>
<%--                            <form:select id="metercycle" class="form-control" path="metercycle" onkeypress="">--%>
<%--                              <form:option value="437" label="437" />--%>
<%--							  --%>

<%--                              <form:options items="${model.payingList}" />--%>
<%--                            </form:select>--%>
<%--                          </div>--%>
<%--                           <!-- <div class="col-xl-12 mb-3 mt-2 center ">--%>
<%--                            <button type ="submit" class="boxed-btn3" id="booking_btn" onclick="">--%>
<%--                              Upload--%>
<%--                            </button>--%>
<%--                          </div> --> --%>
<%--                        </div>--%>
<%--                        --%>
<%--                         <div class="room-type" id="payUnit">--%>
<%--                          <label for="dutyRooms">Select File</label>--%>
<%--                          <div class="input-group">--%>
<%--                            <input  type="file" name="files" multiple>--%>
<%--																                          </div>--%>
<%--                           <div class="col-xl-12 mb-3 mt-2 center ">--%>
<%--                            <input type="submit" class="boxed-btn3" id="booking_btn" onclick="submitForm()" value="Upload">--%>

<%--                          </div> --%>
<%--                        </div>--%>
<%--                        --%>
<%--                        --%>
<%--                    --%>
<%--                  </div>--%>
<%--                </div>--%>
<%--                </form:form>--%>
<%--                --%>
<%--              </div>--%>
<%--            </div>--%>
<%--          </div>--%>


<%--        </div>--%>
<%--        --%>
<%--        <div class="d-none d-sm-block mb-5 pb-4"> --%>
<%--                    <!---------------- map ------------>--%>
<%--                    <div id="map_container"></div>--%>
<%--                </div>--%>
<%--           --%>
<%--        <!-- <div class="card"--%>
<%--          style="width: 50%; box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2); background-color: #fafafa; margin: 0 auto;">--%>
<%--          <div class="card-body" style="padding: 20px;">--%>
<%--            <h5 class="card-title" style="font-size: 2em; font-weight: bold;">Total Price: Rs.</h5>--%>
<%--            <h1 id="totalPriceCard" class="card-text"></h1>--%>
<%--            <h3>Note: If the reservation is successful, <span id="totalPriceCard" class="card-text"></span> will be charged from your salary or pension.</h3>--%>
<%--          </div>--%>
<%--        </div>--%>
<%--         -->--%>


<%--        <!-- Bootstrap JS and Popper.js (order matters) -->--%>
<%--        <!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script> -->--%>
<%--        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>--%>
<%--        <!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script> -->--%>

<%--        <!-- FullCalendar JS -->--%>
<%--        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>--%>
<%--        <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.0/fullcalendar.min.js"></script>--%>

<%--        <!-- footer -->--%>
<%--        <footer class="footer">--%>
<%--          <div class="footer_top">--%>
<%--            <div class="container">--%>
<%--              <div class="row">--%>
<%--                <div class="col-xl-4 col-md-4 col-lg-4"--%>
<%--                  style="display: flex; flex-direction: column; align-items: left;">--%>
<%--                  <div class="footer_widget">--%>
<%--                    <h3 class="footer_title" style="text-align: left;">--%>
<%--                      address--%>
<%--                    </h3>--%>
<%--                    <p class="footer_text"> 50 Sir Chittampalam A Gardiner Mawatha Colombo--%>
<%--                      00200,--%>
<%--                      00700</p>--%>
<%--                    <a href="contact" class="line-button">Get Direction</a>--%>
<%--                  </div>--%>
<%--                </div>--%>
<%--                <div class="col-xl-4 col-md-4 col-lg-4"--%>
<%--                  style="display: flex; flex-direction: column; align-items: left;">--%>
<%--                  <div class="footer_widget" style="text-align: left;">--%>
<%--                    <h3 class="footer_title">--%>
<%--                      Reservation--%>
<%--                    </h3>--%>
<%--                    <p class="footer_text">+94 112 451 098<br>--%>
<%--                      wm@ceb.lk</p>--%>
<%--                  </div>--%>
<%--                </div>--%>
<%--                <div class="col-xl-4 col-md-4 col-lg-4"--%>
<%--                  style="display: flex; flex-direction: column; align-items: left;">--%>
<%--                  <div class="footer_widget" style="text-align: left;">--%>
<%--                    <h3 class="footer_title">--%>
<%--                      Navigation--%>
<%--                    </h3>--%>
<%--                    <ul style="list-style: none; padding: 0; text-align: left;">--%>
<%--                      <li><a href="WelcomeCBRS">Home &nbsp;<i style="font-size: 20px;"--%>
<%--                                                                class="fa fa-home fa-lg"></i></a></li>--%>

<%--                                                    <li><a href="admindashboard" id="goBackLink2">Admin Dashboard--%>
<%--                                                            &nbsp;<i style="font-size: 20px;"--%>
<%--                                                                class="fa fa-user fa-lg"></i></a></li>--%>

<%--                                                    <li><a href="AdminCBRS">LogOut &nbsp;<i style="font-size: 20px;"--%>
<%--                                                                class="fa fa-sign-out fa-lg"></i></a></li>--%>
<%--                 </ul>--%>
<%--                  </div>--%>
<%--                </div>--%>

<%--              </div>--%>
<%--            </div>--%>
<%--          </div>--%>
<%--          </div>--%>
<%--          <div class="copy-right_text">--%>
<%--            <div class="container">--%>
<%--              <div class="footer_border"></div>--%>
<%--              <div class="row">--%>
<%--                <div class="col-xl-8 col-md-7 col-lg-9">--%>
<%--                  <p class="copy_right">--%>
<%--                    Copyright &copy;--%>
<%--                    <script>--%>
<%--                      document.write(new Date().getFullYear());--%>
<%--                    </script>--%>
<%--                    All rights reserved | <a href="https://www.ceb.lk" target="_blank"> Ceylon--%>
<%--                      Electricity Board</a>--%>
<%--                  </p>--%>
<%--                </div>--%>

<%--              </div>--%>
<%--            </div>--%>
<%--          </div>--%>
<%--        </footer>--%>
<%--        <script src="js/jquery.slicknav.min.js"></script>--%>

<%--        <!--contact js-->--%>
<%--        <script src="js/contact.js"></script>--%>
<%--        <script src="js/jquery.ajaxchimp.min.js"></script>--%>
<%--        <script src="js/jquery.form.js"></script>--%>
<%--        <script src="js/jquery.validate.min.js"></script>--%>
<%--        <script src="js/mail-script.js"></script>--%>
<%--        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>--%>
<%--        <script src="js/main.js"></script>--%>

<%--        <script>--%>

<%--          $(document).ready(function () {--%>
<%--            $.ajax({--%>
<%--              // url: 'https://worldtimeapi.org/api/timezone/Etc/UTC',--%>
<%--              url: '/CBRS/returnServerTime',--%>
<%--              success: function (data) {--%>
<%--                // Parse the received date and time from the API--%>
<%--                //var today = new Date(data.datetime);--%>
<%--                // let textData = JSON.stringify(data);--%>


<%--                var today = new Date(data);--%>

<%--                // Initialize the datepicker with the real current date--%>
<%--                $("#datepicker").datepicker({--%>

<%--                  dateFormat: "dd-M-yy",--%>
<%--                  onSelect: function (date) {--%>
<%--                    var selectedDate = new Date(date);--%>

<%--                    // make the check availability button clickable only when check-in date is selected--%>
<%--                    $('button[type="submit"]').prop('disabled', false);--%>
<%--                    $('button[type="submit"]').removeClass('btn_unavailable');--%>

<%--                    $("#datepicker2").datepicker("setDate", selectedDate);--%>
<%--                    $("#datepicker2").datepicker("option", "disabled", false);--%>


<%--                  },--%>
<%--                });--%>

<%--                $("#datepicker2").datepicker({--%>
<%--                  dateFormat: "dd-M-yy",--%>
<%--                  disabled: true,--%>
<%--                });--%>
<%--              }--%>
<%--            });--%>


<%--          });--%>

<%--        </script>--%>
<%--        </script>--%>
<%--        <script>--%>
<%--          function requestreport() {--%>
<%--            var fromDate = $("#datepicker").val();--%>
<%--            var toDate = $("#datepicker2").val();--%>
<%--            var circuit =document.getElementById('payingUnit').value;--%>
<%--            document.getElementById('checkedIn').value = fromDate;--%>
<%--            document.getElementById('checkedOut').value = toDate;--%>

<%--            //document.getElementById('myForm').submit();--%>
<%--            --%>
<%--            --%>
<%--             var url="downloadCBRSReport?date1="+fromDate+"&date2="+toDate+"&circuit="+circuit;--%>
<%-- 	    	 var width = 1100;--%>
<%-- 	    	 var height = 700;--%>
<%-- 	    	 var left = parseInt((screen.availWidth/2) - (width/2));--%>
<%-- 	    	 var top = parseInt((screen.availHeight/2) - (height/2));--%>
<%-- 	     	 var windowFeatures = "width=" + width + ",height=" + height + --%>
<%-- 	    	 ",status,resizable,left=" + left + ",top=" + top +--%>
<%-- 	    	 "screenX=" + left + ",screenY=" + top + ",scrollbars=yes";--%>
<%-- 	    	 window.open(url, "subWind", windowFeatures, "POS");//window.open(url,"_blank","directories=no, status=no,width=1000, height=700,top=50,left=50", "scrollbars=1");--%>
<%-- 	    //myWindow.document.write("<p>This is 'MsgWindow'. I am 200px wide and 100px tall!</p>");--%>
<%--            --%>
<%--          }--%>
<%--          --%>
<%--          function submitForm(){--%>
<%--        	  alert("hiii");--%>
<%--        	  document.getElementById('myForm').submit();--%>
<%--        	  --%>
<%--          }--%>

<%--        </script>--%>


<%--        <script>--%>
<%--          window.onload = updateDateTime();--%>
<%--          /* function updateDateTime() {--%>
<%--            var current_Date = new Date();--%>
<%--            var formattedDatetimeDisplay = current_Date.toLocaleString();--%>
<%--            document.getElementById('datetimeDisplay').innerHTML = formattedDatetimeDisplay;--%>
<%--          } */--%>

<%--          function updateDateTime() {--%>
<%--            $.ajax({--%>
<%--              type: 'GET',--%>
<%--              url: '/CBRS/returnServerDateString',--%>
<%--              data: {},--%>
<%--              contentType: "application/json; charset=utf-8",--%>
<%--              success: function (json) {--%>
<%--                document.getElementById('datetimeDisplay').innerHTML = json;--%>
<%--              }--%>
<%--            });--%>
<%--          }--%>
<%--          setInterval(updateDateTime, 1000);--%>

<%--          /* fetch('/CBRS/returnServerDateString')--%>
<%--            .then(response => response.json())--%>
<%--            .then(data => {--%>
<%--              //var formattedDatetimeDisplay = new Date(data.datetime);--%>
<%--              //var formattedDatetimeDisplay = new Date(data);--%>
<%--              //document.getElementById('datetimeDisplay').innerHTML = formattedDatetimeDisplay.toLocaleString();--%>
<%--              document.getElementById('datetimeDisplay').innerHTML = data;--%>
<%--                --%>
<%--            })--%>
<%--            .catch(error => console.error('Error fetching time:', error));--%>
<%--        } */--%>

<%--        </script>--%>






<%--      </body>--%>

<%--      </html>--%>

<%--      </html>--%>