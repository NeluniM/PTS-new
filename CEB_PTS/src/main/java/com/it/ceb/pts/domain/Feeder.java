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
@Table(name = "FEEDER")
public class Feeder {
    @Id
    @Column(name = "FEEDER_ID", nullable = false)
    private Long id;

    @NotNull
    @Column(name = "SUBSTATION_ID", nullable = false)
    private Long substationId;

    @Size(max = 75)
    @NotNull
    @Column(name = "SERIAL_NO", nullable = false, length = 75)
    private String serialNo;

    @Size(max = 100)
    @NotNull
    @Column(name = "FEEDER_NAME", nullable = false, length = 100)
    private String feederName;

    @Size(max = 50)
    @NotNull
    @Column(name = "FEEDER_CODE", nullable = false, length = 50)
    private String feederCode;

    @Size(max = 250)
    @NotNull
    @Column(name = "DESCRIPTION", nullable = false, length = 250)
    private String description;

    @NotNull
    @Column(name = "NOMINAL_VOLTAGE", nullable = false)
    private Long nominalVoltage;

    @Column(name = "RATED_VOLTAGE")
    private Long ratedVoltage;

    @Column(name = "RATED_FREQUENCY")
    private Long ratedFrequency;

    @Size(max = 50)
    @NotNull
    @Column(name = "LOCATION_ID", nullable = false, length = 50)
    private String locationId;

    @Size(max = 100)
    @NotNull
    @Column(name = "LOCATION_NAME", nullable = false, length = 100)
    private String locationName;

    @Column(name = "LATITUDE", precision = 12, scale = 9)
    private BigDecimal latitude;

    @Column(name = "LONGITUDE", precision = 12, scale = 9)
    private BigDecimal longitude;

    @NotNull
    @Column(name = "IS_BILLED", nullable = false)
    private Long isBilled;

    @NotNull
    @Column(name = "IS_ACTIVE", nullable = false)
    private Long isActive;

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