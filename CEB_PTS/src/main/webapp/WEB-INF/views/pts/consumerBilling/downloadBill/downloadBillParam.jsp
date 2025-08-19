<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<form:form id ="myForm"  method="post"   enctype="application/x-www-form-urlencoded" action="/PTS/downloadBillBulkSupply"
           modelAttribute="model">
    <div class="mb-5">
        <div class="card">
            <div class="container mt-4 mb-4" style="width: 45%;">
                <div class="row">
                    <div class="col" >
                        <div class="selectUnit">
                            <label>Bill Cycle</label>
                            <div class="input-group" style="width: 200px">
                                <form:input  type="text" id="billCycle" name="billCycle" class="form-control" path="billCycle"/>
                            </div>
                        </div>
                    </div>
                    <div class="col" >
                        <div class="selectUnit">
                            <label>Account No</label>
                            <div class="input-group" style="width: 200px">
                                <form:input  type="text" id="accountNumber" name="accountNumber" class="form-control" path="accountNumber"/>
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="ml-5 pt-3">
                            <input type="submit" class="btn btnClick" id="click_btn" value="Download Bill" onclick="submitForm()">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form:form>

<style>
    .selectUnit label, .selectUnit select {
        font-size: small;
        margin: 0;
    }
</style>
<script>

    function submitForm() {
        document.getElementById('myForm').submit();
    }
</script>