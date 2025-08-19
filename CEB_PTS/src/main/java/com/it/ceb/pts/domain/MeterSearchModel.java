package com.it.ceb.pts.domain;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;

@Getter
@Setter
public class MeterSearchModel {

    private String serialNo;
    private String billCycle;
    private String licenseCode;
    private String provinceCode;
    private String provinceName;
    private String lecoProvinceCode;
    private String areaCode;
    private String areaName;
    private String meterPointCode;
    private String meterPointName;
    private String primarySubstationCode;
    private String primarySubstationName;

    private MultipartFile uploadFile;
    private List<MultipartFile> uploadedFiles;

    private String previousReading;
    private String currentReading;
    private String energy;
    private String readingMethod;
    private String measureName;
    private String remark;
    private List<String> readingFileList;
}