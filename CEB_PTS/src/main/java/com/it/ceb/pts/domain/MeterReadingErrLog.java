package com.it.ceb.pts.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@Entity
@Table(name = "METER_READING_ERR_LOG")
public class MeterReadingErrLog {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SeqGenMRErrorLog")
	@SequenceGenerator(name = "SeqGenMRErrorLog", sequenceName = "METER_READING_ERR_LOG_SEQ", allocationSize = 1)
	@Column(name = "ERR_LOG_ID", nullable = false)
    private Long errorLogId;

    @Size(max = 20)
    @Column(name = "CEB_SERIAL_NO", length = 20)
    private String cebSerialNo;

    @Column(name = "UPDATED_DATE")
    private Date updatedDate;

    @Size(max = 40)
    @Column(name = "REASON", length = 40)
    private String reason;

    @Size(max = 20)
    @Column(name = "SERIAL_NO", length = 20)
    private String serialNo;

    @Size(max = 10)
    @Column(name = "STATUS", length = 10)
    private String status;

    @Column(name = "ATTEMPTS")
    private Long attempts;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "LOG_ID")
    private MeterReadingLog meterReadingLog;
}