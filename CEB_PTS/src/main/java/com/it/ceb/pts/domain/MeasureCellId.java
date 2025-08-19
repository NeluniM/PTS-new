package com.it.ceb.pts.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.Hibernate;

import java.io.Serializable;
import java.util.Objects;

@Getter
@Setter
@Embeddable
public class MeasureCellId implements Serializable {
    private static final long serialVersionUID = -5668644795886231608L;
    @NotNull
    @Column(name = "MODEL_ID", nullable = false)
    private Long modelId;

    @NotNull
    @Column(name = "MEASURE_ID", nullable = false)
    private Long measureId;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        MeasureCellId entity = (MeasureCellId) o;
        return Objects.equals(this.measureId, entity.measureId) &&
                Objects.equals(this.modelId, entity.modelId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(measureId, modelId);
    }

}