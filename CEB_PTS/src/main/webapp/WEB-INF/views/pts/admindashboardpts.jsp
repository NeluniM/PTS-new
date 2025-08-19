<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <html class="no-js" lang="zxx">

            <head>
                <meta charset="utf-8">
                <meta http-equiv="x-ua-compatible" content="ie=edge">
                <title>Power Trading System</title>
                <meta name="description" content="">
                <meta name="viewport" content="width=device-width, initial-scale=1">

                <!-- <link rel="manifest" href="site.webmanifest"> -->
                <link rel="shortcut icon" type="image/x-icon" href="img/favicon.png">


                <!-- CSS here -->
                <link rel="stylesheet" href="css/bootstrap.min.css">
                <link rel="stylesheet" href="css/owl.carousel.min.css">
                <link rel="stylesheet" href="css/magnific-popup.css">
                <link rel="stylesheet" href="css/font-awesome.min.css">
                <link rel="stylesheet" href="css/themify-icons.css">
                <link rel="stylesheet" href="css/nice-select.css">
                <link rel="stylesheet" href="css/flaticon.css">
                <link rel="stylesheet" href="css/gijgo.css">
                <link rel="stylesheet" href="css/animate.css">
                <link rel="stylesheet" href="css/slicknav.css">
                <link rel="stylesheet" href="css/style.css">
                <!-- <link rel="stylesheet" href="css/responsive.css"> -->

                <link href='//fonts.googleapis.com/css?family=Open+Sans:400,600,700,300|Titillium+Web:200,300,400'
                    rel='stylesheet' type='text/css'>

                <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
                <!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"> -->


                <style>
                    body {
                        font-family: Arial, sans-serif;
                        background-color: black;

                    }

                    h2 {
                        margin-bottom: 20px;
                    }

                    .custom-card {
                        height: 100%;
                        border: 1px solid #ddd;
                        border-radius: 10px;
                        overflow: hidden;
                        transition: all 0.3s ease;
                    }


                    .custom-card:hover {
                        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
                        transform: scale(1.05);
                    }


                    .custom-card .card-title {
                        font-size: 18px;
                        font-weight: bold;
                        color: #333;
                        margin-bottom: 10px;
                    }


                    .custom-card .card-text {
                        font-size: 16px;
                        color: #666;
                    }


                   .custom-card .icon {
                       display: flex;
                       align-items: center;
                       justify-content: center;
                       height: 10px;
                       width: 10px;
                   }


                    .custom-card .btn {
                        margin-top: auto;
                        width: 80%;
                        background-color: #007bff;
                        color: #fff;
                        border: none;
                        border-radius: 5px;
                        padding: 10px 15px;
                        text-align: center;
                        text-decoration: none;
                        display: block;
                        transition: background-color 0.3s ease;
                    }


                    .custom-card .btn:hover {
                        background-color: #0056b3;
                    }


                    .custom-card .btn i {
                        margin-right: 5px;
                    }


                    .custom-card .card-body {
                        display: flex;
                        flex-direction: column;
                        align-items: center;
                        justify-content: center;
                        height: 100%;
                    }
                </style>



            </head>

            <body>
                <!-- header-start -->
                <header>
                    <div class="header-area">
                        <div id="sticky-header" class="main-header-area">
                            <div class="container-fluid p-0">
                                <div class="row align-items-center no-gutters">
                                    <div class="col-xl-5 col-lg-6">
                                        <div class="main-menu d-none d-lg-block">
                                            <nav>

                                                <ul id="navigation">


                                                    <li><a href="WelcomePTS">Home</a></li>
                                                    
                                                    <!-- <li><a href="AdminCBRS">LogOut</a></li>  -->
                                                    <li><a href="WelcomePTS">LogOut &nbsp;<i style="font-size: 20px;"
                                                                class="fa fa-sign-out fa-lg"></i></a></li>

                                                </ul>
                                            </nav>
                                        </div>
                                    </div>

                                    <!-- <div class="col-xl-5 col-lg-4 text-right">
                                        <div class="main-menu d-none d-lg-block">
                                            <nav>
                                                <ul id="navigation">
                                                    <li><a href="AdminCBRS"><i style="font-size: 20px;" class="fa fa-sign-out fa-lg"></i></a></li>
                                                </ul>
                                            </nav>
                                        </div>
                                    </div> -->

                                    <div class="col-xl-2 col-lg-2">
                                        <div class="logo-img">
                                            <a href="WelcomePTS">
                                                <img src="img/logo.png" alt="" />
                                            </a>
                                        </div>
                                    </div>

                                    <div class="col-12">
                                        <div class="mobile_menu d-block d-lg-none"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </header>
                <!-- header-end -->

                <!-- bradcam_area_start -->
                <div class="new_admindashboard_bradcam_area new_admindashboard_bg"
                     style="padding-top: 170px; padding-bottom: 100px; height:140vh;">
                    <h1>Power Trading System</h1>
                    <!-- </div> ${model.epf}</div> -->
                    <div class="container" style="margin-top: 30px;">

                        <div class="row">
                            <div class="col-lg-3 col-md-5 mb-4">
                                <a href="uploadFile">
                                    <div class="card h-100 custom-card">
                                        <div class="card-body d-flex flex-column align-items-center">
                                            <div class="icon-container mb-3">
                                                <img src="./icons/uploadfile.svg" alt="Upload Icon" style="width: 85px; height: 85px;">
                                            </div>
                                            <div class="text-center">
                                                <h4 class="card-title">Upload Meter Points</h4>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class="col-lg-3 col-md-5 mb-4">
                                <a href="licenseBillingHome">
                                    <div class="card h-100 custom-card">
                                        <div class="card-body d-flex flex-column align-items-center">
                                            <div class="icon-container mb-3">
                                                <img src="./icons/view.svg" alt="View Icon" style="width: 85px; height: 85px;">
                                            </div>
                                            <div class="text-center">
                                                <h4 class="card-title">View Upload Meter Points</h4>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>

                            <div class="col-lg-3 col-md-5 mb-4">
                                <a href="processMeterReading">
                                    <div class="card h-100 custom-card">
                                        <div class="card-body d-flex flex-column align-items-center">
                                            <div class="icon-container mb-3">
                                                <img src="./icons/process.svg" alt="Process Icon" style="width: 85px; height: 85px;">
                                            </div>
                                            <div class="text-center">
                                                <h4 class="card-title">Process Meter Reading</h4>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>

                            <div class="col-lg-3 col-md-5 mb-4">
                                <a href="viewMeterReading">
                                    <div class="card h-100 custom-card">
                                        <div class="card-body d-flex flex-column align-items-center">
                                            <div class="icon-container mb-3">
                                                <img src="./icons/view.svg" alt="Search Icon" style="width: 85px; height: 85px;">
                                            </div>
                                            <div class="text-center">
                                                <h4 class="card-title">View Meter Readings</h4>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <!--  <div class="col-lg-4 col-md-6 mb-4">
                                <div class="card h-100 custom-card">
                                    <div class="card-body d-flex flex-column align-items-center">
                                        <h5 class="card-title">Area Engineer Approvals</h5>
                                        <p class="card-text">Manage Area Engineer(Duty Room Authority) Approvals</p>
                                        <a href="dutyApprovalArea" class="btn btn-primary">Approvals</a>
                                    </div>
                                </div>
                            </div> -->
                            <!-- <div class="col-lg-4 col-md-6 mb-4">
                                <div class="card h-100 custom-card">
                                    <div class="card-body d-flex flex-column align-items-center">
                                        <h5 class="card-title">Reports Viewing</h5>
                                        <p class="card-text">Review reports only by the Area Engineer(Duty Room Authority)</p>
                                        <a href="payingreports" class="btn btn-primary">Reports</a>
                                    </div>
                                </div>
                            </div>
 -->
<%-- <c:if test="${sessionScope.isAdminUser}">
<div class="col-lg-4 col-md-6 mb-4">
                                <div class="card h-100 custom-card">
                                    <div class="card-body d-flex flex-column align-items-center">
                                        <h5 class="card-title">Reports Viewing - Reservations of a Circuit Bungalow</h5>
                                        <p class="card-text">Review reports only by the Admin</p>
                                        <a href="payingreportsAdmin" class="btn btn-primary">Reports</a>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-lg-4 col-md-6 mb-4">
                                <div class="card h-100 custom-card">
                                    <div class="card-body d-flex flex-column align-items-center">
                                        <h5 class="card-title">Reports Viewing - Finalized Reservations for a Circuit Bungalow - Pay Units</h5>
                                        <p class="card-text">Review reports only by the Admin</p>
                                        <a href="payingreportsAdmin2" class="btn btn-primary">Reports</a>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-lg-4 col-md-6 mb-4">
                                <div class="card h-100 custom-card">
                                    <div class="card-body d-flex flex-column align-items-center">
                                        <h5 class="card-title">Reports Viewing - Cancellation of Reservations for a Circuit Bungalow - Pay Units</h5>
                                        <p class="card-text">Review reports only by the Admin</p>
                                        <a href="payingreportsAdmin3" class="btn btn-primary">Reports</a>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-lg-4 col-md-6 mb-4">
                                <div class="card h-100 custom-card">
                                    <div class="card-body d-flex flex-column align-items-center">
                                        <h5 class="card-title">Reports Viewing -Cancellation of Reservations for Circuit Bungalows</h5>
                                        <p class="card-text">Review reports only by the Admin</p>
                                        <a href="payingreportsAdmin4" class="btn btn-primary">Reports</a>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-lg-4 col-md-6 mb-4">
                                <div class="card h-100 custom-card">
                                    <div class="card-body d-flex flex-column align-items-center">
                                        <h5 class="card-title">Reports Viewing -Circuit Bangalow Attendance Status </h5>
                                        <p class="card-text">Review reports only by the Admin</p>
                                        <a href="payingreportsAttendence" class="btn btn-primary">Reports</a>
                                    </div>
                                </div>
                            </div>
                            
                            
                            
                            
                            <div class="col-lg-4 col-md-6 mb-4">
                                <div class="card h-100 custom-card">
                                    <div class="card-body d-flex flex-column align-items-center">
                                        <h5 class="card-title">Manage Circuit</h5>
                                        <p class="card-text">Manage Circuit Related Details only by the Admin</p>
                                        <a href="manageCircuit" class="btn btn-primary">Manage Circuit</a>
                                    </div>
                                </div>
                            </div>
                            

</c:if> --%>

                             <%-- <c:if test="${sessionScope.isSuperUser || sessionScope.isSecondaryUser}">

                            <div class="col-lg-4 col-md-6 mb-4">
                                <div class="card h-100 custom-card">
                                    <div class="card-body d-flex flex-column align-items-center">
                                        <h5 class="card-title">Register Pensioners</h5>
                                        <p class="card-text">Register new pensioners into the system</p>
                                        <a href="regPensioners" class="btn btn-primary">Register Now</a>
                                    </div>
                                </div>
                            </div>

                            </c:if>
 --%>                            
                            <%-- <c:if test="${sessionScope.isSuperUser || sessionScope.isTertiaryUser}">

                            <div class="col-lg-4 col-md-6 mb-4">
                                <div class="card h-100 custom-card">
                                    <div class="card-body d-flex flex-column align-items-center">
                                        <h5 class="card-title">View Pensioners Details</h5>
                                        <p class="card-text">View Pensioners Details</p>
                                        <a href="availabilityPensioners" class="btn btn-primary">View Pensioners Details</a>
                                    </div>
                                </div>
                            </div>

                            </c:if>
                            
 --%> 
<%--                             <c:if test="${sessionScope.isSuperUser}">

                            <div class="col-lg-4 col-md-6 mb-4">
                                <div class="card h-100 custom-card">
                                    <div class="card-body d-flex flex-column align-items-center">
                                        <h5 class="card-title">Admin Bookings</h5>
                                        <p class="card-text">Booking made by the admin</p>
                                        <a href="#" class="btn btn-primary" onclick="openADMbookingModal()">Admin
                                            Bookings</a>

                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-lg-4 col-md-6 mb-4">
                                <div class="card h-100 custom-card">
                                    <div class="card-body d-flex flex-column align-items-center">
                                        <h5 class="card-title">Outside Bookings</h5>
                                        <p class="card-text">Outside booking made by the admin</p>
                                        <a href="#" class="btn btn-primary" onclick="openOutsiderbookingModal()">Outside Bookings</a>
                                    </div>
                                </div>
                            </div>
 
                            <div class="modal" id="outsiderModal" tabindex="-1" role="dialog">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Select a Bungalow</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <form:form id="outsidercircuitForm" action="outsiderbooking" method="post"
                                                modelAttribute="cbrsModel">
                                                <ul id="circuitSelect">
                                                    <c:forEach var="circuit" items="${model.circuitList}">
                                                        <li>
                                                            <div style="cursor: pointer;"
                                                                onclick="selectoutsiderCircuit('${circuit[1]}')">
                                                                ${circuit[0]}
                                                        </div>
                                                        </li>
                                                        <hr>
                                                    </c:forEach>
                                                </ul>
                                                <input type="hidden" id="outsideCircuitCode" name="circuitcode"
                                                    value="">

                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            

                            <div class="modal" id="reviewModal" tabindex="-1" role="dialog">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Select a Bungalow</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <form:form id="circuitForm" action="adminbooking" method="post"
                                                modelAttribute="cbrsModel">
                                                <ul id="circuitSelect">
                                                    <c:forEach var="circuit" items="${model.circuitList}">
                                                        <li>
                                                            <div style="cursor: pointer;"
                                                                onclick="selectCircuit('${circuit[1]}')">
                                                                ${circuit[0]}
                                                        </div>
                                                        </li>
                                                        <hr>
                                                    </c:forEach>
                                                </ul>
                                                <input type="hidden" id="selectedCircuitCode" name="circuitcode"
                                                    value="">

                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-6 mb-4">
                                <div class="card h-100 custom-card">
                                    <div class="card-body d-flex flex-column align-items-center">
                                        <h5 class="card-title">Outside Bookings</h5>
                                        <p class="card-text">Outside booking made by the admin</p>
                                        <a href="#" class="btn btn-primary">Outside Bookings</a>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-4 col-md-6 mb-4">
                                <div class="card h-100 custom-card">
                                    <div class="card-body d-flex flex-column align-items-center">
                                        <h5 class="card-title">Circuit Closing</h5>
                                        <p class="card-text">Circuit Closing done by the admin</p>
                                        <a href="circuitClosing" class="btn btn-primary">Circuit Closing</a>
                                    </div>
                                </div>
                            </div>


                            <div class="col-lg-4 col-md-6 mb-4">
                                <div class="card h-100 custom-card">
                                    <div class="card-body d-flex flex-column align-items-center">
                                        <h5 class="card-title">Reports Viewing</h5>
                                        <p class="card-text">Review reports by the admin</p>
                                        <a href="payingreports" class="btn btn-primary">Reports</a>
                                    </div>
                                </div>
                            </div>

                        </c:if>

 --%>

                        </div>

                    </div>
                </div>
<!-- JS here -->
<script src="js/vendor/modernizr-3.5.0.min.js"></script>
<script src="js/vendor/jquery-1.12.4.min.js"></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/isotope.pkgd.min.js"></script>
<script src="js/ajax-form.js"></script>
<script src="js/waypoints.min.js"></script>
<script src="js/jquery.counterup.min.js"></script>
<script src="js/imagesloaded.pkgd.min.js"></script>
<script src="js/scrollIt.js"></script>
<script src="js/jquery.scrollUp.min.js"></script>
<script src="js/wow.min.js"></script>
<script src="js/nice-select.min.js"></script>
<script src="js/jquery.slicknav.min.js"></script>
<script src="js/jquery.magnific-popup.min.js"></script>
<script src="js/plugins.js"></script>
<script src="js/gijgo.min.js"></script>

<!--contact js-->
<script src="js/contact.js"></script>
<script src="js/jquery.ajaxchimp.min.js"></script>
<script src="js/jquery.form.js"></script>
<script src="js/jquery.validate.min.js"></script>
<script src="js/mail-script.js"></script>

<script src="js/main.js"></script>

<script>
    function openADMbookingModal() {
        $('#reviewModal').modal('show');
    }

    function selectCircuit(circuitCode) {
        document.getElementById('selectedCircuitCode').value = circuitCode;
        document.getElementById('circuitForm').submit();
    }

    function openOutsiderbookingModal() {
        $('#outsiderModal').modal('show');
    }

    function selectoutsiderCircuit(circuitCode) {
        document.getElementById('outsideCircuitCode').value = circuitCode;
        document.getElementById('outsidercircuitForm').submit();
    }
</script>
                
<%--                <script>--%>
<%--        let sessionTimeout =10 * 60 * 1000; // 30 minutes in milliseconds--%>
<%--        let timeoutHandle;--%>

<%--        function resetTimeout() {--%>
<%--            clearTimeout(timeoutHandle);--%>
<%--            timeoutHandle = setTimeout(() => {--%>
<%--                alert('Session has expired due to inactivity.');--%>
<%--                window.location.href = 'WelcomeCBRS'; // Redirect to WelcomeCBRS--%>
<%--            }, sessionTimeout);--%>
<%--        }--%>

<%--        // Monitor user interactions to reset the timeout--%>
<%--        document.addEventListener('mousemove', resetTimeout);--%>
<%--        document.addEventListener('keydown', resetTimeout);--%>
<%--        document.addEventListener('click', resetTimeout);--%>
<%--        document.addEventListener('scroll', resetTimeout);--%>

<%--        // Start the timer initially--%>
<%--        resetTimeout();--%>
<%--    </script>--%>
                

            </body>

            </html>