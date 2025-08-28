<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css' />">

<style>
    .preTable{
        width: 100%;
        font-size: 0.9rem;
        margin-bottom: 30px;
    }
    .preTable td { padding: 4px; border: 1px solid #dddddd; color: #000000; }
    .preTable th { background-color: #FFD900; color: #000000; padding: 8px; border: 1px solid #f6f6f6; font-weight: normal; }
    .preTable tr:nth-child(even) { background-color: #f2f2f2; }

    .group-heading{
        font-weight: 600;
        margin: 14px 0 6px 0;
    }
    .muted{
        color: #666;
        font-weight: 400;
        margin-left: 6px;
        font-size: .9rem;
    }
</style>

<%-- Build a unique list of validFrom dates for non-current tariffs --%>
<c:set var="seenDates" value="," />

<c:forEach var="t" items="${tariffList}">
    <c:if test="${t.isCurrent == 0}">
        <c:set var="dateKey" value="${t.validFrom}" />
        <c:set var="needle" value=",${dateKey}," />

        <c:if test="${!fn:contains(seenDates, needle)}">
            <%-- Mark date as seen --%>
            <c:set var="seenDates" value="${seenDates}${dateKey}," />

            <%-- Get ONE 'validTill' for this date (print only once) --%>
            <c:set var="shownTill" value="false" />
            <c:set var="oneValidTill" value="" />
            <c:forEach var="anyRow" items="${tariffList}" varStatus="s">
                <c:if test="${!shownTill && anyRow.isCurrent == 0 && anyRow.validFrom == dateKey}">
                    <c:set var="oneValidTill" value="${anyRow.validTill}" />
                    <c:set var="shownTill" value="true" />
                </c:if>
            </c:forEach>

            <div class="group-heading">
                Effective From: <span><c:out value="${dateKey}"/></span>
                <span class="muted">(Till: <c:out value="${oneValidTill}"/>)</span>
            </div>

            <table class="preTable">
                <thead>
                <tr>
                    <th>Tariff Type</th>
                    <th>Tariff Name</th>
                    <th>Rate</th>
                </tr>
                </thead>
                <tbody>
                    <%-- Per-table tracker for rowspans inside this date group --%>
                <c:set var="currentTariffType" value="" />

                    <%-- All rows for this date only --%>
                <c:forEach var="tariff" items="${tariffList}">
                    <c:if test="${tariff.isCurrent == 0 && tariff.validFrom == dateKey}">

                        <%-- Count rows of same type within this date to compute rowspan --%>
                        <c:set var="tariffTypeCount" value="0" />
                        <c:forEach var="countTariff" items="${tariffList}">
                            <c:if test="${countTariff.isCurrent == 0
                             && countTariff.validFrom == dateKey
                             && countTariff.tarrifType == tariff.tarrifType}">
                                <c:set var="tariffTypeCount" value="${tariffTypeCount + 1}" />
                            </c:if>
                        </c:forEach>

                        <tr class="non-current-tariff readonly-row">
                            <c:if test="${tariff.tarrifType != currentTariffType}">
                                <td rowspan="${tariffTypeCount}" class="tariff-type-cell">${tariff.tarrifType}</td>
                                <c:set var="currentTariffType" value="${tariff.tarrifType}" />
                            </c:if>
                            <td>${tariff.tariffName}</td>
                            <td class="text-end text-right">${tariff.rate}</td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
        </c:if>
    </c:if>
</c:forEach>

<%-- If there were no previous tariffs at all --%>
<c:if test="${empty tariffList}">
    <table class="preTable">
        <thead>
        <tr>
            <th>Tariff Type</th>
            <th>Tariff Name</th>
            <th>Rate</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td colspan="3" class="text-center text-muted">No previous tariff records found</td>
        </tr>
        </tbody>
    </table>
</c:if>
