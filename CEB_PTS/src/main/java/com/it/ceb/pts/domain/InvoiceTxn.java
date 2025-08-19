package com.it.ceb.pts.domain;

import jakarta.persistence.*;
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
@Table(name = "INVOICE_TXN")
public class InvoiceTxn {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SeqGenInvoiceTxn")
    @SequenceGenerator(name = "SeqGenInvoiceTxn", sequenceName = "INVOICE_TXN_SEQ", allocationSize = 1)
    @Column(name = "TXN_ID", nullable = false, length = 22)
    private Long txnId;

    @Column(name = "BILL_CYCLE_NO")
    private Long billCycleNo;

    @Column(name = "LICENSE_CODE")
    private String licenseCode;

    @Column(name = "TXN_CODE")
    private String txnCode;

    @Size(max = 40)
    @Column(name = "DESCRIPTION", length = 20)
    private String description;

    @Column(name = "CHARGE", precision = 22, scale = 2)
    private BigDecimal charge;

    @Size(max = 20)
    @Column(name = "CREATED_BY", length = 20)
    private String createdBy;

    @Column(name = "CREATED_DATE")
    private LocalDate createdDate;

    @Size(max = 20)
    @Column(name = "UPDATED_BY", length = 20)
    private String updatedBy;

    @Column(name = "UPDATED_DATE")
    private LocalDate updatedDate;

}