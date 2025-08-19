<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css' />">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>

    .date-cell {
        position: relative;
        padding-right: 30px; /* Space for the icon */
    }
    .calendar-icon {
        position: absolute;
        right: 10px;
        top: 50%;
        transform: translateY(-50%);
        cursor: default;
        color: #6c757d; /* Default color for non-editable mode */
    }
    .date-cell.editable .calendar-icon {
        cursor: pointer;
        color: #fdd700; /* Highlight color in editable mode */
    }
    .popup-table {
        width: 100%;
        font-size: 0.9rem;
        margin-bottom: 10px;
    }
    .popup-table th, .popup-table td {
        padding: 4px;
        border: 1px solid #dddddd;
        color: #000000;
    }
    /* Set specific width for rate column */
    .popup-table th:nth-child(5), .popup-table td:nth-child(5) {
        width: 80px;
        min-width: 80px;
        max-width: 80px;
    }
    .popup-table th {
        background-color: #FFD900;
        color: #000000;
        padding: 8px;
        border: 1px solid #f6f6f6;
        font-weight: normal;
        font-size: 16px;
    }
    .popup-table td[contenteditable="true"] {
        background-color: #f9f9f9;
        cursor: text;
    }
    .popup-table td[contenteditable="true"]:focus {
        background-color: #fff;
        outline: 2px solid #007bff;
    }

    /* Styling for rate input boxes in popup table */
    .popup-table .rate-input {
        width: 100%;
        border: 1px solid #ddd;
        padding: 5px;
        font-size: 0.9rem;
        text-align: right;
        background-color: #fff;
    }

    .popup-table .rate-input:focus {
        outline: 2px solid #007bff;
        border-color: #007bff;
    }

    /* Custom styling for SweetAlert2 confirm button */
    .swal2-confirm {
        background-color: #7D0000;
        color: #ffffff;
        padding: 0.5rem 1rem; /* Adjusted to match btn btnClick button size */
        font-size: 1rem; /* Adjusted to match btn btnClick button size */
        border-radius: 0.25rem; /* Adjusted to match btn btnClick button size */
    }

    .swal2-confirm:hover {
        border-color: rgba(255, 255, 255, 0);
        background-color: #B31900;
    }

    .swal2-confirm:active {
        transform: translateY(0) !important;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2) !important;
    }
    .swal2-cancel {
        background-color: #6c757d; /* Default gray color */
        color: #ffffff; /* White text */
        padding: 0.5rem 1rem; /* Matches btn btnClick button size */
        font-size: 1rem; /* Matches btn btnClick button size */
        border-radius: 0.25rem; /* Matches btn btnClick button size */
    }

    .swal2-cancel:hover {
        background-color: #5a6268; /* Darker gray on hover */
    }

    .swal2-cancel:active {
        transform: translateY(0) !important;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2) !important;
    }
</style>

<!-- Message containers -->
<div class="success-msg" id="tariffSuccessMsg" style="width: 80%; margin: 20px auto; text-align: center;"></div>
<div class="error-msg" id="tariffErrorMsg" style="width: 80%; margin: 20px auto; text-align: center;"></div>

<table class="resultTable">
    <thead>
    <tr>
        <th>Tariff Type</th>
        <th>Valid From</th>
        <th>Valid Till</th>
        <th>Tariff Name</th>
        <th>Rate</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <c:set var="currentTariffType" value="" />
    <c:set var="tariffTypeCount" value="0" />
    <c:set var="tariffTypeRowspan" value="0" />

    <!-- First pass: count current tariffs by type -->
    <c:forEach var="tariff" items="${tariffList}">
        <c:if test="${tariff.isCurrent == 1 && tariff.tarrifType != noncurrentTariffType}">
            <c:set var="currentTariffType" value="${tariff.tarrifType}" />
            <c:set var="tariffTypeCount" value="0" />
            <c:forEach var="innerTariff" items="${tariffList}">
                <c:if test="${innerTariff.isCurrent == 1 && innerTariff.tarrifType == currentTariffType}">
                    <c:set var="tariffTypeCount" value="${tariffTypeCount + 1}" />
                </c:if>
            </c:forEach>
        </c:if>
    </c:forEach>

    <!-- Second pass: render table with merged cells for current tariffs only -->
    <c:set var="currentTariffType" value="" />
    <c:set var="isFirstOfType" value="true" />

    <c:forEach var="tariff" items="${tariffList}" varStatus="status">
        <!-- Only display if isCurrent = 1 -->
        <c:if test="${tariff.isCurrent == 1}">
            <c:set var="tariffTypeCount" value="0" />

            <!-- Count occurrences of current tariff type -->
            <c:forEach var="countTariff" items="${tariffList}">
                <c:if test="${countTariff.isCurrent == 1 && countTariff.tarrifType == tariff.tarrifType}">
                    <c:set var="tariffTypeCount" value="${tariffTypeCount + 1}" />
                </c:if>
            </c:forEach>

            <tr data-tariff-id="${tariff.tariffId}"
                data-is-current="${tariff.isCurrent}"
                class="non-current-tariff readonly-row">

                <!-- Only show tariff type cell for first occurrence of each type -->
                <c:if test="${tariff.tarrifType != currentTariffType}">
                    <td rowspan="${tariffTypeCount}" class="tariff-type-cell">${tariff.tarrifType}</td>
                    <c:set var="currentTariffType" value="${tariff.tarrifType}" />
                </c:if>

                <td data-path="validFrom" class="date-cell">
                        ${tariff.validFrom}
                    <i class="fas fa-calendar-alt calendar-icon"></i>
                </td>
                <td data-path="validTill" class="date-cell">
                        ${tariff.validTill}
                    <i class="fas fa-calendar-alt calendar-icon"></i>
                </td>
                <td data-path="tariffName">${tariff.tariffName}</td>
                <td data-path="rate" class="text-end text-right">${tariff.rate}</td>

                <td>
                    <button class="btn btn-sm edit-btn btn btnClick" onclick="editRow(this)">Edit</button>
                </td>
            </tr>
        </c:if>
    </c:forEach>

    <!-- Show message if no non-current tariffs found -->
    <c:if test="${empty tariffList}">
        <tr>
            <td colspan="6" class="text-center text-muted">No current tariff records found</td>
        </tr>
    </c:if>
    </tbody>
</table>

<div style="text-align: right; margin-top: 10px;">
    <button id="addNewBtn" class="btn btnClick">Add New</button>
</div>

<script>
    $(document).ready(function() {
        // Helper functions for displaying messages
        function showSuccessMessage(message) {
            $('#tariffErrorMsg').hide();
            $('#tariffSuccessMsg').text(message).css('display', 'block').show();
        }

        function showErrorMessage(message) {
            $('#tariffSuccessMsg').hide();
            $('#tariffErrorMsg').text(message).css('display', 'block').show();
        }

        // Function to clear all messages
        function clearAllMessages() {
            $('#tariffSuccessMsg, #tariffErrorMsg').hide().text('');
        }

        // Hide messages initially and clear any text
        clearAllMessages();

        let flatpickrInstances = [];

        function editRow(button) {
            const row = $(button).closest('tr');
            const tariffId = row.data('tariff-id');
            const isCurrent = row.data('is-current');

            // Store original values before making editable
            const originalValidFrom = row.find('[data-path="validFrom"]').contents().filter(function() {
                return this.nodeType === 3;
            }).text().trim();
            const originalValidTill = row.find('[data-path="validTill"]').contents().filter(function() {
                return this.nodeType === 3;
            }).text().trim();
            const originalRate = row.find('[data-path="rate"]').text().trim();

            // Store original values as data attributes
            row.data('original-valid-from', originalValidFrom);
            row.data('original-valid-till', originalValidTill);
            row.data('original-rate', originalRate);

            // Make table cells editable
            row.find('[data-path="validFrom"]').attr('contenteditable', true).addClass('editable');
            row.find('[data-path="validTill"]').attr('contenteditable', true).addClass('editable');
            row.find('[data-path="rate"]').attr('contenteditable', true).addClass('editable');

            // Initialize Flatpickr for validFrom and validTill
            const validFromCell = row.find('[data-path="validFrom"]');
            const validTillCell = row.find('[data-path="validTill"]');

            flatpickrInstances.push(flatpickr(validFromCell[0], {
                dateFormat: "Y-m-d",
                allowInput: true,
                onClose: function(selectedDates, dateStr, instance) {
                    // Replace the cell's text content (excluding the icon) with the new date
                    validFromCell.contents().filter(function() {
                        return this.nodeType === 3; // Text nodes only
                    }).remove();
                    validFromCell.prepend(document.createTextNode(dateStr));
                }
            }));
            flatpickrInstances.push(flatpickr(validTillCell[0], {
                dateFormat: "Y-m-d",
                allowInput: true,
                onClose: function(selectedDates, dateStr, instance) {
                    // Replace the cell's text content (excluding the icon) with the new date
                    validTillCell.contents().filter(function() {
                        return this.nodeType === 3; // Text nodes only
                    }).remove();
                    validTillCell.prepend(document.createTextNode(dateStr));
                }
            }));

            // Enable calendar icon click to open Flatpickr
            row.find('.calendar-icon').on('click', function() {
                const cell = $(this).parent();
                if (cell.hasClass('editable')) {
                    const flatpickrInstance = flatpickrInstances.find(instance => instance.element === cell[0]);
                    if (flatpickrInstance) {
                        flatpickrInstance.open();
                    }
                }
            });

            // Change button to "Save" and add "Cancel" button next to it
            const actionCell = $(button).closest('td');
            $(button).text('Save').removeClass('edit-btn').addClass('save-btn btn-sm btn btnClick');
            $(button).after('<button class="btn btn-secondary btn-sm cancel-btn" style="margin-left: 5px;">Cancel</button>');
        }

        function saveRow(button) {
            const row = $(button).closest('tr');
            const tariffId = row.data('tariff-id');
            const isCurrent = row.data('is-current');
            const validFrom = row.find('[data-path="validFrom"]').contents().filter(function() {
                return this.nodeType === 3; // Text nodes only
            }).text().trim();
            const validTill = row.find('[data-path="validTill"]').contents().filter(function() {
                return this.nodeType === 3; // Text nodes only
            }).text().trim();
            const rate = row.find('[data-path="rate"]').text().trim();

            // Get original values
            const originalValidFrom = row.data('original-valid-from');
            const originalValidTill = row.data('original-valid-till');
            const originalRate = row.data('original-rate');

            // Check if any values have changed
            const hasChanges = (validFrom !== originalValidFrom) ||
                (validTill !== originalValidTill) ||
                (rate !== originalRate);

            if (!hasChanges) {
                showSuccessMessage('Nothing to Update');
                // Remove editable state
                row.find('[data-path]').attr('contenteditable', false).removeClass('editable');
                row.find('.save-btn').text('Edit').removeClass('save-btn').addClass('edit-btn');
                row.find('.cancel-btn').remove(); // Remove the cancel button

                // Destroy Flatpickr instances for this row
                flatpickrInstances.forEach(instance => instance.destroy());
                flatpickrInstances = [];
                return;
            }

            if (isNaN(rate) || rate === "") {
                showErrorMessage('Error: Rate must be a valid number.');
                return;
            }
            // Parse validFrom and validTill months
            const validFromDate = new Date(validFrom);
            const validTillDate = new Date(validTill);

            if (validTillDate.getMonth() <= validFromDate.getMonth() && validTillDate.getFullYear() <= validFromDate.getFullYear()) {
                showErrorMessage('Error: validTill month must be greater than validFrom month.');
                return;
            }

            const updatedData = {
                tariffId: tariffId,
                isCurrent: isCurrent,
                validFrom: validFrom,
                validTill: validTill,
                rate: rate
            };

            $.ajax({
                url: '/PTS/updateTariff',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(updatedData),
                success: function(response) {
                    showSuccessMessage('Tariff updated successfully!');
                    // Remove editable state
                    row.find('[data-path]').attr('contenteditable', false).removeClass('editable');
                    row.find('.save-btn').text('Edit').removeClass('save-btn').addClass('edit-btn');
                    row.find('.cancel-btn').remove(); // Remove the cancel button

                    // Destroy Flatpickr instances for this row
                    flatpickrInstances.forEach(instance => instance.destroy());
                    flatpickrInstances = [];
                },
                error: function(xhr, status, error) {
                    showErrorMessage('Error updating tariff: ' + error);
                }
            });
        }

        // Add New Tariff Popup with Empty Table
        $('#addNewBtn').on('click', function() {
            // First, get the calculated dates from the server
            $.ajax({
                url: '/PTS/getCalculatedTariffDates',
                method: 'GET',
                success: function(response) {
                    console.log('Received calculated dates:', response);
                    const calculatedValidFrom = response.validFrom || '2025-07-01';
                    const calculatedValidTill = response.validTill || '2025-12-30';

                    console.log('calculatedValidFrom:', calculatedValidFrom);
                    console.log('calculatedValidTill:', calculatedValidTill);

                    let tableHTML = `
                        <table class="popup-table">
                            <thead>
                                <tr>
                                    <th>Tariff Type</th>
                                    <th>Valid From</th>
                                    <th>Valid Till</th>
                                    <th>Tariff Name</th>
                                    <th>Rate</th>
                                </tr>
                            </thead>
                            <tbody>`;

                    // Create 8 empty rows

                    // Row 1
                    // Row 1 - ENERGY TARIFF (rowspan 3)
                    tableHTML +=
                        '<tr data-row-index="0">' +
                        '<td data-field="tariffType" rowspan="3" width="150px">ENERGY TARIFF</td>' +
                        '<td contenteditable="true" data-field="validFrom" class="date-cell">' + calculatedValidFrom + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td contenteditable="true" data-field="validTill" class="date-cell">' + calculatedValidTill + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td data-field="tariffName" width="200px" align="left">Energy Day Tariff</td>' +
                        '<td data-field="rate"><input type="text" class="form-control rate-input"></td>' +
                        '</tr>';

                    // Row 2 - No tariffType cell (part of rowspan)
                    tableHTML +=
                        '<tr data-row-index="1">' +
                        '<td contenteditable="true" data-field="validFrom" class="date-cell">' + calculatedValidFrom + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td contenteditable="true" data-field="validTill" class="date-cell">' + calculatedValidTill + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td data-field="tariffName" width="200px" align="left">Energy Peak Tariff</td>' +
                        '<td data-field="rate"><input type="text" class="form-control rate-input"></td>' +
                        '</tr>';

                    // Row 3 - No tariffType cell (part of rowspan)
                    tableHTML +=
                        '<tr data-row-index="2">' +
                        '<td contenteditable="true" data-field="validFrom" class="date-cell">' + calculatedValidFrom + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td contenteditable="true" data-field="validTill" class="date-cell">' + calculatedValidTill + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td data-field="tariffName" width="200px" align="left">Energy Off Peak Tariff</td>' +
                        '<td data-field="rate"><input type="text" class="form-control rate-input"></td>' +
                        '</tr>';

                    // Row 4 - CAPACITY TARIFF
                    tableHTML +=
                        '<tr data-row-index="3">' +
                        '<td data-field="tariffType" width="150px">CAPACITY TARIFF</td>' +
                        '<td contenteditable="true" data-field="validFrom" class="date-cell">' + calculatedValidFrom + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td contenteditable="true" data-field="validTill" class="date-cell">' + calculatedValidTill + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td data-field="tariffName" width="200px" align="left">Capacity Tariff</td>' +
                        '<td data-field="rate"><input type="text" class="form-control rate-input"></td>' +
                        '</tr>';

                    // Row 5 - ADJUSTMENT FACTOR (rowspan 4)
                    tableHTML +=
                        '<tr data-row-index="4">' +
                        '<td data-field="tariffType" rowspan="4" width="150px">ADJUSTMENT FACTOR</td>' +
                        '<td contenteditable="true" data-field="validFrom" class="date-cell">' + calculatedValidFrom + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td contenteditable="true" data-field="validTill" class="date-cell">' + calculatedValidTill + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td data-field="tariffName" width="200px" align="left">Day Upward Adjustment Factor</td>' +
                        '<td data-field="rate"><input type="text" class="form-control rate-input"></td>' +
                        '</tr>';

                    // Row 6 - No tariffType cell (part of rowspan)
                    tableHTML +=
                        '<tr data-row-index="5">' +
                        '<td contenteditable="true" data-field="validFrom" class="date-cell">' + calculatedValidFrom + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td contenteditable="true" data-field="validTill" class="date-cell">' + calculatedValidTill + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td data-field="tariffName" width="200px" align="left">Peak Upward Adjustment Factor</td>' +
                        '<td data-field="rate"><input type="text" class="form-control rate-input"></td>' +
                        '</tr>';

                    // Row 7 - No tariffType cell (part of rowspan)
                    tableHTML +=
                        '<tr data-row-index="6">' +
                        '<td contenteditable="true" data-field="validFrom" class="date-cell">' + calculatedValidFrom + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td contenteditable="true" data-field="validTill" class="date-cell">' + calculatedValidTill + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td data-field="tariffName" width="200px" align="left">Off Peak Upward Adjustment Factor</td>' +
                        '<td data-field="rate"><input type="text" class="form-control rate-input"></td>' +
                        '</tr>';

                    // Row 8 - No tariffType cell (part of rowspan)
                    tableHTML +=
                        '<tr data-row-index="7">' +
                        '<td contenteditable="true" data-field="validFrom" class="date-cell">' + calculatedValidFrom + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td contenteditable="true" data-field="validTill" class="date-cell">' + calculatedValidTill + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td data-field="tariffName" width="200px" align="left">Peak Demand Factor</td>' +
                        '<td data-field="rate"><input type="text" class="form-control rate-input"></td>' +
                        '</tr>';

                    tableHTML += `
                            </tbody>
                        </table>`;

                    // Show the SweetAlert popup with the generated table
                    console.log('Generated table HTML with calculated dates:', tableHTML);
                    showTariffPopup(tableHTML);
                },
                error: function(xhr, status, error) {
                    console.error('Error getting calculated dates:', error);
                    console.error('Status:', status);
                    console.error('Response:', xhr.responseText);

                    // Show error message to user
                    showErrorMessage('Failed to load calculated dates. Using default values.');

                    // Use fallback dates if API fails
                    const calculatedValidFrom = '2025-07-01';
                    const calculatedValidTill = '2025-12-30';

                    let tableHTML = `
                        <table class="popup-table">
                            <thead>
                                <tr>
                                    <th>Tariff Type</th>
                                    <th>Valid From</th>
                                    <th>Valid Till</th>
                                    <th>Tariff Name</th>
                                    <th>Rate</th>
                                </tr>
                            </thead>
                            <tbody>`;

                    // Create 8 rows with fallback dates
                    tableHTML +=
                        '<tr data-row-index="0">' +
                        '<td contenteditable="true" data-field="tariffType" rowspan="3" width="150px">ENERGY TARIFF</td>' +
                        '<td contenteditable="true" data-field="validFrom" class="date-cell">' + calculatedValidFrom + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td contenteditable="true" data-field="validTill" class="date-cell">' + calculatedValidTill + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td contenteditable="true" data-field="tariffName" width="200px" align="left">Energy Day Tariff</td>' +
                        '<td data-field="rate"><input type="text" class="form-control rate-input"></td>' +
                        '</tr>';

                    tableHTML +=
                        '<tr data-row-index="1">' +
                        '<td contenteditable="true" data-field="validFrom" class="date-cell">' + calculatedValidFrom + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td contenteditable="true" data-field="validTill" class="date-cell">' + calculatedValidTill + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td contenteditable="true" data-field="tariffName" width="200px" align="left">Energy Peak Tariff</td>' +
                        '<td data-field="rate"><input type="text" class="form-control rate-input"></td>' +
                        '</tr>';

                    tableHTML +=
                        '<tr data-row-index="2">' +
                        '<td contenteditable="true" data-field="validFrom" class="date-cell">' + calculatedValidFrom + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td contenteditable="true" data-field="validTill" class="date-cell">' + calculatedValidTill + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td contenteditable="true" data-field="tariffName" width="200px" align="left">Energy Off Peak Tariff</td>' +
                        '<td data-field="rate"><input type="text" class="form-control rate-input"></td>' +
                        '</tr>';

                    tableHTML +=
                        '<tr data-row-index="3">' +
                        '<td contenteditable="true" data-field="tariffType" width="150px">CAPACITY TARIFF</td>' +
                        '<td contenteditable="true" data-field="validFrom" class="date-cell">' + calculatedValidFrom + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td contenteditable="true" data-field="validTill" class="date-cell">' + calculatedValidTill + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td contenteditable="true" data-field="tariffName" width="200px" align="left">Capacity Tariff</td>' +
                        '<td data-field="rate"><input type="text" class="form-control rate-input"></td>' +
                        '</tr>';

                    tableHTML +=
                        '<tr data-row-index="4">' +
                        '<td contenteditable="true" data-field="tariffType" rowspan="4" width="150px">ADJUSTMENT FACTOR</td>' +
                        '<td contenteditable="true" data-field="validFrom" class="date-cell">' + calculatedValidFrom + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td contenteditable="true" data-field="validTill" class="date-cell">' + calculatedValidTill + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td contenteditable="true" data-field="tariffName" width="200px" align="left">Day Upward Adjustment Factor</td>' +
                        '<td data-field="rate"><input type="text" class="form-control rate-input"></td>' +
                        '</tr>';

                    tableHTML +=
                        '<tr data-row-index="5">' +
                        '<td contenteditable="true" data-field="validFrom" class="date-cell">' + calculatedValidFrom + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td contenteditable="true" data-field="validTill" class="date-cell">' + calculatedValidTill + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td contenteditable="true" data-field="tariffName" width="200px" align="left">Peak Upward Adjustment Factor</td>' +
                        '<td data-field="rate"><input type="text" class="form-control rate-input"></td>' +
                        '</tr>';

                    tableHTML +=
                        '<tr data-row-index="6">' +
                        '<td contenteditable="true" data-field="validFrom" class="date-cell">' + calculatedValidFrom + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td contenteditable="true" data-field="validTill" class="date-cell">' + calculatedValidTill + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td contenteditable="true" data-field="tariffName" width="200px" align="left">Off Peak Upward Adjustment Factor</td>' +
                        '<td data-field="rate"><input type="text" class="form-control rate-input"></td>' +
                        '</tr>';

                    tableHTML +=
                        '<tr data-row-index="7">' +
                        '<td contenteditable="true" data-field="validFrom" class="date-cell">' + calculatedValidFrom + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td contenteditable="true" data-field="validTill" class="date-cell">' + calculatedValidTill + '<i class="fas fa-calendar-alt calendar-icon"></i></td>' +
                        '<td contenteditable="true" data-field="tariffName" width="200px" align="left">Peak Demand Factor</td>' +
                        '<td data-field="rate"><input type="text" class="form-control rate-input"></td>' +
                        '</tr>';

                    tableHTML +=
                        '</tbody>' +
                        '</table>';

                    // Show the SweetAlert popup with fallback dates
                    showTariffPopup(tableHTML);
                }
            });
        });

        // Function to show the tariff popup (extracted to avoid code duplication)
        function showTariffPopup(tableHTML) {
            Swal.fire({
                html: tableHTML,
                width: '800px',
                showCancelButton: true,
                allowOutsideClick: false, // Prevent closing on outside click
                confirmButtonText: 'Save All',
                cancelButtonText: 'Cancel',
                focusConfirm: false,
                didOpen: () => {
                    // Initialize Flatpickr for all date cells
                    const dateFields = document.querySelectorAll('[data-field="validFrom"], [data-field="validTill"]');
                    dateFields.forEach(field => {
                        if (field) { // Ensure the field exists
                            flatpickr(field, {
                                dateFormat: "Y-m-d",
                                allowInput: true,
                                onClose: function(selectedDates, dateStr, instance) {
                                    if (dateStr) { // Ensure dateStr is not undefined
                                        const cell = instance.element;
                                        const icon = cell.querySelector('.calendar-icon');
                                        cell.textContent = dateStr.trim(); // Safely use trim
                                        if (icon) {
                                            cell.appendChild(icon); // Re-add the icon
                                        }
                                    }
                                }
                            });
                        } else {
                            console.error("Flatpickr initialization failed: Element not found.");
                        }
                    });

                    // Add click event for calendar icons
                    const calendarIcons = document.querySelectorAll('.popup-table .calendar-icon');
                    calendarIcons.forEach(icon => {
                        icon.addEventListener('click', function() {
                            const cell = this.parentElement;
                            const flatpickrInstance = cell._flatpickr;
                            if (flatpickrInstance) {
                                flatpickrInstance.open();
                            }
                        });
                    });
                },
                preConfirm: () => {
                    const rows = document.querySelectorAll('.popup-table tbody tr');
                    const tariffs = [];

                    // Define tariff types for each row based on rowspan structure
                    const tariffTypeMap = {
                        0: 'ENERGY TARIFF',
                        1: 'ENERGY TARIFF',
                        2: 'ENERGY TARIFF',
                        3: 'CAPACITY TARIFF',
                        4: 'ADJUSTMENT FACTOR',
                        5: 'ADJUSTMENT FACTOR',
                        6: 'ADJUSTMENT FACTOR',
                        7: 'ADJUSTMENT FACTOR'
                    };

                    // Check that ALL 8 rows are completely filled
                    for (let i = 0; i < rows.length; i++) {
                        const row = rows[i];
                        const tariffTypeCell = row.querySelector('[data-field="tariffType"]');
                        const tariffType = tariffTypeCell ? tariffTypeCell.textContent.trim() : tariffTypeMap[i];
                        const validFrom = row.querySelector('[data-field="validFrom"]').textContent.trim();
                        const validTill = row.querySelector('[data-field="validTill"]').textContent.trim();
                        const tariffName = row.querySelector('[data-field="tariffName"]').textContent.trim();
                        const rateInput = row.querySelector('[data-field="rate"] input.rate-input');
                        const rate = rateInput ? rateInput.value.trim() : '';

                        // Check if any field is empty
                        if (!tariffType || !validFrom || !validTill || !tariffName || !rate) {
                            Swal.showValidationMessage(`Row ${i + 1}: All fields must be filled. Please complete all 8 rows before saving.`);
                            return false;
                        }

                        // Validate that rate is a number
                        if (isNaN(rate) || rate === "") {
                            Swal.showValidationMessage(`Row ${i + 1}: Rate must be a valid number.`);
                            return false;
                        }

                        // Validate date logic
                        const validFromDate = new Date(validFrom);
                        const validTillDate = new Date(validTill);
                        if (validTillDate.getMonth() <= validFromDate.getMonth() &&
                            validTillDate.getFullYear() <= validFromDate.getFullYear()) {
                            Swal.showValidationMessage(`Row ${i + 1}: Valid Till month must be greater than Valid From month`);
                            return false;
                        }

                        // Add valid tariff to array
                        tariffs.push({
                            tarrifType: tariffType,
                            validFrom: validFrom,
                            validTill: validTill,
                            tariffName: tariffName,
                            rate: rate,
                            isCurrent: 1,
                        });
                    }
                    console.log('Tariffs payload:', tariffs); // Log the payload
                    return tariffs;
                }
            }).then((result) => {
                if (result.isConfirmed && result.value.length > 0) {
                    // Show loading indicator
                    Swal.fire({
                        title: 'Saving...',
                        text: 'Please wait while tariffs are being saved.',
                        allowOutsideClick: false,
                        didOpen: () => {
                            Swal.showLoading();
                        }
                    });

                    // Send all tariffs to the server in a single request
                    $.ajax({
                        url: '/PTS/saveAllTariffs',
                        method: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify(result.value), // Send the entire array
                        error: function(response) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Success',
                                text: 'All tariffs added successfully! Previous tariffs have been updated to non-current.',
                                confirmButtonText: 'OK'
                            }).then(() => {
                                // Reload the page to show updated data
                                window.location.reload();
                            });
                        },
                        success: function(xhr, status, error) {
                            let errorMessage = 'Error adding tariffs';
                            // if (xhr.responseText) {
                            //     errorMessage += ': ' + xhr.responseText;
                            // } else {
                            //     errorMessage += ': ' + error;
                            // }

                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: errorMessage,
                                confirmButtonText: 'OK'
                            }).then(() => {
                                // Reload the page to show updated data
                                window.location.reload();
                            });
                        }
                    });
                }
            });
        }

        // Attach click event to buttons with class 'edit-btn' and 'save-btn'
        $(document).on('click', '.edit-btn', function() {
            editRow(this);
        });

        $(document).on('click', '.save-btn', function() {
            saveRow(this);
        });

        $(document).on('click', '.cancel-btn', function() {
            const row = $(this).closest('tr');
            row.find('[data-path]').attr('contenteditable', false).removeClass('editable');
            row.find('.save-btn').text('Edit').removeClass('save-btn').addClass('edit-btn');
            $(this).remove(); // Remove the cancel button

            // Destroy Flatpickr instances for this row
            flatpickrInstances.forEach(instance => instance.destroy());
            flatpickrInstances = [];
        });

        $('#saveTariffsButton').on('click', function() {
            // Example data to send to the server
            const tariffModels = [
                {
                    tariffType: tariffType,
                    validFrom: validFrom,
                    validTill: validTill,
                    tariffName: tariffName,
                    rate: rate,
                }
            ];

            // AJAX POST request
            $.ajax({
                url: '/saveAllTariffs',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(tariffModels),
                success: function(response) {
                    showSuccessMessage('Tariffs saved successfully: ' + response);
                },

                error: function(xhr, status, error) {
                    showErrorMessage('Error saving tariffs: ' + xhr.responseText);
                }
            });

        });
    });
</script>