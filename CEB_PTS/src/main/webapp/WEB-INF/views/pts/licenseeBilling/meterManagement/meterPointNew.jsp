<%@ page language="java" contentType="text/html; charset=ISO-8859-1" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8" />
    <title>Meter Points</title>

    <base href="${pageContext.request.contextPath}/" />

    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/style.css" />
</head>

<body>

<jsp:include page="../../common/header.jsp" />

<div style="min-height: 850px;">

    <jsp:include page="../../common/navLisenceeBilling.jsp">
        <jsp:param name="activeSelection" value="Meter Management"/>
        <jsp:param name="description" value="Meter Points"/>
    </jsp:include>

    <div class="container mt-4">

        <h4>New Meter Point</h4>
        <hr/>

        <form action="meterPointSave" method="post">

            <div class="form-group mt-3">
                <label>Meter Point Name</label>
                <input type="text" class="form-control" name="POINT_NAME" required />
            </div>

            <div class="form-group mt-3">
                <label>CEB Serial No</label>
                <input type="text" class="form-control" name="CEB_SERIAL_NO" required />
            </div>

            <div class="mt-4">
                <a href="meterManagement" class="btn btn-secondary">Cancel</a>
                <button type="submit" class="btn btn-primary">Save</button>
            </div>

        </form>

    </div>

</div>

<jsp:include page="../../common/footer.jsp" />

</body>
</html>
