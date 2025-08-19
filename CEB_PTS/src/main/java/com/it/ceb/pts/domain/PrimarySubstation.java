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

@Getter
@Setter
@Entity
@Table(name = "PRIMARY_SUBSTATION")
public class PrimarySubstation {
    @Id
    @Column(name = "PSS_ID", nullable = false)
    private Long id;

    @NotNull
    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @OnDelete(action = OnDeleteAction.RESTRICT)
    @JoinColumn(name = "LICENSE_CODE", nullable = false)
    private DistributionLicense licenseCode;

    @NotNull
    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @OnDelete(action = OnDeleteAction.RESTRICT)
    @JoinColumn(name = "PROVINCE_CODE", nullable = false)
    private Province provinceCode;

    @NotNull
    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @OnDelete(action = OnDeleteAction.RESTRICT)
    @JoinColumn(name = "AREA_CODE", nullable = false)
    private Area areaCode;

    @Size(max = 10)
    @Column(name = "PSS_CODE", length = 10)
    private String pssCode;

    @Size(max = 150)
    @NotNull
    @Column(name = "PSS_NAME", nullable = false, length = 150)
    private String pssName;

    @Column(name = "LATITUDE", precision = 12, scale = 9)
    private BigDecimal latitude;

    @Column(name = "LONGITUDE", precision = 12, scale = 9)
    private BigDecimal longitude;

    @NotNull
    @Column(name = "STATUS", nullable = false)
    private Long status;

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

    @Size(max = 20)
    @Column(name = "PSS_CODE_1", length = 20)
    private String pssCode1;

}