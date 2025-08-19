
<style>

    .page-container {
        display: flex;
        width: 100%;
        min-height: 100vh;
    }

    .left-column,

    .right-column {
        width: 50%;
        padding: 0;
        box-sizing: border-box;
        overflow-y: auto;
    }

    .column-separator {
        width: 1px;
        background-color: #ccc;
        box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
    }



    /* Original styles */
    .selectUnit label, .selectUnit select, .selectUnit input[type="radio"], .selectUnit span {
        font-size: small;
        margin: 10px;
    }

    /* Add styling for the radio button containers */
    #isUploadLockedDisplay, #isCurrentDisplay, #isUploadLockedEdit, #isCurrentEdit,
    #provinceActiveDisplay, #provinceStatusDisplay, #provinceActiveEdit, #provinceStatusEdit {
        font-size: small;
        margin-top: 5px;
    }

    /* Add some spacing between radio options */
    .selectUnit input[type="radio"] {
        margin-right: 5px;
    }

    .selectUnit label + label {
        margin-left: 15px;
    }
</style>
<div class="page-container">
    <jsp:include page="provinceConfig.jsp" />

    <div class="column-separator"></div>

    <jsp:include page="billCycleConfig.jsp" />

<%--    <div class="column-separator"></div>--%>


</div>
