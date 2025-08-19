package com.it.ceb.pts.domain;

import java.time.LocalDate;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;



public class FileUploadModel {

	private List<FileUpload> fileList;
	List<DistributionLicense> licenseList;
	List<Province> provinceList;

	List<FileUploadHeader>viewFileList;

	public List<FileUploadHeader> getViewFileList() {
		return viewFileList;
	}

	public void setViewFileList(List<FileUploadHeader> viewFileList) {
		this.viewFileList = viewFileList;
	}

	private List<MeterReading> meterReadingList;

	public List<MeterReading> getMeterReadingList() {
		return meterReadingList;
	}

	public void setMeterReadingList(List<MeterReading> meterReadingList) {
		this.meterReadingList = meterReadingList;
	}

	public List<FileUpload> getFileList() {
		return fileList;
	}

	public void setFileList(List<FileUpload> fileList) {
		this.fileList = fileList;
	}


	public List<DistributionLicense> getLicenseList() {
		return licenseList;
	}

	public void setLicenseList(List<DistributionLicense> licenseList) {
		this.licenseList = licenseList;
	}

	public List<Province> getProvinceList() {
		return provinceList;
	}

	public void setProvinceList(List<Province> provinceList) {
		this.provinceList = provinceList;
	}

//	                System.out.println("File Name: " + header.getFileName());
//                System.out.println("Uploaded By: " + header.getUploadedBy());
//                System.out.println("Uploaded Date: " + header.getUploadedDate());
//                System.out.println("Province Code: " + header.getProvinceCode());
//                System.out.println("File Type: " + header.getFileType());


	private String fileName;
	private String uploadedBy;
	private LocalDate uploadedDate;
	private String provinceCode;
	private String fileType;

	private Long isUploadLocked;

	public Long getIsUploadLocked() {
		return isUploadLocked;
	}

	public void setIsUploadLocked(Long isUploadLocked) {
		this.isUploadLocked = isUploadLocked;
	}

	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getUploadedBy() {
		return uploadedBy;
	}
	public void setUploadedBy(String uploadedBy) {
		this.uploadedBy = uploadedBy;
	}
	public LocalDate getUploadedDate() {
		return uploadedDate;
	}
	public void setUploadedDate(LocalDate uploadedDate) {
		this.uploadedDate = uploadedDate;
	}
	public String getProvinceCode() {
		return provinceCode;
	}
	public void setProvinceCode(String provinceCode) {
		this.provinceCode = provinceCode;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}





	private boolean fileNameConflict;
	private String originalFileName;

	public String successMessage;

	public String getSuccessMessage() {
		return successMessage;
	}
	public void setSuccessMessage(String successMessage) {
		this.successMessage = successMessage;
	}
	public String errorMessage;

	public String getErrorMessage() {
		return errorMessage;
	}
	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}

	public boolean isFileNameConflict() {
		return fileNameConflict;
	}

	public void setFileNameConflict(boolean fileNameConflict) {
		this.fileNameConflict = fileNameConflict;
	}

	public String getOriginalFileName() {
		return originalFileName;
	}

	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}


	public String filetype;


	public String getFiletype() {
		return filetype;
	}

	public void setFiletype(String filetype) {
		this.filetype = filetype;
	}

	public String division;

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String province;

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String area;


	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String grid;

	public String getGrid() {
		return grid;
	}

	public void setGrid(String grid) {
		this.grid = grid;
	}

	public String meterpoint;

	public String getMeterpoint() {
		return meterpoint;
	}

	public void setMeterpoint(String meterpoint) {
		this.meterpoint = meterpoint;
	}

	public String billCycle;

	public String getBillCycle() {
		return billCycle;
	}

	public void setBillCycle(String billCycle) {
		this.billCycle = billCycle;
	}


//	                System.out.println("File Name: " + header.getFileName());
//                System.out.println("Uploaded By: " + header.getUploadedBy());
//                System.out.println("Uploaded Date: " + header.getUploadedDate());
//                System.out.println("Province Code: " + header.getProvinceCode());
//                System.out.println("File Type: " + header.getFileType());




	private String formattedUploadedDate;

	public String getFormattedUploadedDate() {
		return formattedUploadedDate;
	}
	public void setFormattedUploadedDate(String formattedUploadedDate) {
		this.formattedUploadedDate = formattedUploadedDate;
	}

//	public String getFormattedUploadedDate() {
//		return uploadedDateFormatted;
//	}
//
//	public void setFormattedUploadedDate(String uploadedDateFormatted) {
//		this.uploadedDateFormatted = uploadedDateFormatted;
//	}












}
