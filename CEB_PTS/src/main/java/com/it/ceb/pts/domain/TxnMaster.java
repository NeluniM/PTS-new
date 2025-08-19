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
@Table(name = "TXN_MASTER")
public class TxnMaster {
    @Id
    @Size(max = 20)
    @Column(name = "TXN_CODE", nullable = false, length = 20)
    private String txnCode;

    @Size(max = 200)
    @NotNull
    @Column(name = "TXN_NAME", nullable = false, length = 200)
    private String txnName;

}