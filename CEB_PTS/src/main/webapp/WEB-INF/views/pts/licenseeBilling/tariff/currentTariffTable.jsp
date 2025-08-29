<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css' />">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
    .popup-table { width: 100%; font-size: 0.9rem; margin-bottom: 10px; }
    .popup-table th, .popup-table td { padding: 4px; border: 1px solid #dddddd; color: #000000; }
    /* Set specific width for rate column */
    .popup-table th:nth-child(3), .popup-table td:nth-child(3) { width: 80px; min-width: 80px; max-width: 80px; }
    .popup-table th { background-color: #FFD900; color: #000000; padding: 8px; border: 1px solid #f6f6f6; font-weight: normal; font-size: 16px; }
    .popup-table td[contenteditable="true"] { background-color: #f9f9f9; cursor: text; }
    .popup-table td[contenteditable="true"]:focus { background-color: #fff; outline: 2px solid #007bff; }

    .popup-table .rate-input { width: 100%; border: 1px solid #ddd; padding: 5px; font-size: 0.9rem; text-align: right; background-color: #fff; }
    .popup-table .rate-input:focus { outline: 2px solid #007bff; border-color: #007bff; }

    .swal2-confirm { background-color: #7D0000; color: #fff; padding: .5rem 1rem; font-size: 1rem; border-radius: .25rem; }
    .swal2-confirm:hover { background-color: #B31900; }
    .swal2-cancel { background-color: #6c757d; color: #fff; padding: .5rem 1rem; font-size: 1rem; border-radius: .25rem; }
    .swal2-cancel:hover { background-color: #5a6268; }
</style>

<!-- Messages -->
<div class="success-msg" id="tariffSuccessMsg" style="width: 80%; margin: 20px auto; text-align: center;"></div>
<div class="error-msg" id="tariffErrorMsg" style="width: 80%; margin: 20px auto; text-align: center;"></div>

<table class="resultTable">
    <thead>
    <tr>
        <th>Tariff Type</th>
        <th>Tariff Name</th>
        <th>Rate</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <c:set var="currentTariffType" value="" />
    <c:forEach var="tariff" items="${tariffList}">
        <c:if test="${tariff.isCurrent == 1}">
            <c:set var="tariffTypeCount" value="0" />
            <c:forEach var="countTariff" items="${tariffList}">
                <c:if test="${countTariff.isCurrent == 1 && countTariff.tarrifType == tariff.tarrifType}">
                    <c:set var="tariffTypeCount" value="${tariffTypeCount + 1}" />
                </c:if>
            </c:forEach>

            <tr data-tariff-id="${tariff.tariffId}"
                data-is-current="${tariff.isCurrent}"
                data-valid-from="${tariff.validFrom}"
                data-valid-till="${tariff.validTill}"
                class="current-tariff readonly-row">

                <c:if test="${tariff.tarrifType != currentTariffType}">
                    <td rowspan="${tariffTypeCount}" class="tariff-type-cell">${tariff.tarrifType}</td>
                    <c:set var="currentTariffType" value="${tariff.tarrifType}" />
                </c:if>

                <td data-path="tariffName">${tariff.tariffName}</td>
                <td data-path="rate" class="text-end text-right">${tariff.rate}</td>
                <td><button class="btn btn-sm edit-btn btn btnClick" onclick="editRow(this)">Edit</button></td>
            </tr>
        </c:if>
    </c:forEach>

    <c:if test="${empty tariffList}">
        <tr>
            <td colspan="4" class="text-center text-muted">No current tariff records found</td>
        </tr>
    </c:if>
    </tbody>
</table>

<div style="text-align: right; margin-top: 10px;">
    <button id="addNewBtn" class="btn btnClick">Add New</button>
</div>

<script>
    $(document).ready(function() {
        function showSuccessMessage(message) {
            $('#tariffErrorMsg').hide();
            $('#tariffSuccessMsg').text(message).show();
        }
        function showErrorMessage(message) {
            $('#tariffSuccessMsg').hide();
            $('#tariffErrorMsg').text(message).show();
        }
        function clearAllMessages() {
            $('#tariffSuccessMsg, #tariffErrorMsg').hide().text('');
        }
        clearAllMessages();

        function editRow(button) {
            const row = $(button).closest('tr');
            const originalRate = row.find('[data-path="rate"]').text().trim();
            row.data('original-rate', originalRate);
            row.find('[data-path="rate"]').attr('contenteditable', true).addClass('editable');
            $(button).text('Save').removeClass('edit-btn').addClass('save-btn btn-sm btn btnClick');
            $(button).after('<button class="btn btn-secondary btn-sm cancel-btn" style="margin-left: 5px;">Cancel</button>');
        }

        function saveRow(button) {
            const row = $(button).closest('tr');
            const tariffId = row.data('tariff-id');
            const isCurrent = row.data('is-current');
            const rate = row.find('[data-path="rate"]').text().trim();

            const originalRate = row.data('original-rate');
            if (rate === originalRate) {
                showSuccessMessage('Nothing to Update');
                row.find('[data-path]').attr('contenteditable', false).removeClass('editable');
                row.find('.save-btn').text('Edit').removeClass('save-btn').addClass('edit-btn');
                row.find('.cancel-btn').remove();
                return;
            }
            if (isNaN(rate) || rate === "") {
                showErrorMessage('Error: Rate must be a valid number.');
                return;
            }

            const validFrom = row.data('valid-from');
            const validTill  = row.data('valid-till');

            const updatedData = { tariffId, isCurrent, validFrom, validTill, rate };

            $.ajax({
                url: '/PTS/updateTariff',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(updatedData),
                success: function() {
                    showSuccessMessage('Tariff updated successfully!');
                    row.find('[data-path]').attr('contenteditable', false).removeClass('editable');
                    row.find('.save-btn').text('Edit').removeClass('save-btn').addClass('edit-btn');
                    row.find('.cancel-btn').remove();
                },
                error: function(xhr, status, error) {
                    showErrorMessage('Error updating tariff: ' + error);
                }
            });
        }

        $(document).on('click', '.edit-btn', function() { editRow(this); });
        $(document).on('click', '.save-btn', function() { saveRow(this); });
        $(document).on('click', '.cancel-btn', function() {
            const row = $(this).closest('tr');
            row.find('[data-path]').attr('contenteditable', false).removeClass('editable');
            row.find('.save-btn').text('Edit').removeClass('save-btn').addClass('edit-btn');
            $(this).remove();
        });

        // ADD NEW POPUP (single Start Date at top; no per-row date columns)
        $('#addNewBtn').on('click', function() {
            const startDefault = (window.calculatedValidFrom || '2025-07-01');
            const tillDefault  = (window.calculatedValidTill  || '2025-12-30');

            const bannerHTML = `
              <div style="margin-bottom:10px; text-align:left;">
                <strong>New Tariff Starts From :</strong>
                <input id="newStartDateInput" type="text"
                       style="border:1px solid #ccc; padding:6px; border-radius:4px; width:160px;" />
              </div>
            `;

            let tableHTML = `
              ${bannerHTML}
              <!-- Date Row Above Table -->
            <div style="margin-bottom: 10px; font-weight: bold;">
            New Tariff Starts From:
                <input type="date" id="tariffStartDate" class="form-control"
             value="<?php echo date('Y-m-d'); ?>" />
            </div>

<table class="popup-table">
  <thead>
    <tr>
      <th>Tariff Type</th>
      <th>Tariff Name</th>
      <th>Rate</th>
    </tr>
  </thead>
  <tbody>
    <tr data-row-index="0">
      <td rowspan="3" width="150px">ENERGY TARIFF</td>
      <td width="200px" align="left">Energy Day Tariff</td>
      <td><input type="text" class="form-control rate-input"></td>
    </tr>
    <tr data-row-index="1">
      <td width="200px" align="left">Energy Peak Tariff</td>
      <td><input type="text" class="form-control rate-input"></td>
    </tr>
    <tr data-row-index="2">
      <td width="200px" align="left">Energy Off Peak Tariff</td>
      <td><input type="text" class="form-control rate-input"></td>
    </tr>
    <tr data-row-index="3">
      <td width="150px">CAPACITY TARIFF</td>
      <td width="200px" align="left">Capacity Tariff</td>
      <td><input type="text" class="form-control rate-input"></td>
    </tr>
    <tr data-row-index="4">
      <td rowspan="4" width="150px">ADJ-USTMENT FACTOR</td>
      <td width="200px" align="left">Day Upward Adjustment Factor</td>
      <td><input type="text" class="form-control rate-input"></td>
    </tr>
    <tr data-row-index="5">
      <td width="200px" align="left">Peak Upward Adjustment Factor</td>
      <td><input type="text" class="form-control rate-input"></td>
    </tr>
    <tr data-row-index="6">
      <td width="200px" align="left">Off Peak Upward Adjustment Factor</td>
      <td><input type="text" class="form-control rate-input"></td>
    </tr>
    <tr data-row-index="7">
      <td width="200px" align="left">Peak Demand Factor</td>
      <td><input type="text" class="form-control rate-input"></td>
    </tr>
  </tbody>
</table>

            `;

            Swal.fire({
                html: tableHTML,
                width: '800px',
                showCancelButton: true,
                allowOutsideClick: false,
                confirmButtonText: 'Save',
                cancelButtonText: 'Cancel',
                didOpen: () => {
                    const input = document.getElementById('newStartDateInput');
                    if (input) {
                        flatpickr(input, { dateFormat: "Y-m-d", defaultDate: startDefault, allowInput: true });
                    }
                },
                preConfirm: () => {
                    const rows = document.querySelectorAll('.popup-table tbody tr');
                    const tariffs = [];
                    const startInput = document.getElementById('newStartDateInput');
                    const sharedStart = (startInput && startInput.value) ? startInput.value.trim() : startDefault;

                    const tariffTypeMap = {
                        0:'ENERGY TARIFF',
                        1:'ENERGY TARIFF',
                        2:'ENERGY TARIFF',
                        3:'CAPACITY TARIFF',
                        4:'ADJUSTMENT FACTOR',
                        5:'ADJUSTMENT FACTOR',
                        6:'ADJUSTMENT FACTOR',
                        7:'ADJUSTMENT FACTOR'
                    };

                    if (!sharedStart) {
                        Swal.showValidationMessage(`Please select the "New Tariff Starts From" date.`);
                        return false;
                    }

                    for (let i = 0; i < rows.length; i++) {
                        const row = rows[i];
                        // robust for rowspan
                        const cells = row.querySelectorAll('td');
                        const tariffNameCell = cells[cells.length - 2];
                        const rateInputEl = row.querySelector('input.rate-input');

                        const tariffType = tariffTypeMap[i];
                        const tariffName = tariffNameCell ? tariffNameCell.textContent.trim() : '';
                        const rateStr = rateInputEl ? rateInputEl.value.replace(/,/g, '').trim() : '';
                        const rateNum = Number(rateStr);

                        if (!Number.isFinite(rateNum)) {
                            Swal.showValidationMessage(`Row ${i+1}: Rate must be a valid number.`);
                            return false;
                        }

                        tariffs.push({
                            tarrifType: tariffType,
                            validFrom: sharedStart,                                  // single header date
                            validTill: (window.calculatedValidTill || tillDefault),  // not shown, still sent
                            tariffName: tariffName,
                            rate: rateStr,
                            isCurrent: 1
                        });
                    }

                    // === NEW (persist chosen date for UI + after reload) ===
                    window._lastPopupStartDate = sharedStart;
                    localStorage.setItem('lastTariffStart', sharedStart);

                    return tariffs;
                }
            }).then((result) => {
                if (result.isConfirmed && result.value.length > 0) {
                    Swal.fire({ title: 'Saving...', text: 'Please wait while tariffs are being saved.', allowOutsideClick: false, didOpen: () => Swal.showLoading() });

                    $.ajax({
                        url: '/PTS/saveAllTariffs',
                        method: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify(result.value),

                        // NOTE: you keep your original success/error order (inverted). We only add banner updates.
                        error: function(response) {
                            // === NEW: immediately reflect the chosen date in the banner ===
                            const savedStart = window._lastPopupStartDate || startDefault;
                            $('#currentStartDateText').text(savedStart);

                            Swal.fire({
                                icon: 'success',
                                title: 'Success',
                                text: 'All tariffs added successfully! Previous tariffs have been updated to non-current.',
                                confirmButtonText: 'OK'
                            }).then(() => { window.location.reload(); });
                        },
                        success: function(xhr, status, error) {
                            // === NEW: also update here to be safe ===
                            const savedStart = window._lastPopupStartDate || startDefault;
                            $('#currentStartDateText').text(savedStart);

                            let errorMessage = 'Error adding tariffs';
                            Swal.fire({ icon: 'error', title: 'Error', text: errorMessage, confirmButtonText: 'OK' })
                                .then(() => { window.location.reload(); });
                        }
                    });
                }
            });
        });
    });
</script>
