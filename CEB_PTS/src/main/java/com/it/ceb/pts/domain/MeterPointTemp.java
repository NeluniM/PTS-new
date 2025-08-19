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
@Table(name = "METER_POINT_TEMP")
public class MeterPointTemp {
    @Id
    @Size(max = 20)
    @Column(name = "SERIAL_NO", nullable = false, length = 20)
    private String serialNo;

    @Size(max = 20)
    @Column(name = "METER_POINT_TYPE", length = 20)
    private String meterPointType;

    @Size(max = 30)
    @Column(name = "METER_POINT_NAME", length = 30)
    private String meterPointName;

    @Size(max = 20)
    @Column(name = "NOMINAL_VOLTAGE", length = 20)
    private String nominalVoltage;

    @Size(max = 20)
    @Column(name = "LICENSE", length = 20)
    private String license;

    @Size(max = 25)
    @Column(name = "PSS", length = 25)
    private String pss;

    @Size(max = 20)
    @Column(name = "METER_MODEL", length = 20)
    private String meterModel;

}