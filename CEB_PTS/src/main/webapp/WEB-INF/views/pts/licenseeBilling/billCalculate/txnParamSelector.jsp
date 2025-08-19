<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div id="txnCont" class="container">

<div class="top-section" style="margin-right: 5px;">
    <div style="display: flex; justify-content: center; align-items: center;">
        <div class="selectUnit" style="margin-right: 10px;">
            <div class="input-group">
                <c:if test="${not empty txnList}">
                    <select id="typeDropdown" class="form-control" >
                        <c:forEach var="txn" items="${txnList}">
                            <option value="${txn.txnName}" label="${txn.txnName}" code="${txn.txnCode}"></option>
                        </c:forEach>
                    </select>
                </c:if>
            </div>
        </div>

        <input type="text" id="prop" placeholder="Property" class="form-control" style="margin-right: 10px; width: 200px;">

        <p style="font-size: 16px; font-weight: bold; margin: 0px 10px 0px 0px;">:</p>

        <input type="number" id="val" placeholder="Value" class="form-control" style="margin-right: 10px; width: 200px;">

        <button id="addButton" class="btn btnClick">Add</button>

    </div>
</div>

<div id="txnParamTable" style="margin-top: 10px; display: flex; justify-content: center;">
    <jsp:include page="txnParamTable.jsp" />
</div>

</div>

<script>
    $(document).ready(function () {

        //-----------------------------------------------
        //   add new invoiceTXN
        //-----------------------------------------------

        $('#addButton').click(function () {
            const code = $('#typeDropdown option:selected').attr("code");
            const type = $('#typeDropdown').val();
            const prop = $('#prop').val();
            const val = $('#val').val();

            const billCycle = $('#billCycle').val();
            const division = $('#divisionDropdown').val();

            const jsonData = {
                "billCycleNo": billCycle,
                "licenseCode": division,
                "txnCode": code,
                "description": type + " "+ prop,
                "charge": val
            };

            // Send the JSON data to the server
            $.ajax({
                url: '/PTS/addInvoiceTxn',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(jsonData),
                success: function (response) {
                    // Optionally, you can handle the response here
                    $('#txnParamTable').html(response);
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                    alert('Failed to submit parameters.');
                }
            });
        });


        //-----------------------------------------------
        //   fetch invoiceTXN list with division change
        //-----------------------------------------------

        $('#divisionDropdown').change(function () {
            const billCycle = $('#billCycle').val();
            const division = $(this).val();

            $.ajax({
                url: '/PTS/getInvoiceTxn',
                type: 'GET',
                data: {
                    billCycle: billCycle,
                    division: division
                },
                success: function (response) {
                    $('#txnParamTable').html(response);
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        });

        //------------------------------------------------
        //       edit and delete
        //------------------------------------------------

        $(document).on('click', '.deleteTxn', function () {
            const txnId = $(this).attr('txnId');
            const billCycle = $('#billCycle').val();
            const division = $('#divisionDropdown').val();

            $.ajax({
                url: '/PTS/deleteInvoiceTxn',
                type: 'POST',
                data: {
                    txnId: txnId,
                    billCycle: billCycle,
                    division: division
                },
                success: function (response) {
                    $('#txnParamTable').html(response);
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        });
    });

</script>

<style>
    #txnCont{
        display: flex;
        justify-content: center;
        flex-direction: column;
        align-items: center;
        min-height: 100px;
        border: 1px solid #a6a6a6;
        padding: 15px;
        border-radius: 5px;
        width:65%;
        margin-bottom: 20px;
    }
    #dataTable {
        width: 80%;
        border-collapse: collapse;
        margin-top: 10px;
        table-layout: fixed;
        align-self: center;
    }
    #dataTable th, #dataTable td {
        border: 1px solid #ddd;
        padding: 5px;
        text-align: center;
    }
</style>