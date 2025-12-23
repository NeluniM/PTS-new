<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>Power Trading System</title>
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- IMPORTANT: make all relative URLs (img/css/js) start from app root -->
    <base href="${pageContext.request.contextPath}/" />

    <!-- Include jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <!-- Include jQuery UI (same as other pages) -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="img/favicon.png" />

    <!-- CSS here (IDENTICAL to other working pages) -->
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/owl.carousel.min.css" />
    <link rel="stylesheet" href="css/magnific-popup.css" />
    <link rel="stylesheet" href="css/font-awesome.min.css" />
    <link rel="stylesheet" href="css/themify-icons.css" />
    <link rel="stylesheet" href="css/nice-select.css" />
    <link rel="stylesheet" href="css/flaticon.css" />
    <link rel="stylesheet" href="css/gijgo.css" />
    <link rel="stylesheet" href="css/animate.css" />
    <link rel="stylesheet" href="css/slicknav.css" />
    <link rel="stylesheet" href="css/style.css" />
    <link href="//fonts.googleapis.com/css?family=Open+Sans:400,600,700,300|Titillium+Web:200,300,400"
          rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.0/fullcalendar.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">

    <style>
        .meter-form-wrapper {
            max-width: 900px;
            margin: 20px auto 60px auto;
        }
        <style>
         .meter-form-wrapper {
             max-width: 900px;
             margin: 20px auto 60px auto;
         }

        /* ? Red button style (same as tariff Save button) */
        .btn-red {
            background-color: #7D0000 !important;
            border-color: #7D0000 !important;
            color: #ffffff !important;
        }
        .btn-red:hover {
            background-color: #B31900 !important;
            border-color: #B31900 !important;
            color: #ffffff !important;
        }
    </style>

    </style>
</head>

<body>

<!-- HEADER -->
<jsp:include page="../../common/header.jsp" />

<div style="min-height: 850px;">

    <jsp:include page="../../common/navLisenceeBilling.jsp">
        <jsp:param name="activeSelection" value="Meter Management"/>
        <jsp:param name="description" value="Meter Install / Update"/>
    </jsp:include>

    <!-- PAGE CONTENT -->
    <div class="container mt-4 meter-form-wrapper">

        <!-- ACTION BUTTONS -->
        <div class="mb-4">
            <!-- UPDATED BUTTON: Redirect to dedicated installation page -->
            <button type="button" class="btn btn-red" style="margin-right: 20px;"
                    onclick="window.location.href='meterManagement/installMeter'">
                Install New Meter
            </button>


        </div>

        <!-- REMOVED FORM FROM THIS PAGE -->

    </div>
</div>

<!-- FOOTER -->
<jsp:include page="../../common/footer.jsp" />

<!-- JS (same block as your working pages) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.0/fullcalendar.min.js"></script>

<script src="js/jquery.slicknav.min.js"></script>

<!-- contact js -->
<script src="js/contact.js"></script>
<script src="js/jquery.ajaxchimp.min.js"></script>
<script src="js/jquery.form.js"></script>
<script src="js/jquery.validate.min.js"></script>
<script src="js/mail-script.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<script src="js/main.js"></script>

</body>
</html>
