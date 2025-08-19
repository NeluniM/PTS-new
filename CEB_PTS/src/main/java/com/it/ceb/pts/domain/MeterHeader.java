package com.it.ceb.pts.domain;

import jakarta.persistence.*;
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
@Table(name = "METER_HEADER")
public class MeterHeader {
    @Id
    @Column(name="BATCH_ID")
    private String batchId;

    @Column(name="ACCURACY_CLASS")
    private String accuracyClass;

    @Column(name="BATCH_NO")
    private String batchNo;

    @Column(name="CREATED_BY")
    private String createdBy;

    @Temporal(TemporalType.DATE)
    @Column(name="CREATED_DATE")
    private Date createdDate;

    @Column(name="CURRENT_RATING")
    private String currentRating;

    @Column(name="CURRENT_RATING3")
    private BigDecimal currentRating3;

    @Column(name="INITIATED_BY")
    private String initiatedBy;

    @Column(name="MANUFACT_ID")
    private BigDecimal manufactId;

    @Column(name="MANUFACTURED_YEAR")
    private String manufacturedYear;

    @Temporal(TemporalType.DATE)
    @Column(name="PROCURED_DATE")
    private Date procuredDate;

    @Column(name="QUANTITY")
    private BigDecimal quantity;

    @Column(name="REMARK")
    private String remark;

    @Column(name="STATUS")
    private String status;

    @Column(name="UPDATED_BY")
    private String updatedBy;

    @Temporal(TemporalType.DATE)
    @Column(name="UPDATED_DATE")
    private Date updatedDate;

    //bi-directional many-to-one association to Meter
    @OneToMany(mappedBy="meterHeader")
    private List<Meter> meters;

    //bi-directional many-to-one association to MeterModel
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="MODEL_ID")
    private MeterModel meterModel;

}