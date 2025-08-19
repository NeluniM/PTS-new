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
@Table(name = "TARIFF")
public class Tariff {
    @Id
//    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "TariffSeqGen")
//    @SequenceGenerator(name = "TariffSeqGen", sequenceName = "TARIFF_SEQ", allocationSize = 1)
    @Column(name = "TARIFF_ID", nullable = false)
    private Long tariffId;

    @NotNull
    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @OnDelete(action = OnDeleteAction.RESTRICT)
    @JoinColumn(name = "TARIFF_CATEGORY_CODE", nullable = false)
    private TariffCategory tariffCategoryCode;

    @NotNull
    @Column(name = "RATE", nullable = false, precision = 20, scale = 2)
    private BigDecimal rate;

    @NotNull
    @Column(name = "VALID_FROM", nullable = false)
    private LocalDate validFrom;

    @NotNull
    @Column(name = "VALID_TILL", nullable = false)
    private LocalDate validTill;

    @NotNull
    @Column(name = "IS_CURRENT", nullable = false)
    private Long isCurrent;


    @Size(max = 20)
    @Column(name = "UPDATED_USER", length = 20)
    private String updatedUser;

    @Column(name = "UPDATED_TIME")
    private LocalDate updatedTime;

    @ManyToOne(fetch = FetchType.EAGER)
    @OnDelete(action = OnDeleteAction.RESTRICT)
    @JoinColumn(name = "LICENSE_CODE")
    private DistributionLicense licenseCode;

}