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

    <!-- IMPORTANT -->
    <base href="${pageContext.request.contextPath}/" />

    <!-- CSS + JS same as other pages -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link rel="shortcut icon" href="img/favicon.png" />

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

    <style>
        .meter-form-wrapper {
            max-width: 900px;
            margin: 30px auto;
        }

        /* yellow header style for Search / Meter Header / Meter Details */
        .meter-section-header {
            background-color: #ffd800 !important;
            color: #000 !important;
            font-weight: bold;
            border-color: #ffd800 !important;
        }
    </style>
</head>

<body>

<!-- HEADER -->
<jsp:include page="../../common/header.jsp" />

<div style="min-height: 850px;">

    <!-- NAV -->
    <jsp:include page="../../common/navLisenceeBilling.jsp">
        <jsp:param name="activeSelection" value="Meter Management"/>
        <jsp:param name="description" value="Update Meter"/>
    </jsp:include>

    <!-- PAGE CONTENT -->
    <div class="container meter-form-wrapper">

        <!-- OPTIONAL MESSAGE -->
        <c:if test="${not empty msg}">
            <div class="alert alert-warning mt-3" role="alert">
                    ${msg}
            </div>
        </c:if>

        <!-- SEARCH BAR -->
        <div class="card mt-3 mb-4">
            <div class="card-header meter-section-header">
                <h5 class="mb-0">Search Meter</h5>
            </div>
            <div class="card-body">
                <form method="get" action="meterManagement/updateMeter" class="row g-3">
                    <div class="col-md-6">
                        <label for="searchCebSerial" class="form-label">CEB Serial No</label>
                        <input type="text"
                               id="searchCebSerial"
                               name="cebSerialNo"
                               class="form-control"
                               value="${searchedCebSerialNo}">
                    </div>
                    <div class="col-md-6 d-flex align-items-end">
                        <button type="submit"
                                class="btn"
                                style="background-color:#7D0000; border-color:#7D0000; color:#fff;">
                            View Meter
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- ONLY SHOW FORM IF A METER IS LOADED -->
        <c:if test="${not empty meter}">

            <!-- ONE FORM WRAPPING BOTH CARDS -->
            <form action="meterManagement/updateMeter" method="post">

                <!-- hidden IDs -->
                <input type="hidden" name="HEADER_ID" value="${meterHeader.batchId}" />
                <input type="hidden" name="METER_ID" value="${meter.cebSerialNo}" />

                <!-- ========================= CARD 1: METER HEADER DETAILS ========================= -->
                <div class="card mt-3">
                    <div class="card-header meter-section-header">
                        <h5 class="mb-0">Meter Header Details</h5>
                    </div>

                    <div class="card-body">

                        <!-- BATCH_ID (Required) -->
                        <div class="form-group mb-3">
                            <label>Batch ID <span style="color:red">*</span></label>
                            <input type="text"
                                   class="form-control"
                                   name="BATCH_ID"
                                   value="${meterHeader.batchId}"
                                   required>
                        </div>

                        <!-- Row 1 -->
                        <div class="row">
                            <div class="col-md-6">
                                <label>Accuracy Class</label>
                                <input type="text"
                                       class="form-control"
                                       name="ACCURACY_CLASS"
                                       value="${meterHeader.accuracyClass}">
                            </div>

                            <div class="col-md-6">
                                <label>Batch No</label>
                                <input type="text"
                                       class="form-control"
                                       name="BATCH_NO"
                                       value="${meterHeader.batchNo}">
                            </div>
                        </div>

                        <!-- Row 2 -->
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <label>Current Rating (Number)</label>
                                <input type="number"
                                       step="0.01"
                                       class="form-control"
                                       name="CURRENT_RATING3"
                                       value="${meterHeader.currentRating3}">
                            </div>

                            <div class="col-md-6">
                                <label>Initiated By</label>
                                <input type="text"
                                       class="form-control"
                                       name="INITIATED_BY"
                                       value="${meterHeader.initiatedBy}">
                            </div>
                        </div>

                        <!-- Row 3 -->
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <label>Manufactured Year</label>
                                <input type="text"
                                       class="form-control"
                                       name="MANUFACTURED_YEAR"
                                       value="${meterHeader.manufacturedYear}">
                            </div>

                            <div class="col-md-6">
                                <label>Procured Date</label>
                                <input type="date"
                                       class="form-control"
                                       name="PROCURED_DATE"
                                       value="${meterHeader.procuredDate}">
                            </div>
                        </div>

                        <!-- Row 4 -->
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <label>Quantity</label>
                                <input type="number"
                                       step="0.01"
                                       class="form-control"
                                       name="QUANTITY"
                                       value="${meterHeader.quantity}">
                            </div>

                            <div class="col-md-6">
                                <label>Status</label>
                                <select class="form-control" name="STATUS">
                                    <option value="AVL" ${meterHeader.status == 'AVL' ? 'selected' : ''}>AVL</option>
                                    <option value="NA"  ${meterHeader.status == 'NA'  ? 'selected' : ''}>NA</option>
                                </select>
                            </div>
                        </div>

                        <!-- Row 5 -->
                        <div class="row mt-3">
                            <div class="col-md-12">
                                <label>Remark</label>
                                <textarea class="form-control"
                                          name="REMARK"
                                          rows="2">${meterHeader.remark}</textarea>
                            </div>
                        </div>

                        <!-- Row 6 -->
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <label>Updated By</label>
                                <input type="text"
                                       class="form-control"
                                       name="UPDATED_BY"
                                       value="${meterHeader.updatedBy}">
                            </div>

                            <div class="col-md-6">
                                <label>Updated Date</label>
                                <input type="date"
                                       class="form-control"
                                       name="UPDATED_DATE"
                                       value="${meterHeader.updatedDate}">
                            </div>
                        </div>

                        <!-- Row 7 -->
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <label>Manufact ID</label>
                                <input type="number"
                                       class="form-control"
                                       name="MANUFACT_ID"
                                       value="${meterHeader.manufactId}">
                            </div>

                            <div class="col-md-6">
                                <label>Model ID</label>
                                <input type="number"
                                       class="form-control"
                                       name="MODEL_ID"
                                       value="${meterHeader.meterModel != null ? meterHeader.meterModel.id : ''}">
                            </div>
                        </div>

                        <!-- Row 8 -->
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <label>Current Rating (Text)</label>
                                <input type="text"
                                       class="form-control"
                                       name="CURRENT_RATING"
                                       value="${meterHeader.currentRating}">
                            </div>

                            <div class="col-md-6">
                                <label>Created By</label>
                                <input type="text"
                                       class="form-control"
                                       name="CREATED_BY"
                                       value="${meterHeader.createdBy}">
                            </div>
                        </div>

                        <!-- Row 9 -->
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <label>Created Date</label>
                                <input type="date"
                                       class="form-control"
                                       name="CREATED_DATE"
                                       value="${meterHeader.createdDate}">
                            </div>
                        </div>

                    </div>
                </div>

                <!-- ========================= CARD 2: METER DETAILS ========================= -->
                <div class="card mt-4">
                    <div class="card-header meter-section-header">
                        <h5 class="mb-0">Meter Details</h5>
                    </div>

                    <div class="card-body">

                        <!-- CEB Serial No -->
                        <div class="form-group mb-3">
                            <label>CEB Serial No <span style="color:red">*</span></label>
                            <input type="text"
                                   class="form-control"
                                   name="CEB_SERIAL_NO"
                                   value="${meter.cebSerialNo}"
                                   required>
                        </div>

                        <!-- Row: Batch ID / Current Rating (string) -->
                        <div class="row">
                            <div class="col-md-6">
                                <label>Meter Batch ID</label>
                                <input type="text"
                                       class="form-control"
                                       name="MTR_BATCH_ID"
                                       value="${meterHeader.batchId}">
                            </div>

                            <div class="col-md-6">
                                <label>Meter Current Rating</label>
                                <input type="text"
                                       class="form-control"
                                       name="MTR_CURRENT_RATING"
                                       value="${meter.currentRating}">
                            </div>
                        </div>

                        <!-- Row: Modified Date / Serial No -->
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <label>Modified Date</label>
                                <input type="date"
                                       class="form-control"
                                       name="MTR_MODIFIED_DATE"
                                       value="${meter.modifiedDate}">
                            </div>

                            <div class="col-md-6">
                                <label>Serial No</label>
                                <input type="text"
                                       class="form-control"
                                       name="MTR_SERIAL_NO"
                                       value="${meter.serialNo}">
                            </div>
                        </div>

                        <!-- Row: Status / Remark -->
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <label>Meter Status</label>
                                <select class="form-control" name="MTR_STATUS">
                                    <option value="AVL" ${meter.status == 'AVL' ? 'selected' : ''}>AVL</option>
                                    <option value="NA"  ${meter.status == 'NA'  ? 'selected' : ''}>NA</option>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label>Meter Remark</label>
                                <textarea class="form-control"
                                          name="MTR_REMARK"
                                          rows="2">${meter.remark}</textarea>
                            </div>
                        </div>

                        <!-- Row: Updated By / Updated Date -->
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <label>Meter Updated By</label>
                                <input type="text"
                                       class="form-control"
                                       name="MTR_UPDATED_BY"
                                       value="${meter.updatedBy}">
                            </div>

                            <div class="col-md-6">
                                <label>Meter Updated Date</label>
                                <input type="date"
                                       class="form-control"
                                       name="MTR_UPDATED_DATE"
                                       value="${meter.updatedDate}">
                            </div>
                        </div>

                        <!-- Row: Created By / Created Date -->
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <label>Meter Created By</label>
                                <input type="text"
                                       class="form-control"
                                       name="MTR_CREATED_BY"
                                       value="${meter.createdBy}">
                            </div>

                            <div class="col-md-6">
                                <label>Meter Created Date</label>
                                <input type="date"
                                       class="form-control"
                                       name="MTR_CREATED_DATE"
                                       value="${meter.createdDate}">
                            </div>
                        </div>

                    </div>
                </div>

                <!-- ============ COMMON BUTTONS FOR BOTH CARDS ============ -->
                <div class="d-flex justify-content-end mt-4 mb-4">
                    <a href="meterManagement/meterHome" class="btn btn-outline-secondary me-2">Cancel</a>
                    <button type="submit"
                            class="btn"
                            style="background-color:#7D0000; border-color:#7D0000; color:#fff;">
                        Update
                    </button>
                </div>

            </form>
        </c:if>

    </div>
</div>

<!-- FOOTER -->
<jsp:include page="../../common/footer.jsp" />

</body>
</html>
