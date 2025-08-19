<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:choose>

<c:when test="${sessionScope.loggedUserRole.equals('DGM') && sessionScope.deptId.equals('380.00')}">
		<%@ include file="user-levels/userPTSDGM.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('EE') && sessionScope.deptId.equals('380.00')}">
		<%@ include file="user-levels/userPTSDGM.jsp" %>
	</c:when>
	<c:when test="${sessionScope.loggedUserRole.equals('ACCNT') && sessionScope.deptId.equals('380.00')}">
		<%@ include file="user-levels/userPTSDGM.jsp" %>
	</c:when>
	

<c:when test="${sessionScope.loggedUserRole.equals('AGM') && sessionScope.deptId.equals('600.41')}">
		<%@ include file="user-levels/userEE.jsp" %>
	</c:when>

	<c:when test="${sessionScope.loggedUserRole.equals('DGM') && sessionScope.deptId.equals('600.41')}">
		<%@ include file="user-levels/userEE.jsp" %>
	</c:when>


	<c:when test="${sessionScope.loggedUserRole.equals('CE') && sessionScope.deptId.equals('600.41')}">
		<%@ include file="user-levels/userEE.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('EE') && sessionScope.deptId.equals('600.41')}">
		<%@ include file="user-levels/userEE.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('ES') && sessionScope.deptId.equals('600.41')}">
		<%@ include file="user-levels/userES.jsp" %>
	</c:when>
	<c:when test="${sessionScope.loggedUserRole.equals('DEO') && sessionScope.deptId.equals('600.41')}">
		<%@ include file="user-levels/userDEO.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('AGM') && sessionScope.deptId.equals('972.30')}">
		<%@ include file="user-levels/userEE.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('DGM') && sessionScope.deptId.equals('972.30')}">
		<%@ include file="user-levels/userEE.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('CE') && sessionScope.deptId.equals('972.30')}">
		<%@ include file="user-levels/userEE.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('EE') && sessionScope.deptId.equals('972.30')}">
		<%@ include file="user-levels/userEE.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('ES') && sessionScope.deptId.equals('972.30')}">
		<%@ include file="user-levels/userES.jsp" %>
	</c:when>
	<c:when test="${sessionScope.loggedUserRole.equals('DEO') && sessionScope.deptId.equals('972.30')}">
		<%@ include file="user-levels/userDEO.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('DGM') && sessionScope.deptId.equals('972.20')}">
		<%@ include file="user-levels/userDEOSUB.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('CE') && sessionScope.deptId.equals('972.20')}">
		<%@ include file="user-levels/userDEOSUB.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('EE') && sessionScope.deptId.equals('972.20')}">
		<%@ include file="user-levels/userDEOSUB.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('ES') && sessionScope.deptId.equals('972.20')}">
		<%@ include file="user-levels/userDEOSUB.jsp" %>
	</c:when>
	<c:when test="${sessionScope.loggedUserRole.equals('DEO') && sessionScope.deptId.equals('972.20')}">
		<%@ include file="user-levels/userDEOSUB.jsp" %>
	</c:when>
	
	
	
	
	
	 <c:when test="${sessionScope.loggedUserRole.equals('DGM') && sessionScope.deptId.equals('600.42')}">
		<%@ include file="user-levels/userDEOSUB.jsp" %>
	</c:when>
		
	<c:when test="${sessionScope.loggedUserRole.equals('CE') && sessionScope.deptId.equals('600.42')}">
		<%@ include file="user-levels/userDEOSUB.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('EE') && sessionScope.deptId.equals('600.42')}">
		<%@ include file="user-levels/userDEOSUB.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('ES') && sessionScope.deptId.equals('600.42')}">
		<%@ include file="user-levels/userDEOSUB.jsp" %>
	</c:when>
	 <c:when test="${sessionScope.loggedUserRole.equals('DEO') && sessionScope.deptId.equals('600.42')}">
		<%@ include file="user-levels/userDEOSUB.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('DGM') && sessionScope.deptId.equals('597.00')}">
		<%@ include file="user-levels/userDEOSUB.jsp" %>
	</c:when>
		
	<c:when test="${sessionScope.loggedUserRole.equals('CE') && sessionScope.deptId.equals('597.00')}">
		<%@ include file="user-levels/userDEOSUB.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('EE') && sessionScope.deptId.equals('597.00')}">
		<%@ include file="user-levels/userDEOSUB.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('ES') && sessionScope.deptId.equals('597.00')}">
		<%@ include file="user-levels/userDEOSUB.jsp" %>
	</c:when>
	 <c:when test="${sessionScope.loggedUserRole.equals('DEO') && sessionScope.deptId.equals('597.00')}">
		<%@ include file="user-levels/userDEOSUB.jsp" %>
	</c:when>
	
	
	
	
	
	<c:when test="${sessionScope.loggedUserRole.equals('DGM') && sessionScope.deptId.equals('780.20')}">
		<%@ include file="user-levels/userDEOSUB.jsp" %>
	</c:when>
		
	<c:when test="${sessionScope.loggedUserRole.equals('CE') && sessionScope.deptId.equals('780.20')}">
		<%@ include file="user-levels/userDEOSUB.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('EE') && sessionScope.deptId.equals('780.20')}">
		<%@ include file="user-levels/userDEOSUB.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('ES') && sessionScope.deptId.equals('780.20')}">
		<%@ include file="user-levels/userDEOSUB.jsp" %>
	</c:when>
	 <c:when test="${sessionScope.loggedUserRole.equals('DEO') && sessionScope.deptId.equals('780.20')}">
		<%@ include file="user-levels/userDEOSUB.jsp" %>
	</c:when>
	
	
	<c:when test="${sessionScope.loggedUserRole.equals('AGM') && sessionScope.deptId.equals('780.00')}">
		<%@ include file="user-levels/userEE.jsp" %>
	</c:when>
	
	
	<c:when test="${sessionScope.loggedUserRole.equals('DGM') && sessionScope.deptId.equals('780.00')}">
		<%@ include file="user-levels/userEE.jsp" %>
	</c:when>
	<c:when test="${sessionScope.loggedUserRole.equals('DGM') && sessionScope.deptId.equals('780.00')}">
		<%@ include file="user-levels/userEE.jsp" %>
	</c:when>
	
	
	<c:when test="${sessionScope.loggedUserRole.equals('CE') && sessionScope.deptId.equals('780.00')}">
		<%@ include file="user-levels/userEE.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('EE') && sessionScope.deptId.equals('780.00')}">
		<%@ include file="user-levels/userEE.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('ES') && sessionScope.deptId.equals('780.00')}">
		<%@ include file="user-levels/userES.jsp" %>
	</c:when>
	<c:when test="${sessionScope.loggedUserRole.equals('DEO') && sessionScope.deptId.equals('780.00')}">
		<%@ include file="user-levels/userDEO.jsp" %>
	</c:when>
	
	
	<c:when test="${sessionScope.loggedUserRole.equals('DGM') && sessionScope.deptId.equals('780.00')}">
		<%@ include file="user-levels/userEE.jsp" %>
	</c:when>
	<c:when test="${sessionScope.loggedUserRole.equals('DGM') && sessionScope.deptId.equals('780.00')}">
		<%@ include file="user-levels/userEE.jsp" %>
	</c:when>
	
	
	<c:when test="${sessionScope.loggedUserRole.equals('CE') && sessionScope.deptId.equals('596.00')}">
		<%@ include file="user-levels/userEE.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('EE') && sessionScope.deptId.equals('596.00')}">
		<%@ include file="user-levels/userEE.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('ES') && sessionScope.deptId.equals('596.00')}">
		<%@ include file="user-levels/userES.jsp" %>
	</c:when>
	<c:when test="${sessionScope.loggedUserRole.equals('DEO') && sessionScope.deptId.equals('596.00')}">
		<%@ include file="user-levels/userDEO.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('DGM') && sessionScope.deptId.equals('596.00')}">
		<%@ include file="user-levels/userEE.jsp" %>
	</c:when>
	<c:when test="${sessionScope.loggedUserRole.equals('DGM') && sessionScope.deptId.equals('596.00')}">
		<%@ include file="user-levels/userEE.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('DEO') && sessionScope.deptId.equals('600.42')}">
		<%@ include file="user-levels/userDEOSUB.jsp" %>
	</c:when>
	<c:when test="${sessionScope.loggedUserRole.equals('EE') && sessionScope.deptId.equals('452.00')}">
		<%@ include file="user-levels/userAE.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('AGM')}">
		<%@ include file="user-levels/userOther.jsp" %>
	</c:when>
	
	<c:when test="${sessionScope.loggedUserRole.equals('ADMIN')}">
		<%@ include file="user-levels/userOther.jsp" %>
	</c:when>
	
	
	 <c:when test="${sessionScope.branchCode.equals('CONSTRUCTION')}">
		<%@ include file="user-levels/userOther.jsp" %>		
	</c:when>
	<c:when test="${sessionScope.branchCode.equals('DM')}">
		<%@ include file="user-levels/userOther.jsp" %>		
	</c:when>
	<c:when test="${sessionScope.branchCode.equals('EM')}">
		<%@ include file="user-levels/userEM.jsp" %>		
	</c:when>
	<c:when test="${sessionScope.branchCode.equals('CW')}">
		<%@ include file="user-levels/userAM.jsp" %>		
	</c:when>
	
	<c:when test="${sessionScope.branchCode.equals('COMMERCIAL')}">
		<%@ include file="user-levels/userOther.jsp" %>	
	</c:when>
	<c:when test="${sessionScope.deptId.equals('340.00')}">
		<%@ include file="user-levels/userEETM.jsp" %>
	</c:when>
	
	
	<c:otherwise>
		<%@ include file="user-levels/userAE.jsp" %>
	</c:otherwise>	
</c:choose>	