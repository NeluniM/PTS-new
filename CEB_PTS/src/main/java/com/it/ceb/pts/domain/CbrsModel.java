package com.it.ceb.pts.domain;

import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;



public class CbrsModel {
	
	private List<FileUpload> fileList;
	
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

	Map<String, String> provinceList = new LinkedHashMap<String,String>();

	public Map<String, String> getProvinceList() {
		return provinceList;
	}

	public void setProvinceList(Map<String, String> provinceList) {
		this.provinceList = provinceList;
	}

	public String metercycle;
	
	public String getMetercycle() {
		return metercycle;
	}

	public void setMetercycle(String metercycle) {
		this.metercycle = metercycle;
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

	public static long vipPrice = 1000;
	public static long nonVipPrice = 700;
	public static long nonVipPriceForMaskeliyaHB = 1000;
	
	public static long durtPrice = 500;
	
	private List<Date> checkedInNew;             
    private List<Date> checkedOutNew;
    
    public List<Date> getCheckedInNew() {
		return this.checkedInNew;
	}

	public void setCheckedInNew(List<Date> checkedIn) {
		this.checkedInNew = checkedInNew;
	}

	public List<Date> getCheckedOutNew() {
		return this.checkedOutNew;
	}

	public void setCheckedOutNew(List<Date> checkedOut) {
		this.checkedOutNew = checkedOutNew;
	}
  

    
	
	
	Map<String, String> circuitClosingList = new LinkedHashMap<String,String>();


	public Map<String, String> getcircuitClosingList() {
		return circuitClosingList;
	}

	public void setcircuitClosingList(Map<String, String> circuitClosingList) {
		this.circuitClosingList = circuitClosingList;
	}
	
	private String username;
	
	private String pensionNo;
	
	
	
	public String getPensionNo() {
		return pensionNo;
	}

	public void setPensionNo(String pensionNo) {
		this.pensionNo = pensionNo;
	}

	private String cancel;
	
	private String rejectReason;
	public String getRejectReason() {
		return rejectReason;
	}

	public void setRejectReason(String rejectReason) {
		this.rejectReason = rejectReason;
	}

	public String getCancel() {
		return cancel;
	}
	
	//private String mode;

	public void setCancel(String cancel) {
		this.cancel = cancel;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	private String password;
	

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	private String bookingDate;
	public String getBookingDate() {
		return bookingDate;
	}

	public void setBookingDate(String bookingDate) {
		this.bookingDate = bookingDate;
	}

	private String bookingTime;

	
	public String getBookingTime() {
		return bookingTime;
	}

	public void setBookingTime(String bookingTime) {
		this.bookingTime = bookingTime;
	}

	
	private String bookingid;
	public String getBookingid() {
		return bookingid;
	}

	public void setBookingid(String bookingid) {
		this.bookingid = bookingid;
	}

	private String empName;
	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	//Charitha
	private String NoOfRooms;
	public String getNoOfPeople() {
		return NoOfPeople;
	}

	public void setNoOfPeople(String noOfPeople) {
		NoOfPeople = noOfPeople;
	}

	public String getTotalPrice() {
		return TotalPrice;
	}

	public void setTotalPrice(String totalPrice) {
		TotalPrice = totalPrice;
	}

	

	

	private String NoOfPeople;
	private String TotalPrice;
	
	private String totalCharge;
	private boolean isSuccess;
	private String errorMsg;
	
	private String empEmail;
	
	private String emailEmp;
	
    
    //Charitha


	
	
	public String getEmailEmp() {
		return emailEmp;
	}

	public void setEmailEmp(String emailEmp) {
		this.emailEmp = emailEmp;
	}

	public String getEmpEmail() {
		return empEmail;
	}

	public void setEmpEmail(String empEmail) {
		this.empEmail = empEmail;
	}

	public String getErrorMsg() {
		return errorMsg;
	}

	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}

	public boolean isSuccess() {
		return isSuccess;
	}

	public void setSuccess(boolean isSuccess) {
		this.isSuccess = isSuccess;
	}

	public String getTotalCharge() {
		return totalCharge;
	}

	public void setTotalCharge(String totalCharge) {
		this.totalCharge = totalCharge;
	}

	//Arunodya
	private String bookingId;
    private String checkedIn;
    private String checkedOut;
    private String noOfRooms;
    private String status;
    
    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public String getCheckedIn() {
        return checkedIn;
    }

    public void setCheckedIn(String checkedIn) {
        this.checkedIn = checkedIn;
    }

    public String getCheckedOut() {
        return checkedOut;
    }

    public void setCheckedOut(String checkedOut) {
        this.checkedOut = checkedOut;
    }

    public String getNoOfRooms() {
        return noOfRooms;
    }

    public void setNoOfRooms(String noOfRooms) {
        this.noOfRooms = noOfRooms;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
	
	
	//Arunodya
	
	
	




private String result;
private String circuitId;
private String circuitKeeper;
private String circuitKeeperMobileNo;
private String epf;
private String vip;
private String circuitcode;
private String proceed;
private String circuitName;
private String telephoneNumber;
private String otp;
private String adults;
private String children;
private String dutyRooms;
private String nonVipRooms;
private String payingUnit;
private String vipRooms;
private String message;
private String name;
private String email;

private String subject;
public String getSubject() {
	return subject;
}

public void setSubject(String subject) {
	this.subject = subject;
}

public String getEmail() {
	return email;
}

public void setEmail(String email) {
	this.email = email;
}

public String getName() {
	return name;
}

public void setName(String name) {
	this.name = name;
}

public String getMessage() {
	return message;
}

public void setMessage(String message) {
	this.message = message;
}

public String getVipRooms() {
	return vipRooms;
}

public void setVipRooms(String vipRooms) {
	this.vipRooms = vipRooms;
}

public String getPayingUnit() {
	return payingUnit;
}

public void setPayingUnit(String payingUnit) {
	this.payingUnit = payingUnit;
}

public String getNonVipRooms() {
	return nonVipRooms;
}

public void setNonVipRooms(String nonVipRooms) {
	this.nonVipRooms = nonVipRooms;
}

public String supervisorEpf;

public String getSupervisorEpf() {
	return supervisorEpf;
}

public void setSupervisorEpf(String supervisorEpf) {
	this.supervisorEpf = supervisorEpf;
}

public String supervisorTelephoneNo;


public String getSupervisorTelephoneNo() {
	return supervisorTelephoneNo;
}

public void setSupervisorTelephoneNo(String supervisorTelephoneNo) {
	this.supervisorTelephoneNo = supervisorTelephoneNo;
}

public String getDutyRooms() {
	return dutyRooms;
}

public void setDutyRooms(String dutyRooms) {
	this.dutyRooms = dutyRooms;
}

public String getChildren() {
	return children;
}

public void setChildren(String children) {
	this.children = children;
}

public String getAdults() {
	return adults;
}

public void setAdults(String adults) {
	this.adults = adults;
}

public String getOtp() {
	return otp;
}

public void setOtp(String otp) {
	this.otp = otp;
}

public String getTelephoneNumber() {
	return telephoneNumber;
}

public void setTelephoneNumber(String telephoneNumber) {
	this.telephoneNumber = telephoneNumber;
}







LinkedHashMap<String, String> payingList = new LinkedHashMap<String,String>();


	public LinkedHashMap<String, String> getPayingList() {
	return payingList;
}

public void setPayingList(LinkedHashMap<String, String> payingList) {
	this.payingList = payingList;
}

	public String getCircuitName() {
	return circuitName;
}

public void setCircuitName(String circuitName) {
	this.circuitName = circuitName;
}

	public String getProceed() {
	return proceed;
}

public void setProceed(String proceed) {
	this.proceed = proceed;
}

	public String getCircuitcode() {
	return circuitcode;
}

public void setCircuitcode(String circuitcode) {
	this.circuitcode = circuitcode;
}

	public String getVip() {
	return vip;
}

public void setVip(String vip) {
	this.vip = vip;
}

	public String getEpf() {
	return epf;
}

public void setEpf(String epf) {
	this.epf = epf;
}

	

	public String getCircuitKeeperMobileNo() {
		return circuitKeeperMobileNo;
	}

	public void setCircuitKeeperMobileNo(String circuitKeeperMobileNo) {
		this.circuitKeeperMobileNo = circuitKeeperMobileNo;
	}

	public String getCircuitKeeper() {
		return circuitKeeper;
	}

	public void setCircuitKeeper(String circuitKeeper) {
		this.circuitKeeper = circuitKeeper;
	}

	public String getCircuitId() {
		return circuitId;
	}

	public void setCircuitId(String circuitId) {
		this.circuitId = circuitId;
	}

	List<Object[]> circuitList;
	
	

	public List<Object[]> getCircuitList() {
		return circuitList;
	}

	public void setCircuitList(List<Object[]> circuitList) {
		this.circuitList = circuitList;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	


	private String closingCircuitId;
	
	public String getclosingCircuitId() {
        return closingCircuitId;
    }

    public void setclosingCircuitId(String closingCircuitId) {
        this.closingCircuitId = closingCircuitId;
    }

}
