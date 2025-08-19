<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:choose>

    <c:when test="${empty msg}">
        <table class="resultTable">
            <thead>
            <tr>
                <th>Province</th>
                <th>Day Energy</th>
                <th>Peak Energy</th>
                <th>Off Peak Energy</th>
                <th>Coincident Peak</th>
                <th>Day Energy (Adj)</th>
                <th>Peak Energy (Adj)</th>
                <th>Off Peak Energy (Adj)</th>
                <th>Coincident Peak (Adj)</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="summary" items="${SummaryList}">
                <tr>
                    <td>${summary.provinceName}</td>
                    <td class="numeric">
                        <c:choose>
                            <c:when test="${summary.dayEnergy < 0}">
                                (<fmt:formatNumber value="${summary.dayEnergy * -1}" type="number" groupingUsed="true"/>)
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${summary.dayEnergy}" type="number" groupingUsed="true"/>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="numeric">
                        <c:choose>
                            <c:when test="${summary.peakEnergy < 0}">
                                (<fmt:formatNumber value="${summary.peakEnergy * -1}" type="number" groupingUsed="true"/>)
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${summary.peakEnergy}" type="number" groupingUsed="true"/>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="numeric">
                        <c:choose>
                            <c:when test="${summary.offPeakEnergy < 0}">
                                (<fmt:formatNumber value="${summary.offPeakEnergy * -1}" type="number" groupingUsed="true"/>)
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${summary.offPeakEnergy}" type="number" groupingUsed="true"/>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="numeric">
                        <c:choose>
                            <c:when test="${summary.coincidentPeak < 0}">
                                (<fmt:formatNumber value="${summary.coincidentPeak * -1}" type="number" groupingUsed="true"/>)
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${summary.coincidentPeak}" type="number" groupingUsed="true"/>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="numeric">
                        <c:choose>
                            <c:when test="${summary.dayEnergyAdj < 0}">
                                (<fmt:formatNumber value="${summary.dayEnergyAdj * -1}" type="number" groupingUsed="true"/>)
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${summary.dayEnergyAdj}" type="number" groupingUsed="true"/>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="numeric">
                        <c:choose>
                            <c:when test="${summary.peakEnergyAdj < 0}">
                                (<fmt:formatNumber value="${summary.peakEnergyAdj * -1}" type="number" groupingUsed="true"/>)
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${summary.peakEnergyAdj}" type="number" groupingUsed="true"/>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="numeric">
                        <c:choose>
                            <c:when test="${summary.offPeakEnergyAdj < 0}">
                                (<fmt:formatNumber value="${summary.offPeakEnergyAdj * -1}" type="number" groupingUsed="true"/>)
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${summary.offPeakEnergyAdj}" type="number" groupingUsed="true"/>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="numeric">
                        <c:choose>
                            <c:when test="${summary.coincidentPeakAdj < 0}">
                                (<fmt:formatNumber value="${summary.coincidentPeakAdj * -1}" type="number" groupingUsed="true"/>)
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${summary.coincidentPeakAdj}" type="number" groupingUsed="true"/>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:when>

    <c:otherwise>
        <div class="msg error-msg">${msg}</div>
    </c:otherwise>

</c:choose>