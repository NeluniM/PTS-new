package com.it.ceb.util.common;

import java.util.Date;

public class SmsDetailsData {
	
	private int recno ;
	private String tele_no  ;
	private String acct_number  ;
	private String ref_id  ;
	private String Message  ;
	private String proc_date  ;
	private String shdl_date  ;
	private String expr_date  ;
	private String send_date  ;
	private String Appkey   ;
	private String app_ref_key   ;
	private String area_code   ;
	private String Province   ;
	private String Division   ;
	private String proc_flag   ;
	private int pr_key    ;
	private String cost_cnter    ;
	private int bill_cycle    ;
	private String Alias    ;
	public int getRecno() {
		return recno;
	}
	public void setRecno(int recno) {
		this.recno = recno;
	}
	public String getTele_no() {
		return tele_no;
	}
	public void setTele_no(String tele_no) {
		this.tele_no = tele_no;
	}
	public String getAcct_number() {
		return acct_number;
	}
	public void setAcct_number(String acct_number) {
		this.acct_number = acct_number;
	}
	public String getRef_id() {
		return ref_id;
	}
	public void setRef_id(String ref_id) {
		this.ref_id = ref_id;
	}
	public String getMessage() {
		return Message;
	}
	public void setMessage(String message) {
		Message = message;
	}
	public String getProc_date() {
		return proc_date;
	}
	public void setProc_date(String proc_date) {
		this.proc_date = proc_date;
	}
	public String getShdl_date() {
		return shdl_date;
	}
	public void setShdl_date(String shdl_date) {
		this.shdl_date = shdl_date;
	}
	public String getExpr_date() {
		return expr_date;
	}
	public void setExpr_date(String expr_date) {
		this.expr_date = expr_date;
	}
	public String getSend_date() {
		return send_date;
	}
	public void setSend_date(String send_date) {
		this.send_date = send_date;
	}
	public String getAppkey() {
		return Appkey;
	}
	public void setAppkey(String appkey) {
		Appkey = appkey;
	}
	public String getApp_ref_key() {
		return app_ref_key;
	}
	public void setApp_ref_key(String app_ref_key) {
		this.app_ref_key = app_ref_key;
	}
	public String getArea_code() {
		return area_code;
	}
	public void setArea_code(String area_code) {
		this.area_code = area_code;
	}
	public String getProvince() {
		return Province;
	}
	public void setProvince(String province) {
		Province = province;
	}
	public String getDivision() {
		return Division;
	}
	public void setDivision(String division) {
		Division = division;
	}
	public String getProc_flag() {
		return proc_flag;
	}
	public void setProc_flag(String proc_flag) {
		this.proc_flag = proc_flag;
	}
	public int getPr_key() {
		return pr_key;
	}
	public void setPr_key(int pr_key) {
		this.pr_key = pr_key;
	}
	public String getCost_cnter() {
		return cost_cnter;
	}
	public void setCost_cnter(String cost_cnter) {
		this.cost_cnter = cost_cnter;
	}
	public int getBill_cycle() {
		return bill_cycle;
	}
	public void setBill_cycle(int bill_cycle) {
		this.bill_cycle = bill_cycle;
	}
	public String getAlias() {
		return Alias;
	}
	public void setAlias(String alias) {
		Alias = alias;
	}
	@Override
	public String toString() {
		return "SmsDetailsData [recno=" + recno + ", tele_no=" + tele_no
				+ ", acct_number=" + acct_number + ", ref_id=" + ref_id
				+ ", Message=" + Message + ", proc_date=" + proc_date
				+ ", shdl_date=" + shdl_date + ", expr_date=" + expr_date
				+ ", send_date=" + send_date + ", Appkey=" + Appkey
				+ ", app_ref_key=" + app_ref_key + ", area_code=" + area_code
				+ ", Province=" + Province + ", Division=" + Division
				+ ", proc_flag=" + proc_flag + ", pr_key=" + pr_key
				+ ", cost_cnter=" + cost_cnter + ", bill_cycle=" + bill_cycle
				+ ", Alias=" + Alias + "]";
	}
	
	
	

}
