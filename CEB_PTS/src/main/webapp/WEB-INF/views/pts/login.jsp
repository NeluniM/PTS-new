<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>CEB Power Trading System</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

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

    <link href='//fonts.googleapis.com/css?family=Open+Sans:400,600,700,300|Titillium+Web:200,300,400'
          rel='stylesheet' type='text/css'>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <style>
        .login-container {
            position: relative;
            z-index: 10; /* Increased z-index to stay above background */
            width: 100%;
            padding: 20px;
            display: flex;
            justify-content: center; /* Centered positioning */
            align-items: center;
            min-height: 100vh;
        }

        .login-form-wrapper {
            max-width: 450px;
            width: 100%;
            position: relative;
            z-index: 11; /* Higher than container */
        }

        .login-form-content {
            background: rgba(255, 255, 255, 0.95); /* Increased opacity for better visibility */
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2); /* Stronger shadow */
            padding: 40px;
            backdrop-filter: blur(10px);
            position: relative;
            z-index: 12; /* Highest z-index */
        }



        /* Responsive adjustments */
        @media (max-width: 768px) {
            .login-container {
                padding: 10px;
                justify-content: center; /* Keep centered on mobile */
            }

            .login-form-content {
                padding: 30px 20px;
            }

            .welcomelogin_bg::after {
                background-position: bottom center;
            }
        }

        @media (max-width: 576px) {
            .login-container {
                padding: 10px;
            }
        }
    </style>
</head>

<body>

<c:if test="${not empty errorMsg}">
    <div class="alert alert-danger text-center" style="margin: 20px;">
        <strong>${errorMsg}</strong>
    </div>
</c:if>

<!-- header-start -->
<header>
    <div class="header-area ">
        <div id="sticky-header" class="main-header-area">
            <div class="container-fluid p-0">
                <div class="row align-items-center no-gutters">
                    <div class="col-xl-5 col-lg-6">
                        <div class="main-menu  d-none d-lg-block">

                        </div>
                    </div>
                    <div class="col-xl-2 col-lg-2">
                        <!-- <div class="logo-img">
                            <a href="WelcomeCBRS">
                                <img src="img/logo.png" alt="">
                            </a>
                        </div> -->
                    </div>
                    <div class="col-12">
                        <!-- <div class="mobile_menu d-block d-lg-none"></div> -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>
<!-- header-end -->

<!-- bradcam_area_start -->
<div class="slider_area">
    <div>
        <div class="single_slider d-flex align-items-center welcomelogin_bg">
            <div class="container-fluid">
                <div class="row justify-content-center">
                    <div class="">
                        <div class="login-form-wrapper">

                            <c:if test="${model.errorMsg != null}">
                                <div class="alert alert-success" id="success-alert">
                                    <strong>${model.errorMsg}</strong>
                                </div>
                            </c:if>

                            <div style="background: rgba(255, 255, 255, 0.95); border-radius: 10px; box-shadow: 0 0 20px rgba(0, 0, 0, 0.2); padding: 40px; position: relative; z-index: 15;">
                                <div class="text-center mb-4">
                                    <img src="${pageContext.request.contextPath}/resources/img/logo.png"
                                         alt="Logo" style="max-width: 150px; height: auto;">
                                </div>

                                <h2 style="text-align: center; margin-bottom: 30px; color: #333; font-weight: 600;">
                                    Energy Marketing System
                                </h2>
                                <form id="loginForm" action="login" method="post" modelAttribute="model">
                                    <div class="form-group">
                                        <label for="userName">User Name</label>
                                        <input type="text" class="form-control" id="userName" path="userName" name="userName" placeholder="User Name">
                                        <div id="epfError" class="text-danger" style="display:none;">User name is required.</div>
                                    </div>

                                    <div class="form-group">
                                        <label for="password">Password</label>
                                        <input type="password" class="form-control" id="password" name="password" path="password" placeholder="Password">
                                        <div id="passwordError" class="text-danger" style="display:none;">Password is required.</div>
                                    </div>

                                    <button type="submit" class="btn btnClick" style="width: 100%; margin: 0px 0;">Login</button>
                                </form>

                                <p style="font-size: 0.8rem; text-align: center; margin-top: 20px; color: #666;">
                                    <a href="https://www.ceb.lk" target="_blank">Ceylon Electricity Board</a> | Version 1.0
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- JS here -->
<script>
    $('#loginForm').submit(function(e) {
        e.preventDefault();
        $('#epfError').hide(); // Hide error before request
        $.ajax({
            url: 'http://localhost:9090/SharedService/api/auth/user-details',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                epfNo: $('#userName').val()
            }),
            xhrFields: { withCredentials: true }, // for session/cookie
            success: function() {
                window.location.href = 'home'; // redirect to home pag
            },
            error: function(xhr) {
                $('#epfError').show().text(xhr.responseText || 'User not found');
            }
        });
    });
</script>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>

</body>

</html>