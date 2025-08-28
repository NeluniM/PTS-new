<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="mb-1">
    <div class="container mt-4 mb-4" style="width: 90%; ">

        <!-- Current Tariffs Section -->
        <div class="row">
            <div class="col vertical-layout">
                <h5>Current Tariffs</h5>

                <!-- Global start date banner (filled from server) -->
                <div id="currentStartBanner" class="alert alert-light" style="border:1px dashed #ccc;">
                    <strong>New Tariff Starts From :</strong>
                    <span id="currentStartDateText">—</span>
                </div>

                <div id="tariffList"></div>
            </div>
        </div>

        <!-- Non-Current Tariffs Section -->
        <div class="row mt-4">
            <div class="col vertical-layout">
                <h5>Previous Tariffs</h5>
                <div id="nonCurrentTariffList">
                    <!-- Non-current tariff table will be loaded here -->
                </div>
            </div>
        </div>

    </div>
</div>

<style>
    .table-with-plus thead tr:first-child th:first-child {
        width: 30px;
        padding: 5px !important;
        text-align: center;
        vertical-align: middle;
        border: none;
    }
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    let calculatedValidFrom = null; // shared start date
    let calculatedValidTill  = null; // still used internally but not shown

    $(document).ready(function () {
        // Load the shared dates first so UI can show the banner and popup can use it
        $.ajax({
            url: '/PTS/getCalculatedTariffDates',
            method: 'GET',
            success: function (resp) {
                calculatedValidFrom = resp.validFrom || '2025-07-01';
                calculatedValidTill  = resp.validTill  || '2025-12-30';
                $('#currentStartDateText').text(calculatedValidFrom);

                // If we just saved a new date, show it immediately
                const pending = localStorage.getItem('lastTariffStart');
                if (pending) { $('#currentStartDateText').text(pending); calculatedValidFrom = pending; }
            },
            error: function () {
                calculatedValidFrom = '2025-07-01';
                calculatedValidTill  = '2025-12-30';
                $('#currentStartDateText').text(calculatedValidFrom);

                // Same override on error path
                const pending = localStorage.getItem('lastTariffStart');
                if (pending) { $('#currentStartDateText').text(pending); calculatedValidFrom = pending; }
            },
            complete: function () {
                loadTariffRecords();
                loadNonCurrentTariffs();

                // clear the override after the page has loaded
                localStorage.removeItem('lastTariffStart');
            }
        });
    });

    function loadNonCurrentTariffs() {
        $.ajax({
            url: '/PTS/getNonCurrentTariffs',
            method: 'GET',
            success: function (response) { $('#nonCurrentTariffList').html(response); },
            error: function (xhr, status, error) {
                $('#nonCurrentTariffList').html(
                    `<div style="text-align:center;color:red;padding:20px;">Error loading non-current records: ${error}</div>`
                );
            }
        });
    }

    function loadTariffRecords() {
        $.ajax({
            url: '/PTS/getAllTariffs',
            method: 'GET',
            success: function (response) {
                $('#tariffList').html(response);

                // ✅ NEW: Derive the banner date from the current rows we just loaded.
                // This ensures the banner shows the real "validFrom" used by the current tariff rows,
                // even if the /getCalculatedTariffDates endpoint returns some hard-coded or stale date.
                const firstCurrentRow = $('#tariffList').find('tr.current-tariff').first();
                const vf = firstCurrentRow.data('valid-from');
                if (vf) {
                    $('#currentStartDateText').text(vf);
                    calculatedValidFrom = vf;
                } else {
                    // As an extra safety fallback, use the last saved date if present
                    const pending = localStorage.getItem('lastTariffStart');
                    if (pending) { $('#currentStartDateText').text(pending); calculatedValidFrom = pending; }
                }
            },
            error: function (xhr, status, error) {
                $('#tariffList').html(
                    `<div style="text-align:center;color:red;padding:20px;">Error loading records: ${error}</div>`
                );
            }
        });
    }
</script>
