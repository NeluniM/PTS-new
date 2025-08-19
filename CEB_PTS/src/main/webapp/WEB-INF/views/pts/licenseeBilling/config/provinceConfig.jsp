<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css' />">

<div class="left-column">
    <div class="mb-1">
        <p style="text-align: center; margin-top:30px">Province Config</p>

        <!-- Message containers -->
        <div class="success-msg" id="provinceSuccessMsg" style="width: 65%; margin: 0 auto; text-align: center;"></div>
        <div class="error-msg" id="provinceErrorMsg" style="width: 65%; margin: 0 auto; text-align: center;"></div>

        <div class="container mt-4 mb-4" style="width: 70%; margin: 0 auto;">
            <div class="row">
                <div class="col vertical-layout">
                    <!-- Bill Cycle -->
                    <div class="selectUnit" style="width:98% " >
                        <label style="margin-bottom:0;margin-top: -10px " >Bill Cycle</label>
                        <div class="input-group" >
                            <input type="number" id="billCycleNo"   name="billCycle" class="form-control" style="margin-left: 10px; " />
                        </div>
                    </div>

                    <!-- Distribution Division -->
                    <div class="selectUnit " style="margin-top:2px">
                        <label style="margin-bottom:0" >Distribution division</label>
                        <div class="input-group"style="margin-bottom:0" >
                            <c:if test="${not empty licenseList}">
                                <select id="divisionDropdown" class="form-control" style="margin-top: -1px; width:100% ">
                                    <c:forEach var="license" items="${licenseList}">
                                        <option value="${license.licenseCode}" label="${license.licenseName}" />
                                    </c:forEach>
                                </select>
                            </c:if>
                        </div>
                    </div>

                    <!-- Province -->
                    <div class="selectUnit" style="margin-top:2px">
                        <label style="margin-bottom:0">Province</label>
                        <div class="input-group" >
                            <select id="provinceDropdown" class="form-control" style="margin-top:-1px"  ></select>
                        </div>
                    </div>
                    <br/>
                    <!-- Province Code and Find Button -->
                    <div class="selectUnit">
                        <input type="button" class="btn btnClick" id="fetchProvinceBtn" value="Find"  style="margin-left: 10px;  margin-top:10px">
                    </div>
                </div>
            </div>

            <!-- Province Details Section - Initially visible but empty -->
            <br/>
            <div id="provinceDetails">
                <div class="selectUnit" style="width: 100%; display: flex; align-items: center;">
                    <label class="checkbox-label" style="margin-left: 15px; margin-right: 10px;">
                        File Upload Locked
                    </label>
                    <input type="checkbox" id="provinceActiveCheckbox" name="provinceActiveCheckbox" value="1" class="single-checkbox" style="margin-left: 5px;">

                    <div id="provinceActiveDisplay">
                        <span id="provinceActiveText"></span>
                    </div>
                    <div id="provinceActiveEdit" style="display: none; margin-left: 10px;">
                        <label style="margin-right: 10px; ">
                            Yes
                            <input type="checkbox" id="provinceActiveYes" name="provinceActive" value="1" class="single-checkbox" style="margin-left: 5px;">
                        </label>
                        <label>
                            No
                            <input type="checkbox" id="provinceActiveNo" name="provinceActive" value="0" class="single-checkbox" style="margin-left: 5px;">
                        </label>
                    </div>
                </div>


            </div>
            <br/>
            <div class="row">
                <div class="col">
                    <div class="ml-5 pt-3">
                        <input type="button" class="btn btn btnClick" id="saveProvinceBtn" value="Save" style="margin-left: 15px;">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function () {
        // Auto-fill current bill cycle number when page loads
        const currentBillCycleNo = '${currentBillCycleNo}';
        if (currentBillCycleNo && currentBillCycleNo.trim() !== '') {
            $('#billCycleNo').val(currentBillCycleNo);
        }

        // Helper functions for displaying messages
        function showSuccessMessage(message) {
            $('#provinceErrorMsg').hide();
            $('#provinceSuccessMsg').text(message).css('display', 'block').show();
        }

        function showErrorMessage(message) {
            $('#provinceSuccessMsg').hide();
            $('#provinceErrorMsg').text(message).css('display', 'block').show();
        }

        // Function to clear all messages
        function clearAllMessages() {
            $('#provinceSuccessMsg, #provinceErrorMsg').hide().text('');
        }

        // Hide messages initially and clear any text
        clearAllMessages();

        //----------------------------------------------
        //      province and div rendering to drop down
        //----------------------------------------------
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

        filterProvince('DD1');//initial division

        //----------------------------------------------
        //      fetch province config
        //----------------------------------------------

        const findButton = $('#fetchProvinceBtn');
        const billCycleNo = $('#billCycleNo');
        const provinceSaveButton = $('#saveProvinceBtn');

        provinceSaveButton.hide();

        findButton.click(function (e) {
            e.preventDefault();
            fetchProvinceConfig();
        });

        function fetchProvinceConfig() {
            clearAllMessages(); // Clear any existing messages

            if (!billCycleNo.val().trim()) {
                showErrorMessage('Please enter a Bill Cycle number');
                return;
            }

            // Validate that bill cycle number is a valid number
            const billCycleValue = parseInt(billCycleNo.val().trim());
            if (isNaN(billCycleValue) || billCycleValue <= 0) {
                showErrorMessage('Please enter a valid Bill Cycle number');
                return;
            }

            $.ajax({
                url: '/PTS/provinceConfig',
                type: 'GET',
                data: {
                    billCycleNo: billCycleValue,
                    provinceCode: provDropdown.val(),
                    licenseCode: divDropdown.val(),
                },
                success: function (response) {
                    console.log('Response received:', response);

                    // Check if there's an error in the response
                    if (response.error) {
                        if (response.error === "Bill Cycle not found") {
                            showErrorMessage('No such Bill Cycle number: ' + billCycleValue);
                        } else if (response.error === "Province Configuration not found") {
                             showErrorMessage('No Such Province Configuration found' );
                        } else {
                            showErrorMessage(response.message || 'An error occurred while fetching data');
                        }
                        // Hide save button and disable checkboxes when there's an error
                        provinceSaveButton.hide();
                        $('#provinceActiveCheckbox').prop('disabled', true);
                        return;
                    }

                    // Check if response has valid data
                    if (!response || !response.provinceConfig) {
                        showErrorMessage('No data found for Bill Cycle: ' + billCycleValue);
                        provinceSaveButton.hide();
                        $('#provinceActiveCheckbox').prop('disabled', true);
                        return;
                    }

                    // Success case - display the data
                    const isUploadLocked = response.provinceConfig.isUploadLocked === 1;
                    const isCurrent = response.isCurrent === 1;

                    $('#provinceActiveCheckbox').prop('checked', isUploadLocked);

                    console.log('isCurrent:', response.isCurrent);

                    // Enable checkbox only if isCurrent=1 AND checkbox is ticked
                    if (isCurrent && isUploadLocked) {
                        $('#provinceActiveCheckbox').prop('disabled', false);
                        provinceSaveButton.show();
                    } else {
                        // Disable checkbox in all other cases
                        $('#provinceActiveCheckbox').prop('disabled', true);
                        if (isCurrent) {
                            provinceSaveButton.show();
                        } else {
                            provinceSaveButton.hide();
                        }
                    }


                },
                error: function (xhr, status, error) {
                    console.error('AJAX Error:', xhr.responseText);
                    console.error('Status:', status);
                    console.error('Error:', error);

                    // Hide save button and disable checkboxes on error
                    provinceSaveButton.hide();
                    $('#provinceActiveCheckbox').prop('disabled', true);

                    // Show appropriate error message
                    if (xhr.status === 404) {
                        showErrorMessage('No such Bill Cycle number: ' + billCycleValue);
                    } else if (xhr.status === 500) {
                        showErrorMessage('Server error occurred. Please try again.');
                    } else {
                        showErrorMessage('Error fetching data. Please check your connection and try again.');
                    }
                }
            });
        }

        //----------------------------------------------
        //      fetch province config update
        //----------------------------------------------

        provinceSaveButton.click(function (e) {
            e.preventDefault();
            updateProvinceConfig();
        });

        function updateProvinceConfig() {
            $.ajax({
                url: '/PTS/updateProvinceConfig',
                type: 'POST',
                data: {
                    billCycleNo: billCycleNo.val(),
                    provinceCode: provDropdown.val(),
                    licenseCode: divDropdown.val(),
                    isUploadLocked: $('#provinceActiveCheckbox').prop('checked'),
                },
                success: function (response) {
                    showSuccessMessage('Province configuration updated successfully!');
                },
                error: function (xhr, status, error) {
                    console.error('Error updating province config:', xhr.responseText);
                    showErrorMessage('Error updating province configuration: ' + error);
                }
            });
        }
    });
</script>
