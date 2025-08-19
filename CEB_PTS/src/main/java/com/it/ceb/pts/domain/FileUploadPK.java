package com.it.ceb.pts.domain;


import java.io.Serializable;
import jakarta.persistence.*;

/**
 * The primary key class for the FILE_UPLOAD database table.
 * 
 */
@Embeddable
public class FileUploadPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="BILL_CYCLE_NO")
	private long billCycleNo;

	@Column(name="CEB_SERIAL_NO")
	private String cebSerialNo;

	public FileUploadPK() {
	}
	public long getBillCycleNo() {
		return this.billCycleNo;
	}
	public void setBillCycleNo(long billCycleNo) {
		this.billCycleNo = billCycleNo;
	}
	public String getCebSerialNo() {
		return this.cebSerialNo;
	}
	public void setCebSerialNo(String cebSerialNo) {
		this.cebSerialNo = cebSerialNo;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof FileUploadPK)) {
			return false;
		}
		FileUploadPK castOther = (FileUploadPK)other;
		return 
			(this.billCycleNo == castOther.billCycleNo)
			&& this.cebSerialNo.equals(castOther.cebSerialNo);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + ((int) (this.billCycleNo ^ (this.billCycleNo >>> 32)));
		hash = hash * prime + this.cebSerialNo.hashCode();
		
		return hash;
	}
}