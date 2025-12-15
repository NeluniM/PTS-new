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

        .meter-section-header {
            background-color: #ffd800 !important;
            color: #000 !important;
            font-weight: bold;
            border-color: #ffd800 !important;
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
    </style>
</head>

<body>

<jsp:include page="../../common/header.jsp" />

<div style="min-height: 850px;">

    <jsp:include page="../../common/navLisenceeBilling.jsp">
        <jsp:param name="activeSelection" value="Meter Management"/>
        <jsp:param name="description" value="Update Meter"/>
    </jsp:include>

    <div class="container meter-form-wrapper">

        <c:if test="${not empty msg}">
        <div class="alert alert-warning mt-3">${msg}</div>
        </c:if>

        <!-- ========================================================= -->
        <!-- SEARCH SECTION -->
        <!-- ========================================================= -->
        <div class="card mt-3 mb-4">
            <div class="card-header meter-section-header">
                <h5 class="mb-0">Search Meter</h5>
            </div>

            <div class="card-body">
                <form method="get" action="meterManagement/updateMeter" class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">CEB Serial No</label>
                        <input type="text"
                               name="cebSerialNo"
                               class="form-control"
                               value="${searchedCebSerialNo}">
                    </div>

                    <div class="col-md-6 d-flex align-items-end">
                        <button type="submit" class="btn btn-save-red">
                            View Meter
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- ========================================================= -->
        <!-- UPDATE FORM (SHOWN ONLY WHEN METER IS LOADED) -->
        <!-- ========================================================= -->
        <c:if test="${not empty meter}">
        <form action="meterManagement/updateMeter" method="post">

            <input type="hidden" name="HEADER_ID" value="${meterHeader.batchId}">
            <input type="hidden" name="METER_ID"  value="${meter.cebSerialNo}">
