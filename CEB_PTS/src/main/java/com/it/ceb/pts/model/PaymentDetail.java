package com.it.ceb.pts.model;

public class PaymentDetail {
    private String crdtDate;
    private String description;
    private double debitAmt;
    private double creditAmt;
    private double balance;
    private String drcr; // "Dr" or "Cr"

    public String getCrdtDate() {
        return crdtDate;
    }

    public void setCrdtDate(String crdtDate) {
        this.crdtDate = crdtDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getDebitAmt() {
        return debitAmt;
    }

    public void setDebitAmt(double debitAmt) {
        this.debitAmt = debitAmt;
    }

    public double getCreditAmt() {
        return creditAmt;
    }

    public void setCreditAmt(double creditAmt) {
        this.creditAmt = creditAmt;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public String getDrcr() {
        return drcr;
    }

    public void setDrcr(String drcr) {
        this.drcr = drcr;
    }
}
