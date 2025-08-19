package com.it.ceb.pts.model;

import com.fasterxml.jackson.annotation.JsonProperty;

public class AmountDetails {
    @JsonProperty("previousDueAmt")
    private double previousDueAmt;

    @JsonProperty("payments")
    private double payments;

    @JsonProperty("debitAmount")
    private double debitAmount;

    @JsonProperty("creditAmount")
    private double creditAmount;

    @JsonProperty("currentMonthBill")
    private double currentMonthBill;

    @JsonProperty("totalDueAmount")
    private double totalDueAmount;

    @JsonProperty("fixedChg")
    private double fixedCharge;

    @JsonProperty("chargesConsumed")
    private double chargesConsumed;

    @JsonProperty("sscLevy")
    private double sscLevy;

    @JsonProperty("chargesMonth")
    private double chargesMonth;

	public double getPreviousDueAmt() {
		return previousDueAmt;
	}

	public void setPreviousDueAmt(double previousDueAmt) {
		this.previousDueAmt = previousDueAmt;
	}

	public double getPayments() {
		return payments;
	}

	public void setPayments(double payments) {
		this.payments = payments;
	}

	public double getDebitAmount() {
		return debitAmount;
	}

	public void setDebitAmount(double debitAmount) {
		this.debitAmount = debitAmount;
	}

	public double getCreditAmount() {
		return creditAmount;
	}

	public void setCreditAmount(double creditAmount) {
		this.creditAmount = creditAmount;
	}

	public double getCurrentMonthBill() {
		return currentMonthBill;
	}

	public void setCurrentMonthBill(double currentMonthBill) {
		this.currentMonthBill = currentMonthBill;
	}

	public double getTotalDueAmount() {
		return totalDueAmount;
	}

	public void setTotalDueAmount(double totalDueAmount) {
		this.totalDueAmount = totalDueAmount;
	}

	public double getFixedCharge() {
		return fixedCharge;
	}

	public void setFixedCharge(double fixedCharge) {
		this.fixedCharge = fixedCharge;
	}

	public double getChargesConsumed() {
		return chargesConsumed;
	}

	public void setChargesConsumed(double chargesConsumed) {
		this.chargesConsumed = chargesConsumed;
	}

	public double getSscLevy() {
		return sscLevy;
	}

	public void setSscLevy(double sscLevy) {
		this.sscLevy = sscLevy;
	}

	public double getChargesMonth() {
		return chargesMonth;
	}

	public void setChargesMonth(double chargesMonth) {
		this.chargesMonth = chargesMonth;
	}
    
    

    // Getters and setters
}
