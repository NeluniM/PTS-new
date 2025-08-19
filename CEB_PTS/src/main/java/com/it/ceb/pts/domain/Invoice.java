package com.it.ceb.pts.domain;

import jakarta.persistence.Column;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Date;

@Getter
@Setter
@Entity
@Table(name = "INVOICE")
public class Invoice {
    @EmbeddedId
    private InvoiceId id;

    @Column(name = "DAY_ENERGY")
    private BigDecimal dayEnergy = BigDecimal.ZERO;

    @Column(name = "PEAK_ENERGY")
    private BigDecimal peakEnergy = BigDecimal.ZERO;

    @Column(name = "OFF_PEAK_ENERGY")
    private BigDecimal offPeakEnergy = BigDecimal.ZERO;

    @Column(name = "COINCIDENT_PEAK", precision = 22, scale = 3)
    private BigDecimal coincidentPeak;

    @Column(name = "TOTAL_ENERGY", precision = 22, scale = 3)
    private BigDecimal totalEnergy;

    @Column(name = "DAY_ENERGY_CHARGE")
    private BigDecimal dayEnergyCharge;

    @Column(name = "PEAK_ENERGY_CHARGE")
    private BigDecimal peakEnergyCharge;

    @Column(name = "OFF_PEAK_ENERGY_CHARGE")
    private BigDecimal offPeakEnergyCharge;

    @Column(name = "CAPACITY_CHARGE")
    private BigDecimal capacityCharge;

    @Column(name = "TOTAL_ENERGY_CHARGE")
    private BigDecimal totalEnergyCharge;

    @Column(name = "DAY_TARIFF")
    private BigDecimal dayTariff;

    @Column(name = "PEAK_TARIFF")
    private BigDecimal peakTariff;

    @Column(name = "OFF_PEAK_TARIFF")
    private BigDecimal offPeakTariff;

    @Column(name = "CAPACITY_TARIFF")
    private BigDecimal capacityTariff;

    @Column(name = "INVOICE_CREATED_DATE")
    private Date invoiceCreatedDate;

    @Size(max = 20)
    @Column(name = "INVOICE_CREATED_BY", length = 20)
    private String invoiceCreatedBy;

    @Column(name = "MONTHLY_TOTAL_CHARGE")
    private BigDecimal monthlyTotalCharge;

    @Column(name = "TOTAL_INVOICE_CHARGE")
    private BigDecimal totalInvoiceCharge;

    @Column(name = "IS_CALC_CLOSED")
    private Long isCalcClosed;
}