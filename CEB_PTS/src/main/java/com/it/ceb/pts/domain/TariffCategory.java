package com.it.ceb.pts.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.LinkedHashSet;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "TARIFF_CATEGORY")
public class TariffCategory {
    @Id
    @Size(max = 10)
    @Column(name = "TARIFF_CATEGORY_CODE", nullable = false, length = 10)
    private String tariffCategoryCode;

    @Size(max = 50)
    @NotNull
    @Column(name = "TARIFF_NAME", nullable = false, length = 50)
    private String tariffName;

    @OneToMany(mappedBy = "tariffCategoryCode")
    private Set<Tariff> tariffs = new LinkedHashSet<>();

    @Column(name = "GROUP_KEY")
    private BigDecimal groupKey;

    @Size(max = 20)
    @Column(name = "TARRIF_TYPE", length = 20)
    private String tarrifType;

}