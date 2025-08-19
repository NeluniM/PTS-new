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
public class ProvinceConfigId implements Serializable {
    private static final long serialVersionUID = 1723615790077126293L;
    @NotNull
    @Column(name = "BILL_CYCLE_NO", nullable = false)
    private Long billCycleNo;

    @Size(max = 10)
    @NotNull
    @Column(name = "PROVINCE_CODE", nullable = false, length = 10)
    private String provinceCode;

    @Size(max = 4)
    @NotNull
    @Column(name = "LICENSE_CODE", nullable = false, length = 4)
    private String licenseCode;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        ProvinceConfigId entity = (ProvinceConfigId) o;
        return Objects.equals(this.provinceCode, entity.provinceCode) &&
                Objects.equals(this.billCycleNo, entity.billCycleNo) &&
                Objects.equals(this.licenseCode, entity.licenseCode);
    }

    @Override
    public int hashCode() {
        return Objects.hash(provinceCode, billCycleNo, licenseCode);
    }

}