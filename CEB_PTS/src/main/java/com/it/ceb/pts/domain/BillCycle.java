package com.it.ceb.pts.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "BILL_CYCLE")
public class BillCycle {
    @Id
    @Column(name = "BILL_CYCLE_NO", nullable = false)
    private Long billCycleNo;

    @Column(name = "BILL_YEAR")
    private BigDecimal billYear;

    @Column(name = "BILL_MONTH")
    private BigDecimal billMonth;

    @Size(max = 20)
    @Column(name = "REMARKS", length = 20)
    private String remarks;

    @Size(max = 15)
    @Column(name = "CREATED_BY", length = 15)
    private String createdBy;

    @Column(name = "CREATED_DATE")
    private LocalDate createdDate;

    @Column(name = "UPDATED_BY")
    private LocalDate updatedBy;

    @Size(max = 20)
    @Column(name = "UPDATED_DATE", length = 20)
    private String updatedDate;

    @Column(name = "IS_CURRENT")
    private Long isCurrent;

    @Column(name = "COINCIDENT_PEAK_DATE")
    private Date coincidentPeakDate;

    @Column(name = "RECORDED_PEAK_DEMAND", precision = 22, scale = 3)
    private Long recordedPeakDemand;

    @Column(name = "IS_CLOSED")
    private Long isClosed;

    @Column(name = "CLOSED_DATE")
    private Date closedDate;

    @Size(max = 20)
    @Column(name = "CLOSED_BY", length = 20)
    private String closedBy;


    @OneToMany(mappedBy = "billCycleNo")
    private Set<ProvinceConfig> provinceConfigs = new LinkedHashSet<>();

    @OneToMany(mappedBy = "billCycle")
    private List<MeterReading> meterReadings;

    @OneToMany(mappedBy = "billCycle")
    private List<MeterReadingLog> meterReadingLogs;
}