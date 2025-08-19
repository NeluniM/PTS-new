package com.it.ceb.pts.model;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class InvoiceTXNmodel {

    private String billCycleNo;

    private String licenseCode;

    private String txnCode;

    private String description;

    private BigDecimal charge;
}
