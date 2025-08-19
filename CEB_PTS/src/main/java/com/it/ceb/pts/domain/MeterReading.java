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

@Getter
@Setter
@Entity
@Table(name = "METER_READING")
public class MeterReading {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SeqGenMeterRead")
	@SequenceGenerator(name = "SeqGenMeterRead", sequenceName = "METER_READING_SEQ", allocationSize = 1)
	@Column(name = "READING_ID", nullable = false)
    private Long readingId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "BILL_CYCLE_NO")
    private BillCycle billCycle;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "CEB_SERIAL_NO")
    private Meter meter;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "MEASURE_ID")
    private Measure measure;

    @Column(name = "CURRENT_READING", precision = 12, scale = 2)
    private BigDecimal currentReading;

    @Size(max = 15)
    @Column(name = "CREATED_BY", length = 15)
    private String createdBy;

    @Column(name = "CREATED_DATE")
    private Date createdDate;

    @Size(max = 10)
    @Column(name = "UPDATED_BY", length = 10)
    private String updatedBy;

    @Column(name = "UPDATED_DATE")
    private Date updatedDate;

    @Size(max = 5)
    @Column(name = "READING_METHOD", length = 5)
    private String readingMethod;

    @Column(name = "PREVIOUS_READING", precision = 12, scale = 2)
    private BigDecimal previousReading;

    @Column(name = "ENERGY", precision = 12, scale = 2)
    private BigDecimal energy;

    @Size(max = 20)
    @Column(name = "SERIAL_NO", length = 20)
    private String serialNo;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "POINT_ID")
    private MeterPoint point;


//    @ManyToOne(fetch = FetchType.EAGER)
//    @JoinColumn(name = "LOG_ID")
//    private MeterReadingLog meterReadingLog;

}