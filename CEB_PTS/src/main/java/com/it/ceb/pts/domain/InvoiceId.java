package com.it.ceb.pts.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.Hibernate;

import java.io.Serializable;
import java.util.Objects;

@Getter
@Setter
@Embeddable
public class InvoiceId implements Serializable {
    private static final long serialVersionUID = -68655657443876586L;
    @NotNull
    @Column(name = "BILL_CYCLE_NO", nullable = false)
    private Long billCycleNo;

    @Size(max = 20)
    @NotNull
    @Column(name = "LICENSE_CODE", nullable = false, length = 20)
    private String licenseCode;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        InvoiceId entity = (InvoiceId) o;
        return Objects.equals(this.billCycleNo, entity.billCycleNo) &&
                Objects.equals(this.licenseCode, entity.licenseCode);
    }

    @Override
    public int hashCode() {
        return Objects.hash(billCycleNo, licenseCode);
    }

}