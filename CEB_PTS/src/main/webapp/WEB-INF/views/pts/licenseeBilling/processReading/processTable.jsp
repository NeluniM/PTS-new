<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="out" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div>
    <c:choose>
        <c:when test="${not empty msg}">
            <div class="msg error-msg">${msg}</div>
            <span class="filler"></span>
        </c:when>
        <c:otherwise>
            <table class="resultTable">
                <thead>
                <tr>
                    <th>#</th>
                    <th>CEB area office</th>
                    <th>Primary substation</th>
                    <th>Serial Number</th>
                    <th>Status</th>
                    <th>File</th>
                    <th>Time of use</th>
                    <th>Reading on ${currentDate}</th>
                    <th>Reading on ${previousDate}</th>
                    <th>Energy in three intervals ${billMonth} ${billYear} (kWh)</th>
                    <th>Total Energy in ${billMonth} ${billYear} (kWh)</th>
                    <th>Component of Coincident Peak Demand (MW) <br> ${coincidentPeakDate} at ${coincidentPeakTime}</th>
                </tr>
                </thead>
                <tbody id="resultTableBody">
                <c:set var="rowIndex" value="1" />
                <c:forEach items="${processSummary}" var="reading" varStatus="readingStatus">
                    <c:choose>
                        <c:when test="${not empty reading.meterReadingRecordModelList}">
                            <c:forEach items="${reading.meterReadingRecordModelList}" var="record" varStatus="status">
                                <tr>
                                    <c:if test="${status.index == 0}">
                                        <td rowspan="6">${rowIndex}</td>
                                        <td rowspan="6">${reading.area}</td>
                                        <td rowspan="6">${reading.pss}</td>
                                        <td rowspan="6"><a class="serialNoLink" href="meterSearch?billCycle=${billCycle}&serialNo=${reading.serialNo}">${reading.serialNo}</a></td>
                                        <td rowspan="6">${reading.status}<br><div class="errorReason">${reading.errorReason}</div></td>
                                        <td rowspan="6">${reading.fileName}</td>
                                    </c:if>
                                    <td class="type">${record.measure}</td>
                                    <td class="numeric"><fmt:formatNumber value="${record.currentReading}" type="number" groupingUsed="true"/></td>
                                    <td class="numeric"><fmt:formatNumber value="${record.previousReading}" type="number" groupingUsed="true"/></td>
                                    <td class="numeric">
                                        <c:choose>
                                            <c:when test="${record.energy < 0}">
                                                (<fmt:formatNumber value="${record.energy * -1}" type="number" groupingUsed="true"/>)
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:formatNumber value="${record.energy}" type="number" groupingUsed="true"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <c:choose>
                                        <c:when test="${status.index < 3}">
                                            <c:if test="${status.index == 0}">
                                                <td class="numeric" rowspan="3">
                                                    <c:choose>
                                                        <c:when test="${reading.exportEnergy < 0}">
                                                            (<fmt:formatNumber value="${reading.exportEnergy * -1}" type="number" groupingUsed="true"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:formatNumber value="${reading.exportEnergy}" type="number" groupingUsed="true"/>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <c:if test="${status.index == 3}">
                                                <td class="numeric" rowspan="3">
                                                    <c:choose>
                                                        <c:when test="${reading.importEnergy < 0}">
                                                            (<fmt:formatNumber value="${reading.importEnergy * -1}" type="number" groupingUsed="true"/>)
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:formatNumber value="${reading.importEnergy}" type="number" groupingUsed="true"/>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${status.index < 3}">
                                            <c:if test="${status.index == 0}">
                                                <td class="numeric" rowspan="3">
                                                <c:choose>
                                                    <c:when test="${reading.exportCoincidentPeak > 0}">
                                                        <fmt:formatNumber value="${reading.exportCoincidentPeak}" type="number" groupingUsed="true"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        .
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <c:if test="${status.index == 3}">
                                                <td class="numeric" rowspan="3">
                                                    <c:choose>
                                                        <c:when test="${reading.importCoincidentPeak < 0}">
                                                            (<fmt:formatNumber value="${reading.importCoincidentPeak * -1}" type="number" groupingUsed="true"/>)
                                                        </c:when>
                                                        <c:otherwise>
                                                            .
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </tr>
                                <c:if test="${status.last}">
                                    <c:set var="rowIndex" value="${rowIndex + 1}" />
                                </c:if>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td>${rowIndex}</td>
                                <td>${reading.area}</td>
                                <td>${reading.pss}</td>
                                <td><a class="serialNoLink" href="meterSearch?billCycle=${billCycle}&serialNo=${reading.serialNo}">${reading.serialNo}</a></td>
                                <td>${reading.status}<br><div class="errorReason">${reading.errorReason}</div></td>
                                <td>${reading.fileName}</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <c:set var="rowIndex" value="${rowIndex + 1}" />
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                </tbody>
            </table>

            <p>Total :</p>
            <table class="resultTable">
                <thead>
                <tr>
                    <th></th>
                    <th>Total Energy ${billMonth} ${billYear}</th>
                    <th>Total Energy  with Upward Adjustment ${billMonth} ${billYear}</th>
                </thead>
                <tbody>
                <tr>
                    <td>Day (kWh)</td>
                    <td class="numeric">
                        <c:choose>
                            <c:when test="${energySummary.dayEnergy < 0}">
                                (<fmt:formatNumber value="${energySummary.dayEnergy * -1}" type="number" groupingUsed="true"/>)
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${energySummary.dayEnergy}" type="number" groupingUsed="true"/>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="numeric">
                        <c:choose>
                            <c:when test="${energySummary.dayEnergyAdj < 0}">
                                (<fmt:formatNumber value="${energySummary.dayEnergyAdj * -1}" type="number" groupingUsed="true"/>)
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${energySummary.dayEnergyAdj}" type="number" groupingUsed="true"/>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <td>Peak (kWh)</td>
                    <td class="numeric">
                        <c:choose>
                            <c:when test="${energySummary.peakEnergy < 0}">
                                (<fmt:formatNumber value="${energySummary.peakEnergy * -1}" type="number" groupingUsed="true"/>)
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${energySummary.peakEnergy}" type="number" groupingUsed="true"/>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="numeric">
                        <c:choose>
                            <c:when test="${energySummary.peakEnergyAdj < 0}">
                                (<fmt:formatNumber value="${energySummary.peakEnergyAdj * -1}" type="number" groupingUsed="true"/>)
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${energySummary.peakEnergyAdj}" type="number" groupingUsed="true"/>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <td>Off Peak (kWh)</td>
                    <td class="numeric">
                        <c:choose>
                            <c:when test="${energySummary.offPeakEnergy < 0}">
                                (<fmt:formatNumber value="${energySummary.offPeakEnergy * -1}" type="number" groupingUsed="true"/>)
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${energySummary.offPeakEnergy}" type="number" groupingUsed="true"/>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="numeric">
                        <c:choose>
                            <c:when test="${energySummary.offPeakEnergyAdj < 0}">
                                (<fmt:formatNumber value="${energySummary.offPeakEnergyAdj * -1}" type="number" groupingUsed="true"/>)
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${energySummary.offPeakEnergyAdj}" type="number" groupingUsed="true"/>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr class="total-row">
                    <td><strong>Total Energy (kWh)</strong></td>
                    <td class="numeric">
                        <strong>
                            <c:set var="total" value="${energySummary.dayEnergy + energySummary.peakEnergy + energySummary.offPeakEnergy}" />
                            <c:choose>
                                <c:when test="${total < 0}">
                                    (<fmt:formatNumber value="${total * -1}" type="number" groupingUsed="true"/>)
                                </c:when>
                                <c:otherwise>
                                    <fmt:formatNumber value="${total}" type="number" groupingUsed="true"/>
                                </c:otherwise>
                            </c:choose>
                        </strong>
                    </td>
                    <td class="numeric">
                        <strong>
                            <c:set var="total" value="${energySummary.dayEnergyAdj + energySummary.peakEnergyAdj + energySummary.offPeakEnergyAdj}" />
                            <c:choose>
                                <c:when test="${total < 0}">
                                    (<fmt:formatNumber value="${total * -1}" type="number" groupingUsed="true"/>)
                                </c:when>
                                <c:otherwise>
                                    <fmt:formatNumber value="${total}" type="number" groupingUsed="true"/>
                                </c:otherwise>
                            </c:choose>
                        </strong>
                    </td>
                </tr>
                <tr>
                    <td>Component of Peak demand (MW)</td>
                    <td class="numeric">
                        <c:choose>
                            <c:when test="${energySummary.coincidentPeak < 0}">
                                (<fmt:formatNumber value="${energySummary.coincidentPeak * -1}" type="number" groupingUsed="true"/>)
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${energySummary.coincidentPeak}" type="number" groupingUsed="true"/>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td class="numeric">
                        <c:choose>
                            <c:when test="${energySummary.coincidentPeakAdj < 0}">
                                (<fmt:formatNumber value="${energySummary.coincidentPeakAdj * -1}" type="number" groupingUsed="true"/>)
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${energySummary.coincidentPeakAdj}" type="number" groupingUsed="true"/>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>