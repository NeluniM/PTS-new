<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>Power Trading System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <base href="${pageContext.request.contextPath}/" />

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link rel="shortcut icon" href="img/favicon.png" />
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/style.css" />

    <style>
        .meter-form-wrapper {
            max-width: 900px;
            margin: 30px auto;
        }

        .btn-save-red {
            background-color: #7D0000 !important;
            border-color: #7D0000 !important;
            color: #fff !important;
        }

        .btn-save-red:hover {
            background-color: #B31900 !important;
            border-color: #B31900 !important;
            color: #fff !important;
        }

        input[readonly], textarea[readonly], select[disabled], input[type="date"][readonly] {
            background-color: #ffffff !important;
            color: #000 !important;
            opacity: 1 !important;
            cursor: not-allowed !important;
        }


    </style>
</head>

<body>

<jsp:include page="../../common/header.jsp" />

<div style="min-height: 850px;">

    <jsp:include page="../../common/navLisenceeBilling.jsp">
        <jsp:param name="activeSelection" value="Meter Management"/>
        <jsp:param name="description" value="Install New Meter"/>
    </jsp:include>

    <div class="container meter-form-wrapper">

        <form action="installMeter" method="post">

            <!-- ========================= METER HEADER ONLY ========================= -->
            <div class="card mt-3" id="meterHeaderWrapper">

            <div class="card-header">
                    <h5 class="mb-0">Meter Header Details</h5>
                </div>

                <div class="card-body">

                    <div class="row mt-3">
                        <div class="col-md-6">
                            <label>Manufactured Year</label>
                            <input type="text" class="form-control" name="MANUFACTURED_COUNTRY" required>
                        </div>
                    </div>

                    <div class="row mt-3">
                        <div class="col-md-6">
                            <label>Quantity</label>
                            <input type="number" step="0.01" class="form-control" name="QUANTITY" required>
                        </div>

                        <div class="col-md-6">
                            <label>Status</label>
                            <input type="text" class="form-control" value="AVL" readonly>
                            <input type="hidden" name="STATUS" value="AVL">
                        </div>
                    </div>

                    <div class="row mt-3">
                        <div class="col-md-6">
                            <label>Manufacturer</label>
                            <select id="manufacturerSelect" class="form-control" required>
                                <option value="">-- Select Manufacturer --</option>
                                <option value="1">EDMI</option>
                                <option value="2">ELSTER</option>
                                <option value="3">CEWE</option>
                                <option value="4">ACTARIS</option>
                                <option value="5">ISKRA</option>
                                <option value="6">ALSTOM</option>
                                <option value="7">CEWE OLD</option>
                                <option value="8">GCE</option>
                                <option value="9">ABB</option>
                                <option value="10">SCHNEIDER</option>
                                <option value="11">SECURE</option>
                                <option value="12">Lasdis & Gyr</option>
                            </select>
                            <input type="hidden" name="MANUFACT_ID" id="manufacturerHidden">
                        </div>

                        <div class="col-md-6">
                            <label>Model</label>
                            <select id="modelSelect" class="form-control" required>
                                <option value="">-- Select Model --</option>
                                <option value="1" data-manufact="1">MK6E_A</option>
                                <option value="14" data-manufact="1">MK6E_G</option>
                                <option value="15" data-manufact="1">MK6E_H</option>
                                <option value="2" data-manufact="2">A1500</option>
                                <option value="3" data-manufact="2">A1800</option>
                                <option value="4" data-manufact="3">PROMETER</option>
                                <option value="5" data-manufact="3">PROMETER_100_C</option>
                                <option value="16" data-manufact="3">PROMETER_100_E</option>
                                <option value="17" data-manufact="3">PROMETER_100_F</option>
                                <option value="6" data-manufact="5">ACE8000</option>
                                <option value="8" data-manufact="5">ISKRA MODEL</option>
                                <option value="7" data-manufact="6">M230</option>
                                <option value="9" data-manufact="7">CEWE OLD MODEL</option>
                                <option value="10" data-manufact="8">GCE MODEL</option>
                                <option value="11" data-manufact="9">ABB MODEL</option>
                                <option value="12" data-manufact="10">SCHNEIDER MODEL</option>
                                <option value="13" data-manufact="11">SECURE</option>
                            </select>
                            <input type="hidden" name="MODEL_ID" id="modelHidden">
                        </div>
                    </div>

                    <!-- hidden fields unchanged -->
                    <input type="hidden" name="ACCURACY_CLASS" value="0.2">
                    <input type="hidden" name="CURRENT_RATING3" value="1">
                    <input type="hidden" name="INITIATED_BY" value="ADMIN">
                    <input type="hidden" name="REMARK" value="Exported">
                    <input type="hidden" name="UPDATED_BY" value="Export">
                    <input type="hidden" name="UPDATED_DATE" value="${today}">
                    <input type="hidden" name="CURRENT_RATING" value="400/1 A">
                    <input type="hidden" name="CREATED_BY" value="${loggedUser}">
                    <input type="hidden" name="CREATED_DATE" value="${today}">
                    <input type="hidden" name="PROCURED_DATE" value="${today}">
                </div>
            </div>

            <!-- ================= BUTTONS ================= -->
            <div class="d-flex justify-content-end mt-4 mb-4" id="meterActionButtons">

                <button type="submit"
                        formaction="${pageContext.request.contextPath}/meterManagement"
                        formmethod="get"
                        formnovalidate
                        class="btn btn-outline-secondary"
                        style="margin-right:12px;">
                    Cancel
                </button>



                <button type="button"
                        id="showTableBtn"
                        class="btn btn-save-red">
                    Add Meters
                </button>

            </div>


            <!-- ================= ADD METER TABLE ================= -->
            <div id="serialTableWrapper" class="card mt-4" style="display:none;">
                <div class="card-header">
                    <h5 class="mb-0">Add Meter Serials</h5>
                </div>

                <div class="card-body">
                    <table class="table table-bordered" id="serialTable">
                        <thead>
                        <tr>
                            <th>Serial Number</th>
                        </tr>
                        </thead>
                        <tbody></tbody>
                    </table>

                    <button type="button" id="addRowBtn" class="btn btn-outline-primary">Add Row</button>

                    <div class="d-flex justify-content-end mt-4">
                        <button type="submit" class="btn btn-save-red">Submit All</button>
                    </div>
                </div>
            </div>




        </form>
    </div>
</div>

<jsp:include page="../../common/footer.jsp" />

<script>

    $("#manufacturerSelect").on("change", function () {
        let id = $(this).val();

        // set hidden manufacturer id
        $("#manufacturerHidden").val(id);

        // reset model
        $("#modelSelect").val("");
        $("#modelHidden").val("");

        // filter models by manufacturer
        $("#modelSelect option").each(function () {
            let m = $(this).data("manufact");
            if (!m || m == id) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    });

    $("#modelSelect").on("change", function () {
        $("#modelHidden").val($(this).val());
    });

    $("#showTableBtn").on("click", function () {

        // exit remove mode
        $("body").removeClass("remove-mode");

        $("#removeMeterWrapper").hide();
        $("#meterHeaderWrapper").show();
        $("#serialTableWrapper").slideDown();

        addRow();
    });

    $("#addRowBtn").on("click", function () {
        addRow();
    });



</script>

<script>
    function addRow() {
        $("#serialTable tbody").append(`
        <tr>
            <td>
                <input type="text"
                       name="serials"
                       class="form-control serial-input">
                <small class="text-danger serial-error" style="display:none;">
                    Serial number already exists
                </small>
            </td>
        </tr>
    `);
    }
</script>

<script>
    $(document).on("blur", ".serial-input", function () {

        let input = $(this);
        let serialNo = input.val().trim();
        let errorText = input.siblings(".serial-error");

        if (serialNo === "") return;

        $.ajax({
            url: "${pageContext.request.contextPath}/meter/checkSerial",
            method: "GET",
            data: { serialNo: serialNo },
            success: function (res) {
                if (res === "EXISTS") {
                    input.addClass("is-invalid");
                    errorText.text("Serial number already exists");
                    errorText.show();
                }
            }
        });
    });
</script>


<script>

    function setPageTitle(text) {
        $("h4, h5, .page-title").each(function () {
            if ($(this).text().trim() === "Install New Meter") {
                $(this).text(text);
            }
        });
    }


    $("#showTableBtn").on("click", function () {
        setPageTitle("Install New Meter");
    });

</script>




<script>
    $("form").on("submit", function (e) {

        let seen = {};
        let hasDuplicate = false;

        $(".serial-input").each(function () {
            let val = $(this).val().trim().toUpperCase();

            if (val === "") return;

            if (seen[val]) {
                hasDuplicate = true;
                $(this).addClass("is-invalid");
                $(this).siblings(".serial-error")
                    .text("Duplicate serial number")
                    .show();
            } else {
                seen[val] = true;
            }
        });

        if (hasDuplicate) {
            alert("Duplicate serial numbers found. Please correct them.");
            e.preventDefault();
        }
    });
</script>






</body>
</html>
