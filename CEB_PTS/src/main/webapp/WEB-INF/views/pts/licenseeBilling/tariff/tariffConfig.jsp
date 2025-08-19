<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="mb-1">
    <div class="container mt-4 mb-4" style="width: 90%; ">

        <!-- Current Tariffs Section -->
        <div class="row">
            <div class="col vertical-layout">
                <h5>Current Tariffs</h5>
                <div id="tariffList">
                </div>
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
    /*.table-with-plus {*/
    /*    position: relative;*/
    /*}*/

    .table-with-plus thead tr:first-child th:first-child {
        width: 30px;
        padding: 5px !important;
        text-align: center;
        vertical-align: middle;
        border: none;
    }



    /*.editing-mode {*/
    /*    background-color: #fff3cd !important;*/
    /*    border: 2px solid #ffc107;*/
    /*}*/

    /*.form-control {*/
    /*    font-size: 14px;*/
    /*    padding: 4px 8px;*/
    /*}*/

    /*.btn-sm {*/
    /*    padding: 2px 8px;*/
    /*    font-size: 12px;*/
    /*    margin: 1px;*/
    /*}*/

    /*.badge {*/
    /*    padding: 0.25em 0.6em;*/
    /*    font-size: 0.75em;*/
    /*    font-weight: 700;*/
    /*    line-height: 1;*/
    /*    text-align: center;*/
    /*    white-space: nowrap;*/
    /*    vertical-align: baseline;*/
    /*    border-radius: 0.25rem;*/
    /*}*/


</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    let isAddingNew = false;
    let editingRowId = null;
    let tariffCategories = [];

    $(document).ready(function () {

        // Automatically load tariff records when page loads
        loadTariffRecords();
        loadNonCurrentTariffs();
    });


    function loadNonCurrentTariffs() {
        $.ajax({
            url: '/PTS/getNonCurrentTariffs',
            method: 'GET',
            success: function (response) {
                console.log('Non-current tariff records loaded:', response);
                $('#nonCurrentTariffList').html(response);
            },
            error: function (xhr, status, error) {
                console.error('Failed to fetch non-current tariff records:', status, error);
                $('#nonCurrentTariffList').html(`
                    <div style="text-align: center; color: red; padding: 20px;">
                        Error loading non-current records: ${error}
                    </div>
                `);
            }
        });
    }

    function loadTariffRecords() {
        $.ajax({
            url: '/PTS/getAllTariffs',
            method: 'GET',
            success: function (response) {
                console.log('Tariff records loaded:', response);
                $('#tariffList').html(response);

            },
            error: function (xhr, status, error) {
                console.error('Failed to fetch tariff records:', status, error);
                alert('Failed to fetch tariff records. Please try again.');
                $('#tariffList').html(`
                    <div style="text-align: center; color: red; padding: 20px;">
                        Error loading records: ${error}
                    </div>
                `);
            }
        });
    }

</script>
