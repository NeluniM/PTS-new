package com.it.ceb.admin.domain;

import java.io.Serializable;
import jakarta.persistence.*;

/**
 * The primary key class for the SAUSRDPM database table.
 * 
 */
@Embeddable
public class SausrdpmPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="USER_ID", unique=true, nullable=false, length=12)
	private String userId;

	@Column(name="DEPT_ID", unique=true, nullable=false, length=6)
	private String deptId;

	public SausrdpmPK() {
	}
	public String getUserId() {
		return this.userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getDeptId() {
		return this.deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof SausrdpmPK)) {
			return false;
		}
		SausrdpmPK castOther = (SausrdpmPK)other;
		return 
			this.userId.equals(castOther.userId)
			&& this.deptId.equals(castOther.deptId);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.userId.hashCode();
		hash = hash * prime + this.deptId.hashCode();
		
		return hash;
	}
}