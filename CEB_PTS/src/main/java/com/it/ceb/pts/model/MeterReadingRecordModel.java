package com.it.ceb.pts.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class MeterReadingRecordModel {

    private Long readingId;

    private String measure;

    private BigDecimal currentReading = BigDecimal.ZERO;

    private BigDecimal previousReading = BigDecimal.ZERO;

    private BigDecimal energy = BigDecimal.ZERO;

    private String dpo;//day peak off-peak

    private String importExport;//export import

    private Long pointId=0L;

    public MeterReadingRecordModel(Long readingId,
                                   String measure,
                                   BigDecimal currentReading,
                                   BigDecimal previousReading,
                                   BigDecimal energy,
                                   Long pointId,
                                   String dpo,
                                   String importExport) {
        this.readingId = readingId;
        this.measure = measure;
        this.currentReading = currentReading;
        this.previousReading = previousReading;
        this.energy = energy;
        this.pointId = pointId;
        this.dpo = dpo;
        this.importExport = importExport;

    }
}

