package com.it.ceb.pts.domain;

import java.io.Serializable;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Getter
@Setter
@Entity
@NamedQuery(name="Province.findAll", query="SELECT p FROM Province p")
public class Province implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="PROVINCE_CODE")
	private String provinceCode;

	@Column(name="CREATED_BY")
	private String createdBy;

	@Temporal(TemporalType.DATE)
	@Column(name="CREATED_DATE")
	private Date createdDate;

	private String description;

	@Column(name="LICENSE_CODE")
	private String licenseCode;

	@Column(name="PROVINCE_NAME")
	private String provinceName;

	private BigDecimal status;

	@Column(name="UPDATED_BY")
	private String updatedBy;

	@Temporal(TemporalType.DATE)
	@Column(name="UPDATED_DATE")
	private Date updatedDate;

	@OneToMany(mappedBy = "province")
	private List<MeterReadingLog> meterReadingLogs;

}