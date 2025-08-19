package com.it.ceb.util.common;

import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;




//import org.json.simple.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.util.JSONPObject;


import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;


public class SendSMS {


	public boolean sendSMSWithDateAsString(List<SMSDataProjectCosting> smsList)
	{
		boolean isSuccess = false;
		System.out.println("sendSMSWithDateAsString start");
		try
		{
			String smsUrl="http://10.128.1.126/SMSServiceJobCosting/api/SaveSMSDetails/SaveSMSDetailsProjectCosting";

			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.APPLICATION_JSON);
			headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

			/*
			//Add the Jackson Message converter
	        MappingJackson2HttpMessageConverter jsonConverter = new MappingJackson2HttpMessageConverter();
	        // Note: here we are making this converter to process any kind of response,
	        // not only application/*json, which is the default behaviour
	        jsonConverter.setSupportedMediaTypes(Collections.singletonList(MediaType.APPLICATION_JSON));
	        List<HttpMessageConverter<?>> messageConverters = new ArrayList<HttpMessageConverter<?>>();
	        messageConverters.add(jsonConverter);
	        restTemplate.setMessageConverters(messageConverters);
	        */

			JSONPObject jsonObj = new JSONPObject("smsDetailsList",smsList);
			//jsonObj.put("smsDetailsList", smsList);

			HttpEntity requestEntity = new HttpEntity(jsonObj, headers);

			RestTemplate restTemplate = new RestTemplate();
			ResponseEntity<smsDetailsResponse> responseEntity = restTemplate.postForEntity(smsUrl, requestEntity, smsDetailsResponse.class);

			System.out.println("response sendSMSWithDateAsString ex "+responseEntity.getBody().getEx());
			System.out.println("response sendSMSWithDateAsString status "+responseEntity.getBody().isSuccess());
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		System.out.println("sendSMSWithDateAsString end");

		return isSuccess;
	}

	/*public boolean sendSMS(List<SMSData> smsList)
	{
		boolean isSuccess = false;

		try
		{
			String smsUrl="http://10.128.1.126/SMSAPI/api/SaveSMSDetails/SaveSMSDetails";

			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.APPLICATION_JSON);
			headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));


			//Add the Jackson Message converter
	        MappingJackson2HttpMessageConverter jsonConverter = new MappingJackson2HttpMessageConverter();
	        // Note: here we are making this converter to process any kind of response,
	        // not only application/*json, which is the default behaviour
	        jsonConverter.setSupportedMediaTypes(Collections.singletonList(MediaType.APPLICATION_JSON));
	        List<HttpMessageConverter<?>> messageConverters = new ArrayList<HttpMessageConverter<?>>();
	        messageConverters.add(jsonConverter);
	        restTemplate.setMessageConverters(messageConverters);


			JSONPObject jsonObj = new JSONPObject("smsDetailsList",smsList);
		  	 //  jsonObj.put("smsDetailsList", smsList);

	  	     HttpEntity requestEntity = new HttpEntity(jsonObj, headers);

	  	     RestTemplate restTemplate = new RestTemplate();
	  	     ResponseEntity<smsDetailsResponse> responseEntity = restTemplate.postForEntity(smsUrl, requestEntity, smsDetailsResponse.class);

	  	     System.out.println("response ex 3 "+responseEntity.getBody().getEx());
	  	     System.out.println("response status 3 "+responseEntity.getBody().isSuccess());
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		System.out.println("calling sms end method 2");

		return isSuccess;
	}*/


	public String sendPostRequest(String url, String requestBody) throws Exception {
		// Create a URL object with the target URL
		url="http://10.128.1.126/SMSServiceJobCosting/api/SaveSMSDetails/SaveSMSDetailsProjectCosting";
		URL obj = new URL(url);

		// Open a connection to the URL
		HttpURLConnection connection = (HttpURLConnection) obj.openConnection();

		// Set the HTTP request method to POST
		connection.setRequestMethod("POST");

		// Set additional HTTP headers if needed
		connection.setRequestProperty("Content-Type", "application/json"); // Example header

		// Enable input and output streams
		connection.setDoOutput(true);

		// Write the request body data to the output stream
		try (DataOutputStream wr = new DataOutputStream(connection.getOutputStream())) {
			wr.writeBytes(requestBody);
			wr.flush();
		}

		// Get the HTTP response code
		int responseCode = connection.getResponseCode();

		// Read the response from the server
		StringBuilder response = new StringBuilder();
		try (BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()))) {
			String inputLine;
			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
		}

		// Close the connection
		connection.disconnect();

		// Return the response as a string
		return response.toString();
	}

	public String sendPostRequestMMS(String url, String requestBody) throws Exception {
		// Create a URL object with the target URL
		url=url;
		URL obj = new URL(url);

		// Open a connection to the URL
		HttpURLConnection connection = (HttpURLConnection) obj.openConnection();

		// Set the HTTP request method to POST
		connection.setRequestMethod("POST");

		// Set additional HTTP headers if needed
		connection.setRequestProperty("Content-Type", "application/json"); // Example header

		// Enable input and output streams
		connection.setDoOutput(true);

		// Write the request body data to the output stream
		try (DataOutputStream wr = new DataOutputStream(connection.getOutputStream())) {
			wr.writeBytes(requestBody);
			wr.flush();
		}

		// Get the HTTP response code
		int responseCode = connection.getResponseCode();

		// Read the response from the server
		StringBuilder response = new StringBuilder();
		try (BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()))) {
			String inputLine;
			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
		}

		// Close the connection
		connection.disconnect();

		// Return the response as a string
		return response.toString();
	}




}