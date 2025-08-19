<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css' />">

<style>
    .preTable{

        width: 100%;
        font-size: 0.9rem;
        margin-bottom: 50px;
    }
    .preTable td {
        padding: 4px;
        border: 1px solid #dddddd;
        color: #000000;
    }
    .preTable th {
        background-color: #FFD900;
        color: #000000;
        padding: 8px;
        border: 1px solid #f6f6f6;
        font-weight: normal;
    }
    .preTable tr:nth-child(even) {
        background-color: #f2f2f2;
    }
</style>

    <table class="preTable">
    <thead>
    <tr>
        <th>Tariff Type</th>
        <th>Valid From</th>
        <th>Valid Till</th>
        <th>Tariff Name</th>
        <th>Rate</th>

    </tr>
    </thead>
    <tbody>
    <c:set var="currentTariffType" value="" />
    <c:set var="tariffTypeCount" value="0" />
    <c:set var="tariffTypeRowspan" value="0" />

    <!-- First pass: count non-current tariffs by type -->
    <c:forEach var="tariff" items="${tariffList}">
        <c:if test="${tariff.isCurrent == 0 && tariff.tarrifType != currentTariffType}">
            <c:set var="currentTariffType" value="${tariff.tarrifType}" />
            <c:set var="tariffTypeCount" value="0" />
            <c:forEach var="innerTariff" items="${tariffList}">
                <c:if test="${innerTariff.isCurrent == 0 && innerTariff.tarrifType == currentTariffType}">
                    <c:set var="tariffTypeCount" value="${tariffTypeCount + 1}" />
                </c:if>
            </c:forEach>
        </c:if>
    </c:forEach>

    <!-- Second pass: render table with merged cells for non-current tariffs only -->
    <c:set var="currentTariffType" value="" />
    <c:set var="isFirstOfType" value="true" />

    <c:forEach var="tariff" items="${tariffList}" varStatus="status">
        <!-- Only display if isCurrent = 0 -->
        <c:if test="${tariff.isCurrent == 0}">
            <c:set var="tariffTypeCount" value="0" />

            <!-- Count occurrences of current tariff type (only non-current tariffs) -->
            <c:forEach var="countTariff" items="${tariffList}">
                <c:if test="${countTariff.isCurrent == 0 && countTariff.tarrifType == tariff.tarrifType}">
                    <c:set var="tariffTypeCount" value="${tariffTypeCount + 1}" />
                </c:if>
            </c:forEach>

            <tr data-tariff-id="${tariff.tariffId}"
                data-is-current="${tariff.isCurrent}"
                class="non-current-tariff readonly-row">

                <!-- Only show tariff type cell for first occurrence -->
                <c:if test="${tariff.tarrifType != currentTariffType}">
                    <td rowspan="${tariffTypeCount}" class="tariff-type-cell">${tariff.tarrifType}</td>
                    <c:set var="currentTariffType" value="${tariff.tarrifType}" />
                </c:if>

                <td>${tariff.validFrom}</td>
                <td>${tariff.validTill}</td>
                <td>${tariff.tariffName}</td>
                <td class="text-end text-right">${tariff.rate}</td>
<%--                <td>--%>
<%--                    <span class="badge badge-secondary">Inactive</span>--%>
<%--                </td>--%>
            </tr>
        </c:if>
    </c:forEach>

    <!-- Show message if no non-current tariffs found -->
    <c:if test="${empty tariffList}">
        <tr>
            <td colspan="6" class="text-center text-muted">No previous tariff records found</td>
        </tr>
    </c:if>
    </tbody>
</table>
