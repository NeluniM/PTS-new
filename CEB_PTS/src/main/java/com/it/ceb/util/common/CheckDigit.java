package com.it.ceb.util.common;

import java.util.Calendar;
import java.util.StringTokenizer;

public class CheckDigit
{
	public CheckDigit()
	{
		System.out.println("testing");
	}
	
	/*private int checkdigit(String idWithoutCheckdigit) {
		
		int c= -1;
		int len = idWithoutCheckdigit.length();
		int k = 2;
		int sum = 0;
		for (int i = len-1;i>=0;i--)
		{
			String s = idWithoutCheckdigit.substring(i,i+1);
			int j = Integer.parseInt(s);
			int result = j*k;
			System.out.println(s+" * "+k+" = "+result);
			sum = sum +result;
			k++;
		}
		int dividedInt = len + 2;
		int rem = sum%dividedInt;
		System.out.println("sum is "+sum);
		System.out.println("devided by "+dividedInt);
		System.out.println("remain is "+rem);
		c = dividedInt - rem;
		if(c==15)
			c = 0;
		System.out.println("check digit is is "+c);
		return c;
			
		
	}*/
	
	private int checkdigit(String idWithoutCheckdigit)
	{
		//System.out.println(idWithoutCheckdigit);
		int c= -1;
		int len = idWithoutCheckdigit.length();
		int k = 2;
		int sum = 0;
		int oddSum = 0;
		int evenSum = 0;
		for (int i = 1;i<=len;i++)
		{
			
			String s = idWithoutCheckdigit.substring(i-1,i);
			int j = Integer.parseInt(s);
			if(i%2==0)
			{
				evenSum = evenSum+j;
			}
			else
			{
				oddSum = oddSum+j;
				}
		}
		//System.out.println("odd sum is "+oddSum);
		//System.out.println("even sum is "+evenSum);
		oddSum = oddSum*3;
		sum = oddSum + evenSum;
		int dividedInt = 10;
		int rem = sum%dividedInt;
		//System.out.println("sum is "+sum);
		c = dividedInt - rem;
		if(c==10)
			c = 0;
		//System.out.println("check digit is is "+c);
		return c;
			
		
	}
	
	public String getBankCheckNo(String dpetId,String pivTypeDigit, String serialNo)
	{
		String pivNo = null;
		StringTokenizer st = new StringTokenizer(dpetId,".");
		Calendar cal = Calendar.getInstance();
		String year = String.valueOf(cal.get(Calendar.YEAR)).substring(2, 4);
		//String pivTypeDigit = PivType.getPIVTypeInDigit(appType, pivType);
		String pivWithoutCheckdigit = st.nextToken()+st.nextToken()+pivTypeDigit+year+serialNo;
		//System.out.println("pivWithoutCheckdigit"+pivWithoutCheckdigit);
		int checkDigit = checkdigit(pivWithoutCheckdigit);
		pivNo = pivWithoutCheckdigit+Integer.toString(checkDigit);
		return pivNo;
		
	}
	
	public static void main(String[] args) {
		CheckDigit cd = new CheckDigit();
		//cd.checkdigit1("5142001130853");
		cd.getBankCheckNo("514.20","EST","1334");
	}
}