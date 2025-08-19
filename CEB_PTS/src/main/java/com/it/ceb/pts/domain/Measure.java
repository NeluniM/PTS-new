package com.it.ceb.pts.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "MEASURE")
public class Measure {
    @Id
    @Column(name = "MEASURE_ID", nullable = false)
    private Long measureId;

    @Size(max = 50)
    @Column(name = "MEASURE_NAME", length = 50)
    private String measureName;

    @Column(name = "IS_ACTIVE")
    private BigDecimal isActive;

    @Column(name = "IMPORT_OR_EXPORT")
    private String importOrExport;

    @Column(name="DAY_PEAK_OFF")
    private String dayPeakOff;

    @Column(name = "ORDER_KEY")
    private BigDecimal orderKey;

    @OneToMany(mappedBy = "measure")
    private List<MeasureCell> measureCells;

    @OneToMany(mappedBy = "measure")
    private List<MeterReading> meterReadings;

}