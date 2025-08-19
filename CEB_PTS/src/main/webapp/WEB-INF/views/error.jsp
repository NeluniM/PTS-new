<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>CEB Circuit Bungalow</title>
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>

        <!-- <link rel="stylesheet" href="css/responsive.css"> -->

        <style>
            .successMessage {
                font-family: 'Arial', sans-serif;
                /* background-color: #f4f4f4; */
                margin: 50px;
                /* padding: 0; */
                display: flex;
                justify-content: center;
                /* align-items: center; */
            }

            .box {
                /* background-color: #fff; */
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            }

            .details-container {
                background-color: #fff;
                border-radius: 10px;
                width: 210mm;
                height: 295mm;
                text-align: left;
            }


            .successh2 {
                color: #333;
                border-bottom: 2px solid #ddd;
                padding-bottom: 10px;
                padding-left: 40px;
                margin-bottom: 20px;
                margin-top: 10px;
            }

            .detail-item {
                margin-bottom: 15px;
                padding-left: 40px;
            }

            strong {
                display: inline-block;
                width: 150px;
                font-weight: normal;
            }

             /* ------------------ Header styles ------------------- */
            .header-image {
                width: 100%;
                text-align: center;
                border-top-left-radius: 10px;
                border-top-right-radius: 10px;
            }

            .header-image img {
                width: 210mm;
                border-top-left-radius: 10px;
                border-top-right-radius: 10px;

            }

            /* ------------------ Footer styles ------------------- */
            .footer-confirmPage {
                position: relative;
                bottom: -130px;
                width: 100%;
                text-align: center;
                flex-shrink: 0;
            }

            .footer-line-confirmPage {
                display: inline-block;
                width: 100%;
                border-top: 1px solid #ddd;
            }

            p {
                margin-top: 3px;
                margin-bottom: -3px;
                font-size: smaller;
            }


            .download-button-container {
                position: absolute;
                /* top: 50px;  */
                right: 35px;
            }

            .download-button {
                padding: 10px;
                background-color: #007BFF;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .message{
                margin-left: 70px;
            }

            .restart_container{
                width: 100%;
                display: flex;
                justify-content: center;
                align-items: center;
                margin-left: auto;
                margin-right: auto;
            }
            .box-btn3{
                margin-left: auto;
                margin-right: auto;
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
                                            <li><a href="WelcomeCBRS">home</a></li>
                                            <!-- <li><a href="allbungalows">Bungalows</a></li>
                                            <li><a href="contact">Contact</a></li>
                                         --></ul>
                                    </nav>
                                </div>
                            </div>
                            <div class="col-xl-2 col-lg-2">
                                <div class="logo-img">
                                    <a href="index.html">
                                        <img src="img/logo.png" alt="" />
                                    </a>
                                </div>
                            </div>
                            <div class="dateDisplayContainer col-xl-5 col-lg-6 main-menu" id="dateDisplayContainer">
                                <span class="dateDisplay" id="datetimeDisplay"></span>
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
        <div class="room_details_bradcam_area room_details_breadcam_bg">
            <h3>OOPS!</h3>
        </div>
        <!-- bradcam_area_end -->

        <br><br>

        <div class="message">
            <h4>It seems like there was an unexpected error while processing your reservation. We apologize for any inconvenience this may have caused.</h4>
            <h4>Please kindly retry your reservation process.</h4>
        </div>
        <div class="restart_container">
            <div class="col-xl-12 mb-3 center ">
                <button class="boxed-btn3" onclick="restartBooking()">
                  RETRY
                </button>
            </div>
        </div>


        <!---------------------------------- End of Confirm page-------------------------->


        <!-- footer -->
        <footer class="footer">
            <div class="footer_top">
                <div class="container">
                    <div class="row">
                        <div class="col-xl-4 col-md-6 col-lg-4"
                            style="display: flex; flex-direction: column; align-items: center;">
                            <div class="footer_widget">
                                <h3 class="footer_title" style="text-align: left;">
                                    Address
                                </h3>
                                <p class="footer_text"> 50 Sir Chittampalam A Gardiner Mawatha Colombo 00200,
                                    00700</p>
                                <a href="contact" class="line-button">Get Direction</a>
                            </div>
                        </div>
                        <div class="col-xl-4 col-md-6 col-lg-4"
                            style="display: flex; flex-direction: column; align-items: center;">
                            <div class="footer_widget" style="text-align: left;">
                                <h3 class="footer_title">
                                    Reservation
                                </h3>
                                <p class="footer_text">+94 112 451 098<br>
                                    reservation@CEB.com</p>
                            </div>
                        </div>
                        <div class="col-xl-4 col-md-6 col-lg-4"
                            style="display: flex; flex-direction: column; align-items: center;">
                            <div class="footer_widget" style="text-align: left;">
                                <h3 class="footer_title">
                                    Navigation
                                </h3>
                                <ul style="list-style: none; padding: 0; text-align: left;">
                                    <li><a href="WelcomeCBRS">Home</a></li>
                                    <li><a href="allbungalows">Bungalows</a></li>
                                   <li><a href="contact">Contact</a></li>
                                </ul>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            </div>
            <div class="copy-right_text">
                <div class="container">
                    <div class="footer_border"></div>
                    <div class="row">
                        <div class="col-xl-8 col-md-7 col-lg-9">
                            <p class="copy_right">
                                Copyright &copy;
                                <script>
                                    document.write(new Date().getFullYear());
                                </script>
                                All rights reserved | <a href="https://www.ceb.lk" target="_blank"> Ceylon Electricity Board</a>
                            </p>
                        </div>

                    </div>
                </div>
            </div>
        </footer>

        <script>
            function restartBooking(){
                window.location.href = 'WelcomeCBRS';
            }
        </script>

    </body>

    </html>