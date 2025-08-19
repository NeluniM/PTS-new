<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:choose>
    <c:when test="${not empty msg}">
        <div class="msg error-msg">${msg}</div>
    </c:when>
</c:choose>

<table class="resultTable">
    <tr>
        <td colspan="3">Distribution License</td>
        <td colspan="4">Distribution license 5 - Lanka Electricity Company (Pvt) Ltd.</td>
    </tr>
    <tr>
        <td colspan="3">Billing Month</td>
        <td colspan="4">${billMonth} ${billYear}</td>
    </tr>
    <tr>
        <td colspan="3">Invoice Date</td>
        <td colspan="4">${invoiceDate}</td>
    </tr>
    <tr>
        <td colspan="7" style="font-weight: bold">Energy Consumption (kWh)</td>
    </tr>
    <tr>
        <td rowspan="2" colspan="2">Time Interval Of The Day</td>
        <td rowspan="2">Unit</td>
        <td>Interval 1</td>
        <td>Interval 2</td>
        <td>Interval 3</td>
        <td rowspan="2">Total</td>
    </tr>
    <tr>
        <td>Day</td>
        <td>Peak</td>
        <td>Off-Peak</td>
    </tr>
    <tr>
        <td colspan="2">Energy</td>
        <td>kWh</td>
        <td class="numeric"><fmt:formatNumber value="${invoice.dayEnergy}" type="number" groupingUsed="true"/></td>
        <td class="numeric"><fmt:formatNumber value="${invoice.peakEnergy}" type="number" groupingUsed="true"/></td>
        <td class="numeric"><fmt:formatNumber value="${invoice.offPeakEnergy}" type="number" groupingUsed="true"/></td>
        <td class="numeric"><fmt:formatNumber value="${invoice.totalEnergy}" type="number" groupingUsed="true"/></td>
    </tr>
    <tr>
        <td colspan="2">Applicable Tariff</td>
        <td>Rs./kWh</td>
        <td class="numeric"><fmt:formatNumber value="${invoice.dayTariff}" type="number" groupingUsed="true" minFractionDigits="2" maxFractionDigits="2"/></td>
        <td class="numeric"><fmt:formatNumber value="${invoice.peakTariff}" type="number" groupingUsed="true" minFractionDigits="2" maxFractionDigits="2"/></td>
        <td class="numeric"><fmt:formatNumber value="${invoice.offPeakTariff}" type="number" groupingUsed="true" minFractionDigits="2" maxFractionDigits="2"/></td><td></td>
    </tr>
    <tr>
        <td colspan="2">Bulk Supply Energy Charge For The Month</td>
        <td>Rs.</td>
        <td class="numeric"><fmt:formatNumber value="${invoice.dayEnergyCharge}" type="number" groupingUsed="true" minFractionDigits="2" maxFractionDigits="2"/></td>
        <td class="numeric"><fmt:formatNumber value="${invoice.peakEnergyCharge}" type="number" groupingUsed="true" minFractionDigits="2" maxFractionDigits="2"/></td>
        <td class="numeric"><fmt:formatNumber value="${invoice.offPeakEnergyCharge}" type="number" groupingUsed="true" minFractionDigits="2" maxFractionDigits="2"/></td>
        <td class="numeric"><fmt:formatNumber value="${invoice.totalEnergyCharge}" type="number" groupingUsed="true" minFractionDigits="2" maxFractionDigits="2"/></td>
    </tr>
    <tr>
        <td colspan="7" style="font-weight: bold">Coincident Peak Capacity Demand</td>
    </tr>
    <tr>
        <td colspan="3">Date And Time Of The Recorded Peak Demand Of The Month</td>
        <td colspan="2">${coincidentPeakDate} | ${coincidentPeakTime}</td>
        <td colspan="2">${recordedPeakDemand}</td>
    </tr>
    <tr>
        <td colspan="2">Component Of The Coincident Peak Demand (MW)</td>
        <td></td>
        <td colspan="4" class="numeric"><fmt:formatNumber value="${invoice.coincidentPeak}" type="number" groupingUsed="true"/></td>
    </tr>
    <tr>
        <td colspan="2">Bulk Supply Capacity Tariff</td>
        <td>Rs./MW</td>
        <td colspan="4" class="numeric"><fmt:formatNumber value="${invoice.capacityTariff}" type="number" groupingUsed="true" minFractionDigits="2" maxFractionDigits="2"/></td>
    </tr>
    <tr>
        <td colspan="2">Bulk Supply Capacity Charge</td>
        <td>Rs.</td>
        <td colspan="4" class="numeric"><fmt:formatNumber value="${invoice.capacityCharge}" type="number" groupingUsed="true" minFractionDigits="2" maxFractionDigits="2"/></td>
    </tr>
    <tr>
        <td colspan="5" style="font-weight: bold">Total Charges For ${billMonth} ${billYear}</td>
        <td colspan="2" class="numeric"><fmt:formatNumber value="${invoice.monthlyTotalCharge}" type="number" groupingUsed="true" minFractionDigits="2" maxFractionDigits="2"/></td>
    </tr>
    <c:forEach var="txn" items="${invoiceTXNlist}">
        <tr>
            <td colspan="5">${txn.description}</td>
            <td colspan="2" class="numeric"><fmt:formatNumber value="${txn.charge}" type="number" groupingUsed="true" minFractionDigits="2" maxFractionDigits="2"/></td>
        </tr>
    </c:forEach>
    <tr style="border-top: #0a0a0a solid 3px;">
        <td colspan="5" style="font-weight: bold">Total Transaction Invoice Value For ${billMonth} ${billYear}</td>
        <td colspan="2" class="numeric"><fmt:formatNumber value="${invoice.totalInvoiceCharge}" type="number" groupingUsed="true" minFractionDigits="2" maxFractionDigits="2"/></td>
    </tr>
</table>

<c:if test="${invoice.isCalcClosed == 0}">
    <div class="d-flex w-100 justify-content-start pt-3 pb-3 mb-5">
        <input type="submit" class="btn btnClick" id="fin_btn" value="Conform Bill">
    </div>
</c:if>

<c:if test="${invoice.isCalcClosed == 1}">
    <div class="d-flex w-100 justify-content-end pt-3 pb-3 mb-5">
        <input type="submit" class="btn btnClick" id="print_btn" value="Print">
    </div>
</c:if>


<script>
    $(document).ready(function() {

        const bc = $('#billCycle').val();
        const div = $('#divisionDropdown').val();
        //-------------------------------------------------------------------
        //            bill finalize
        //-------------------------------------------------------------------

        $('#fin_btn').click(function () {

            $.ajax({
                url: '/PTS/finalizeBill',
                type: 'POST',
                data: {
                    billCycle: bc,
                    division: div
                },
                success: function (response) {
                    //refresh the page
                    location.reload();
                },
                error: function (xhr, status, error) {
                    console.error('Error finalizing bill:', error);
                }
            });
        });


        //-------------------------------------------------------------------
        //            print invoice
        //-------------------------------------------------------------------

        const button = $('#print_btn');

        button.click(function(e) {
            e.preventDefault(); // Prevent form submission
            printInvoice();
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

        function printInvoice() {
            button.val('Printing...').prop('disabled', true);

            $.ajax({
                url: '/PTS/printInv',
                method: 'GET',
                data: {
                    division: div,
                    billCycle: bc
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