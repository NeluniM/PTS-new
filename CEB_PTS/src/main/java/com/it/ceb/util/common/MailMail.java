package com.it.ceb.util.common;


import java.io.File;
import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.MailParseException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

public class MailMail
{
	
	
	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	private SimpleMailMessage simpleMailMessage;
	
	
	
	public void setSimpleMailMessage(SimpleMailMessage simpleMailMessage) {
		this.simpleMailMessage = simpleMailMessage;
	}

	public void setMailSender(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}
	
	public void sendMail(String dear, String content) {
	
	   MimeMessage message = mailSender.createMimeMessage();
		
	   try{
		MimeMessageHelper helper = new MimeMessageHelper(message, true);
			
		helper.setFrom(simpleMailMessage.getFrom());
		helper.setTo(simpleMailMessage.getTo());
		helper.setSubject(simpleMailMessage.getSubject());
		helper.setText(String.format(simpleMailMessage.getText(), dear, content));
			
		//FileSystemResource file = new FileSystemResource("C:\\log.txt");
		//helper.addAttachment(file.getFilename(), file);

	     }catch (MessagingException e) {
		          System.out.print("error : " + e.getMessage());  
	    	 throw new MailParseException(e);
	     }
	     mailSender.send(message);
         }
	
	public void sendMailTo(String dear, String content,String to,String subject) {
		
		   MimeMessage message = mailSender.createMimeMessage();
			
		   try{
			MimeMessageHelper helper = new MimeMessageHelper(message, true);
				
			helper.setFrom(simpleMailMessage.getFrom());
			helper.setTo(to);
			//helper.setCc(cc);
			helper.setSubject(subject);
			helper.setText(String.format(simpleMailMessage.getText(), dear, content));
				
			//FileSystemResource file = new FileSystemResource("C:\\log.txt");
			//helper.addAttachment(file.getName(), file);
			//helper.addAttachment("doc", new ByteArrayResource(bytes));
		     }catch (MessagingException e) {
			          System.out.print("error : " + e.getMessage());  
		    	 throw new MailParseException(e);
		     }
		     mailSender.send(message);
	         }
	
	public void sendMailTo(String dear, String content,String to,String[] cc,String subject) {
		
		   MimeMessage message = mailSender.createMimeMessage();
			
		   try{
			MimeMessageHelper helper = new MimeMessageHelper(message, true);
				
			helper.setFrom(simpleMailMessage.getFrom());
			helper.setTo(to);
			helper.setCc(cc);
			helper.setSubject(subject);
			helper.setText(String.format(simpleMailMessage.getText(), dear, content));
				
			//FileSystemResource file = new FileSystemResource("C:\\log.txt");
			//helper.addAttachment(file.getName(), file);
			//helper.addAttachment("doc", new ByteArrayResource(bytes));
		     }catch (MessagingException e) {
			          System.out.print("error : " + e.getMessage());  
		    	 throw new MailParseException(e);
		     }
		     mailSender.send(message);
	         }


	
	public void sendMailTo(String dear, String content,String to,String cc,String subject,File file,File file1,File file2,File file3,File file4,File pdfFile) {
		System.out.println("finish 1 11" + mailSender );
		
		   MimeMessage message = mailSender.createMimeMessage();
			
		   try{
			MimeMessageHelper helper = new MimeMessageHelper(message, true);
			System.out.println("finish 1 12" );
			
			helper.setFrom(simpleMailMessage.getFrom());
			helper.setTo(to);
			helper.setCc(cc);
			helper.setSubject(subject);
			helper.setText(String.format(simpleMailMessage.getText(), dear, content));
			System.out.println("finish 1 13" );
			
			//FileSystemResource file = new FileSystemResource("C:\\log.txt");
			//FileSystemResource filegayani = new FileSystemResource(new File(file.getAbsolutePath()));
			if(file != null){
				//System.out.println("finish 1 14" + file.getAbsolutePath());
				//FileSystemResource filegayani = new FileSystemResource(new File(file.getAbsolutePath()));
				
				helper.addAttachment(file.getName(), file);
				System.out.println("finish 1 144" );
				
				
			}
			if(file1 != null){
				System.out.println("finish 1 15" );
				
				helper.addAttachment(file1.getName(), file1);
				
			}
			if(file2 != null){
				System.out.println("finish 1 16" );
				
				helper.addAttachment(file2.getName(), file2);
				
			}
			if(file3 != null){
				System.out.println("finish 1 16" );
				
				helper.addAttachment(file3.getName(), file3);
				
			}
			if(file4 != null){
				System.out.println("finish 1 17" );
				
				
			helper.addAttachment(file4.getName(), file4);
			}
			
			if(pdfFile != null){
				System.out.println("finish 1 17" );
				
				
			helper.addAttachment(pdfFile.getName(), pdfFile);
			}
			
			//helper.addAttachment("doc", new ByteArrayResource(bytes));
		      mailSender.send(message);
		      System.out.println("finish 1 18" );
				
	         }catch (Exception e) {
		          System.out.print("error : " + e.getMessage());  
	    	 //throw new MailParseException(e);
	     }
	}
	
	
	public void sendMailTo(String dear, String content,String to,String subject,File file,File file1,File file2,File file3,File file4,File pdfFile) {
		System.out.println("finish 1 11" );
		
		   MimeMessage message = mailSender.createMimeMessage();
			
		   try{
			MimeMessageHelper helper = new MimeMessageHelper(message, true);
			System.out.println("finish 1 12" );
			
			helper.setFrom(simpleMailMessage.getFrom());
			helper.setTo(to);
			//helper.setCc(cc);
			helper.setSubject(subject);
			helper.setText(String.format(simpleMailMessage.getText(), dear, content));
			System.out.println("finish 1 13" );
			
			//FileSystemResource file = new FileSystemResource("C:\\log.txt");
			//FileSystemResource filegayani = new FileSystemResource(new File(file.getAbsolutePath()));
			if(file != null){
				//System.out.println("finish 1 14" + file.getAbsolutePath());
				//FileSystemResource filegayani = new FileSystemResource(new File(file.getAbsolutePath()));
				
				helper.addAttachment(file.getName(), file);
				System.out.println("finish 1 144" );
				
				
			}
			if(file1 != null){
				System.out.println("finish 1 15" );
				
				helper.addAttachment(file1.getName(), file1);
				
			}
			if(file2 != null){
				System.out.println("finish 1 16" );
				
				helper.addAttachment(file2.getName(), file2);
				
			}
			if(file3 != null){
				System.out.println("finish 1 16" );
				
				helper.addAttachment(file3.getName(), file3);
				
			}
			if(file4 != null){
				System.out.println("finish 1 17" );
				
				
			helper.addAttachment(file4.getName(), file4);
			}
			
			if(pdfFile != null){
				System.out.println("finish 1 17" );
				
				
			helper.addAttachment(pdfFile.getName(), pdfFile);
			}
			
			//helper.addAttachment("doc", new ByteArrayResource(bytes));
		      mailSender.send(message);
		      System.out.println("finish 1 18" );
				
	         }catch (Exception e) {
		          System.out.print("error : " + e.getMessage());  
	    	 //throw new MailParseException(e);
	     }
	}
	
	
	
	public void sendMailTo(String dear, String content,String to,String[] cc,String subject,File file,File file1,File file2,File file3,File file4,File pdfFile) {
		System.out.println("finish 1 11" );
		
		   MimeMessage message = mailSender.createMimeMessage();
			
		   try{
			MimeMessageHelper helper = new MimeMessageHelper(message, true);
			System.out.println("finish 1 12" );
			
			helper.setFrom(simpleMailMessage.getFrom());
			helper.setTo(to);
			helper.setCc(cc);
			helper.setSubject(subject);
			helper.setText(String.format(simpleMailMessage.getText(), dear, content));
			System.out.println("finish 1 13" );
			
			//FileSystemResource file = new FileSystemResource("C:\\log.txt");
			//FileSystemResource filegayani = new FileSystemResource(new File(file.getAbsolutePath()));
			if(file != null){
				//System.out.println("finish 1 14" + file.getAbsolutePath());
				//FileSystemResource filegayani = new FileSystemResource(new File(file.getAbsolutePath()));
				
				helper.addAttachment(file.getName(), file);
				System.out.println("finish 1 144" );
				
				
			}
			if(file1 != null){
				System.out.println("finish 1 15" );
				
				helper.addAttachment(file1.getName(), file1);
				
			}
			if(file2 != null){
				System.out.println("finish 1 16" );
				
				helper.addAttachment(file2.getName(), file2);
				
			}
			if(file3 != null){
				System.out.println("finish 1 16" );
				
				helper.addAttachment(file3.getName(), file3);
				
			}
			if(file4 != null){
				System.out.println("finish 1 17" );
				
				
			helper.addAttachment(file4.getName(), file4);
			}
			
			if(pdfFile != null){
				System.out.println("finish 1 20" );
				
				
			helper.addAttachment(pdfFile.getName(), pdfFile);
			}
			
			//helper.addAttachment("doc", new ByteArrayResource(bytes));
		      mailSender.send(message);
		      System.out.println("finish 1 18" );
				
	         }catch (Exception e) {
		          System.out.print("error : " + e.getMessage());  
	    	 //throw new MailParseException(e);
	     }
	}

	    

	
	 public void sendPlainTextEmail(String host, String port,
	            final String userName, final String password, String toAddress,
	            String subject, String message) throws AddressException,
	            MessagingException {

	        // sets SMTP server properties
	        Properties properties = new Properties();
	        properties.put("mail.smtp.host", host);
	        properties.put("mail.smtp.port", port);
	        properties.put("mail.smtp.auth", "true");
	        properties.put("mail.smtp.starttls.enable", "true");
	// *** BEGIN CHANGE
	        properties.put("mail.smtp.user", userName);

	        // creates a new session, no Authenticator (will connect() later)
	        Session session = Session.getDefaultInstance(properties);
	// *** END CHANGE

	        // creates a new e-mail message
	        Message msg = new MimeMessage(session);

	        msg.setFrom(new InternetAddress(userName));
	        InternetAddress[] toAddresses = { new InternetAddress(toAddress) };
	        msg.setRecipients(Message.RecipientType.TO, toAddresses);
	        msg.setSubject(subject);
	        msg.setSentDate(new Date());
	        // set plain text message
	        msg.setText(message);

	// *** BEGIN CHANGE
	        // sends the e-mail
	        Transport t = session.getTransport("smtp");
	        t.connect(userName, password);
	        t.sendMessage(msg, msg.getAllRecipients());
	        t.close();
	// *** END CHANGE

	    }
}
