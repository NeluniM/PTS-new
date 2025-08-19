package com.it.ceb.pts.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.util.Date;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "METER_READING_LOG")
public class MeterReadingLog {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SeqGenMRLog")
	@SequenceGenerator(name = "SeqGenMRLog", sequenceName = "METER_READING_LOG_SEQ", allocationSize = 1)
	@Column(name = "LOG_ID", nullable = false)
    private Long readingLogId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "BILL_CYCLE_NO")
    private BillCycle billCycle;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "LICENSE_CODE")
    private DistributionLicense license;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "PROVINCE_CODE")
    private Province province;

    @Size(max = 15)
    @Column(name = "PROCESSED_BY", length = 15)
    private String processedBy;

    @Column(name = "PROCESSED_DATE")
    private Date processedDate;

    @Size(max = 5)
    @Column(name = "STATUS", length = 5)
    private String status;

    @Column(name = "FILES")
    private Long files;

    @Column(name = "FILES_READ")
    private Long filesRead;

    @OneToMany(mappedBy = "meterReadingLog")
    private List<MeterReadingErrLog> meterReadingErrLogList;

//    @OneToMany(mappedBy = "meterReadingLog")
//    private List<MeterReading> meterReadingList;

}