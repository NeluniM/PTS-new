package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.BillCycle;
import com.it.ceb.pts.domain.ProvinceConfig;


import java.util.List;

public interface ProvinceConfigDao {

    ProvinceConfig findByParams(Long billCycleNo, String licenseCode);


    ProvinceConfig save(ProvinceConfig provinceConfig);

    Long isBillCycleCurrent(Long billCycleNo);

    ProvinceConfig getProvinceConfig(Long billCycleNo, String licenseCode, String provinceCode);

    BillCycle getCurrentBillCycle();
}