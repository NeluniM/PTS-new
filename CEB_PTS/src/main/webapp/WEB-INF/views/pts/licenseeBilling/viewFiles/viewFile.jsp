<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="out" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet">

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>Power Trading System</title>
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Include jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <!-- Include jQuery UI -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <!-- <link rel="manifest" href="site.webmanifest"> -->
    <link rel="shortcut icon" type="image/x-icon" href="img/favicon.png" />
    <!-- Place favicon.ico in the root directory -->

    <!-- CSS here -->
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/owl.carousel.min.css" />
    <link rel="stylesheet" href="css/magnific-popup.css" />
    <link rel="stylesheet" href="css/font-awesome.min.css" />
    <link rel="stylesheet" href="css/themify-icons.css" />
    <link rel="stylesheet" href="css/nice-select.css" />
    <link rel="stylesheet" href="css/flaticon.css" />
    <link rel="stylesheet" href="css/gijgo.css" />
    <link rel="stylesheet" href="css/animate.css" />
    <link rel="stylesheet" href="css/slicknav.css" />
    <link rel="stylesheet" href="css/style.css" />
    <link href="//fonts.googleapis.com/css?family=Open+Sans:400,600,700,300|Titillium+Web:200,300,400"
          rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.0/fullcalendar.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">
    <!-- <link rel="stylesheet" href="css/responsive.css"> -->

</head>

<body>
<!-- ---------------------------------------------------------------------------------- -->
<!--                         HEADER                                                     -->
<!-- ---------------------------------------------------------------------------------- -->

<jsp:include page="../../common/header.jsp"/>

<!-- ---------------------------------------------------------------------------------- -->
<!--                         CONTENT                                                    -->
<!-- ---------------------------------------------------------------------------------- -->
<div style="min-height: 850px;">

<jsp:include page="../../common/navLisenceeBilling.jsp">
    <jsp:param name="activeSelection" value="View Files"/>
    <jsp:param name="description" value="View & Lock Uploaded Files By Division"/>
</jsp:include>

<jsp:include page="fileSelector.jsp">
    <jsp:param name="btnName" value="View" />
</jsp:include>

<div id="tableContainer" class="container"></div>
<div id="tableContainer1" class="container"></div>
<div id="tableContainer2" class="container"></div>

<div class="container mt-5">
    <c:if test="${not empty groupedUploadDetails}">
        <table class="resultTable" aria-label="Grouped Upload Details">
            <button class="btn btnClick" onclick="lockSelectedProvinces()">Lock</button>
            <br>
            <br>
            <thead>
            <tr>
                <th><input type="checkbox" id="selectAllCheckbox" onclick="toggleSelectAll(this)" aria-label="Select All" /></th>
                <th>Province</th>
                <th>File Name</th>
                <th>Uploaded By</th>
                <th>Uploaded Date</th>
                    <%--                <th>Action</th>--%>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="entry" items="${groupedUploadDetails}">
                <c:set var="provinceName" value="${entry.key}" />
                <c:set var="files" value="${entry.value}" />
                <c:set var="isLocked" value="${lockedProvinces[provinceName]}" />
                <c:forEach var="file" items="${files}" varStatus="loopStatus">
                    <tr class="${isLocked ? 'locked-province' : ''}">
                        <c:if test="${loopStatus.index == 0}">
                            <td rowspan="${files.size()}">
                                <input
                                        type="checkbox"
                                        class="provinceCheckbox"
                                        value="${provinceName}"
                                        data-billcycle="${param.billCycle}"
                                        data-licensecode="${param.division}"
                                        data-provincecode="${file.province}"
                                        data-locked="${isLocked}"
                                    ${isLocked ? "disabled checked" : ""}
                                />
                                <c:if test="${isLocked}">
                                    <span class="text-danger">(Locked)</span>
                                </c:if>
                            </td>
                            <td rowspan="${files.size()}">
                                    ${provinceName}
                                <c:if test="${isLocked}">
                                    <span class="text-danger">(Locked)</span>
                                </c:if>
                            </td>
                        </c:if>
                            <%--                        <td><a href="${pageContext.request.contextPath}/downloadZipFile?billCycle=${param.billCycle}&licensee=${param.division}&province=${provinceName}&fileName=${file.fileName}" target="_blank">--%>
                            <%--                            <i class="fa fa-download" aria-hidden="true"></i>--%>
                            <%--                            ${file.fileName}--%>
                            <%--                        </a></td>--%>
                        <td><i class="fa fa-download" aria-hidden="true" onclick="downloadZipFile('${param.billCycle}', '${param.division}', '${provinceName}','${file.fileName}' )"></i> ${file.fileName}</td>

                        <td>${file.uploadedBy}</td>
                            <%--                        <td>${file.uploadedDate}</td>--%>
                        <td>${fn:substring(fn:replace(file.uploadedDate, 'T', ' '), 0, 16)}</td>

                    </tr>
                </c:forEach>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>
<div id="loadingSpinner" style="display: none;">
    <p>Loading...</p>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Dynamically fetch lock status for each province
        document.querySelectorAll('.provinceCheckbox').forEach(cb => {
            const billCycle = cb.dataset.billcycle;
            const licenseCode = cb.dataset.licensecode;
            const provinceCode = cb.dataset.provincecode;

            console.log("Fetching lock status for province:", provinceCode, "Bill Cycle:", billCycle, "License Code:", licenseCode);

            if (provinceCode) {
                $.ajax({
                    url: '/PTS/provinceConfig',
                    type: 'GET',
                    data: { billCycleNo: billCycle, licenseCode: licenseCode},
                    success: function (response) {
                        if (response.provinceConfig && response.provinceConfig.isUploadLocked === 1) {
                            cb.disabled = true;
                            cb.checked = true;
                            cb.setAttribute('data-locked', 'true');
                            const labelCell = cb.closest('tr').querySelector('td:nth-child(2)');
                            if (labelCell && !labelCell.innerHTML.includes('Locked')) {
                                labelCell.innerHTML += ' <span class="text-danger">(Locked)</span>';
                            }
                        }
                    },
                    error: function (xhr) {
                        console.error('Error fetching province config:', xhr.responseText);
                    }
                });
            }
        });
    });
</script>


<script>
    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('.provinceCheckbox').forEach(cb => {
            if (cb.dataset.locked === 'true') {
                cb.disabled = true;
                cb.checked = true;
            }
        });
    });

    function toggleSelectAll(selectAllCheckbox) {
        const checkboxes = document.querySelectorAll('.provinceCheckbox');
        checkboxes.forEach(cb => {
            if (!cb.disabled) {
                cb.checked = selectAllCheckbox.checked;
            }
        });
    }

    function lockSelectedProvinces() {
        const selectedCheckboxes = document.querySelectorAll('.provinceCheckbox:checked:not([disabled])');
        if (selectedCheckboxes.length === 0) {
            alert('Please select at least one province to lock.');
            return;
        }
        selectedCheckboxes.forEach(cb => {
            const provinceName = cb.value; // Assuming the checkbox value contains the province name
            const billCycle = cb.dataset.billcycle;
            const licenseCode = cb.dataset.licensecode;

            // Fetch the provinceCode dynamically if not already available
            if (!cb.dataset.provincecode) {
                $.ajax({
                    url: '/PTS/getProvinceCode',
                    type: 'GET',
                    data: { provinceName: provinceName },
                    success: function (provinceCode) {
                        if (!provinceCode || provinceCode === "Unknown Province") {
                            alert(`Province code not found for ${provinceName}`);
                            return;
                        }
                        cb.dataset.provincecode = provinceCode; // Update the dataset with the fetched provinceCode
                        sendLockRequest(cb, billCycle, licenseCode, provinceCode);
                    },
                    error: function (xhr) {
                        console.error('Error fetching province code:', xhr.responseText);
                        alert(`Failed to fetch province code for ${provinceName}.`);
                    }
                });
            } else {
                sendLockRequest(cb, billCycle, licenseCode, cb.dataset.provincecode);
            }
        });
    }

    function sendLockRequest(checkbox, billCycle, licenseCode, provinceCode) {
        const data = {
            billCycleNo: billCycle,
            provinceCode: provinceCode,
            licenseCode: licenseCode,
            isUploadLocked: true
           // isReadingProcessLocked: false
        };

        $.ajax({
            url: '/PTS/updateIsUploadLocked',
            type: 'POST',
            data: data,
            success: function (response) {
                checkbox.disabled = true;
                checkbox.setAttribute('data-locked', 'true');
                const labelCell = checkbox.closest('tr').querySelector('td:nth-child(2)');
                if (labelCell && !labelCell.innerHTML.includes('Locked')) {
                    labelCell.innerHTML += ' <span class="text-danger">(Locked)</span>';
                }
            },
            error: function (xhr, status, error) {
                console.error('Lock failed:', xhr.responseText);
                alert('Failed to lock province: ' + error);
            }
        });
    }
</script>

<%--<!-- to give a gap to hide the footer -->--%>
<%--<span id="spanItem" style="min-height: 500px; display: inline-block;"></span>--%>
<%--    --%>

<!-- Bootstrap JS and Popper.js (order matters) -->
<!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

<!-- FullCalendar JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.0/fullcalendar.min.js"></script>

</div>

<!-- ---------------------------------------------------------------------------------- -->
<!--                         FOOTER                                                     -->
<!-- ---------------------------------------------------------------------------------- -->

<jsp:include page="../../common/footer.jsp" />

<script src="js/jquery.slicknav.min.js"></script>

<!--contact js-->
<script src="js/contact.js"></script>
<script src="js/jquery.ajaxchimp.min.js"></script>
<script src="js/jquery.form.js"></script>
<script src="js/jquery.validate.min.js"></script>
<script src="js/mail-script.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
<script src="js/main.js"></script>

<script>

    $(document).ready(function() {

        $('#uploadModal').hide();
        //-------------------------------------------------------------------
        //            drop down menu
        //-------------------------------------------------------------------
        const divDropdown = $('#divisionDropdown');
        const provDropdown = $('#provinceDropdown');
        const provinceList = JSON.parse('${provinceList}');

        divDropdown.change(function() {
            let selectedLicenseCode = divDropdown.val();
            filterProvince(selectedLicenseCode);
        });

        function filterProvince(lCode) {
            const filteredProvinces = provinceList.filter(function(province) {
                return province.licenseCode === lCode;
            });
            provDropdown.empty().append(
                filteredProvinces.map(function(province) {
                    return $('<option>', {
                        value: province.provinceCode,
                        text: province.provinceName
                    });
                })
            );
        }
        filterProvince('DD1');//initial rendering
    });
</script>

<style>
    .selectUnit label, .selectUnit select, .selectUnit input {
        font-size: small;
        margin: 0;
    }
</style>

<script>
    function downloadZipFile(billCycle, licensee, provinceName, fileName) {
        // Fetch the province code dynamically based on the province name
        $.ajax({
            url: '/PTS/getProvinceCode', // Endpoint to get the province code
            type: 'GET',
            data: { provinceName: provinceName },
            success: function (provinceCode) {
                if (!provinceCode || provinceCode === "Unknown Province") {
                    console.error(`Province code not found for ${provinceName}`);
                    alert(`Failed to fetch province code for ${provinceName}`);
                    return;
                }
                $.ajax({
                    url:'/PTS/downloadZipFile',
                    type: 'GET',
                    data: {
                        fileName: fileName,
                        billCycle: billCycle,
                        division: licensee,
                        province: provinceCode,

                    },
                    success: function(response) {
                        // Handle the response if needed
                        console.log("response: ", response);
                        // Construct the download URL
                        <%--const downloadUrl = `/PTS/downloadZipFile?fileName=${fileName}&billCycle=${billCycle}&division=${licensee}&province=${provinceCode}`;--%>

                        <%--console.log("Download URL: " + downloadUrl);--%>
                        <%--// Trigger the file download--%>
                        <%--window.location.href = downloadUrl;--%>
                        <%--console.log("File downloaded successfully:", response);--%>
                        // Fetch the download URL from the back-end
                        $.ajax({
                            url: '/PTS/generateDownloadUrl', // Endpoint to generate the download URL
                            type: 'GET',
                            data: {
                                fileName: fileName,
                                billCycle: billCycle,
                                division: licensee,
                                province: provinceCode
                            },
                            success: function (downloadUrl) {
                                console.log("Download URL: " + downloadUrl);
                                // Trigger the file download
                                window.location.href = downloadUrl;
                            },

                        });
                    },

                });


            },
        })
    }
</script>

<script>
    // Fetch province name dynamically
    (function(provinceCode) {
        $.ajax({
            url: '/PTS/getProvinceName',
            type: 'GET',
            data: { provinceCode: provinceCode },
            success: function(response) {
                $('#provinceName-' + provinceCode).text(response);
                console.log("Province name for " + provinceCode );
            },
            error: function() {
                $('#provinceName-' + provinceCode).text('Error fetching province name');
            }
        });
    })('${file.provinceCode}');
</script>

<script>
    $(document).ready(function () {
        $(".provinceCheckbox").each(function () {
            const checkbox = $(this);
            const provinceName = checkbox.val();
            const billCycle = checkbox.data("billcycle");
            const licenseCode = checkbox.data("licensecode");

            // Fetch provinceCode using provinceName
            $.ajax({
                url: '/PTS/getProvinceCode',
                type: 'GET',
                data: { provinceName: provinceName },
                success: function (provinceCode) {
                    if (provinceCode && provinceCode !== "Unknown Province") {
                        checkbox.data("provincecode", provinceCode);

                        // Fetch lock status using billCycle, licenseCode, and provinceCode
                        $.ajax({
                            url: '/PTS/getUploadLockStatus',
                            type: 'GET',
                            data: {
                                billCycle: billCycle,
                                licenseCode: licenseCode,
                                provinceCode: provinceCode
                            },
                            success: function (lockStatus) {
                                if (lockStatus.includes("Upload Lock Status:")) {
                                    const isLocked = lockStatus.split(":")[1].trim() === "1";
                                    checkbox.data("locked", isLocked);
                                    if (isLocked) {
                                        checkbox.prop("checked", true).prop("disabled", true);
                                    }
                                } else {
                                    console.error("Error fetching lock status:", lockStatus);
                                }
                            },
                            error: function () {
                                console.error("Failed to fetch lock status.");
                            }
                        });
                    } else {
                        console.error("Invalid province code for:", provinceName);
                    }
                },
                error: function () {
                    console.error("Failed to fetch province code.");
                }
            });
        });
    });
</script>

</body>

</html>