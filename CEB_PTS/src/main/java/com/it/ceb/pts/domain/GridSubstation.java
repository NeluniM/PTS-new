package com.it.ceb.pts.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;

@Getter
@Setter
@Entity
@Table(name = "GRID_SUBSTATION")
public class GridSubstation {
    @Id
    @Column(name = "GSS_ID", nullable = false)
    private Long id;

    @Size(max = 4)
    @NotNull
    @Column(name = "LICENSE_CODE", nullable = false, length = 4)
    private String licenseCode;

    @Size(max = 50)
    @NotNull
    @Column(name = "GSS_CODE", nullable = false, length = 50)
    private String gssCode;

    @Size(max = 150)
    @NotNull
    @Column(name = "GSS_NAME", nullable = false, length = 150)
    private String gssName;

    @Size(max = 10)
    @Column(name = "NOMINAL_VOLTAGE", length = 10)
    private String nominalVoltage;

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

}