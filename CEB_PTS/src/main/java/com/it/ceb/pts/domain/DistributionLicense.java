package com.it.ceb.pts.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "DISTRIBUTION_LICENSE")
public class DistributionLicense {
    @Id
    @Size(max = 4)
    @Column(name = "LICENSE_CODE", nullable = false, length = 4)
    private String licenseCode;

    @Size(max = 100)
    @NotNull
    @Column(name = "LICENSE_NAME", nullable = false, length = 100)
    private String licenseName;

    @NotNull
    @Column(name = "STATUS", nullable = false)
    private Short status;

    @Size(max = 15)
    @NotNull
    @Column(name = "CREATED_BY", nullable = false, length = 15)
    private String createdBy;

    @NotNull
    @Column(name = "CREATED_DATE", nullable = false)
    private LocalDate createdDate;

    @Size(max = 15)
    @Column(name = "UPDATED_BY", length = 15)
    private String updatedBy;

    @Column(name = "UPDATED_DATE")
    private LocalDate updatedDate;

    @NotNull
    @Column(name = "TARIFF_CODE", nullable = false)
    private Short tariffCode;

    @Size(max = 20)
    @Column(name = "MITFIN_CODE", length = 20)
    private String mitfinCode;

    @OneToMany(mappedBy = "license")
    private List<MeterReadingLog> meterReadingLogs;
}