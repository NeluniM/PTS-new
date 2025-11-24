<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="nav bg-light bg-opacity-75">
    <div class="d-flex justify-content-around align-items-center w-100 my-1">

        <div class="nav-item text-center" style="width: 130px;">
            <a class="nav-link d-flex flex-column align-items-center ${param.activeSelection eq 'Dashboard' ? 'activeSelection' : ''}" href="licenseeBillingHome">
                <div class="icon-container">
                    <img src="./icons/dashboard.svg" alt="Upload Icon" style="width: 40px; height: 40px; margin-bottom: 3px;">
                </div>
                <span style="font-size: 0.8rem;">Dashboard</span>
            </a>
        </div>

        <div class="nav-item text-center" style="width: 130px;">
            <a class="nav-link d-flex flex-column align-items-center ${param.activeSelection eq 'Upload Files' ? 'activeSelection' : ''}" href="uploadFile">
                <div class="icon-container">
                    <img src="./icons/uploadFile.svg" alt="Upload Icon" style="width: 40px; height: 40px; margin-bottom: 3px;">
                </div>
                <span style="font-size: 0.8rem;">Upload Files</span>
            </a>
        </div>

        <div class="nav-item text-center" style="width: 130px;">
            <a class="nav-link d-flex flex-column align-items-center ${param.activeSelection eq 'View Files' ? 'activeSelection' : ''}" href="viewFile">
                <div class="icon-container">
                    <img src="./icons/viewFile.svg" alt="View Icon" style="width: 40px; height: 40px;margin-bottom: 3px;">
                </div>
                <span style="font-size: 0.8rem;">View Files</span>
            </a>
        </div>

        <div class="nav-item text-center" style="width: 145px;">
            <a class="nav-link d-flex flex-column align-items-center ${param.activeSelection eq 'Process Readings' ? 'activeSelection' : ''}" href="processMeterReading">
                <div class="icon-container">
                    <img src="./icons/process.svg" alt="Process Icon" style="width: 40px; height: 40px;margin-bottom: 3px;">
                </div>
                <span style="font-size: 0.8rem;">Process Readings</span>
            </a>
        </div>

        <div class="nav-item text-center" style="width: 130px;">
            <a class="nav-link d-flex flex-column align-items-center ${param.activeSelection eq 'View Readings' ? 'activeSelection' : ''}" href="viewMeterReading">
                <div class="icon-container">
                    <img src="./icons/view.svg" alt="Search Icon" style="width: 40px; height: 40px;margin-bottom: 3px;">
                </div>
                <span style="font-size: 0.8rem;">View Readings</span>
            </a>
        </div>

        <div class="nav-item text-center" style="width: 130px;">
            <a class="nav-link d-flex flex-column align-items-center ${param.activeSelection eq 'Meter Search' ? 'activeSelection' : ''}" href="meterSearch">
                <div class="icon-container">
                    <img src="./icons/meterSearch.svg" alt="Search Icon" style="width: 40px; height: 40px;margin-bottom: 3px;">
                </div>
                <span style="font-size: 0.8rem;">Meter Search</span>
            </a>
        </div>

        <div class="nav-item text-center" style="width: 130px;">
            <a class="nav-link d-flex flex-column align-items-center ${param.activeSelection eq 'Bill Calculate' ? 'activeSelection' : ''}" href="billCalc">
                <div class="icon-container">
                    <img src="./icons/billCalc.svg" alt="Search Icon" style="width: 40px; height: 40px;margin-bottom: 3px;">
                </div>
                <span style="font-size: 0.8rem;">Bill Calculate</span>
            </a>
        </div>

        <div class="nav-item text-center" style="width: 130px;">
            <a class="nav-link d-flex flex-column align-items-center ${param.activeSelection eq 'Invoice' ? 'activeSelection' : ''}" href="invoice">
                <div class="icon-container">
                    <img src="./icons/invoice.svg" alt="Search Icon" style="width: 40px; height: 40px;margin-bottom: 3px;">
                </div>
                <span style="font-size: 0.8rem;">Invoice</span>
            </a>
        </div>

        <div class="nav-item text-center" style="width: 130px;">
            <a class="nav-link d-flex flex-column align-items-center ${param.activeSelection eq 'Tariff' ? 'activeSelection' : ''}" href="tariff">
                <div class="icon-container">
                    <img src="./icons/tariff.svg" alt="Search Icon" style="width: 40px; height: 40px;margin-bottom: 3px;">
                </div>
                <span style="font-size: 0.8rem;">Tariff</span>
            </a>
        </div>

        <div class="nav-item text-center" style="width: 130px;">
            <a class="nav-link d-flex flex-column align-items-center ${param.activeSelection eq 'Config' ? 'activeSelection' : ''}" href="config">
                <div class="icon-container">
                    <img src="./icons/config.svg" alt="Search Icon" style="width: 40px; height: 40px;margin-bottom: 3px;">
                </div>
                <span style="font-size: 0.8rem;">Config</span>
            </a>
        </div>

        <div class="nav-item text-center" style="width: 160px;">
            <a class="nav-link d-flex flex-column align-items-center ${param.activeSelection eq 'Meter Management' ? 'activeSelection' : ''}" href="meterManagement">
                <div class="icon-container">
                    <img src="./icons/meterManagement.svg" alt="Meter Management Icon" style="width: 40px; height: 40px; margin-bottom: 3px;">
                </div>
                <span style="font-size: 0.8rem; white-space: nowrap;">Meter Management</span>
            </a>
        </div>





    </div>


</div>

<div div class="d-flex justify-content-center w-100 py-1 navTitle" >
    <p  class="titleDescription" style="display: inline; margin: 0px;">${param.description}</p>
</div>