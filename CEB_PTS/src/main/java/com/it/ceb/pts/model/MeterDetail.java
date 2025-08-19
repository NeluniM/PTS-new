package com.it.ceb.pts.model;

import com.it.ceb.pts.model.MeterReading;

import java.util.List;

public class MeterDetail {
    public String mtrNumber;
    
    public double chargeforMeter; // Add this field

	public double getChargeforMeter() {
		return chargeforMeter;
	}
	public void setChargeforMeter(double chargeforMeter) {
		this.chargeforMeter = chargeforMeter;
	}

    public List<MeterReading> mtrReadings;
	public String getMtrNumber() {
		return mtrNumber;
	}
	public void setMtrNumber(String mtrNumber) {
		this.mtrNumber = mtrNumber;
	}
	public List<MeterReading> getMtrReadings() {
		return mtrReadings;
	}
	public void setMtrReadings(List<MeterReading> mtrReadings) {
		this.mtrReadings = mtrReadings;
	}
    
    
	
}
