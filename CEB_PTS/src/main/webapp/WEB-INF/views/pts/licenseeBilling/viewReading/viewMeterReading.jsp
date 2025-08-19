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

</head>

<body>
<!-- ---------------------------------------------------------------------------------- -->
<!--                         HEADER                                                     -->
<!-- ---------------------------------------------------------------------------------- -->

<jsp:include page="../../common/header.jsp"/>

<!-- ---------------------------------------------------------------------------------- -->
<!--                         CONTENT                                                    -->
<!-- ---------------------------------------------------------------------------------- -->

<div style="min-height: 850px;">
    <jsp:include page="../../common/navLisenceeBilling.jsp">
        <jsp:param name="activeSelection" value="View Readings" />
        <jsp:param name="description" value="View Processed Meter-Readings"/>
    </jsp:include>

    <jsp:include page="meterReadingSelector.jsp">
        <jsp:param name="btnName" value="View" />
    </jsp:include>

    <div id="resultContainer" class="tableContainer">
    </div>
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

<jsp:include page="../../common/footer.jsp" />

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
        let msg = $('#message');

        //-------------------------------------------------------------------
        //            view processing
        //-------------------------------------------------------------------
        const btn = $('#click_btn');
        const table = $('#resultContainer');

        btn.click(function(e) {
            e.preventDefault();

            let billCycle = $('#billCycle').val();
            localStorage.setItem('selectedBillCycle', billCycle);
            let division = $('#divisionDropdown').val();
            localStorage.setItem('selectedDivision', division);
            let province = $('#provinceDropdown').val();
            localStorage.setItem('selectedProvince', province);

            // Validate if dropdown values are selected
            if (!billCycle || !division || !province) {
                msg.text('Please select all fields.');
                return;
            }

            btn.val('Retrieving...').prop('disabled', true);

            // Call endpoint with parameters
            loadMeterReadingList(
                billCycle,
                division,
                province
            );
        });

        //-------------------------------------------------------------------
        //            error files re processing
        //-------------------------------------------------------------------
        const uploadBtn = $('#uploadButton');

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
                formData.append('billCycle', localStorage.getItem('selectedBillCycle'));
                uploadBtn.prop('disabled', true).text('Processing...');

                $.ajax({
                    url: '/PTS/reProcess',
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    cache: false,
                    timeout: 60000,
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                    },
                    success: function(response) {
                        uploadBtn.prop('disabled', false).text('Upload');
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
                            msg.text(xhr.responseJSON.message);
                        } else {
                            msg.text('An error occurred while uploading the file.');
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
                    table.html(data);
                },
                error: function(xhr, status, error) {
                    btn.val('View').prop('disabled', false);
                    table.hide();
                    msg.text('An error occurred while loading the data.');
                }
            });
        }
    });
</script>

</body>

</html>