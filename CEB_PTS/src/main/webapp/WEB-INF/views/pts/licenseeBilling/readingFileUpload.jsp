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

    <!-- Include jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <!-- Include jQuery UI -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <!-- <link rel="manifest" href="site.webmanifest"> -->
    <link rel="shortcut icon" type="image/x-icon" href="img/favicon.png" />
    <!-- Place favicon.ico in the root directory -->

    <!-- CSS here -->
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
    <!-- <link rel="stylesheet" href="css/responsive.css"> -->

    <style type="text/css">
        div#map_container {
            width: 100%;
            height: 500px;
            border-radius: 5px;
        }

        .center {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 10vh;
        }
    </style>
    <style>
        #content,
        #rates_holder {
            display: none;
            /* Hide content by default */
        }

        #loading,
        #full_loading {
            display: none;
            /* Show loading animation by default */
            text-align: center;
        }

        .spinner {
            border: 4px solid rgba(0, 0, 0, 0.1);
            border-radius: 50%;
            border-top: 4px solid #3498db;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
            margin: 20px auto;
        }

        @keyframes spin {
            0% {
                transform: rotate(0deg);
            }

            100% {
                transform: rotate(360deg);
            }
        }

        .caret-icon {
            font-size: 1.0em;
            margin-right: 5px;
            cursor: pointer;

        }

        .avbl_section {
            display: flex;
        }

        .date_holder {
            margin-top: 10px;
            margin-bottom: 10px;
            width: 25%;
        }

        .date_container {
            display: flex;
            width: 400%;
        }

        .full_container {
            overflow-x: scroll;
        }

        .fulldate_container {
            display: flex;
            width: 400%;
        }

        .fulldate_holder {
            margin-top: 10px;
            margin-bottom: 10px;
        }

        /* .date_box {
          height: 50px;
          width: 50px;
          border-radius: 6px;
          border: 2px solid #d1d0d0;
          text-align: center;
          display: flex;
          align-items: center;
          justify-content: center;
          margin-left: auto;
          margin-right: auto;
          font-size: 0.7em;
          font-family: Verdana, Geneva, Tahoma, sans-serif;
        }
*/
        .date_box {
            height: 50px;
            width: 50px;
            border-radius: 50%;
            border: 2px solid #d1d0d0;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-left: auto;
            margin-right: auto;
            font-size: 0.7em;
            font-family: Verdana, Geneva, Tahoma, sans-serif;
        }

        .available {
            background-color: rgb(3, 213, 3);
        }

        .unavailable {
            background-color: rgb(252, 22, 22);
        }


        .eve_available {
            background-image: linear-gradient(to right, rgba(3, 213, 3, 0) 50%, rgb(3, 213, 3) 50%);
        }

        .eve_unavailable {
            background-image: linear-gradient(to right, rgba(3, 213, 3, 0) 50%, rgb(252, 22, 22) 50%);

        }

        .mor_available {
            background-image: linear-gradient(to right, rgb(3, 213, 3) 50%, rgba(3, 213, 3, 0) 50%);

        }

        .mor_unavailable {
            background-image: linear-gradient(to right, rgb(252, 22, 22) 50%, rgba(3, 213, 3, 0) 50%);

        }

        .rate_tbl {
            width: 50%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th {
            background-color: #4F81BD;
            color: white;
        }

        th,
        td {
            border: 1px solid #dddddd;
            padding: 8px;
            text-align: left;
        }

        td {
            color: #003868;
        }

        /* Alternate row colors */
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .center {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .people_container {
            margin-top: 15px;
            width: 100%;
            display: block;
            align-items: center;
            justify-content: center;
        }

        .people_title {
            margin-top: 20px;
        }

        .visitorCount {
            width: 100%;
            margin-left: auto;
            margin-right: auto;
        }

        .booking_container {
            width: 60%;
        }

        .boxed-btn3 {
            cursor: pointer;
        }

        .btn_unavailable {
            cursor: not-allowed;
        }

        .btn_available {
            cursor: pointer;
        }

        .instructions {
            margin-left: 10%;
            margin-top: 5%;
            margin-bottom: 5%;
        }

        .errorMsg {
            color: red;
            margin-bottom: 3px;
            font-weight: 400;
        }

        .dateDisplay {
            color: #fff;
            text-decoration: none;
            font-family: "Roboto", "Helvetica", "Arial", sans-serif;
        }

        @media screen and (min-width: 200px) and (max-width: 900px) {
            .fulldate_container {
                width: 400%;
            }

            .avbl_section {
                display: block;
            }

            .date_container {
                width: 400%;
            }

            .date_holder {
                padding-left: 35%;
                width: 50%;
            }

            .instructions {
                margin-left: 4%;
                margin-right: 4%;
            }
        }

        @media screen and (max-width: 768px) {
            .rates_holder {
                margin-top: 10px;
                margin-left: auto;
                margin-right: auto
            }
        }

        @media screen and (min-width: 200px) and (max-width: 900px) {
            .fulldate_container {
                width: 100%;
            }

            .avbl_section {
                display: block;
            }

            .date_container {
                width: 100%;
            }

            .date_holder {
                padding-left: 0;
                width: 100%;
            }

            .date_box {
                width: 80px;
                height: 80px;
                font-size: 0.8em;
            }

            .instructions {
                margin-left: 4%;
                margin-right: 4%;
            }
        }


        .date_holder p[id^="room_id_"] {
            margin-left: 2%;
        }

        .fulldate_holder {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        #full_container .fulldate_holder .date_box {
            margin: 3px;
        }

        @media screen and (min-width: 200px) and (max-width: 900px) {

            .date_box {
                width: 80px;
                height: 80px;
                font-size: 0.8em;
            }
        }
    </style>

</head>

<body>
<!-- ---------------------------------------------------------------------------------- -->
<!--                         HEADER                                                     -->
<!-- ---------------------------------------------------------------------------------- -->

<jsp:include page="../common/header.jsp"/>

<!-- ---------------------------------------------------------------------------------- -->
<!--                         CONTENT                                                    -->
<!-- ---------------------------------------------------------------------------------- -->

<jsp:include page="../common/navLisenceeBilling.jsp">
    <jsp:param name="activeSelection" value="Upload Meter Points" />
</jsp:include>

<jsp:include page="../common/fileUploadParam.jsp">
    <jsp:param name="btnName" value="Process" />
</jsp:include>


<!-- to give a gap to hide the footer -->
<span id="spanItem" style="min-height: 500px; display: inline-block;"></span>

<div id="tableContainer" class="container">
</div>


<!-- Bootstrap JS and Popper.js (order matters) -->
<!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

<!-- FullCalendar JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.0/fullcalendar.min.js"></script>



<!-- ---------------------------------------------------------------------------------- -->
<!--                         FOOTER                                                     -->
<!-- ---------------------------------------------------------------------------------- -->

<jsp:include page="../common/footer.jsp" />

<script src="js/jquery.slicknav.min.js"></script>

<!--contact js-->
<script src="js/contact.js"></script>
<script src="js/jquery.ajaxchimp.min.js"></script>
<script src="js/jquery.form.js"></script>
<script src="js/jquery.validate.min.js"></script>
<script src="js/mail-script.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<script src="js/main.js"></script>

<script>

    $(document).ready(function() {

        $('#uploadModal').hide();
        //-------------------------------------------------------------------
        //            drop down menu
        //-------------------------------------------------------------------
        const divDropdown = $('#divisionDropdown');
        const provDropdown = $('#provinceDropdown');
        const provinceList = JSON.parse('${provinceList}');

        divDropdown.change(function() {
            let selectedLicenseCode = divDropdown.val();
            filterProvince(selectedLicenseCode);
        });

        function filterProvince(lCode) {
            const filteredProvinces = provinceList.filter(function(province) {
                return province.licenseCode === lCode;
            });
            provDropdown.empty().append(
                filteredProvinces.map(function(province) {
                    return $('<option>', {
                        value: province.provinceCode,
                        text: province.provinceName
                    });
                })
            );
        }

        filterProvince('DD1');//initial rendering

        //-------------------------------------------------------------------
        //            view processing
        //-------------------------------------------------------------------
        const btn = $('#click_btn');
        const uploadBtn = $('#uploadButton');
        const table = $('#tableContainer');

        btn.click(function() {

            let billCycle = $('#billCycle').val();
            localStorage.setItem('selectedBillCycle', billCycle);
            let division = divDropdown.val();
            localStorage.setItem('selectedDivision', division);
            let province = provDropdown.val();
            localStorage.setItem('selectedProvince', province);
            let lable = $('#processMsg');
            lable.text('').css('color', 'black');

            // Validate if dropdown values are selected
            if (!billCycle || !division || !province) {
                lable.css('color', 'red').text('Please select all required fields.');
                setTimeout(function(){lable.text('');}, 5000);
                return;
            }
            btn.val('Processing...').prop('disabled', true);

            // Call endpoint with parameters
            loadMeterReadingList(
                billCycle,
                division,
                province
            );
        });

        $(document).on('click', '.upload', function(e) {
            e.preventDefault();
            $('#uploadModal').modal('show');
        });

// Display selected filename
        $('#fileInput').on('change', function() {
            const fileName = $(this).val().split('\\').pop();
            $('#displayData').text(fileName);
        });

// Handle upload button click
        uploadBtn.on('click', function() {
            const fileInput = $('#fileInput')[0];
            if (fileInput.files.length > 0) {
                const formData = new FormData();
                formData.append('file', fileInput.files[0]);
                formData.append('billCycle',localStorage.getItem('selectedBillCycle'));
                uploadBtn.prop('disabled', true).text('Processing...');

                $.ajax({
                    url: '/PTS/rePro',
                    type: 'POST',
                    data: formData,
                    processData: false,  // Don't process the files
                    contentType: false,  // Set to false, browser will set content type to multipart/form-data
                    cache: false,        // Disable caching
                    timeout: 60000,      // Set timeout to 1 minute
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                    },
                    success: function(response) {
                       uploadBtn.prop('disabled', false).text('Upload');
                       $('#displayData').text('File uploaded successfully: ' + response);
                       //hide model after 1.5 seconds
                        setTimeout(function(){
                            $('#uploadModal').modal('hide');
                            loadMeterReadingList(
                                localStorage.getItem('selectedBillCycle'),
                                localStorage.getItem('selectedDivision'),
                                localStorage.getItem('selectedProvince')
                            );
                        }, 1500);
                    },
                    error: function(xhr, status, error) {
                        uploadBtn.prop('disabled', false).text('Upload');
                        if (xhr.status === 400) {
                            $('#displayData').text('Error: No file uploaded');
                        } else {
                            $('#displayData').text('An error occurred: ' + (xhr.responseText || error));
                        }
                    }
                });
            }
        });

        function loadMeterReadingList(billCycle, division, province) {
            $.ajax({
                url: '/PTS/viewMeterReadingList',
                method: 'GET',
                data: { billCycle, division, province },
                success: function(data) {
                    btn.val('View').prop('disabled', false);
                    $('#spanItem').css('display', 'none');
                    table.html(data);
                },
                error: function(xhr, status, error) {
                    btn.val('View').prop('disabled', false);
                    table.hide();
                    $('#spanItem').css('display', 'inline-block');
                    lable.css('color', 'red').text('An error occurred...');
                    setTimeout(function(){lable.text('');}, 5000);
                }
            });
        }
    });
</script>

</body>

</html>