package com.it.ceb.pts.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "ENERGY_SUMMERY", schema = "PTDBA")
public class EnergySummery {
    @Id
    @Column(name = "ID", nullable = false)
    private Long id;

    @Column(name = "TOTAL_ENERGY")
    private Long totalEnergy;

    @Column(name = "DAY_OFF_PEAK")
    private Boolean dayOffPeak;

    @Column(name = "BILL_CYCLE_NO")
    private Long billCycleNo;

    @Size(max = 10)
    @Column(name = "PROVINCE_CODE", length = 10)
    private String provinceCode;

    @Size(max = 20)
    @Column(name = "LICENSE_CODE", length = 20)
    private String licenseCode;

}