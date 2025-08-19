package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.DistributionLicense;
import com.it.ceb.pts.domain.Province;

import java.util.List;

public interface DistributionLicenseDao {

    public List<DistributionLicense> getLicenseList() throws Exception;
    public List<Province> getProvinceByLicense(String licenseCode);
}
