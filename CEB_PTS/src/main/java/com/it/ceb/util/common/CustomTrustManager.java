package com.it.ceb.util.common;

import java.security.SecureRandom;
import java.security.cert.X509Certificate;
import javax.net.ssl.*;

public class CustomTrustManager implements X509TrustManager {
    
    @Override
    public void checkClientTrusted(X509Certificate[] chain, String authType) {
        // Do nothing, just accept any client certificates
    }

    @Override
    public void checkServerTrusted(X509Certificate[] chain, String authType) {
        // Do nothing, just accept any server certificates
    }

    @Override
    public X509Certificate[] getAcceptedIssuers() {
        return new X509Certificate[0];
    }
}
