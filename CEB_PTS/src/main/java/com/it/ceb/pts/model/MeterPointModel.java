package com.it.ceb.pts.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class MeterPointModel {

    private Long id;

    private String serialNo;

    private String cebSerialNo;

    private String area;

    private String pss;

    private String status;

    private String errorReason;

    private List<MeterReadingRecordModel> meterReadingRecordModels = new ArrayList<>();

    private BigDecimal importEnergy = BigDecimal.ZERO;

    private BigDecimal exportEnergy = BigDecimal.ZERO;

    private BigDecimal importCoincidentPeak = BigDecimal.ZERO;

    private BigDecimal exportCoincidentPeak = BigDecimal.ZERO;

    public MeterPointModel(Long id, String serialNo, String cebSerialNo, String area,String pss) {
        this.id = id;
        this.serialNo = serialNo;
        this.cebSerialNo = cebSerialNo;
        this.area = area;
        this.pss = pss;
        this.status = "Incomplete";
        this.meterReadingRecordModels = new ArrayList<>();
    }

}