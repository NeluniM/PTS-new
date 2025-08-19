package com.it.ceb.pts.repo;

import java.util.HashMap;
import java.util.List;

import com.it.ceb.pts.domain.Province;

public interface ProvinceDao {
	HashMap<String, String> getProvinceListToLicense(String licenceId) throws Exception;
    List<Province> getProvinceByDivition(String dev);
    List<Province> getAllProvince();

    public String getProvinceCodeByName(String provinceName);
}
