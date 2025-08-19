<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<c:if test="${not empty model.successMessage}">

    <%--<!-- Success message box -->--%>
<%--    <div style="margin-right: 10%; margin-left: 10%;">--%>
        <div id="successMsg" class="msg success-msg" >
            <c:out value="${model.successMessage}" escapeXml="true" />
        </div>
<%--    </div>--%>
<%--    <div id="successMsg" class="alert alert-success">--%>
<%--        <fmt:message key="${model.successMessage}" />--%>
<%--        success Message--%>
<%--    </div>--%>
</c:if>


<c:if test="${not empty model.errorMessage}">

<%--    <div style="margin-left: 10% ; margin-right: 10%">--%>
    <div id="errorMsg" class="msg error-msg">
        <c:out value="${model.errorMessage}" escapeXml="true" />
    </div>
<%--    </div>--%>
</c:if>

<c:if test="${not empty alertScript}">
    ${alertScript}
</c:if>


<%--<!-- Success Message Script -->--%>
<%--<c:if test="${not empty model.successMessage}">--%>
<%--    <script>--%>
<%--        $(document).ready(function () {--%>
<%--            var msg = `<c:out value="${model.successMessage}" escapeXml="true" />`;--%>
<%--            var formattedMsg = msg.replace(/\n/g, "<br>");--%>
<%--            console.log("Alert message in JSP (success): " + msg);--%>
<%--            $('#successMsg').html(formattedMsg).fadeIn();--%>
<%--            //setTimeout(() => $('#successMsg').fadeOut(), 21000);--%>
<%--        });--%>
<%--    </script>--%>
<%--</c:if>--%>

<%--<!-- Error Message Script -->--%>
<%--<c:if test="${not empty model.errorMessage}">--%>
<%--    <script>--%>
<%--        $(document).ready(function () {--%>
<%--            var msg = `<c:out value="${model.errorMessage}" escapeXml="true" />`;--%>
<%--            var formattedMsg = msg.replace(/\n/g, "<br>");--%>
<%--            console.log("Alert message in JSP (error): " + msg);--%>
<%--            $('#errorMsg').html(formattedMsg).fadeIn();--%>
<%--            //   setTimeout(() => $('#errorMsg').fadeOut(), 21000);--%>
<%--        });--%>
<%--    </script>--%>
<%--</c:if>--%>

<%--<c:if test="${not empty model.errorMessage}">--%>
<%--<div>errorMsg</div>--%>
<%--</c:if>--%>