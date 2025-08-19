package com.it.ceb.pts.model;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class ProvinceEnergySummaryModel {
    private String provinceName;
    private String provinceCode;
    private BigDecimal dayEnergy ;
    private BigDecimal peakEnergy ;
    private BigDecimal offPeakEnergy ;
    private BigDecimal coincidentPeak ;
    private BigDecimal dayEnergyAdj ;
    private BigDecimal peakEnergyAdj ;
    private BigDecimal offPeakEnergyAdj ;
    private BigDecimal coincidentPeakAdj ;
}