package com.it.ceb.pts.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@Entity
@Table(name = "AREA")
public class Area {
    @Id
    @Size(max = 10)
    @Column(name = "AREA_CODE", nullable = false, length = 10)
    private String areaCode;

    @Size(max = 10)
    @NotNull
    @Column(name = "PROVINCE_CODE", nullable = false, length = 10)
    private String provinceCode;

    @Size(max = 100)
    @NotNull
    @Column(name = "AREA_NAME", nullable = false, length = 100)
    private String areaName;

    @Size(max = 250)
    @Column(name = "DESCRIPTION", length = 250)
    private String description;

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

    @Size(max = 4)
    @Column(name = "LICENSE_CODE", length = 4)
    private String licenseCode;

}