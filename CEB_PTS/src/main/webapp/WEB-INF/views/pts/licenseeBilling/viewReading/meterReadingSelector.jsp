<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="mb-5">
    <div class="card">
        <div class="container mt-4 mb-4" style="width: 70%;">
            <div class="row">
                <div class="col" >
                    <div class="selectUnit">
                        <label>Bill Cycle</label>
                        <div class="input-group">
                            <input value="${billCycleNo}" type="number" id="billCycle" name="billCycle" class="form-control">
                            </select>
                        </div>
                    </div>
                </div>

                <div class="col">
                    <div class="selectUnit">
                        <label>Distribution Division</label>
                        <div class="input-group">
                            <c:if test="${not empty licenseList}">
                                <select id="divisionDropdown" class="form-control" >
                                    <c:forEach var="license" items="${licenseList}">
                                        <option value="${license.licenseCode}" label="${license.licenseName}" />
                                    </c:forEach>
                                </select>
                            </c:if>
                        </div>
                    </div>
                </div>


                <div class="col" >
                    <div class="selectUnit">
                        <label>Province</label>
                        <div class="input-group">
                            <select id="provinceDropdown" class="form-control">
                            </select>
                        </div>
                    </div>
                </div>

                <div>
                    <div class="ml-5 pt-3">
                        <input type="submit" class="btn btnClick" id="click_btn" value=${param.btnName}>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function() {
        //-------------------------------------------------------------------
        //            drop down menu
        //-------------------------------------------------------------------
        const divDropdown = $('#divisionDropdown');
        const provDropdown = $('#provinceDropdown');
        const provinceList = JSON.parse('${provinceList}');
        console.log(provinceList);

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
    .selectUnit label, .selectUnit select {
        font-size: small;
        margin: 0;
    }
</style>