package com.it.ceb.pts.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "METER_POINT_TYPE")
public class MeterPointType {
    @Id
    @Column(name = "POINT_TYPE_ID", nullable = false)
    private Long id;


    @Size(max = 100)
    @NotNull
    @Column(name = "POINT_NAME", nullable = false, length = 100)
    private String pointName;

}