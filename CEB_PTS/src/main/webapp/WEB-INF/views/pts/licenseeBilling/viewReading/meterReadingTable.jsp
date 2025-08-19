<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div>
    <c:choose>
        <c:when test="${not empty msg}">
            <div class="msg error-msg">${msg}</div>
            <span class="filler"></span>
        </c:when>
        <c:otherwise>
            <c:set var="rowIndex" value="1" />
            <table class="resultTable">
                <thead>
                <tr>
                    <th>#</th>
                    <th>CEB area office</th>
                    <th>Primary substation</th>
                    <th>Serial Number</th>
                    <th>Status</th>
                    <th>Time of use</th>
                    <th>Reading on ${currentDate}</th>
                    <th>Reading on ${previousDate}</th>
                    <th>Energy in three intervals ${billMonth} ${billYear} (kWh)</th>
                    <th>Total Energy in ${billMonth} ${billYear} (kWh)</th>
                    <th>Component of Coincident Peak Demand (kW) <br> ${coincidentPeakDate} at ${coincidentPeakTime}</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${meterReadingFileList}" var="meterReadingFile" varStatus="fileStatus">
                    <c:choose>
                        <c:when test="${not empty meterReadingFile.meterReadingRecordModels}">
                            <c:forEach items="${meterReadingFile.meterReadingRecordModels}" var="processRecord" varStatus="status">
                                <tr>
                                    <c:if test="${status.index == 0}">
                                        <td rowspan="6">${rowIndex}</td>
                                        <td rowspan="6">${meterReadingFile.area}</td>
                                        <td rowspan="6">${meterReadingFile.pss}</td>
                                        <td rowspan="6"><a class="serialNoLink" href="meterSearch?billCycle=${billCycle}&serialNo=${meterReadingFile.serialNo}">${meterReadingFile.serialNo}</a></td>
                                        <td rowspan="6">${meterReadingFile.status}<br><div class="errorReason">${meterReadingFile.errorReason}</div></td>
                                        <c:set var="rowIndex" value="${rowIndex + 1}" />
                                    </c:if>
                                    <td class="type">${processRecord.measure}</td>
                                    <td class="numeric">
                                        <fmt:formatNumber value="${processRecord.currentReading}" type="number" groupingUsed="true"/>
                                    </td>
                                    <td class="numeric">
                                        <fmt:formatNumber value="${processRecord.previousReading}" type="number" groupingUsed="true"/>
                                    </td>
                                    <td class="numeric">
                                        <c:choose>
                                            <c:when test="${processRecord.energy < 0}">
                                                (<fmt:formatNumber value="${processRecord.energy * -1}" type="number" groupingUsed="true"/>)
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:formatNumber value="${processRecord.energy}" type="number" groupingUsed="true"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <c:choose>
                                        <c:when test="${status.index < 3}">
                                            <c:if test="${status.index == 0}">
                                                <td class="numeric" rowspan="3">
                                                    <c:choose>
                                                        <c:when test="${meterReadingFile.exportEnergy < 0}">
                                                            (<fmt:formatNumber value="${meterReadingFile.exportEnergy * -1}" type="number" groupingUsed="true"/>)
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:formatNumber value="${meterReadingFile.exportEnergy}" type="number" groupingUsed="true"/>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <c:if test="${status.index == 3}">
                                                <td class="numeric" rowspan="3">
                                                    <c:choose>
                                                        <c:when test="${meterReadingFile.importEnergy < 0}">
                                                            (<fmt:formatNumber value="${meterReadingFile.importEnergy * -1}" type="number" groupingUsed="true"/>)
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:formatNumber value="${meterReadingFile.importEnergy}" type="number" groupingUsed="true"/>
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
                                                        <c:when test="${meterReadingFile.exportCoincidentPeak > 0}">
                                                            <fmt:formatNumber value="${meterReadingFile.exportCoincidentPeak}" type="number" groupingUsed="true"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            .
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <c:if test="${status.index == 3}">
                                                <td class="numeric" rowspan="3">
                                                    <c:choose>
                                                        <c:when test="${meterReadingFile.importCoincidentPeak < 0}">
                                                            (<fmt:formatNumber value="${meterReadingFile.importCoincidentPeak * -1}" type="number" groupingUsed="true"/>)
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
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td>${rowIndex}</td>
                                <td>${meterReadingFile.area}</td>
                                <td>${meterReadingFile.pss}</td>
                                <td><a class="serialNoLink" href="meterSearch?billCycle=${billCycle}&serialNo=${meterReadingFile.serialNo}">${meterReadingFile.serialNo}</a></td>
                                <td>${meterReadingFile.status}<br><div class="errorReason">${meterReadingFile.errorReason}</div></td>
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

            <div class="d-flex w-100 justify-content-end pt-3 pb-3">
                <input type="submit" class="btn btnClick" id="view_reading_print" value="Print">
            </div>
        </c:otherwise>
    </c:choose>
</div>


<script>
    $(document).ready(function() {
        console.log("Ready to print view reading");

        const bc = $('#billCycle').val();
        const div = $('#divisionDropdown').val();
        //-------------------------------------------------------------------
        //            bill finalize
        //-------------------------------------------------------------------

        // $('#fin_btn').click(function () {
        //
        //     $.ajax({
        //         url: '/PTS/finalizeBill',
        //         type: 'POST',
        //         data: {
        //             billCycle: bc,
        //             division: div
        //         },
        //         success: function (response) {
        //             //refresh the page
        //             location.reload();
        //         },
        //         error: function (xhr, status, error) {
        //             console.error('Error finalizing bill:', error);
        //         }
        //     });
        // });


        //-------------------------------------------------------------------
        //            print invoice
        //-------------------------------------------------------------------

        const button = $('#view_reading_print');

        button.click(function(e) {
            e.preventDefault(); // Prevent form submission
            printEnergyBill();
        });

        /*function printInvoice() {

           // alert('printInvoice')
            button.val('Printing...').prop('disabled', true);

            $.ajax({
                url: '/PTS/printInv',
                method: 'GET',
                data: {
                    division: div,
                    billCycle: bc
                },
                success: function(response) {
                    button.val('Print').prop('disabled', false);
                },
                error: function(xhr, status, error) {
                    button.val('Print').prop('disabled', false);
                }
            });
        }*/

        function printEnergyBill() {
            button.val('Printing...').prop('disabled', true);
            console.log("Printing view reading for division: " + div + ", bill cycle: " + bc);

            $.ajax({
                url: '/PTS/printEnergyBill',
                method: 'GET',
                data: {
                    billCycle: bc,
                    division: div
                },
                xhrFields: {
                    responseType: 'blob' // Expect binary data (PDF)
                },
                success: function(response, status, xhr) {
                    button.val('Print').prop('disabled', false);

                    // Create a blob from the response
                    const blob = new Blob([response], { type: 'application/pdf' });

                    // Create a URL for the blob
                    const url = window.URL.createObjectURL(blob);

                    // Open PDF in a new tab
                    window.open(url, '_blank');
                },
                error: function(xhr, status, error) {
                    button.val('Print').prop('disabled', false);
                    console.error('Error printing invoice:', error);
                }
            });
        }



    });

</script>