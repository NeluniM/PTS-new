package com.it.ceb.pts.domain;


import java.io.Serializable;
import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the FILE_UPLOAD database table.
 * 
 */
@Entity
@Table(name="FILE_UPLOAD" , schema = "PSTDB")
@NamedQuery(name="FileUpload.findAll", query="SELECT f FROM FileUpload f")
public class FileUpload implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private FileUploadPK id;

	@Column(name="FILE_NAME")
	private String fileName;

	@Column(name="FILE_TYPE")
	private String fileType;

	@Column(name="IS_UPLOADED")
	private BigDecimal isUploaded;

	@Column(name="SERIAL_NO")
	private String serialNo;

	@Column(name="UPLOADED_BY")
	private String uploadedBy;

	@Temporal(TemporalType.DATE)
	@Column(name="UPLOADED_DATE")
	private Date uploadedDate;

	public FileUpload() {
	}

	public FileUploadPK getId() {
		return this.id;
	}

	public void setId(FileUploadPK id) {
		this.id = id;
	}

	public String getFileName() {
		return this.fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileType() {
		return this.fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public BigDecimal getIsUploaded() {
		return this.isUploaded;
	}

	public void setIsUploaded(BigDecimal isUploaded) {
		this.isUploaded = isUploaded;
	}

	public String getSerialNo() {
		return this.serialNo;
	}

	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}

	public String getUploadedBy() {
		return this.uploadedBy;
	}

	public void setUploadedBy(String uploadedBy) {
		this.uploadedBy = uploadedBy;
	}

	public Date getUploadedDate() {
		return this.uploadedDate;
	}

	public void setUploadedDate(Date uploadedDate) {
		this.uploadedDate = uploadedDate;
	}

}