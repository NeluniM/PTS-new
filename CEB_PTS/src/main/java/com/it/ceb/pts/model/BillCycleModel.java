package com.it.ceb.pts.model;

import lombok.Getter;
import lombok.Setter;
import java.math.BigDecimal;

@Getter
@Setter
public class BillCycleModel {
    private Long billCycleNo;
    private BigDecimal billYear;
    private BigDecimal billMonth;
    private String billMonthName;
    private String remarks;
    private Long isUploadLocked;
    private Long isCurrent;
    private Long isReadingLocked;
    private Long isPrccessLocked;
    private String coincidentPeakDate;
    private Long recordedPeakDemand;
    private BigDecimal untAdjustment;
    private BigDecimal tariffAdjustment;
}