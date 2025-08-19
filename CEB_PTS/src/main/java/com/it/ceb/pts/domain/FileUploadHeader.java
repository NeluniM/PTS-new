package com.it.ceb.pts.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
@Entity
@Table(name = "FILE_UPLOAD_HEADER")
public class FileUploadHeader {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "FileUploadSeqGen")
    @SequenceGenerator(name = "FileUploadSeqGen", sequenceName = "FILE_UPLOAD_HEADER_SEQ", allocationSize = 1)
    @Column(name = "UPLOAD_ID", nullable = false)
    private Long uploadId;

    @Size(max = 200)
    @Column(name = "FILE_NAME", length = 200)
    private String fileName;

    @Column(name = "IS_UPLOADED")
    private Long isUploaded;

    @Size(max = 15)
    @Column(name = "UPLOADED_BY", length = 15)
    private String uploadedBy;

    @Column(name = "UPLOADED_DATE")
    private LocalDateTime uploadedDate;

    @Column(name = "BILL_CYCLE_NO", nullable = false)
    private Long billCycleNo;

    @Size(max = 100)
    @Column(name = "LICENSE_CODE", nullable = false, length = 100)
    private String licenseCode;

    @Size(max = 50)
    @Column(name = "PROVINCE_CODE", nullable = false, length = 50)
    private String provinceCode;

    public void setIsUploadLocked(Long isUploadLocked) {
    }
}
