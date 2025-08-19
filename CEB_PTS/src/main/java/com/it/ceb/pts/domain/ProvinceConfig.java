package com.it.ceb.pts.domain;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Getter
@Setter
@Entity
@Table(name = "PROVINCE_CONFIG")
public class ProvinceConfig {
    @EmbeddedId
    private ProvinceConfigId pConfigid;

    @MapsId("billCycleNo")
    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @OnDelete(action = OnDeleteAction.RESTRICT)
    @JoinColumn(name = "BILL_CYCLE_NO", nullable = false)
    private BillCycle billCycleNo;

    @MapsId("provinceCode")
    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @OnDelete(action = OnDeleteAction.RESTRICT)
    @JoinColumn(name = "PROVINCE_CODE", nullable = false)
    private Province provinceCode;

    @MapsId("licenseCode")
    @ManyToOne(fetch = FetchType.EAGER, optional = false)
    @OnDelete(action = OnDeleteAction.RESTRICT)
    @JoinColumn(name = "LICENSE_CODE", nullable = false)
    private DistributionLicense licenseCode;

    @Column(name = "IS_UPLOAD_LOCKED")
    private Long isUploadLocked;

    @Column(name = "IS_READING_PROCESS_LOCKED")
    private Long isReadingProcessLocked;

}