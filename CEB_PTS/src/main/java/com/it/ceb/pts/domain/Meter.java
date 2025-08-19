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
@Table(name = "METER")
public class Meter {
    @Id
    @Size(max = 20)
    @Column(name = "CEB_SERIAL_NO", nullable = false, length = 20)
    private String cebSerialNo;

    @Column(name = "CURRENT_RATING", precision = 19, scale = 2)
    private BigDecimal currentRating;

    @Column(name = "MODIFIED_DATE")
    private LocalDate modifiedDate;

    @Size(max = 255)
    @Column(name = "REMARK")
    private String remark;

    @Size(max = 5)
    @Column(name = "STATUS", length = 5)
    private String status;

    @Size(max = 15)
    @Column(name = "UPDATED_BY", length = 15)
    private String updatedBy;

    @Size(max = 20)
    @Column(name = "SERIAL_NO", length = 20)
    private String serialNo;

    @Column(name = "UPDATED_DATE")
    private Date updatedDate;

    @Size(max = 15)
    @Column(name = "CREATED_BY", length = 15)
    private String createdBy;

    @Column(name = "CREATED_DATE")
    private LocalDate createdDate;

    @ManyToOne(fetch = FetchType.EAGER)
    @OnDelete(action = OnDeleteAction.RESTRICT)
    @JoinColumn(name = "BATCH_ID")
    private MeterHeader meterHeader;

    @OneToMany(mappedBy="meter")
    private List<MeterReading> meterReadings;

    @OneToMany(mappedBy="meter")
    private List<MeterPoint> meterPoints;


}