<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<table id="dataTable" >
    <c:forEach var="txn" items="${invoiceTXNlist}">
        <tr>
            <td style="text-align: left">${txn.description}</td>
            <td style="text-align: right"><fmt:formatNumber value="${txn.charge}" type="number" groupingUsed="true" minFractionDigits="2" maxFractionDigits="2"/></td>
            <td style="border: 1px solid #FFFFFF; width: 60px;"><button class="btn btn-sm">Edit</button></td>
            <td style="border: 1px solid #FFFFFF; width: 75px;"><button class="btn btn-sm deleteTxn" txnId="${txn.txnId}">Delete</button></td>
        </tr>
    </c:forEach>
</table>

<style>
    #dataTable {
        width: 80%;
        border-collapse: collapse;
        margin-top: 10px;
        table-layout: fixed;
        align-self: center;
    }
    #dataTable th, #dataTable td {
        border: 1px solid #ddd;
        padding: 4px;
        text-align: center;
        font-size: 14px;
    }
</style>

