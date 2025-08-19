package com.it.ceb.pts.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "METER_MODEL")
public class MeterModel {
    @Id
    @Column(name = "MODEL_ID", nullable = false)
    private Long modelId;

    @Size(max = 50)
    @NotNull
    @Column(name = "MODEL_NAME", nullable = false, length = 50)
    private String modelName;

    @Size(max = 500)
    @Column(name = "REMARK", length = 500)
    private String remark;

    @NotNull
    @Column(name = "STATUS", nullable = false)
    private Long status;

    @Size(max = 15)
    @NotNull
    @Column(name = "CREATED_BY", nullable = false, length = 15)
    private String createdBy;

    @NotNull
    @Column(name = "CREATED_DATE", nullable = false)
    private Date createdDate;

    @Size(max = 15)
    @Column(name = "UPDATED_BY", length = 15)
    private String updatedBy;

    @Column(name = "UPDATED_DATE")
    private Date updatedDate;

    @Column(name = "ENERGY_FILE_PREFIX", length = 5)
    private String energyPrefix;

    @Column(name = "LOAD_FILE_PREFIX", length = 5)
    private String loadPrefix;

    @NotNull
    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @OnDelete(action = OnDeleteAction.RESTRICT)
    @JoinColumn(name = "MANUFACT_ID", nullable = false)
    private Manufacturer manufact;

    //bi-directional many-to-one association to MeasureCell
    @OneToMany(mappedBy="meterModel")
    private List<MeasureCell> measureCells;

    //bi-directional many-to-one association to MeterHeader
    @OneToMany(mappedBy="meterModel")
    private List<MeterHeader> meterHeaders;


}