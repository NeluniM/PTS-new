package com.it.ceb.pts.model;

import com.fasterxml.jackson.annotation.JsonProperty;

public class MeterReading {
    public String crnt_date;
    public String prvDate;
    public String mtrType;
    public String crntReading;
    public String prvReading;
    public String units;
    public String mFactor;
    public double rate;
    public double amount;
    public String mtrSeq;
    public String getCrnt_date() {
        return crnt_date;
    }
    public void setCrnt_date(String crnt_date) {
        this.crnt_date = crnt_date;
    }
    public String getPrvDate() {
        return prvDate;
    }
    public void setPrvDate(String prvDate) {
        this.prvDate = prvDate;
    }
    public String getMtrType() {
        return mtrType;
    }
    public void setMtrType(String mtrType) {
        this.mtrType = mtrType;
    }
    public String getCrntReading() {
        return crntReading;
    }
    public void setCrntReading(String crntReading) {
        this.crntReading = crntReading;
    }
    public String getPrvReading() {
        return prvReading;
    }
    public void setPrvReading(String prvReading) {
        this.prvReading = prvReading;
    }
    public String getUnits() {
        return units;
    }
    public void setUnits(String units) {
        this.units = units;
    }
    public String getmFactor() {
        return mFactor;
    }
    public void setmFactor(String mFactor) {
        this.mFactor = mFactor;
    }
    public double getRate() {
        return rate;
    }
    public void setRate(double rate) {
        this.rate = rate;
    }
    public double getAmount() {
        return amount;
    }
    public void setAmount(double amount) {
        this.amount = amount;
    }
    public String getMtrSeq() {
        return mtrSeq;
    }
    public void setMtrSeq(String mtrSeq) {
        this.mtrSeq = mtrSeq;
    }



    // Getters and setters
    // (Generate these using your IDE for brevity)
}
