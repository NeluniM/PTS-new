package com.it.ceb.pts.model;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class MeterReadingFileModel {

    private String serialNo;

    private String cebSerialNo;

    private String pss;

    private String area;

    private String status;

    private String fileName;

    private String errorReason;

    private List<MeterReadingRecordModel> meterReadingRecordModelList = new ArrayList<>();

    private BigDecimal importEnergy = BigDecimal.ZERO;

    private BigDecimal exportEnergy = BigDecimal.ZERO;

    private BigDecimal importCoincidentPeak = BigDecimal.ZERO;

    private BigDecimal exportCoincidentPeak = BigDecimal.ZERO;

}
