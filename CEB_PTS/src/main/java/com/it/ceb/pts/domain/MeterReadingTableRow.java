package com.it.ceb.pts.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MeterReadingTableRow {
    private String importOrExport;
    private String dayPeakOff;
    private String measureName;
    private String previousReading;
    private String currentReading;
    private String energy;
    private String readingMethod;
    private boolean editable;
}