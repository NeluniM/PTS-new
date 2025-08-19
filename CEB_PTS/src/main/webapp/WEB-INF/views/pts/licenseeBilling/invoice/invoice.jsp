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
        <jsp:param name="activeSelection" value="Invoice"/>
        <jsp:param name="description" value="View Prepared Invoices"/>
    </jsp:include>

    <jsp:include page="invoiceSelector.jsp"/>


    <div id="resultContainer" class="tableContainer">
        <jsp:include page="invoiceTable.jsp"/>
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

        const table = $('#resultContainer');
        const billCycle = $('#billCycle');
        const division = $('#divisionDropdown');
        const button = $('#click_btn');

        console.log("bc"+'${billCycleParam}');
        console.log("div"+'${divisionParam}');
        //-------------------------------------------------------------------
        //            View invoice
        //-------------------------------------------------------------------

        button.click(function(e) {
            e.preventDefault(); // Prevent form submission
            viewInvoice(billCycle.val(), division.val());
        });

        function viewInvoice(bc,div) {
            //alert('bc'+bc);
            if (bc === '') {
                return;
            }
            button.val('Retrieving...').prop('disabled', true);

            $.ajax({
                url: '/PTS/viewInvoice',
                method: 'GET',
                data: {
                    division: div,
                    billCycle: bc
                },
                success: function(response) {
                    button.val('View').prop('disabled', false);
                    table.html(response);
                    setTimeout(function() { $label.text(''); }, 5000);
                },
                error: function(xhr, status, error) {
                    button.val('View').prop('disabled', false);
                    table.hide();
                    setTimeout(function(){$label.text('');}, 5000);
                }
            });
        }

        if ('${billCycleParam}' !== '' && '${divisionParam}' !== '') {
            billCycle.val('${billCycleParam}');
            division.val('${divisionParam}');
            viewInvoice('${billCycleParam}', '${divisionParam}');
        }

    });


</script>

</body>

</html>
