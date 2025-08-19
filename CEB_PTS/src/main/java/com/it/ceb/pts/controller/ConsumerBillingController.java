package com.it.ceb.pts.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.it.ceb.pts.model.BillDetails;
import com.it.ceb.pts.model.MeterDetail;
import com.it.ceb.pts.model.PMTModel;
import com.it.ceb.pts.repo.JasperDao;
import com.it.ceb.util.common.ConfigProperties;
import com.it.ceb.util.common.SendSMS;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRPdfExporterParameter;
import org.apache.commons.compress.utils.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.io.*;
import java.math.BigDecimal;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Controller
public class ConsumerBillingController {

    @Autowired
    private JasperDao jasperDao;

    @RequestMapping(value = "/downloadBill" ,  method = RequestMethod.GET)
    public ModelAndView downloadBill(HttpServletRequest request,@ModelAttribute("model") PMTModel pmtModel){

        System.out.println("Successfully entered downloadBill method");
        String usrRole;
        String deptId;
        String usrName;
        try{
            deptId = request.getSession().getAttribute("deptId").toString();
            usrName = request.getSession().getAttribute("loggedUser").toString();
            usrRole = request.getSession().getAttribute("loggedUserRole").toString();
        }catch (Exception e) {
            System.out.println("Error while: " + e.getMessage());
        }
        PMTModel model = new PMTModel();
        return new ModelAndView("pts/consumerBilling/downloadBill/downloadBill", "model",model);

    }


    //downloa bill bulk sypply========================================
    @RequestMapping(value="/downloadBillBulkSupply" , method = RequestMethod.POST)
    public void downloadBillBulkSupply(@ModelAttribute("pmtModel") PMTModel pmtModel ,HttpServletRequest request,
                                       HttpServletResponse response)
    {

        System.out.println("downloadEstimate");
        System.out.println("pmtModel.getAccountNumber() " + pmtModel.getAccountNumber());
        System.out.println("pmtModel.getBillCycle() " + pmtModel.getBillCycle());
        String path1 = ConfigProperties.getProperty("REPORT_PATH") + "Reports";
        String path2 = ConfigProperties.getProperty("EXPORT_REPORT_PATH")  + "EmailAttachment";
        String pdfPath ="";
        String pdfName = "";
        Connection conn = null;
        String accountNumber= pmtModel.getAccountNumber();
        String billCycle = pmtModel.getBillCycle();
        Integer billCycleInt = Integer.valueOf(billCycle);
        try {

            //String apiUrl = "http://10.128.1.126/TransmissionBill/api/getBulkBillDetails";

            String apiUrl = "http://10.128.1.126/BulkBill_API/api/getBulkBillDetails";

            //String apiUrl = "http://10.128.1.126/TransmissionBill/api/getBulkBillDetails";
            String jsonInput = "{ \"acc_nbr\": \""+accountNumber+"\", \"billCycle\": "+billCycleInt+" }";

            SendSMS obj1 = new SendSMS();

            String jsonOutput = obj1.sendPostRequestMMS(apiUrl,jsonInput);

            ObjectMapper objectMapper = new ObjectMapper();


            // Parse JSON string to JsonNode
            JsonNode jsonNode = objectMapper.readTree(jsonOutput);
            System.out.println("text 1");

            String billMonth = jsonNode.get("billMonth").asText();
            String fromDate = jsonNode.get("fromDate").asText();
            String toDate = jsonNode.get("toDate").asText();

            System.out.println("text 2" + billMonth );


            // Navigate to masterDetail node
            JsonNode masterDetailNode = jsonNode.get("masterDetail");

            // Access acctNumber
            String acctNumber = masterDetailNode.get("acctNumber").asText();
            System.out.println("text 3" + acctNumber );

            String name = masterDetailNode.get("name").asText();
            System.out.println("text 4" + acctNumber );

            String address_l1 = masterDetailNode.get("address_1").asText();
            System.out.println("text 5" + acctNumber );

            String address_l2 = masterDetailNode.get("address_2").asText();
            System.out.println("text 6" + acctNumber );

            String email = masterDetailNode.get("email").asText();
            System.out.println("text 7" + acctNumber );

            String city = masterDetailNode.get("city").asText();
            System.out.println("text 8" + acctNumber );

            String tariff = masterDetailNode.get("tariff").asText();
            System.out.println("text 9" + acctNumber );
//
//            if (masterDetailNode.get("cntrDemand")!= null) {
//                Double cntrDemand = masterDetailNode.get("cntrDemand").asDouble();
//
//            }

            Double cntrDemand = masterDetailNode.get("cntrDemand").asDouble();
            Double secDeposit = masterDetailNode.get("secDeposit").asDouble();
            String invoiceNum = masterDetailNode.get("invoiceNum").asText();
            String oldAccNumber = masterDetailNode.get("oldAccNumber").asText();

            ////////////////////////////

            // Navigate to amountDetails node
            JsonNode amountDetails = jsonNode.get("amountDetails");
            Double previousDueAmt = amountDetails.get("previousDueAmt").asDouble();
            Double payments = amountDetails.get("payments").asDouble();
            Double debitAmount = amountDetails.get("debitAmount").asDouble();
            Double creditAmount = amountDetails.get("creditAmount").asDouble();
            Double currentMonthBill = amountDetails.get("currentMonthBill").asDouble();
            Double totalDueAmount = amountDetails.get("totalDueAmount").asDouble();
            // Double totalDueAmount = amountDetails.get("totalDueAmount").asDouble();
            Double chargesConsumed = amountDetails.get("chargesConsumed").asDouble();
            Double sscLevy = amountDetails.get("sscLevy").asDouble();
            Double chargesMonth = amountDetails.get("chargesMonth").asDouble();
            Double fixedChg = amountDetails.get("fixedChg").asDouble();


            System.out.println("text 10" + previousDueAmt );

            //JsonNode pmtDetails = jsonNode.get("pmtDetails");

            System.out.println("billMonth 1" + billMonth);
            System.out.println("acctNumber 1" + acctNumber);

            HashMap<String, Object> hmParams = new HashMap<String, Object>();
            hmParams.put("@acc_nbr", acctNumber);
            hmParams.put("@billCycle", billCycleInt);
            hmParams.put("@bill_mnth", billMonth);
            hmParams.put("@name", name);
            hmParams.put("@address_l1", address_l1);
            hmParams.put("@address_l2", address_l2);
            hmParams.put("@email", email);
            hmParams.put("@city", city);
            System.out.println("text 11" );

            SimpleDateFormat formatter = new SimpleDateFormat("M/d/yyyy h:mm:ss a");

            try {
                // Parse the string into a Date object
                Date date = formatter.parse(fromDate);

                SimpleDateFormat formatterNew = new SimpleDateFormat("dd/MM/yyyy"); // Define format
                String formattedDate = formatterNew.format(date); // Format date

                // Date dateNew = formatterNew.parse(formattedDate);

                hmParams.put("@from_date",  formattedDate);


                Date date1 = formatter.parse(toDate);
                String formattedToDate = formatterNew.format(date1); // Format date

                hmParams.put("@to_date",  formattedToDate);

                // Print the Date object
                System.out.println("Converted Date: " + date);
            } catch (Exception e) {
                e.printStackTrace();
            }


            hmParams.put("@tariff", tariff);

            System.out.println("text 12" );

            hmParams.put("@cntr_dmnd", BigDecimal.valueOf(cntrDemand));

            System.out.println("text 13");

            hmParams.put("@tot_sec_dep",BigDecimal.valueOf(secDeposit));

            System.out.println("text 14");

            if(invoiceNum == null){
                hmParams.put("@invoice_no", "");

            }else{
                hmParams.put("@invoice_no", invoiceNum);
            }
            hmParams.put("@oldAcc_no", oldAccNumber);

            System.out.println("text 15");

            hmParams.put("@fixed_chg", BigDecimal.valueOf(fixedChg));


            System.out.println("text 16" );

            //////////////////////////
            hmParams.put("@bf_bal", BigDecimal.valueOf(previousDueAmt));

            System.out.println("text 17"  );

            hmParams.put("@pay_tot", BigDecimal.valueOf(payments));
            System.out.println("text 18" );
            hmParams.put("@debt_tot", BigDecimal.valueOf(debitAmount));
            System.out.println("text 19"  );

            hmParams.put("@crdt_tot", BigDecimal.valueOf(creditAmount));

            System.out.println("text 20" );
            hmParams.put("@tot_amt", BigDecimal.valueOf(chargesMonth));
            System.out.println("text 21" );
            hmParams.put("@crnt_bal", BigDecimal.valueOf(totalDueAmount));
            System.out.println("text 22" );
            hmParams.put("@tot_gst", BigDecimal.valueOf(sscLevy));
            System.out.println("text 23"  );
            hmParams.put("@tot_amt", BigDecimal.valueOf(chargesMonth));
            System.out.println("text 24" );
            hmParams.put("@Tot_Consued_Fixed", BigDecimal.valueOf(chargesConsumed));
            System.out.println("text 25");

            try {
                System.out.println("text 25.1" );
                BillDetails bill = objectMapper.readValue(jsonOutput, BillDetails.class);

                System.out.println("text 25.2" );
                hmParams.put("@oldAcc_no", bill.getMasterDetail().getOldAccNumber());

                System.out.println("text 26" );

                List<MeterDetail> meterDetails = bill.getMeterDetails();
                if (meterDetails != null && !meterDetails.isEmpty()) {
                    hmParams.put("@mtr_nbr1", meterDetails.get(0).getMtrNumber()); // First meter number

                    System.out.println("text 27" );

                    hmParams.put("@Tot_mtr_nbr1", new BigDecimal(meterDetails.get(0).getChargeforMeter())); // First meter number

                    System.out.println("text 28" );
                    hmParams.put("@mtr_nbr2", meterDetails.get(1).getMtrNumber()); // First meter number

                    System.out.println("text 29" );
                    hmParams.put("@Tot_mtr_nbr2", new BigDecimal(meterDetails.get(1).getChargeforMeter())); // First meter number

                    System.out.println("text 30" );
                }

                System.out.println("text 31");


                hmParams.put("meterDetails", bill.getMeterDetails());

                //hmParams.put("@costctr","'" +costCenter.trim() +"'");
                System.out.println("downloadEstimatecostCenter 1" );

                conn = jasperDao.getConnectionInformixLive();
                System.out.println("downloadEstimatecostCenter 2" );

                File file = new File(path1 + "/" + "Bulk_Bill_Summary_Gayani_English_PayTrans_20250128" + ".jrxml" );
                System.out.println("downloadEstimatecostCenter 3" );

                if(!file.exists())
                    throw new RuntimeException("File " + file + " not found. The report design must be compiled first.");

                System.out.println("text 32");
                JasperPrint jasperPrint =null;
                JRPdfExporter pdf=null;
                System.out.println("text 33" );
                try {

                    //JRProperties.setProperty("net.sf.jasperreports.font.family.Iskoola Pota", "Iskoola Pota");
                    //JRProperties.setProperty("net.sf.jasperreports.font.path", "fonts/Iskoola Pota Regular.ttf");

                    JasperReport jasperReport =  JasperCompileManager.compileReport(path1  + "/" +  "Bulk_Bill_Summary_Gayani_English_PayTrans_20250128" + ".jrxml");
                    System.out.println("Executing SQL for report: " + jasperReport.getQuery().getText());
                    // Set up JasperReports font
                    System.out.println("text 34" );

                    System.out.println("jasperReport"+ jasperReport);
                    System.out.println("hmParams"+ hmParams);
                    System.out.println("conn"+ conn);

                    jasperPrint = JasperFillManager.fillReport(jasperReport, hmParams, conn);

                    System.out.println("text 35" );
                    pdf = new JRPdfExporter();
                    System.out.println("downloadEstimatecostCenter 4"  );
                } catch (Exception e1) {
                    // TODO Auto-generated catch block
                    e1.printStackTrace();
                    System.out.println("text 36" );
                }

                System.out.println("text 37" );

                Calendar calendar = Calendar.getInstance();

                pdf.setParameter(JRPdfExporterParameter.CHARACTER_ENCODING, "UTF-8");
                pdfPath = accountNumber+ ".pdf";

                File pdfFile = new File(path2 + File.separator + pdfPath);
                System.out.println("pdfPath" +pdfPath );
                pdf.setParameter(JRPdfExporterParameter.JASPER_PRINT, jasperPrint);
                pdf.setParameter(JRPdfExporterParameter.OUTPUT_FILE_NAME, path2 + File.separator + pdfPath);
                pdf.exportReport();
                System.out.println("downloadEstimatecostCenter 5" );


                if (pdfFile.exists())
                {
                    try {
                        response.setContentType("application/pdf");
                        //response.addHeader("Content-Disposition", "attachment; filename="+pdfPath);
                        response.setHeader("Content-Disposition", "attachment; filename=\"" + accountNumber + ".pdf\"");

                        InputStream inputStream = new FileInputStream(new File( path2 + File.separator + pdfPath)); //load the file
                        IOUtils.copy(inputStream, response.getOutputStream());
                        response.flushBuffer();
                        System.out.println("pdfPath" +pdfPath );

                    } catch (FileNotFoundException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    } catch (IOException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }



                }
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

        } catch (Exception ex) {
            System.out.println("Joboxxxxxxxxx conn.close();xxxxx dclose"+ ex);
            //throw new Exception("Database Connection Error !!");
        }


    }

}
