package com.it.ceb.pts.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Getter
@Setter
@Entity
@Table(name = "MEASURE_CELL")
@IdClass(MeasureCellId.class)
public class MeasureCell {
    @Id
    @Column(name = "MODEL_ID", nullable = false)
    private Long modelId;

    @Id
    @Column(name = "MEASURE_ID", nullable = false)
    private Long measureId;

    @Size(max = 20)
    @Column(name = "CELL", length = 20)
    private String cell;

    @Size(max = 5)
    @Column(name = "FILE_TYPE", length = 5)
    private String fileType;

    @Size(max = 20)
    @Column(name = "VALUE_CALC", length = 20)
    private String valueCalc;

    @Size(max = 5)
    @Column(name = "REVERSED")
    private Long reversed;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @OnDelete(action = OnDeleteAction.RESTRICT)
    @JoinColumn(name = "MEASURE_ID", nullable = false, insertable = false, updatable = false)
    private Measure measure;

    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @OnDelete(action = OnDeleteAction.RESTRICT)
    @JoinColumn(name = "MODEL_ID", nullable = false, insertable = false, updatable = false)
    private MeterModel meterModel;

}