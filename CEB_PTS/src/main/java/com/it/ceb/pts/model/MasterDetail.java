package com.it.ceb.pts.model;

import com.fasterxml.jackson.annotation.JsonProperty;

public class MasterDetail {
    @JsonProperty("acctNumber")
    private String acctNumber;

    @JsonProperty("areaCode")
    private String areaCode;

    @JsonProperty("areaName")
    private String areaName;

    @JsonProperty("name")
    private String name;

    @JsonProperty("address_1")
    private String address1;

    @JsonProperty("address_2")
    private String address2;

    @JsonProperty("city")
    private String city;

    @JsonProperty("tariff")
    private String tariff;

    @JsonProperty("cntrDemand")
    private double cntrDemand;

    @JsonProperty("secDeposit")
    private double secDeposit;

    @JsonProperty("email")
    private String email;

    @JsonProperty("invoiceNum")
    private String invoiceNum;

    @JsonProperty("oldAccNumber")
    private String oldAccNumber;

    @JsonProperty("noOfmeterSets")
    private String noOfMeterSets;

	public String getAcctNumber() {
		return acctNumber;
	}

	public void setAcctNumber(String acctNumber) {
		this.acctNumber = acctNumber;
	}

	public String getAreaCode() {
		return areaCode;
	}

	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}

	public String getAreaName() {
		return areaName;
	}

	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getTariff() {
		return tariff;
	}

	public void setTariff(String tariff) {
		this.tariff = tariff;
	}

	public double getCntrDemand() {
		return cntrDemand;
	}

	public void setCntrDemand(double cntrDemand) {
		this.cntrDemand = cntrDemand;
	}

	public double getSecDeposit() {
		return secDeposit;
	}

	public void setSecDeposit(double secDeposit) {
		this.secDeposit = secDeposit;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getInvoiceNum() {
		return invoiceNum;
	}

	public void setInvoiceNum(String invoiceNum) {
		this.invoiceNum = invoiceNum;
	}

	public String getOldAccNumber() {
		return oldAccNumber;
	}

	public void setOldAccNumber(String oldAccNumber) {
		this.oldAccNumber = oldAccNumber;
	}

	public String getNoOfMeterSets() {
		return noOfMeterSets;
	}

	public void setNoOfMeterSets(String noOfMeterSets) {
		this.noOfMeterSets = noOfMeterSets;
	}
    
    

    // Getters and setters
}
