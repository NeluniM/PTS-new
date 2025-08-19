package com.it.ceb.pts.repo;

import com.it.ceb.util.common.ConfigProperties;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.export.HtmlExporter;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRPdfExporterParameter;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleHtmlExporterOutput;
import net.sf.jasperreports.export.SimpleHtmlReportConfiguration;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.naming.NamingException;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.*;

//import com.it.piv.issue.domain.PivAmount;
//import com.it.piv.issue.domain.PivAmountPK;

@Repository
@Transactional
public class JasperDaoImpl implements JasperDao {

	@Autowired
	private EntityManager em;


	@Override
	public Connection getConnection() throws SQLException
	{
		Connection conn = null;

		try {
			System.out.println("gggggggggggggggggggggggggggg");

			//Class.forName("com.mysql.jdbc.Driver");
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			System.out.println("Please include Classpath Where your MySQL Driver is located");
			e.printStackTrace();
		}
		System.out.println("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
		//conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root","*****");
		//

		//conn = DriverManager.getConnection("jdbc:oracle:thin:@10.128.0.56:1521:hqorad1","dacons12","dacons12");
		conn = DriverManager.getConnection("jdbc:oracle:thin:@10.128.0.163:1521:hqorap1","prodmis","prodmisn");

		System.out.println("lllllllllllllllllllllllllllllllllllll" +conn);

		if (conn != null)
		{
			System.out.println("Database Connected");
		}
		else
		{
			System.out.println(" connection Failed ");
		}





		return conn;


	}

	@Override
	public JasperReport getCompiledFile(String fileName, HttpServletRequest request) throws JRException {
		System.out.println("path " + request.getSession().getServletContext().getRealPath("/jasper/" + fileName + ".jasper"));
		File reportFile = new File( request.getSession().getServletContext().getRealPath("/jasper/" + fileName + ".jasper"));
		// If compiled file is not found, then compile XML template
		if (!reportFile.exists()) {
			JasperCompileManager.compileReportToFile(request.getSession().getServletContext().getRealPath("/jasper/" + fileName + ".jrxml"),request.getSession().getServletContext().getRealPath("/jasper/" + fileName + ".jasper"));
		}
		JasperReport jasperReport = (JasperReport) JRLoader.loadObjectFromFile(reportFile.getPath());
		System.out.println("path " +jasperReport );


		return jasperReport;
	}

	@Override
	public void generateReportHtml( JasperPrint jasperPrint, HttpServletRequest req, HttpServletResponse resp) throws IOException, JRException {
		HtmlExporter exporter=new HtmlExporter();
		List<JasperPrint> jasperPrintList = new ArrayList<JasperPrint>();
		jasperPrintList.add(jasperPrint);
		exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList));
		exporter.setExporterOutput( new SimpleHtmlExporterOutput(resp.getWriter()));
		SimpleHtmlReportConfiguration configuration =new SimpleHtmlReportConfiguration();
		exporter.setConfiguration(configuration);
		exporter.exportReport();

	}

	@Override
	public void generateReportExcel(JasperPrint jasperPrint, HttpServletRequest req, HttpServletResponse response) throws IOException, JRException {
		/*JRXlsxExporter exporter=new JRXlsxExporter();
			 List<JasperPrint> jasperPrintList = new ArrayList<JasperPrint>();
			 jasperPrintList.add(jasperPrint);
			 exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList));
			 exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(resp.getWriter()));
			 SimpleXlsxReportConfiguration configuration =new SimpleXlsxReportConfiguration();
			 exporter.setConfiguration(configuration);
			 exporter.exportReport();
*/

       /* JRXlsxExporter exporter = new JRXlsxExporter();
        SimpleXlsxReportConfiguration reportConfigXLS = new SimpleXlsxReportConfiguration();
        reportConfigXLS.setSheetNames(new String[] { "sheet1" });
        exporter.setConfiguration(reportConfigXLS);
        exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
        exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(response.getOutputStream()));
        response.setHeader("Content-Disposition", "attachment;filename=jasperReport.xlsx");
        response.setContentType("application/octet-stream");
        exporter.exportReport();
       */

		JRXlsxExporter exporter = new JRXlsxExporter();
		exporter.setParameter(JRXlsExporterParameter.JASPER_PRINT, jasperPrint);
		exporter.setParameter(JRXlsExporterParameter.OUTPUT_FILE_NAME, "test");

		exporter.exportReport();
	}


	@Override
	public void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws JRException, NamingException, SQLException, IOException {



		byte[] bytes = null;
		bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
		resp.reset();
		resp.resetBuffer();
		resp.setContentType("application/pdf");
		resp.setContentLength(bytes.length);

		resp.addHeader("Content-Disposition", "inline; filename="+"test");
//resp.setHeader("", arg1);
		//resp.setHeader("test", "test");

		//resp.setContentType("application/pdf");
		try
		{
			ServletOutputStream ouputStream = resp.getOutputStream();
			//ouputStream.
			ouputStream.write(bytes, 0, bytes.length);
			ouputStream.flush();
			ouputStream.close();

		}
		catch (IOException ex) {
			ex.printStackTrace();
		}





	}



	public String generateReport(String type,String reportName,HashMap<String, Object> param,Map<String, Object> session,String REPORT_DIRECTORY,String EXPORT_REPORT_DIRECTORY,String requ,String requeting,String areaName,String lineNames,String province){

		String pdfPath = "";
		//String reportFileName ="Inspection_Request";
		Connection conn = null;

		try {

			try {
				HashMap<String, Object> hmParams = new HashMap<String, Object>();

				hmParams.put("@erquirement", "'"+requ+"'");
				hmParams.put("@requesting","'" +requeting +"'");
				hmParams.put("@coordinating","'"+areaName+"'");
				hmParams.put("@lineName","'"+lineNames+"'");
				hmParams.put("@province","'"+province+"'");


				conn =getConnection();
				File file = new File(REPORT_DIRECTORY + "/" + reportName + ".jrxml" );

				if(!file.exists())
					throw new JRRuntimeException("File " + file + " not found. The report design must be compiled first.");

				JasperReport jasperReport =  JasperCompileManager.compileReport(EXPORT_REPORT_DIRECTORY  + "/" + reportName + ".jrxml");
				JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, hmParams, conn);
				JRPdfExporter pdf = new JRPdfExporter();

				Calendar calendar = Calendar.getInstance();

				pdf.setParameter(JRPdfExporterParameter.CHARACTER_ENCODING, "UTF-8");

				/*pdfPath = EXPORT_REPORT_DIRECTORY + "/" + calendar.get(Calendar.YEAR) + "-" + (calendar.get(Calendar.MONTH ) + 1)+ "-"
				+ calendar.get(Calendar.DATE)+ "-" + calendar.get(Calendar.HOUR) + "-" + calendar.get(Calendar.MINUTE)+ "-"
				+ calendar.get(Calendar.SECOND)+ "-" + calendar.get(Calendar.MILLISECOND)   + "R.pdf";
				*/
				pdfPath = EXPORT_REPORT_DIRECTORY + "/" +type+ calendar.get(Calendar.YEAR) + "-" + (calendar.get(Calendar.MONTH ) + 1)+ "-"
						+ calendar.get(Calendar.DATE)+ "-" + calendar.get(Calendar.HOUR) + "-" + calendar.get(Calendar.MINUTE)+ "-"
						+ calendar.get(Calendar.SECOND)+ "-" + calendar.get(Calendar.MILLISECOND)   + ".pdf";



				pdf.setParameter(JRPdfExporterParameter.JASPER_PRINT, jasperPrint);
				pdf.setParameter(JRPdfExporterParameter.OUTPUT_FILE_NAME, pdfPath);
				pdf.exportReport();


				System.out.println("Joboxxxxxxxxxxxxxxxxxxxxxxxxxxxx dclose");



			} catch (Exception ex) {
				System.out.println("Joboxxxxxxxxx conn.close();xxxxx dclose"+ ex);
				throw new Exception("Database Connection Error !!");
			} finally {
				System.out.println("Joboxxxxxxxxx conn.close();xxxxx dclose");
				if(conn!=null){
					conn.close();
				}
				System.out.println("Joboxxxxxxxxx conn.close() tttttttttttttttttt;xxxxx dclose");
			}



		} catch (Exception e) {
			e.printStackTrace();


		}

		return pdfPath ;
	}





	@Override
	public JasperReport getCompiledFileMVMMS(String fileName,HttpServletRequest request) throws JRException {

		String path = ConfigProperties.getProperty("REPORT_PATH") + "Reports";
		File dir = new File(path + File.separator + "Reports");
		if (!dir.exists())
			dir.mkdirs();


		System.out.println("path " + path +File.separator + fileName + ".jasper");
		File reportFile = new File( path +File.separator + fileName + ".jasper");
		// If compiled file is not found, then compile XML template
		if (!reportFile.exists()) {
			JasperCompileManager.compileReportToFile(path +File.separator + fileName + ".jrxml",path +File.separator + fileName + ".jasper");
		}
		JasperReport jasperReport = (JasperReport) JRLoader.loadObjectFromFile(reportFile.getPath());
		System.out.println("path " +jasperReport );





		return jasperReport;
	}

	@Override
	public void generateReportPDFToFolder(HttpServletResponse resp,
										  Map parameters, JasperReport jasperReport, Connection conn)
			throws JRException, NamingException, SQLException, IOException {
		// TODO Auto-generated method stub

	}

	@Override
	public void generateReportPDFWithName(HttpServletResponse resp,
										  Map parameters, JasperReport jasperReport, Connection conn,String name)
			throws JRException, NamingException, SQLException, IOException {
		// TODO Auto-generated method stub

		byte[] bytes = null;
		bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
		resp.reset();
		resp.resetBuffer();
		resp.setContentType("application/pdf");
		resp.setContentLength(bytes.length);

		resp.addHeader("Content-Disposition", "inline; filename="+name);
		//resp.setHeader("", arg1);
		//resp.setHeader("test", "test");

		//resp.setContentType("application/pdf");
		try
		{
			ServletOutputStream ouputStream = resp.getOutputStream();
			//ouputStream.
			ouputStream.write(bytes, 0, bytes.length);
			ouputStream.flush();
			ouputStream.close();

		}
		catch (IOException ex) {
			ex.printStackTrace();
		}






	}

	@Override
	public void generateReportAPKWithName(HttpServletResponse resp,
										  Map parameters, File file, Connection conn,
										  String name) throws JRException, NamingException, SQLException,
			IOException {
		// TODO Auto-generated method stub


		/*Path n = Paths.get(arg0, arg1)
		byte[] bytes = null;
		bytes = file.;
		resp.reset();
		resp.resetBuffer();
		resp.setContentType("application/octet-stream");
		resp.setContentLength(bytes.length);

		resp.addHeader("Content-Disposition", "inline; filename=MVMMS");
        //resp.setHeader("", arg1);
		//resp.setHeader("test", "test");

		//resp.setContentType("application/pdf");
		try
        {
        	ServletOutputStream ouputStream = resp.getOutputStream();
        	//ouputStream.
			ouputStream.write(bytes, 0, bytes.length);
			ouputStream.flush();
			ouputStream.close();

        }
        catch (IOException ex) {
            ex.printStackTrace();
        }
*/
	}

	/*@Override
	public Connection getConnectionInformix() throws SQLException {
		{
	        String url = "jdbc:informix-sqli://10.128.28.101:1526/billhsbhq:INFORMIXSERVER=testbulkinfdb1";
	        String username = "informix";
	        String password = "informix";

	        Connection conn = null;

	        try {
	            // Load the Informix JDBC driver
	            Class.forName("com.informix.jdbc.IfxDriver");

	            // Establish the connection
	            conn = DriverManager.getConnection(url, username, password);
	            System.out.println("Connected to Informix database successfully!");

	            // Perform database operations here

	        } catch (ClassNotFoundException e) {
	            System.out.println("Informix JDBC Driver not found!");
	            e.printStackTrace();
	        } catch (SQLException e) {
	            System.out.println("Failed to connect to Informix database!");
	            e.printStackTrace();
	        } finally {
	            try {
	                if (conn != null) {
	                    conn.close();
	                }
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }

	        return conn;
	    }

	}
*/


	@Override
	public Connection getConnectionInformix() throws SQLException {
		String url = "jdbc:informix-sqli://10.128.28.101:1526/billhsbhq:INFORMIXSERVER=testbulkinfdb1";
		String username = "informix";
		String password = "informix";

		try {
			// Load the Informix JDBC driver
			Class.forName("com.informix.jdbc.IfxDriver");

			// Establish and return the connection
			Connection conn = DriverManager.getConnection(url, username, password);
			System.out.println("Connected to Informix database successfully!");
			return conn;
		} catch (ClassNotFoundException e) {
			System.out.println("Informix JDBC Driver not found!");
			throw new SQLException("Failed to load Informix JDBC Driver", e);
		} catch (SQLException e) {
			System.out.println("Failed to connect to Informix database!");
			throw e; // Re-throw exception to allow proper error handling in the caller
		}
	}

	@Override
	public Connection getConnectionInformixLive() throws SQLException {
		String url = "jdbc:informix-sqli://10.128.0.201:1526/billhsbhq:INFORMIXSERVER=bulkinfdb1";
		String username = "informix";
		String password = "informix";

		try {
			// Load the Informix JDBC driver
			Class.forName("com.informix.jdbc.IfxDriver");

			// Establish and return the connection
			Connection conn = DriverManager.getConnection(url, username, password);
			System.out.println("Connected to Informix database successfully!");
			return conn;
		} catch (ClassNotFoundException e) {
			System.out.println("Informix JDBC Driver not found!");
			throw new SQLException("Failed to load Informix JDBC Driver", e);
		} catch (SQLException e) {
			System.out.println("Failed to connect to Informix database!");
			throw e; // Re-throw exception to allow proper error handling in the caller
		}

	}


}
