package com.it.ceb.pts.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MeterReadingResultModel {

    private Long readingId;

    private String serialNo;

    private String cebSerialNo;

    private String measureType;

    private BigDecimal currentReading;

    private BigDecimal previousReading;

    private BigDecimal energy;

    private String pssName;

    private String area;
    //--------------

}
