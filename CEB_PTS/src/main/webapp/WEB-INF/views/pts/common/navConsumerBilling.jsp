<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="nav bg-light bg-opacity-75">
    <div class="d-flex justify-content-around align-items-center w-100 my-1" style="padding-right:60%;">
        <div class="nav-item text-center ${param.activeSelection eq 'Dashboard' ? 'activeSelection' : ''}" style="width: 120px;">
            <a class="nav-link d-flex flex-column align-items-center" href="consumerBillingHome">
                <div class="icon-container">
                    <img src="./icons/dashboard.svg" alt="Upload Icon" style="width: 40px; height: 40px; margin-bottom: 3px;">
                </div>
                <span style="font-size: 0.8rem;">Dashboard</span>
            </a>
        </div>
        <div class="nav-item text-center ${param.activeSelection eq 'View Readings' ? 'activeSelection' : ''}" >
            <a class="nav-link d-flex flex-column align-items-center" href="viewMeterReading">
                <div class="icon-container">
                    <img src="./icons/meterSearch.svg" alt="View Icon" style="width: 40px; height: 40px;margin-bottom: 3px;">
                </div>
                <span style="font-size: 0.8rem;">Meter Search</span>
            </a>
        </div>
        <div class="nav-item text-center ${param.activeSelection eq 'Download Bill' ? 'activeSelection' : ''}" >
            <a class="nav-link d-flex flex-column align-items-center" href="downloadBill">
                <div class="icon-container">
                    <img src="./icons/billDownload.svg" alt="View Icon" style="width: 40px; height: 40px;margin-bottom: 3px;">
                </div>
                <span style="font-size: 0.8rem;">Download Bill</span>
            </a>
        </div>
    </div>


</div>
<div div class="d-flex justify-content-center w-100 py-1 navTitle">
    <p  class="titleDescription" style="display: inline; margin: 0px;">${param.description}</p>
</div>