package com.it.ceb.pts.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "METER_POINT")
public class MeterPoint {

    @Id
    @Column(name="POINT_ID")
    private Long pointId;

    @Column(name="CREATED_BY")
    private String createdBy;

    @Temporal(TemporalType.DATE)
    @Column(name="CREATED_DATE")
    private Date createdDate;

    @Column(name="DESCRIPTION")
    private String description;

    @Column(name="LATITUDE")
    private BigDecimal latitude;

    @Column(name="LICENSE_CODE")
    private String licenseCode;

    @Column(name="LONGITUDE")
    private BigDecimal longitude;

    @Column(name="METER_POINT_CODE")
    private String meterPointCode;

    @Column(name="METER_POINT_NAME")
    private String meterPointName;

    @Column(name="NOMINAL_VOLTAGE")
    private BigDecimal nominalVoltage;

    @Column(name="RATED_FREQUENCY")
    private BigDecimal ratedFrequency;

    @Column(name="RATED_VOLTAGE")
    private BigDecimal ratedVoltage;

    @Column(name="SERIAL_NO")
    private String serialNo;

    @Column(name="STATUS")
    private BigDecimal status;

    @Column(name="UPDATED_BY")
    private String updatedBy;

    @Column(name = "PEAK_DEMAND_COLUMN", length = 20)
    private String peakDemandColumn;

    @Temporal(TemporalType.DATE)
    @Column(name="UPDATED_DATE")
    private Date updatedDate;

    //bi-directional many-to-one association to Area
    @ManyToOne
    @JoinColumn(name="AREA_CODE")
    private Area area;

    //bi-directional many-to-one association to GridSubstation
    @ManyToOne
    @JoinColumn(name="GSS_ID")
    private GridSubstation gridSubstation;

    //bi-directional many-to-one association to Meter
    @ManyToOne
    @JoinColumn(name="CEB_SERIAL_NO")
    private Meter meter;

    //bi-directional many-to-one association to MeterPointType
    @ManyToOne
    @JoinColumn(name="POINT_TYPE_ID")
    private MeterPointType meterPointType;

    //bi-directional many-to-one association to PrimarySubstation
    @ManyToOne
    @JoinColumn(name="PSS_ID")
    private PrimarySubstation primarySubstation;

    //bi-directional many-to-one association to Province
    @ManyToOne
    @JoinColumn(name="CEB_PROVINCE_CODE")
    private Province province1;

    //bi-directional many-to-one association to Province
    @ManyToOne
    @JoinColumn(name="LECO_PROVINCE_CODE")
    private Province province2;

    @OneToMany(mappedBy = "point")
    private List<MeterReading> meterReadingList;

}