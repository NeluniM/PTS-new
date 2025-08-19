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
@Table(name = "MANUFACTURER")
public class Manufacturer {
    @Id
    @Column(name = "MANUFACT_ID", nullable = false)
    private Long id;

    @Size(max = 150)
    @Column(name = "MANUFACT_NAME", length = 150)
    private String manufactName;

    @Size(max = 500)
    @Column(name = "REMARK", length = 500)
    private String remark;

    @NotNull
    @Column(name = "STATUS", nullable = false)
    private Long status;

    @Size(max = 15)
    @Column(name = "CREATED_BY", length = 15)
    private String createdBy;

    @Column(name = "CREATED_DATE")
    private LocalDate createdDate;

    @Size(max = 15)
    @Column(name = "UPDATED_BY", length = 15)
    private String updatedBy;

    @Column(name = "UPDATED_DATE")
    private LocalDate updatedDate;

}