package com.it.ceb.util.common;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.Date;
import java.util.List;

public class SmsRequest {
    @JsonProperty("smsDetailsList")
    private List<SmsDetails> smsDetailsList;

    public List<SmsDetails> getSmsDetailsList() {
        return smsDetailsList;
    }

    public void setSmsDetailsList(List<SmsDetails> smsDetailsList) {
        this.smsDetailsList = smsDetailsList;
    }

    public static class SmsDetails {
        @JsonProperty("recno")
        private int recno;

        public int getRecno() {
			return recno;
		}

		public void setRecno(int recno) {
			this.recno = recno;
		}

		public String getTeleNo() {
			return teleNo;
		}

		public void setTeleNo(String teleNo) {
			this.teleNo = teleNo;
		}

		public String getAcctNumber() {
			return acctNumber;
		}

		public void setAcctNumber(String acctNumber) {
			this.acctNumber = acctNumber;
		}

		public String getRefId() {
			return refId;
		}

		public void setRefId(String refId) {
			this.refId = refId;
		}

		public String getMessage() {
			return message;
		}

		public void setMessage(String message) {
			this.message = message;
		}

		public String getProcDate() {
			return procDate;
		}

		public void setProcDate(String procDate) {
			this.procDate = procDate;
		}

		public String getShdlDate() {
			return shdlDate;
		}

		public void setShdlDate(String shdlDate) {
			this.shdlDate = shdlDate;
		}

		public String getExprDate() {
			return exprDate;
		}

		public void setExprDate(String exprDate) {
			this.exprDate = exprDate;
		}

		public String getSendDate() {
			return sendDate;
		}

		public void setSendDate(String sendDate) {
			this.sendDate = sendDate;
		}

		public String getAppkey() {
			return appkey;
		}

		public void setAppkey(String appkey) {
			this.appkey = appkey;
		}

		public String getAppRefKey() {
			return appRefKey;
		}

		public void setAppRefKey(String appRefKey) {
			this.appRefKey = appRefKey;
		}

		public String getAreaCode() {
			return areaCode;
		}

		public void setAreaCode(String areaCode) {
			this.areaCode = areaCode;
		}

		public String getProvince() {
			return province;
		}

		public void setProvince(String province) {
			this.province = province;
		}

		public String getDivision() {
			return division;
		}

		public void setDivision(String division) {
			this.division = division;
		}

		public String getProcFlag() {
			return procFlag;
		}

		public void setProcFlag(String procFlag) {
			this.procFlag = procFlag;
		}

		public String getErrorFlag() {
			return errorFlag;
		}

		public void setErrorFlag(String errorFlag) {
			this.errorFlag = errorFlag;
		}

		public int getSmsLen() {
			return smsLen;
		}

		public void setSmsLen(int smsLen) {
			this.smsLen = smsLen;
		}

		public int getNoSms() {
			return noSms;
		}

		public void setNoSms(int noSms) {
			this.noSms = noSms;
		}

		public String getGateId() {
			return gateId;
		}

		public void setGateId(String gateId) {
			this.gateId = gateId;
		}

		public String getPrKey() {
			return prKey;
		}

		public void setPrKey(String prKey) {
			this.prKey = prKey;
		}

		public String getCostCnter() {
			return costCnter;
		}

		public void setCostCnter(String costCnter) {
			this.costCnter = costCnter;
		}

		public String getBillCycle() {
			return billCycle;
		}

		public void setBillCycle(String billCycle) {
			this.billCycle = billCycle;
		}

		public String getAlias() {
			return alias;
		}

		public void setAlias(String alias) {
			this.alias = alias;
		}

		@JsonProperty("tele_no")
        private String teleNo;

        @JsonProperty("acct_number")
        private String acctNumber;

        @JsonProperty("ref_id")
        private String refId;

        @JsonProperty("message")
        private String message;

        @JsonProperty("proc_date")
        @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
        private String procDate;

        @JsonProperty("shdl_date")
        @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
        private String shdlDate;

        @JsonProperty("expr_date")
        @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
        private String exprDate;

        @JsonProperty("send_date")
        @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
        private String sendDate;

        @JsonProperty("appkey")
        private String appkey;

        @JsonProperty("app_ref_key")
        private String appRefKey;

        @JsonProperty("area_code")
        private String areaCode;

        @JsonProperty("province")
        private String province;

        @JsonProperty("division")
        private String division;

        @JsonProperty("proc_flag")
        private String procFlag;

        @JsonProperty("error_flag")
        private String errorFlag;

        @JsonProperty("sms_len")
        private int smsLen;

        @JsonProperty("no_sms")
        private int noSms;

        @JsonProperty("gate_id")
        private String gateId;

        @JsonProperty("pr_key")
        private String prKey;

        @JsonProperty("cost_cnter")
        private String costCnter;

        @JsonProperty("bill_cycle")
        private String billCycle;

        @JsonProperty("alias")
        private String alias;

        // Getters and setters for all fields

        // Constructors
        // ...
    }
}
