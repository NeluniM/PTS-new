package com.it.ceb.util.common;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

//import estimate.web.MsgLineRecord;

public class Format {
	
	public static String formatDecimal(double number) {
		  float epsilon = 0.004f; // 4 tenths of a cent
		  if (Math.abs(Math.round(number) - number) < epsilon) {
		     return String.format("%10.0f", number); // sdb
		  } else {
		     return String.format("%10.2f", number); // dj_segfault
		  }
		}
	
	public String formatDate2(Date dt){
		if(dt==null){
			return null;
		}else{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy MM dd");
			return sdf.format(dt);
		}
	}
	
	
	public static double round(double value, int places) {
	    if (places < 0) throw new IllegalArgumentException();

	    BigDecimal bd = new BigDecimal(value);
	    bd = bd.setScale(places, RoundingMode.HALF_UP);
	    return bd.doubleValue();
	}
	
	/**public static double round(double value, int places) {
	    if (places < 0) throw new IllegalArgumentException();

	    long factor = (long) Math.pow(10, places);
	    value = value * factor;
	    long tmp = Math.round(value);
	    return (double) tmp / factor;
	}*/
	public String FormatDate() {
		String DATE_FORMAT = "yyyy-MM-dd";
		SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
		Calendar calendar = Calendar.getInstance(); // today
		// System.out.println("Today is " + sdf.format(calendar.getTime()));
		return sdf.format(calendar.getTime());

	}
	
	
	
	public String FormatStringDate(Date dt) {
		String DATE_FORMAT = "dd/MM/yyyy";
		SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
		
		
		return sdf.format(dt);

	}
	
	public static Date StrToDate(String str_date) {
		try{
			
		
			//String str_date="11-June-07";
	        DateFormat formatter ; 
	        Date date ; 
	        formatter = new SimpleDateFormat("yyyy-MM-dd");
	        date = (Date)formatter.parse(str_date);    
	        return date;
		 } catch (ParseException e) {
			 System.out.println("Exception :"+e);
			 return null;
		}    
		     
	   }	
	
	public Date StringToDate(String str_date) {
		try{
			
				
	        DateFormat formatter ; 
	        Date date ; 
	        formatter = new SimpleDateFormat("dd/MM/yyyy");
	        date = (Date)formatter.parse(str_date);    
	        return date;
		 } catch (ParseException e) {
			 System.out.println("Exception :"+e);
			 return null;
		}    
		     
	   }
	
	public Date StringToDateSlash(String str_date) {
		try{
			
				
	        DateFormat formatter ; 
	        Date date ; 
	        formatter = new SimpleDateFormat("MM/dd/yyyy");
	        date = (Date)formatter.parse(str_date);    
	        return date;
		 } catch (ParseException e) {
			 System.out.println("Exception :"+e);
			 return null;
		}    
		     
	   }
	
	public String formatDate(Date dt)
	{
		if (dt == null)
			return null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy MMM dd");
	    return sdf.format(dt);
	}
	

	public String FormatDate(String DATE_FORMAT) {
		SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
		Calendar calendar = Calendar.getInstance(); // today
		// System.out.println("Today is " + sdf.format(calendar.getTime()));
		return sdf.format(calendar.getTime());

	}

	public String FormatTime() {
		String TIME_FORMAT = "hh:mm:ss a";
		SimpleDateFormat sdf = new SimpleDateFormat(TIME_FORMAT);
		Calendar calendar = Calendar.getInstance(); // today
		// System.out.println("Today is " + sdf.format(calendar.getTime()));
		return sdf.format(calendar.getTime());

	}

	public String FormatTime(String TIME_FORMAT) {
		SimpleDateFormat sdf = new SimpleDateFormat(TIME_FORMAT);
		Calendar calendar = Calendar.getInstance(); // today
		// System.out.println("Today is " + sdf.format(calendar.getTime()));
		return sdf.format(calendar.getTime());

	}
	public Date getDefaultDate()
    {
          Calendar cal = Calendar.getInstance();
          cal.set(1900,0,1);
          return cal.getTime();
    }

	
	public String getYear() {
		String DATE_FORMAT = "yy";
		SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
		Calendar calendar = Calendar.getInstance(); // today
		//calendar.getTime().
		return sdf.format(calendar.getTime());

	}
	
	/**public List<MsgLineRecord> setMsgLineList(String msgLine){
		List<MsgLineRecord> list=new ArrayList<MsgLineRecord>();
		String[] x=msgLine.split("#");
		for (int i=0; i<=x.length-1;i++ ){
			MsgLineRecord lineRecord=new MsgLineRecord();
			String[] y=x[i].split(",");
			lineRecord.setCode(y[0]);
			lineRecord.setQuntity(y[1]);
			lineRecord.setCost(y[2]);
			list.add(lineRecord);
			lineRecord=null;

		}
		return list;
		
	}*/
	
	public String fromatCurrency(BigDecimal value)
	{
		if (value == null)
			return null;
		NumberFormat nf = NumberFormat.getInstance();
		 nf.setMaximumFractionDigits(2);
		    nf.setMinimumFractionDigits(2);
	   return  nf.format(value);
	}
	
	public Date StrToDateMenu(String str_date) {
		try{
			
		
			//String str_date="11-June-07";
	        DateFormat formatter ; 
	        Date date ; 
	        formatter = new SimpleDateFormat("yyyy MMM dd");
	        date = (Date)formatter.parse(str_date);    
	        return date;
		 } catch (ParseException e) {
			 System.out.println("Exception :"+e);
			 return null;
		}    
		     
	   }	
	
	public static void main(String[] args){
		Format format=new Format();
		//format.setMsgLineList("");
		//System.out.print(format.getYear());
		System.out.print(format.StrToDateMenu("2010 Dec 30"));
	}

}
