package com.it.ceb.pts.model;

import java.util.List;

public class BillDetails {
	
	public String billMonth;
	public double totAmtPayable;
	public String toDate;
	public String getToDate() {
		return toDate;
	}

	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
	public String fromDate;
	
public String getFromDate() {
		return fromDate;
	}

	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}

public double getTotAmtPayable() {
		return totAmtPayable;
	}

	public void setTotAmtPayable(double totAmtPayable) {
		this.totAmtPayable = totAmtPayable;
	}
		public MasterDetail masterDetail;
	    public List<MeterDetail> meterDetails;
	    public AmountDetails amountDetails;
	    

	    private List<PaymentDetail> pmtDetails;

		public List<PaymentDetail> getPmtDetails() {
			return pmtDetails;
		}
		public void setPmtDetails(List<PaymentDetail> pmtDetails) {
			this.pmtDetails = pmtDetails;
		}
		public String getBillMonth() {
			return billMonth;
		}
		public void setBillMonth(String billMonth) {
			this.billMonth = billMonth;
		}
		public MasterDetail getMasterDetail() {
			return masterDetail;
		}
		public void setMasterDetail(MasterDetail masterDetail) {
			this.masterDetail = masterDetail;
		}
		public List<MeterDetail> getMeterDetails() {
			return meterDetails;
		}
		public void setMeterDetails(List<MeterDetail> meterDetails) {
			this.meterDetails = meterDetails;
		}
		public AmountDetails getAmountDetails() {
			return amountDetails;
		}
		public void setAmountDetails(AmountDetails amountDetails) {
			this.amountDetails = amountDetails;
		}
	    
	    

}
