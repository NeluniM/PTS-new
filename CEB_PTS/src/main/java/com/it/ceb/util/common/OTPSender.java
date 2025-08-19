package com.it.ceb.util.common;

public class OTPSender {
	
	private static String generateOTP() {
        // Generate a random 6-digit OTP
        int otp = (int) (Math.random() * 900000) + 100000;
        return String.valueOf(otp);
    }

    

}
