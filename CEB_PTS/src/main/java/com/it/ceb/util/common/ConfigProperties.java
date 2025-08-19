package com.it.ceb.util.common;


import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.core.env.Environment;




   public class ConfigProperties{
      private static final String PROP_FILE="config.properties";
      
      
      
      public void readPropertiesFile(){
          /*try{
             InputStream is = Path.class.getResourceAsStream(PROP_FILE);
             Properties prop = new Properties();
                 prop.load(is);
            String directory = prop.getProperty("Directory");
            System.out.println(directory);
                String numberOfFiles = prop.getProperty("NumberOfFiles");
            System.out.println(numberOfFiles);
            String  fileExtension = prop.getProperty("Extension");
            System.out.println(fileExtension);
            is.close();
         /* code to use values read from the file*/
          /*}catch(Exception e){
            System.out.println("Failed to read from " + PROP_FILE + " file.");
          }*/
    	  //System.out.println("property@@@"+property);
      }
      public static String getPath(){
        try {
            InputStream is = ConfigProperties.class.getResourceAsStream(PROP_FILE);
            Properties prop = new Properties();
            prop.load(is);
            String path = prop.getProperty("pdfPath");
            //System.out.println(path);
            return  path;
        } catch (IOException ex) {
            Logger.getLogger(ConfigProperties.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
      }
      
//      public  static String getReportPath(){
//    	  //
//          try {
//        	  	GenericXmlApplicationContext ctx = new GenericXmlApplicationContext("META-INF/spring/SystemConfig.xml");
//        	  	SystemConfig sc = (SystemConfig) ctx.getBean("SysConfig");
//
//        	  	String REPORT_DIRECTORY = "" ;
//        	  	if (System.getProperty("os.name").indexOf("Windows") != -1 )
//  				{
//  					REPORT_DIRECTORY = sc.getWindowsReportDir();
//  				}
//  				else
//  				{
//  					REPORT_DIRECTORY = sc.getLinuxReportDir();
//  				}
//
//  				ctx.close();
//              System.out.println("REPORT_DIRECTORY"+REPORT_DIRECTORY);
//  				return  REPORT_DIRECTORY;
//          	} /*/catch (IOException ex) {
//        	  ex.printStackTrace();
//              Logger.getLogger(Path.class.getName()).log(Level.SEVERE, null, ex);
//              return null;
//          	}*/
//          	catch(Exception e)
//          	{
//        	  e.printStackTrace();
//        	  return null;
//          	}
//        }
      
      public  static String getReportOutPath(){
    	  //System.out.println("property@@@"+property);
          try {
        	  	GenericXmlApplicationContext ctx = new GenericXmlApplicationContext("META-INF/spring/SystemConfig.xml");
        	  	SystemConfig sc = (SystemConfig) ctx.getBean("SysConfig");
        	  
        	  	String EXPORT_REPORT_DIRECTORY = "";
  			
        	  	if (System.getProperty("os.name").indexOf("Windows") != -1 )
        	  	{
  					EXPORT_REPORT_DIRECTORY = sc.getWindowsReportOutDir();

  				}	
  				else
  				{
  					EXPORT_REPORT_DIRECTORY = sc.getLinuxReportOutDir();
  				}
        	  
  				ctx.close();
              
  				return  EXPORT_REPORT_DIRECTORY;
          	} /*/catch (IOException ex) {
        	  ex.printStackTrace();
              Logger.getLogger(Path.class.getName()).log(Level.SEVERE, null, ex);
              return null;
          	}*/
          	catch(Exception e)
          	{
        	  e.printStackTrace();
        	  return null;
          	}
        }
      
      public String getDBUrl(String region)
      {
    	  try {
              InputStream is = ConfigProperties.class.getResourceAsStream(PROP_FILE);
              Properties prop = new Properties();
              prop.load(is);
              
              String db_url = null;
              if (region.equals("R1")){
  				db_url = prop.getProperty("db_url_R1");  				 
  			  } else if (region.equals("R2")){
  				db_url = prop.getProperty("db_url_R2");  			 
  			  }else if (region.equals("R3")){
  				db_url = prop.getProperty("db_url_R3");  			 
  			  }else if (region.equals("R4")){
  				db_url = prop.getProperty("db_url_R4");  			 
  			  }else {
   				db_url = prop.getProperty("db_url_RX");  			 
   			  }
             
               
              return  db_url;
          } catch (IOException ex) {
              Logger.getLogger(ConfigProperties.class.getName()).log(Level.SEVERE, null, ex);
              return null;
          }
      }
      
      public String getDBUserName(String region)
      {
    	  try {
              InputStream is = ConfigProperties.class.getResourceAsStream(PROP_FILE);
              Properties prop = new Properties();
              prop.load(is);
              
              String db_url = null;
            if (region.equals("R1")){
  				db_url = prop.getProperty("db_userName_R1");  				 
  			} else if (region.equals("R2")){
  				db_url = prop.getProperty("db_userName_R2");  			 
  			} else if (region.equals("R3"))	{
  				db_url = prop.getProperty("db_userName_R3");  			 
  			} else if (region.equals("R4")){
  				db_url = prop.getProperty("db_userName_R4");  			 
  			}else {
  				db_url = prop.getProperty("db_userName_RX");  			 
  			}
             
               
              return  db_url;
          } catch (IOException ex) {
              Logger.getLogger(ConfigProperties.class.getName()).log(Level.SEVERE, null, ex);
              return null;
          }
      }
      
      public String getDBPassword(String region)
      {
    	  try {
              InputStream is = ConfigProperties.class.getResourceAsStream(PROP_FILE);
              Properties prop = new Properties();
              prop.load(is);
              
              String db_url = null;
              if (region.equals("R1")){
  				db_url = prop.getProperty("db_password_R1");  				 
  			  } else if (region.equals("R2"))	{
  				db_url = prop.getProperty("db_password_R2");  			 
  			  } else if (region.equals("R3"))	{
  				db_url = prop.getProperty("db_password_R3");  			 
  			  }else if (region.equals("R4")){
  				db_url = prop.getProperty("db_password_R4");  			 
  			  }else {
  				db_url = prop.getProperty("db_password_RX");  			 
  			  }
               
              return  db_url;
          } catch (IOException ex) {
              Logger.getLogger(ConfigProperties.class.getName()).log(Level.SEVERE, null, ex);
              return null;
          }
      }
      
      /*public static String getWebAppName(){
          try {
              InputStream is = Path.class.getResourceAsStream(PROP_FILE);
              Properties prop = new Properties();
              prop.load(is);
              String path = prop.getProperty("webAppName");
              //System.out.println(path);
              return  path;
          } catch (IOException ex) {
              Logger.getLogger(Path.class.getName()).log(Level.SEVERE, null, ex);
              return null;
          }
        }*/
      
      public static String getBillExportPath(){
          try {
              InputStream is = ConfigProperties.class.getResourceAsStream(PROP_FILE);
              Properties prop = new Properties();
              prop.load(is);
              String path = prop.getProperty("BillExportPath");
              //System.out.println(path);
              return  path;
          } catch (IOException ex) {
              Logger.getLogger(ConfigProperties.class.getName()).log(Level.SEVERE, null, ex);
              return null;
          }
        }
      
      
      public static void main(String[] args){
         // Path path= new Path();
          //System.out.println("hgfsdhafjhsa");
          //path.readPropertiesFile();
          System.out.println(ConfigProperties.getBillExportPath());
          System.out.println(ConfigProperties.getPath());
      }
      
      public  static String getProperty(String propertyCode){
    	  //
          try {
        	  	GenericXmlApplicationContext ctx = new GenericXmlApplicationContext("META-INF/spring/SystemConfig.xml");
        	  	SystemConfig sc = (SystemConfig) ctx.getBean("SysConfig");
        	  
        	  	String propertyValue = "";
        	  	if(propertyCode.equals("FILE_PATH"))
        	  	{
	        	  	if (System.getProperty("os.name").indexOf("Windows") != -1 )
	  				{
	        	  		propertyValue = sc.getWindowsReadingFileDir();
	  				}	
	  				else
	  				{
	  					propertyValue = sc.getLinuxReadingFileDir();
	  				}
        	  	}
        	  	else if(propertyCode.equals("REPORT_PATH"))
        	  	{
	        	  	if (System.getProperty("os.name").indexOf("Windows") != -1 )
	  				{
	        	  		propertyValue = sc.getWindowsReportDir();
	  				}	
	  				else
	  				{
	  					propertyValue = sc.getLinuxReportDir();
	  				}
        	  	}
        	  	else if(propertyCode.equals("EXPORT_REPORT_PATH"))
        	  	{
	        	  	if (System.getProperty("os.name").indexOf("Windows") != -1 )
	  				{
	        	  		propertyValue = sc.getWindowsReportOutDir();
	  				}	
	  				else
	  				{
	  					propertyValue = sc.getLinuxReportOutDir();
	  				}
        	  	}
        	  
  				ctx.close();
              System.out.println("propertyValue"+propertyValue);
  				return  propertyValue;
          	} /*/catch (IOException ex) {
        	  ex.printStackTrace();
              Logger.getLogger(Path.class.getName()).log(Level.SEVERE, null, ex);
              return null;
          	}*/
          	catch(Exception e)
          	{
        	  e.printStackTrace();
        	  return null;
          	}
        }
     }