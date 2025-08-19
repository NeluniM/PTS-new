<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<%--<link href="https://fonts.googleapis.com/css?family=Montserrat&display=swap" rel="stylesheet">--%>

<style>
    label[for="serialNo"] {
        margin-bottom: 0 !important;
    }
    label[for="billCycle"] {
        margin-bottom: 0 !important;
    }
    label[for="remark"] {
        margin-bottom: 0 !important;
    }
    label[for="fileUpload"],
    .no-margin-label {
        margin-bottom: 0 !important;
    }
    td input.form-control {
        text-align: right;
    }
    .list-group-item {
        position: relative;
        display: block;
        padding: .5rem 1rem;
        margin-bottom: -1px;
        background-color: #fff;
        border: 1px solid rgba(0, 0, 0, .125);
    }
</style>

<div class="mb-5">
    <div class="card">
        <div class="container mt-4 mb-4" style="width: 70%;">
            <!-- Search Form -->
            <form:form modelAttribute="meterSearchModel" method="get" action="${pageContext.request.contextPath}/meterSearch" id="searchForm">
                <div class="row">
                    <div class="col">
                        <div class="selectUnit">
                            <label for="serialNo">Serial Number</label>
                            <div class="input-group">
                                <form:input path="serialNo" id="serialNo" class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="selectUnit">
                            <label for="billCycle">Current Bill Cycle</label>
                            <div class="input-group">
                                <form:input path="billCycle" id="billCycle" type="number" class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 d-flex align-items-end">
                        <button type="submit" class="btn btnClick">Search</button>
                    </div>
                </div>
            </form:form>

            <!-- Display Search Results from Database -->
            <div class=" mt-4 mb-4">
                <c:if test="${searchSuccess == true}">
                    <div class="msg success-msg">
                        <strong>Success:</strong> Meter point found!
                    </div>
                </c:if>
                <c:if test="${searchPerformed and !searchSuccess}">
                    <div class="msg error-msg">
                        <strong>Error:</strong> Error occured!
                    </div>
                </c:if>

                <!-- Always show the labels and value fields -->
                <div class="card shadow-sm">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 mb-2 d-flex align-items-center">
                                <label class="me-2 mb-0">License Code:</label>
                                <span style="margin-left: 8px;">${meterSearchModel.licenseCode != null ? meterSearchModel.licenseCode : ''}</span>
                            </div>
                            <div class="col-md-6 mb-2 d-flex align-items-center">
                                <label class="me-2 mb-0">LECO Province Name:</label>
                                <span style="margin-left: 8px;">${meterSearchModel.provinceName != null ? meterSearchModel.provinceName : ''}</span>
                            </div>
                            <div class="col-md-6 mb-2 d-flex align-items-center">
                                <label class="me-2 mb-0">Area Name:</label>
                                <span style="margin-left: 8px;">${meterSearchModel.areaName != null ? meterSearchModel.areaName : ''}</span>
                            </div>
                            <div class="col-md-6 mb-2 d-flex align-items-center">
                                <label class="me-2 mb-0">Primary Substation Name:</label>
                                <span style="margin-left: 8px;">${meterSearchModel.primarySubstationName != null ? meterSearchModel.primarySubstationName : ''}</span>
                            </div>
                            <div class="col-md-6 mb-2 d-flex align-items-center">
                                <label class="me-2 mb-0">Meter Point Code:</label>
                                <span style="margin-left: 8px;">${meterSearchModel.meterPointCode != null ? meterSearchModel.meterPointCode : ''}</span>
                            </div>
                            <div class="col-md-6 mb-2 d-flex align-items-center">
                                <label class="me-2 mb-0">Meter Point Name:</label>
                                <span style="margin-left: 8px;">${meterSearchModel.meterPointName != null ? meterSearchModel.meterPointName : ''}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Gap before next Section -->
            <div class="mt-4"></div>

            <%--            <form id="uploadForm" enctype="multipart/form-data">--%>
            <div class="row">
                <!-- Uploaded Files Section -->
                <div class="col">
                    <label class="no-margin-label">Uploaded Files</label>
                    <ul id="uploadedFilesList" class="list-group" style="max-width: 100%;">
                        <c:forEach var="file" items="${meterSearchModel.readingFileList}">
                            <li class="list-group-item">
                                <a href="${pageContext.request.contextPath}/download?billCycle=${meterSearchModel.billCycle}&licensee=${meterSearchModel.licenseCode}&province=${meterSearchModel.lecoProvinceCode}&pssCode=${meterSearchModel.primarySubstationCode}&meterPointCode=${meterSearchModel.meterPointCode}&fileName=${file}" target="_blank">
                                    <i class="fa fa-download" aria-hidden="true"></i>
                                        ${file}
                                </a>
                            </li>
                        </c:forEach>
                        <c:if test="${empty meterSearchModel.readingFileList and empty uploadedFilesError}">
                            <li class="list-group-item">No files uploaded.</li>
                        </c:if>
                    </ul>
                </div>

                <div class="col">
                    <c:if test="${not empty uploadSuccess}">
                        <div class="msg success-msg">
                                ${uploadSuccess}
                        </div>
                    </c:if>
                    <c:if test="${not empty uploadError}">
                        <div class="msg error-msg">
                            <strong>Error:</strong> ${uploadError}
                        </div>
                    </c:if>
                    <!-- Upload File Section -->
                    <form id="uploadForm" enctype="multipart/form-data" method="post" action="${pageContext.request.contextPath}/uploadFile">
                        <input type="hidden" name="serialNo" value="${meterSearchModel.serialNo}" />
                        <input type="hidden" name="billCycle" value="${meterSearchModel.billCycle}" />
                        <input type="hidden" name="licenseCode" value="${meterSearchModel.licenseCode}" />
                        <input type="hidden" name="provinceCode" value="${meterSearchModel.lecoProvinceCode}" />
                        <input type="hidden" name="pssCode" value="${meterSearchModel.primarySubstationCode}" />
                        <input type="hidden" name="meterPointCode" value="${meterSearchModel.meterPointCode}" />
                        <div class="row">
                            <div class="col">
                                <label class="no-margin-label">Upload File</label>
                                <input type="file" id="fileUpload" name="fileUpload" class="form-control"
                                       multiple accept=".xlsx,.xls,.csv"
                                       <c:if test="${searchSuccess and disableUpload}">disabled title="File upload is disabled for this bill cycle and province."</c:if> />
                            </div>
                            <div class="col">
                                <label>&nbsp;</label>
                                <div>
                                    <input type="submit" class="btn btnClick" id="upload_btn" value="Upload"
                                           <c:if test="${searchSuccess and disableUpload}">disabled title="File upload is disabled for this bill cycle and province."</c:if> />
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <%--            </form>--%>

            <!-- Gap before next Section -->
            <div class="mt-4"></div>
            <!--Meter readings-->
            <%
                String[][] measureTypes = {
                        {"Day", "Export", "DayExport"},
                        {"Peak", "Export", "PeakExport"},
                        {"OffPeak", "Export", "OffPeakExport"},
                        {"Day", "Import", "DayImport"},
                        {"Peak", "Import", "PeakImport"},
                        {"OffPeak", "Import", "OffPeakImport"}
                };
                java.util.Map<String, com.it.ceb.pts.domain.MeterReadingTableRow> measureMap = new java.util.HashMap<>();
                java.util.List rows = (java.util.List) request.getAttribute("meterReadings");
                if (rows != null) {
                    for (Object obj : rows) {
                        com.it.ceb.pts.domain.MeterReadingTableRow row = (com.it.ceb.pts.domain.MeterReadingTableRow) obj;
                        if (row.getMeasureName() != null) {
                            measureMap.put(row.getMeasureName().replaceAll("\\s", ""), row);
                        }
                    }
                }
                boolean searchPerformed = request.getAttribute("searchSuccess") != null && (Boolean)request.getAttribute("searchSuccess");
            %>

            <c:if test="${saveSuccess == true}">
                <div class="msg success-msg">
                    Successfully saved.
                </div>
            </c:if>
            <c:if test="${saveSuccess == false && not empty saveMessage}">
                <div class="msg error-msg">
                    <strong>Error:</strong> ${saveMessage}
                </div>
            </c:if>
            <!-- Start Save Form -->
            <form id="meterReadingForm" method="post" action="${pageContext.request.contextPath}/saveMeterReadings">
                <input type="hidden" name="serialNo" value="${meterSearchModel.serialNo}" />
                <input type="hidden" name="billCycle" value="${meterSearchModel.billCycle}" />

                <table class="resultTable">
                    <thead>
                    <tr>
                        <th>Import/Export</th>
                        <th>Day/Peak/Off</th>
                        <th>Reading Method</th>
                        <th>Previous Reading</th>
                        <th>Current Reading</th>
                        <th>Energy</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        int exportRows = 3, importRows = 3, rowIndex = 0;
                        for (String[] type : measureTypes) {
                            String dpo = type[0], io = type[1], key = type[2];
                            com.it.ceb.pts.domain.MeterReadingTableRow row = measureMap.get(key); // <-- FIXED HERE
                            String prev = "", curr = "", energy = "", readingMethod = "";
                            if (row != null) {
                                prev = row.getPreviousReading() != null ? row.getPreviousReading() : "";
                                curr = row.getCurrentReading() != null ? row.getCurrentReading() : "";
                                energy = row.getEnergy() != null ? row.getEnergy() : "";
                                readingMethod = row.getReadingMethod() != null ? row.getReadingMethod() : "";
                            }
                    %>
                    <tr>
                        <td><%= io %></td>
                        <td><%= dpo %></td>
                        <td><%= readingMethod %></td>
                        <td class="numeric">
                            <fmt:formatNumber value="<%= prev %>" type="number" />
                        </td>
                        <td class="numeric">
                            <%
                                boolean editable = false;
                                if (searchPerformed) {
                                    if (row == null || row.getCurrentReading() == null || "0".equals(row.getCurrentReading()) || "0.00".equals(row.getCurrentReading())) {
                                        editable = true;
                                    } else if (row != null && row.isEditable()) {
                                        editable = true;
                                    }
                                }
                            %>
                            <% if (editable) { %>
                            <input type="text" name="currentReading_<%= key %>" value="<%= (curr != null && !curr.isEmpty()) ? curr : "" %>" class="form-control"
                                   <c:if test="${searchSuccess and !isBillCycleCurrent}">readonly title="Editing is disabled for non-current bill cycles."</c:if> />
                            <% } else { %>
                            <fmt:formatNumber value="<%= curr %>" type="number" />
                            <% } %>
                        </td>
                        <td class="numeric">
                            <% if (editable) { %>
                            <input type="text" name="energy_<%= key %>" value="<%= (energy != null && !energy.isEmpty()) ? energy : "" %>" class="form-control"
                                   <c:if test="${searchSuccess and !isBillCycleCurrent}">readonly title="Editing is disabled for non-current bill cycles."</c:if> />
                            <% } else { %>
                            <c:set var="energyVal" value="<%= energy %>" />
                            <c:choose>
                                <c:when test="${energyVal < 0}">
                                    (<fmt:formatNumber value="${energyVal * -1}" type="number" groupingUsed="true"/>)
                                </c:when>
                                <c:otherwise>
                                    <fmt:formatNumber value="${energyVal}" type="number" groupingUsed="true"/>
                                </c:otherwise>
                            </c:choose>
                            <% } %>
                            <input type="hidden" name="measureName_<%= key %>" value="<%= key.replaceAll("([A-Z])", " $1").trim() %>" />
                        </td>
                    </tr>
                    <%
                        rowIndex++;
                        // After Export rows, show Export Energy and Coincident Peak Export
                        if (rowIndex == exportRows) {
                    %>
                    <tr>
                        <td colspan="5" style="border: none; background: none; text-align: right;">
                            Export Energy
                        </td>
                        <td class="numeric">
                            <c:choose>
                                <c:when test="${exportTotal < 0}">
                                    (<fmt:formatNumber value="${exportTotal * -1}" type="number" groupingUsed="true"/>)
                                </c:when>
                                <c:otherwise>
                                    <fmt:formatNumber value="${exportTotal}" type="number" groupingUsed="true"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <!-- Coincident Peak Export Row (always shown, after Export Energy) -->
                    <tr>
                        <td colspan="5" style="border: none; background: none; text-align: right;">
                            Export Coincident Peak
                        </td>
                        <td class="numeric">
                            <c:choose>
                                <c:when test="${exportCoincidentPeak < 0}">
                                    (<fmt:formatNumber value="${exportCoincidentPeak * -1}" type="number" groupingUsed="true"/>)
                                </c:when>
                                <c:otherwise>
                                    <fmt:formatNumber value="${exportCoincidentPeak}" type="number" groupingUsed="true"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>

                    <%
                        }
                        // After Import rows, show Import Energy and Coincident Peak Import
                        if (rowIndex == exportRows + importRows) {
                    %>
                    <tr>
                        <td colspan="5" style="border: none; background: none; text-align: right;">
                            Import Energy
                        </td>
                        <td class="numeric">
                            <c:choose>
                                <c:when test="${importTotal < 0}">
                                    (<fmt:formatNumber value="${importTotal * -1}" type="number" groupingUsed="true"/>)
                                </c:when>
                                <c:otherwise>
                                    <fmt:formatNumber value="${importTotal}" type="number" groupingUsed="true"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <!-- Coincident Peak Import Row (always shown, after Import Energy) -->
                    <tr>
                        <td colspan="5" style="border: none; background: none; text-align: right;">
                            Import Coincident Peak
                        </td>
                        <td class="numeric">
                            <c:choose>
                                <c:when test="${importCoincidentPeak < 0}">
                                    (<fmt:formatNumber value="${importCoincidentPeak * -1}" type="number" groupingUsed="true"/>)
                                </c:when>
                                <c:otherwise>
                                    <fmt:formatNumber value="${importCoincidentPeak}" type="number" groupingUsed="true"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5" style="border: none; background: none; text-align: right;">
                            Total Energy
                        </td>
                        <td class="numeric">
                            <c:choose>
                                <c:when test="${searchSuccess}">
                                    <fmt:formatNumber value="${exportTotal - importTotal}" type="number"/>
                                </c:when>
                                <c:otherwise>
                                    &nbsp;
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <%
                            }
                        } // end for
                    %>
                    </tbody>
                </table>

                <!-- Remark and Save Section -->
                <div class="row">
                    <div class="col">
                        <div class="selectUnit">
                            <label for="remark">Remark</label>
                            <textarea id="remark" name="remark" class="form-control" rows="2" style="font-size: 14px;"
                                      <c:if test="${searchSuccess and !isBillCycleCurrent}">readonly title="Editing is disabled for non-current bill cycles."</c:if>>${fn:trim(meterSearchModel.remark)}
                            </textarea>
                        </div>
                    </div>
                    <div class="col-md-4 d-flex align-items-end">
                        <button type="submit" class="btn btnClick" id="saveBtn"
                                <c:if test="${searchSuccess and !isBillCycleCurrent}">disabled title="Saving is disabled for non-current bill cycles."</c:if>>Save</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // JavaScript for form handling
    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('searchForm').addEventListener('submit', function(e) {
            const serialNo = document.getElementById('serialNo').value.trim();
            if (!serialNo) {
                e.preventDefault();
                alert('Please enter a serial number');
            }
        });
    });

    // Validation for numbers (Allow digits and one dot for decimal numbers)
    document.querySelectorAll('input[name^="currentReading_"], input[name^="energy_"]').forEach(function(input) {
        input.addEventListener('input', function(e) {
            // Allow only digits and a single dot
            this.value = this.value.replace(/[^0-9.]/g, '');
            // Prevent more than one dot
            if ((this.value.match(/\./g) || []).length > 1) {
                this.value = this.value.substring(0, this.value.length - 1);
            }
        });
        input.addEventListener('keydown', function(e) {
            // Allow: backspace, delete, tab, escape, enter, dot, and numbers
            if (
                [46, 8, 9, 27, 13, 110, 190].indexOf(e.keyCode) !== -1 ||
                // Allow: Ctrl/cmd+A
                (e.keyCode === 65 && (e.ctrlKey || e.metaKey)) ||
                // Allow: Ctrl/cmd+C
                (e.keyCode === 67 && (e.ctrlKey || e.metaKey)) ||
                // Allow: Ctrl/cmd+V
                (e.keyCode === 86 && (e.ctrlKey || e.metaKey)) ||
                // Allow: home, end, left, right
                (e.keyCode >= 35 && e.keyCode <= 39)
            ) {
                return;
            }
            // Ensure that it is a number or dot and stop the keypress
            if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105) && e.keyCode !== 190 && e.keyCode !== 110) {
                e.preventDefault();
            }
        });
    });

    // validation for current readings
    document.getElementById('meterReadingForm').addEventListener('submit', function(e) {
        let valid = true;
        // For each editable currentReading input
        document.querySelectorAll('input[name^="currentReading_"]').forEach(function(currInput) {
            // Get the key (e.g., DayExport, PeakImport, etc.)
            const key = currInput.name.replace('currentReading_', '');
            // Find the corresponding previous reading cell (by traversing DOM)
            const row = currInput.closest('tr');
            if (row) {
                // Previous reading is in the 4th cell (index 3)
                const prevCell = row.cells[3];
                let prevValue = prevCell ? prevCell.textContent.replace(/,/g, '').trim() : '';
                let currValue = currInput.value.trim();
                // Only check if both values are present and numeric
                if (prevValue && currValue && !isNaN(prevValue) && !isNaN(currValue)) {
                    if (parseFloat(currValue) <= parseFloat(prevValue)) {
                        valid = false;
                        currInput.classList.add('is-invalid');
                    } else {
                        currInput.classList.remove('is-invalid');
                    }
                }
            }
        });
        if (!valid) {
            e.preventDefault();
            alert('Current Reading must be greater than Previous Reading.');
        }
    });

    document.addEventListener('DOMContentLoaded', function () {
        // Enable Bootstrap tooltips
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[title]'));
        tooltipTriggerList.forEach(function (el) {
            new bootstrap.Tooltip(el);
        });
    });
</script>