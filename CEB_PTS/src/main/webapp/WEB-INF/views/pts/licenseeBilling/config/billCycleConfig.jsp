<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Updated DateTime Picker CSS and JS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<style>
    .datetime-input-container {
        position: relative;
        width: 100%;
    }

    .datetime-input-container .form-control {
        padding-right: 40px; /* Make space for the icon */
    }

    .datetime-picker-icon {
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        cursor: pointer;
        z-index: 10;
        color: #6c757d;
        font-size: 16px;
    }
</style>

<div class="right-column" >
    <form:form id="myForm" method="post" enctype="multipart/form-data" modelAttribute="BillCycleModel" autocomplete="false">
        <div class="mb-5">
            <p style="text-align: center; margin-top:30px">Bill Cycle Config</p>

            <!-- Message containers -->
            <div class="success-msg" id="billCycleSuccessMsg" style="width: 65%; margin: 0 auto; text-align: center;"></div>
            <div class="error-msg" id="billCycleErrorMsg" style="width: 65%; margin: 0 auto;  text-align: center;"></div>

            <div class="mt-4 mb-4" style="width: 70%; margin: 0 auto;">
                <div class="row">
                    <div class="col">
                        <div class="selectUnit" style="width: 94%;">
                            <label style="margin-left: 28px; margin-bottom:0;margin-top: -10px">Bill Cycle</label>
                            <div class="input-group" style="width: 100%; margin-left: 28px;margin-bottom: -10px;">
                                    <%--                                <input value="${billCycleNo}" type="number" id="billCycle" name="billCycle" class="form-control" >--%>
                                <input type="number" id="billCycle" name="billCycle" class="form-control"  autocomplete="true" />

                                <div class="input-group-append" style="margin-left: 15px;">
                                    <input type="button" class="btn btnClick" id="fetchBillCycleBtn" value="Find">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="billCycleDetails" style="width: 100%; margin-top: 10px;">
                    <div class="col">
                        <div class="selectUnit" style="width: 100%;">
                            <label style="margin-left: 15px; margin-bottom: 0;">Bill Year</label>
                            <input type="text" id="billYear" class="form-control" readonly style="width: 100%; margin-left: 15px;" />
                        </div>
                    </div>
                    <div class="col">
                        <div class="selectUnit" style="width: 100%;">
                            <label style="margin-left: 15px; margin-bottom: 0;">Bill Month</label>
                            <input type="text" id="billMonth" class="form-control" readonly style="width: 100%; margin-left: 15px;" />
                        </div>
                    </div>


                    <br />
                    <div class="col" style="margin-top: -25px;">
                        <div class="selectUnit" style="width: 100%;">
                            <label style="margin-left: 15px; margin-bottom: 0;">System Peak</label>
                            <div class="datetime-input-container" style="margin-left: 15px;">
                                <input type="text" id="coincidentPeakDate" name="coincidentPeakDate" class="form-control datetime-picker"
                                       style="width: 100%;" placeholder="Select date and time" readonly />
                                <i class="fa fa-calendar datetime-picker-icon" id="datePickerTrigger"></i>
                            </div>
                        </div>
                    </div>

                    <div class="col">
                        <div class="selectUnit" style="width: 100%;">
                            <label style="margin-left: 15px; margin-bottom: 0;">Recorded Peak Demand</label>
                            <input type="number" id="recordedPeakDemand" name="recordedPeakDemand" class="form-control"
                                   style="width: 100%; margin-left: 15px;"  />
                        </div>
                    </div>
                    <div class="col">
                        <div class="selectUnit" style="width: 100%;">
                            <label style="margin-left: 15px; margin-bottom: 0;">Remarks</label>
                            <textarea id="remarks" name="remarks" class="form-control"
                                      style="width: 100%; margin-left: 15px;" rows="4" maxlength="500"></textarea>
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-top: 10px;">
                    <div class="col">
                        <div class="ml-5 pt-3">
                            <!-- The save button will be dynamically added here -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form:form>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function () {
        // Auto-fill current bill cycle number when page loads
        const currentBillCycleNo = '${currentBillCycleNo}';
        if (currentBillCycleNo && currentBillCycleNo.trim() !== '') {
            $('#billCycle').val(currentBillCycleNo);
        }

        // Helper functions for displaying messages
        function showSuccessMessage(message) {
            $('#billCycleErrorMsg').hide();
            $('#billCycleSuccessMsg').text(message).show();
        }

        function showErrorMessage(message) {
            $('#billCycleSuccessMsg').hide();
            $('#billCycleErrorMsg').text(message).show();
        }

        // Function to clear all messages
        function clearAllMessages() {
            $('#billCycleSuccessMsg, #billCycleErrorMsg').hide().text('');
        }

        // Hide messages initially and clear any text
        clearAllMessages();

        // Disable autocomplete for all form inputs except billCycle
        $('#myForm input, #myForm select, #myForm textarea').each(function () {
            if (this.id !== 'billCycle') {
                $(this).attr('autocomplete', 'off');
            }
        });

        // Track if form has been modified
        var billCycleFormModified = false;
        var currentBillCycleStatus = 0;
        var flatpickrInstance = null;
        var currentBillYear = null;
        var currentBillMonth = null;

        // Create save button
        var billCycleSaveButton = $('<input type="button" class="btn btn btnClick float-right mr-3" id="saveChangesBtn" value="Save">');
        $('#myForm .row .col .ml-5.pt-3').append(billCycleSaveButton);
        $('#saveChangesBtn').hide();

        // Clear all form fields initially
        clearBillCycleFormFields();

        // Function to get month number from month name
        function getMonthNumber(monthName) {
            const months = {
                'january': 0, 'february': 1, 'march': 2, 'april': 3,
                'may': 4, 'june': 5, 'july': 6, 'august': 7,
                'september': 8, 'october': 9, 'november': 10, 'december': 11
            };
            return months[monthName.toLowerCase()];
        }

        // Initialize Flatpickr datetime picker with month restriction
        function initializeDateTimePicker() {
            if (!flatpickrInstance && currentBillYear && currentBillMonth) {
                const monthNumber = getMonthNumber(currentBillMonth);
                const year = parseInt(currentBillYear);

                // Calculate the first and last day of the bill month
                const minDate = new Date(year, monthNumber, 1);
                const maxDate = new Date(year, monthNumber + 1, 0, 23, 59, 59);

                flatpickrInstance = flatpickr("#coincidentPeakDate", {
                    enableTime: true,
                    dateFormat: "m/d/Y H:i",
                    time_24hr: true,
                    allowInput: true,
                    clickOpens: true,
                    minDate: minDate,
                    maxDate: maxDate,
                    onChange: function(selectedDates, dateStr, instance) {
                        if (currentBillCycleStatus === 1) {
                            if (selectedDates.length > 0) {
                                const selectedDate = selectedDates[0];
                                const selectedMonth = selectedDate.getMonth();
                                const selectedYear = selectedDate.getFullYear();
                            }
                            billCycleFormModified = true;
                        }
                    },
                    onReady: function(selectedDates, dateStr, instance) {
                        // Add click event to the calendar icon
                        $('#datePickerTrigger').on('click', function() {
                            if (!$('#coincidentPeakDate').prop('readonly')) {
                                instance.open();
                            }
                        });
                    },
                    // Disable dates outside the bill month
                    disable: [
                        function(date) {
                            return date.getMonth() !== monthNumber || date.getFullYear() !== year;
                        }
                    ]
                });
            }
        }

        // Function to destroy datetime picker
        function destroyDateTimePicker() {
            if (flatpickrInstance) {
                flatpickrInstance.destroy();
                flatpickrInstance = null;
            }
        }

        // Function to validate date format and month
        function isValidCoincidentPeakDateFormat(value) {
            if (!value) return true;

            // Check if the date matches the expected format (m/d/Y H:i)
            var pattern = /^(\d{1,2})\/(\d{1,2})\/(\d{4})\s(\d{1,2}):(\d{2})$/;
            var match = value.match(pattern);
            if (!match) return false;

            var [, month, day, year, hour, minute] = match;
            month = parseInt(month);
            day = parseInt(day);
            year = parseInt(year);
            hour = parseInt(hour);
            minute = parseInt(minute);

            if (month < 1 || month > 12) return false;
            if (day < 1 || day > 31) return false;
            if (hour > 23 || minute > 59) return false;
            if (year < 2000 || year > 2099) return false;

            // Additional validation: check if the date is actually valid
            var testDate = new Date(year, month - 1, day, hour, minute);
            var isValidDate = testDate.getFullYear() === year &&
                testDate.getMonth() === month - 1 &&
                testDate.getDate() === day &&
                testDate.getHours() === hour &&
                testDate.getMinutes() === minute;

            if (!isValidDate) return false;

            // Validate that the date is within the bill month and year
            if (currentBillMonth && currentBillYear) {
                const billMonthNumber = getMonthNumber(currentBillMonth);
                const billYear = parseInt(currentBillYear);

                if (testDate.getMonth() !== billMonthNumber || testDate.getFullYear() !== billYear) {
                    return false;
                }
            }

            return true;
        }

        // Function to set form elements read-only or editable
        function setBillCycleFormState(isEditable) {
            if (isEditable) {
                $('#recordedPeakDemand, #remarks').prop('readonly', false);
                $('#coincidentPeakDate').prop('readonly', false);
                $('#saveChangesBtn').show();
                initializeDateTimePicker();
            } else {
                $('#coincidentPeakDate, #recordedPeakDemand, #remarks').prop('readonly', true);
                $('#saveChangesBtn').hide();
                destroyDateTimePicker();
            }
            $('#billYear, #billMonth').prop('readonly', true);
            $('#isUploadLockedCheckbox, #isCurrentCheckbox').prop('disabled', true);
        }

        // Function to enable editing mode and track changes
        function enableBillCycleEditMode() {
            $('#recordedPeakDemand, #remarks').off('input').on('input', function () {
                billCycleFormModified = true;
            });
        }

        // Bill Cycle fetch button click handler
        $('#fetchBillCycleBtn').on('click', function() {
            var billCycleNo = $('#billCycle').val().trim();
            if (!billCycleNo) {
                showErrorMessage('Please enter a Bill Cycle number');
                return;
            }

            // Validate that bill cycle number is a valid number
            const billCycleValue = parseInt(billCycleNo);
            if (isNaN(billCycleValue) || billCycleValue <= 0) {
                showErrorMessage('Please enter a valid Bill Cycle number');
                return;
            }
            clearAllMessages(); // Clear any existing messages

            $.ajax({
                url: '/PTS/getBillCycleDetails',
                type: 'GET',
                data: { billCycleNo: billCycleValue },
                dataType: 'json',
                success: function (response) {
                    console.log('Received response:', response);

                    if (response && response.billYear) {
                        // Store current bill year and month for date picker validation
                        currentBillYear = response.billYear;
                        currentBillMonth = response.billMonthName;

                        $('#billYear').val(response.billYear || '');
                        $('#billMonth').val(response.billMonthName || '');
                        $('#recordedPeakDemand').val(response.recordedPeakDemand || '');
                        $('#isUploadLockedCheckbox').prop('checked', response.isUploadLocked === 1);
                        $('#isCurrentCheckbox').prop('checked', response.isCurrent === 1);
                        $('#remarks').val(response.remarks || '');
                        currentBillCycleStatus = response.isCurrent;

                        // Set coincidentPeakDate
                        if (response.coincidentPeakDate) {
                            $('#coincidentPeakDate').val(response.coincidentPeakDate);
                        } else {
                            $('#coincidentPeakDate').val('');
                        }

                        billCycleFormModified = false;

                        if (response.isCurrent === 1) {
                            setBillCycleFormState(true);
                            enableBillCycleEditMode();

                            // Set the date in flatpickr after initialization
                            setTimeout(function() {
                                if (response.coincidentPeakDate && flatpickrInstance) {
                                    flatpickrInstance.setDate(response.coincidentPeakDate);
                                }
                            }, 100);
                        } else {
                            setBillCycleFormState(false);
                        }

                        // showSuccessMessage('Bill Cycle data loaded successfully');
                    } else {
                        showErrorMessage('Bill Cycle not found');
                        clearBillCycleFormFields();
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Fetch error:', status, error, 'Response:', xhr.responseText);

                    // Handle different error cases
                    if (xhr.status === 404) {
                        showErrorMessage('No such Bill Cycle number: ' + billCycleValue);
                    } else if (xhr.status === 500) {
                        showErrorMessage('Server error occurred. Please try again.');
                    } else {
                        showErrorMessage('No such Bill Cycle number');
                    }
                    clearBillCycleFormFields();
                }
            });
        });

        // Save button click handler
        $('#saveChangesBtn').on('click', function () {
            saveBillCycleChanges();
        });

        // Function to save Bill Cycle changes
        function saveBillCycleChanges() {

            if (!billCycleFormModified) {
                showErrorMessage('No changes to save.');
                return;
            }

            if (!$('#billYear').val() || !$('#billMonth').val()) {
                showErrorMessage('Bill Year and Bill Month are required.');
                return;
            }

            var coincidentPeakDateValue = $('#coincidentPeakDate').val().trim();

            if (coincidentPeakDateValue && !isValidCoincidentPeakDateFormat(coincidentPeakDateValue)) {
                showErrorMessage('Invalid Coincident Peak date format. Please use m/d/yyyy H:mm format (e.g., 6/27/2025 21:32)');
                return;
            }

            var recordedPeakDemand = $('#recordedPeakDemand').val();
            if (recordedPeakDemand && (isNaN(recordedPeakDemand) || parseFloat(recordedPeakDemand) < 0)) {
                showErrorMessage('Recorded Peak Demand must be a valid positive number.');
                return;
            }

            var updatedData = {
                billCycleNo: $('#billCycle').val().trim(),
                billYear: $('#billYear').val(),
                billMonthName: $('#billMonth').val(),
                coincidentPeakDate: coincidentPeakDateValue || null,
                recordedPeakDemand: recordedPeakDemand ? parseFloat(recordedPeakDemand) : null,
                remarks: $('#remarks').val() || ''
            };

            console.log('Sending bill cycle data:', updatedData);

            $.ajax({
                url: '/PTS/updateBillCycleDetails',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(updatedData),
                headers: { 'X-CSRF-TOKEN': $("meta[name='_csrf']").attr("content") || '' },
                success: function (response) {
                    showSuccessMessage('Bill Cycle updated successfully');
                    billCycleFormModified = false;
                    $('#fetchBillCycleBtn').click(); // Refresh data
                },
                error: function (xhr, status, error) {
                    console.error('Update error:', status, error, 'Response:', xhr.responseText);

                    // Handle different error cases
                    if (xhr.status === 404) {
                        showErrorMessage('Bill Cycle not found');
                    } else if (xhr.status === 403) {
                        showErrorMessage('Cannot update: Bill Cycle is not current');
                    } else if (xhr.status === 400) {
                        showErrorMessage('Invalid data: ' + (xhr.responseText || error));
                    } else if (xhr.status === 500) {
                        showErrorMessage('Server error occurred. Please try again.');
                    } else {
                        showErrorMessage('Error updating Bill Cycle: ' + (xhr.responseText || error));
                    }
                }
            });
        }

        // Function to clear all form fields
        function clearBillCycleFormFields() {
            $('#billYear').val('');
            $('#billMonth').val('');
            $('#coincidentPeakDate').val('');
            $('#recordedPeakDemand').val('');
            $('#isUploadLockedCheckbox').prop('checked', false);
            $('#isCurrentCheckbox').prop('checked', false);
            $('#remarks').val('');
            billCycleFormModified = false;
            currentBillCycleStatus = 0;
            currentBillYear = null;
            currentBillMonth = null;
            setBillCycleFormState(false);
        }

        // Initialize form state
        setBillCycleFormState(false);
    });
</script>
