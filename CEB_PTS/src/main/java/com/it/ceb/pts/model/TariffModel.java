package com.it.ceb.pts.model;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;

@Getter
@Setter
public class TariffModel {
    private Long tariffId;
    private String tariffCategoryCode;
    private BigDecimal rate;
    private LocalDate validFrom;
    private LocalDate validTill;
    private Long isCurrent;
    private String updatedUser;
    private LocalDate updatedTime;
    private String tariffName;
    private String tarrifType;
    private BigDecimal groupKey;


}