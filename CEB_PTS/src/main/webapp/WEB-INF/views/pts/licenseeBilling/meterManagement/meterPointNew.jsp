<%@ page language="java" contentType="text/html; charset=ISO-8859-1" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8" />
    <title>Meter Points</title>

    <base href="${pageContext.request.contextPath}/" />

    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/style.css" />
    <link rel="shortcut icon" href="img/favicon.png" />

    <!-- ? REQUIRED: jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>

<body>

<jsp:include page="../../common/header.jsp" />

<div style="min-height: 850px;">

    <jsp:include page="../../common/navLisenceeBilling.jsp">
        <jsp:param name="activeSelection" value="Meter Management"/>
        <jsp:param name="description" value="Meter Points"/>
    </jsp:include>

    <div class="container mt-4">
        <div class="card">
            <div class="card-body">

                <form method="post" action="saveMeterPoint">

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Serial No</label>
                                <input type="text" class="form-control" name="SERIAL_NO">
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label>CEB Serial No</label>
                                <input type="text" class="form-control" name="CEB_SERIAL_NO">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Meter Point Name</label>
                                <input type="text" class="form-control" name="METER_POINT_NAME">
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Meter Point Code</label>
                                <input type="text" class="form-control" name="METER_POINT_CODE">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Area Code</label>
                                <input type="text" class="form-control" name="AREA_CODE">
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Substation Type</label>
                                <select class="form-control" name="SUBSTATION_TYPE">
                                    <option value="">-- Select --</option>
                                    <option value="PRIMARY">Primary Substation</option>
                                    <option value="SECONDARY">Secondary Substation</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-group col-md-6">
                            <label>Point Type</label>
                            <select class="form-control" name="POINT_TYPE_ID" required>
                                <option value="">-- Select --</option>
                                <option value="3">Boundary Meter</option>
                                <option value="1">Transformer</option>
                                <option value="2">Feeder</option>
                            </select>
                        </div>


                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Licensee Code</label>
                                <select name="LICENSEE_CODE" id="licensee" onchange="toggleProvince()" required>
                                    <option value="">-- Select --</option>
                                    <option value="CEB">CEB</option>
                                    <option value="LECO">LECO</option>
                                </select>

                            </div>
                        </div>
                    </div>

                    <!-- Province Codes -->
                    <div class="row">

                        <div id="cebDiv">
                        <label>CEB Province Code</label>
                        <input type="text" name="CEB_PROVINCE_CODE">
                        </div>

                        <div id="lecoDiv" style="display:none;">
                            <label>LECO Province Code</label>
                            <input type="text" name="LECO_PROVINCE_CODE">
                        </div>


                        <div class="row mt-4">
                            <div class="col-md-12 text-end">
                                <button type="submit" class="btn btn-danger">
                                    Save
                                </button>

                                <a href="${pageContext.request.contextPath}/meterManagement"
                                   class="btn btn-secondary ms-2">
                                    Cancel
                                </a>
                            </div>
                        </div>


                    </div>

                </form>

            </div>
        </div>
    </div>

</div>

<jsp:include page="../../common/footer.jsp" />

<script>
    document.addEventListener("DOMContentLoaded", function () {

        const licenseeSelect = document.getElementById("licenseeSelect");
        const cebDiv = document.getElementById("cebProvinceDiv");
        const lecoDiv = document.getElementById("lecoProvinceDiv");

        // hide initially
        cebDiv.style.display = "none";
        lecoDiv.style.display = "none";

        licenseeSelect.addEventListener("change", function () {
            const value = this.value;

            if (value === "LECO") {
                cebDiv.style.display = "block";
                lecoDiv.style.display = "block";
            }
            else if (value === "CEB") {
                cebDiv.style.display = "block";
                lecoDiv.style.display = "none";
            }
            else {
                cebDiv.style.display = "none";
                lecoDiv.style.display = "none";
            }
        });
    });
</script>

<script>
    function toggleProvince() {
        let licensee = document.getElementById("licensee").value;

        document.getElementById("cebDiv").style.display =
            licensee === "CEB" ? "block" : "none";

        document.getElementById("lecoDiv").style.display =
            licensee === "LECO" ? "block" : "none";
    }
</script>


</body>
</html>
