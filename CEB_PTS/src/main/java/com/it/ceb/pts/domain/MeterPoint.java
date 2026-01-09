package com.it.ceb.pts.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "METER_POINT")
public class MeterPoint {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "METER_POINT_SEQ_GEN")
    @SequenceGenerator(
            name = "METER_POINT_SEQ_GEN",
            sequenceName = "METER_POINT_SEQ",
            allocationSize = 1
    )
    @Column(name = "POINT_ID")
    private Long pointId;

    @Column(name = "SERIAL_NO", nullable = false)
    private String serialNo;

    @Column(name = "METER_POINT_NAME", nullable = false)
    private String meterPointName;

    @Column(name = "METER_POINT_CODE")
    private String meterPointCode;

    @Column(name = "DESCRIPTION")
    private String description;

    @Column(name = "LICENSE_CODE", nullable = false)
    private String licenseCode;

    @Column(name = "STATUS", nullable = false)
    private BigDecimal status;

    @Column(name = "CREATED_BY", nullable = false)
    private String createdBy;

    @Temporal(TemporalType.DATE)
    @Column(name = "CREATED_DATE", nullable = false)
    private Date createdDate;

    @Column(name = "UPDATED_BY")
    private String updatedBy;

    @Temporal(TemporalType.DATE)
    @Column(name = "UPDATED_DATE")
    private Date updatedDate;

    @Column(name = "LATITUDE")
    private BigDecimal latitude;

    @Column(name = "LONGITUDE")
    private BigDecimal longitude;

    @Column(name = "NOMINAL_VOLTAGE")
    private BigDecimal nominalVoltage;

    @Column(name = "RATED_VOLTAGE")
    private BigDecimal ratedVoltage;

    @Column(name = "RATED_FREQUENCY")
    private BigDecimal ratedFrequency;

    @Column(name = "PEAK_DEMAND_COLUMN")
    private String peakDemandColumn;

    // ---------- RELATIONSHIPS ----------

    @ManyToOne
    @JoinColumn(name = "AREA_CODE")
    private Area area;

    @ManyToOne
    @JoinColumn(name = "GSS_ID")
    private GridSubstation gridSubstation;

    @ManyToOne
    @JoinColumn(name = "CEB_SERIAL_NO", nullable = false)
    private Meter meter;

    @ManyToOne
    @JoinColumn(name = "POINT_TYPE_ID", nullable = false)
    private MeterPointType meterPointType;

    @ManyToOne
    @JoinColumn(name = "PSS_ID")
    private PrimarySubstation primarySubstation;

    @ManyToOne
    @JoinColumn(name = "CEB_PROVINCE_CODE", nullable = false)
    private Province cebProvince;

    @ManyToOne
    @JoinColumn(name = "LECO_PROVINCE_CODE")
    private Province lecoProvince;

    @OneToMany(mappedBy = "point")
    private List<MeterReading> meterReadingList;


    // ================= BACKWARD COMPATIBILITY =================

    // Old CEB province naming
    public Province getProvince1() {
        return cebProvince;
    }

    public void setProvince1(Province province) {
        this.cebProvince = province;
    }

    // Old LECO province naming
    public Province getProvince2() {
        return lecoProvince;
    }

    public void setProvince2(Province province) {
        this.lecoProvince = province;
    }

}
