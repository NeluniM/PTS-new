package com.it.ceb.pts.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@Entity
@Table(name = "ENERGY_SUMMARY")
public class EnergySummary {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SeqGenEnergySummary")
	@SequenceGenerator(name = "SeqGenEnergySummary", sequenceName = "ENERGY_SUMMARY_SEQ", allocationSize = 1)
	 @Column(name = "SUMMARY_ID", nullable = false)
    private Long summaryId;

    @Column(name = "BILL_CYCLE_NO")
    private Long billCycleNo;

    @Size(max = 20)
    @Column(name = "LICENSE_CODE", length = 20)
    private String licenseCode;

    @Column(name = "DAY_ENERGY")
    private BigDecimal dayEnergy = BigDecimal.ZERO;

    @Column(name = "PEAK_ENERGY")
    private BigDecimal peakEnergy = BigDecimal.ZERO;

    @Column(name = "OFF_PEAK_ENERGY")
    private BigDecimal offPeakEnergy = BigDecimal.ZERO;

    @Column(name = "COINCIDENT_PEAK", precision = 22, scale = 3)
    private BigDecimal coincidentPeak;

}