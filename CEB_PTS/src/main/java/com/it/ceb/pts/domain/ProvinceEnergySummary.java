package com.it.ceb.pts.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.math.BigDecimal;

@Getter
@Setter
@Entity
@Table(name = "PROVINCE_ENERGY_SUMMARY")
public class ProvinceEnergySummary {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SeqGenProvinceEnergySummary")
    @SequenceGenerator(name = "SeqGenProvinceEnergySummary", sequenceName = "PROV_ENERGY_SUMMARY_SEQ", allocationSize = 1)
    @Column(name = "SUMMARY_ID", nullable = false)
    private Long summaryId;

    @Column(name = "BILL_CYCLE_NO")
    private Long billCycleNo;

    @Column(name = "LICENSE_CODE")
    private String licenseCode;

    @Column(name = "PROVINCE_CODE")
    private String provinceCode;

    @Column(name = "DAY_ENERGY")
    private BigDecimal dayEnergy;

    @Column(name = "PEAK_ENERGY")
    private BigDecimal peakEnergy;

    @Column(name = "OFF_PEAK_ENERGY")
    private BigDecimal offPeakEnergy;

    @Column(name = "COINCIDENT_PEAK", precision = 22, scale = 3)
    private BigDecimal coincidentPeak;

    @Column(name = "DAY_ENERGY_ADJ")
    private BigDecimal dayEnergyAdj;

    @Column(name = "PEAK_ENERGY_ADJ")
    private BigDecimal peakEnergyAdj;

    @Column(name = "OFF_PEAK_ENERGY_ADJ")
    private BigDecimal offPeakEnergyAdj;

    @Column(name = "COINCIDENT_PEAK_ADJ", precision = 22, scale = 3)
    private BigDecimal coincidentPeakAdj;

}