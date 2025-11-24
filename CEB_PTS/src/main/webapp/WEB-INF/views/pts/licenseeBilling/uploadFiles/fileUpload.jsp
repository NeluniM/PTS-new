<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="out" uri="http://java.sun.com/jsp/jstl/core" %>
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

<jsp:include page="../../common/navLisenceeBilling.jsp">
    <jsp:param name="activeSelection" value="Upload Files" />
    <jsp:param name="description" value="Upload Meter-Reading Files By Province"/>
</jsp:include>

<jsp:include page="fileUploadSelector.jsp">
    <jsp:param name="btnName" value="Process" />

</jsp:include>

<input type="hidden" name="overwrite" id="overwriteFlag" value="false"/>


<%--<!-- Error message box -->--%>
<div style="margin-left: 10% ; margin-right: 10%">
    <div id="errorMsg" style="display: none;" class="msg error-msg"></div>
</div>

<%--<!-- Success message box -->--%>
<div style="margin-right: 10%; margin-left: 10%;"><div id="successMsg" style="display:none;" class="msg success-msg" ></div></div>

<!-- Hidden field to track overwrite decision -->
<input type="hidden" name="overwriteDecision" id="overwriteDecision" value="">



<%--&lt;%&ndash;alert message box&ndash;%&gt;--%>
<div id="alertBox" class="alertBox">
</div>

<%--<!-- Success message box -->--%>
<%--<div id="successMsg" class="alert alert-success" style="display: none;"></div>--%>

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

<%--<script>--%>

<%--    $(document).ready(function() {--%>


<%--    });--%>
<%--</script>--%>


<%--<script>--%>

<%--    function confirmUpload() {--%>
<%--        var answer = confirm("Are you sure you want to save?");--%>
<%--        if (!answer) {--%>
<%--            return false; // Prevent form submission--%>
<%--        }--%>
<%--        return true; // Allow form submission--%>
<%--    }--%>

<%--</script>--%>


<script>

    function handleOverwrite() {
        console.log("Overwrite confirmed. Submitting form with YES decision.");
        const form = document.getElementById('myForm');
        if (form) {
            const overwriteInput = document.createElement('input');
            overwriteInput.type = 'hidden';
            overwriteInput.name = 'overwriteDecision';
            overwriteInput.value = 'YES';
            form.appendChild(overwriteInput);

            const formData = new FormData(form);

            $.ajax({
                url: form.action,
                type: form.method,
                data: formData,
                processData: false,
                contentType: false,
                success: function (response) {
                    console.log("File upload processed successfully.");
                    // Clear form after successful upload
                    form.reset();

                    // $('#successMsg').html("File upload processed successfully.").fadeIn();
                    //alert("Files uploaded successfully.");

                    // Clear the alertBox content
                    $('#alertBox').html('');

                    // ---------------------- Bill Cycle AJAX ------------------------
                    $.ajax({
                        url: '/PTS/getBillCycle',
                        method: 'GET',
                        dataType: 'text',
                        success: function (data) {
                            $('#billCycle').val(data); // ? Will now be "436" instead of [object XMLDocument] or <Long>436</Long>
                        },
                        error: function (err) {
                            console.error('Error fetching bill cycle:', err);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    console.error("Upload error:", error);
                    alert("Something went wrong while uploading: " + error);

                    // Restore form data on error so user doesn't lose their selection
                    $('#billCycle').val(localStorage.getItem('billCycle'));
                    $('#divisionDropdown').val(localStorage.getItem('licenseCode'));
                    $('#provinceDropdown').val(localStorage.getItem('provinceCode'));
                }
            });
        } else {
            console.error('Form with id "myForm" not found');
        }

    }

    function handleCancel() {
        console.log("Overwrite cancelled. Submitting form with CANCEL decision.");
        const form = document.getElementById('myForm');
        if (form) {
            const cancelInput = document.createElement('input');
            cancelInput.type = 'hidden';
            cancelInput.name = 'overwriteDecision';
            cancelInput.value = 'CANCEL';
            form.appendChild(cancelInput);
            form.submit();
        } else {
            console.error('Form with id "myForm" not found');
        }
    }

</script>

<!-- Success Message Script -->
<c:if test="${not empty model.successMessage}">
    <script>
        $(document).ready(function () {
            var msg = `<c:out value="${model.successMessage}" escapeXml="true" />`;
            var formattedMsg = msg.replace(/\n/g, "<br>");
            console.log("Alert message in JSP (success): " + msg);
            $('#successMsg').html(formattedMsg).fadeIn();
            //setTimeout(() => $('#successMsg').fadeOut(), 21000);
        });


    </script>
</c:if>

<!-- Error Message Script -->
<c:if test="${not empty model.errorMessage}">
    <script>
        $(document).ready(function () {
            var msg = `<c:out value="${model.errorMessage}" escapeXml="true" />`;
            var formattedMsg = msg.replace(/\n/g, "<br>");
            console.log("Alert message in JSP (error): " + msg);
            $('#errorMsg').html(formattedMsg).fadeIn();
            //   setTimeout(() => $('#errorMsg').fadeOut(), 21000);
        });
    </script>
</c:if>

<%--<script>--%>
<%--    $(document).ready(function () {--%>
<%--        $('#myForm').on('submit', function (e) {--%>
<%--            var hasConflict = '${model.fileNameConflict}' === 'true';--%>
<%--            var originalFileName = '${model.originalFileName}';--%>

<%--            if (hasConflict) {--%>
<%--                e.preventDefault(); // Always stop first to wait for confirmation--%>

<%--                var userConfirmed = confirm("The file '" + originalFileName + "' is already uploaded. Do you want to upload this file? Are you sure?");--%>

<%--                if (userConfirmed) {--%>
<%--                    // Set overwriteFlag to true and re-submit--%>
<%--                    $('#overwriteFlag').val("true");--%>
<%--                    this.submit(); // Submit again--%>
<%--                } else {--%>
<%--                    // Cancel upload, clear file input--%>
<%--                    alert("Upload cancelled. Please choose a different file.");--%>
<%--                    $('input[type="file"]').val('');--%>
<%--                }--%>
<%--            }--%>
<%--        });--%>
<%--    });--%>
<%--</script>--%>


<%--<c:if test="${fileNameConflict}">--%>
<%--    <script>--%>
<%--        $(document).ready(function () {--%>
<%--            swal({--%>
<%--                title: "Duplicate File Detected!",--%>
<%--                text: "The file '${originalFileName}' is already uploaded. It has been renamed to avoid conflict.",--%>
<%--                type: "warning",--%>
<%--                confirmButtonText: "OK"--%>
<%--            });--%>
<%--        });--%>
<%--    </script>--%>
<%--</c:if>--%>
<%--<c:if test="${model.fileNameConflict}">--%>
<%--    <script type="text/javascript">--%>
<%--        window.onload = function () {--%>
<%--            var userConfirmed = confirm("The file '${model.originalFileName}' already exists. Do you want to overwrite it?");--%>
<%--            if (userConfirmed) {--%>
<%--                // Set the overwrite flag and resubmit the form--%>
<%--                document.getElementById("overwriteFlag").value = "true";--%>
<%--                document.forms[0].submit();--%>
<%--            } else {--%>
<%--                alert("Upload cancelled. Please rename your file.");--%>
<%--            }--%>
<%--        };--%>
<%--    </script>--%>
<%--</c:if>--%>

<%--<c:if test="${showConfirmation}">--%>
<%--    <script>--%>
<%--        if (confirm("${msg}\nDo you want to proceed with uploading more files?")) {--%>
<%--            let url = window.location.href;--%>
<%--            url += (url.indexOf('?') > -1 ? '&' : '?') + 'confirmOverwrite=yes';--%>
<%--            window.location.href = url;--%>
<%--        } else {--%>
<%--            alert("Upload canceled.");--%>
<%--        }--%>
<%--    </script>--%>
<%--</c:if>--%>


<%--<script>--%>
<%--    $(document).on('click', '#overwriteButton', function () {--%>
<%--        console.log("Overwrite confirmed. Submitting form with YES decision.");--%>
<%--    });--%>

<%--    $(document).on('click', '#cancelButton', function () {--%>
<%--        console.log("Overwrite cancelled. Submitting form with CANCEL decision.");--%>
<%--    });--%>
<%--</script>--%>

</body>

</html>