package com.it.ceb.pts.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.it.ceb.pts.domain.*;
import com.it.ceb.pts.domain.MeterReading;
import com.it.ceb.pts.model.*;
import com.it.ceb.pts.repo.InvoiceDao;
import com.it.ceb.pts.repo.MeterProcessDao;
import com.it.ceb.pts.repo.MeterReadingDao;
import com.it.ceb.pts.repo.ProvinceDao;
import com.it.ceb.util.common.ExcelMeterReader;
import com.it.ceb.util.common.ConfigProperties;
import com.it.ceb.util.common.exceptions.ExceptionHandler;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRPdfExporterParameter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ViewResolver;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileInputStream;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class MeterPointController {

    @Autowired
    private com.it.ceb.pts.repo.DistributionLicenseDao DistributionLicenseDao;
    @Autowired
    private ExcelMeterReader excelMeterReader;
    @Autowired
    private MeterProcessDao meterProcessDao;
    @Autowired
    private MeterReadingDao meterReadingDao;
    @Autowired
    private ModelService modelService;
    @Autowired
    private ProvinceDao provinceDao;
    @Autowired
    private InvoiceDao invoiceDao;
    @Autowired
    private ViewResolver viewResolver;


    //-----------------------------------------------------------------------------
    //                  Initial page Views
    //-----------------------------------------------------------------------------

    //processMeterReading
    @Transactional
    @RequestMapping(value = "/processMeterReading", method = RequestMethod.GET)
    public String processMeterReading(Model model) throws Exception{
        BillCycle billCycle = meterProcessDao.getCurrentBillCycle();
        List<DistributionLicense> licenseList = DistributionLicenseDao.getLicenseList();
        List<Province> provinceList = provinceDao.getAllProvince();
        model.addAttribute("licenseList",licenseList);
        model.addAttribute("provinceList",new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
        model.addAttribute("billCycleNo", billCycle.getBillCycleNo());
        return "pts/licenseeBilling/processReading/processMeterReading"; // Return the same page after form submission
    }

    //viewMeterReading
    @Transactional
    @RequestMapping(value = "/viewMeterReading", method = RequestMethod.GET)
    public String viewMeterReading(Model model) throws Exception{
        BillCycle billCycle = meterProcessDao.getCurrentBillCycle();
        List<DistributionLicense> licenseList = DistributionLicenseDao.getLicenseList();
        List<Province> provinceList = provinceDao.getAllProvince();
        model.addAttribute("licenseList",licenseList);
        model.addAttribute("billCycleNo", billCycle.getBillCycleNo());
        model.addAttribute("provinceList",new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
        return "pts/licenseeBilling/viewReading/viewMeterReading"; // Return the same page after form submission
    }

    //bill calculation
    @Transactional
    @RequestMapping(value = "/billCalc", method = RequestMethod.GET)
    public String billCalc(Model model) throws Exception{
        BillCycle billCycle = meterProcessDao.getCurrentBillCycle();
        List<DistributionLicense> licenseList = DistributionLicenseDao.getLicenseList();
        List<TxnMaster> txnList = invoiceDao.getTxnList();
        List<InvoiceTxn> invoiceTxnList = invoiceDao.getInvoiceTxnList(billCycle.getBillCycleNo(), "DD1");
        invoiceDao.prepareProvinceSummary(billCycle.getBillCycleNo(), "DD1");
        List<ProvinceEnergySummaryModel> list = invoiceDao.getProvinceEnergySummaryList();
        model.addAttribute("SummaryList", list);
        model.addAttribute("licenseList",licenseList);
        model.addAttribute("billCycleNo", billCycle.getBillCycleNo());
        model.addAttribute("txnList",txnList);
        model.addAttribute("invoiceTXNlist", invoiceTxnList);
        return "pts/licenseeBilling/billCalculate/billCalculate"; // Return the same page after form submission
    }

    //invoice
    @Transactional
    @RequestMapping(value = "/invoice", method = RequestMethod.GET)
    public String invoice(Model model,
         @RequestParam(value="billCycle" ,required = false) String billCycle,
         @RequestParam(value="division" ,required = false) String division) throws Exception{
        String bc="";
        if(!Objects.equals(billCycle, "")){
            bc = meterProcessDao.getCurrentBillCycle().getBillCycleNo().toString();
        }
        List<DistributionLicense> licenseList = DistributionLicenseDao.getLicenseList();
            model.addAttribute("billCycleParam", billCycle);
            model.addAttribute("billCycleNo", bc);
            model.addAttribute("divisionParam", division);
            model.addAttribute("licenseList",licenseList);
            return "pts/licenseeBilling/invoice/invoice"; // Return the same page after form submission
    }


    //----------------------------------------------------------------------------
    //                              API request methods
    //----------------------------------------------------------------------------

    //viewMeterReadingList===================================================
    @Transactional(readOnly = true)
    @RequestMapping(value = "/viewMeterReadingList", method = RequestMethod.GET)
    public String getMeterPointAndReadings(
            @RequestParam("billCycle") Long billCycle,
            @RequestParam("division") String division,
            @RequestParam("province") String province,
            Model model) throws Exception {
        System.out.println("get MeterReadings method called");
        List<MeterPointModel> meterPoints = new ArrayList<>();
        try {
            List<MeterReadingRecordModel> meterReadings = meterReadingDao.getMeterReadings(billCycle, province, division);
            meterPoints = meterReadingDao.getMeterPoints(province, division);
            System.out.println("MeterReadings & MeterPoints fetched successfully");

            //getting serial no's to get the meter reading summary detail
            List<String> serialNumbers = meterPoints.stream()
                    .map(MeterPointModel::getSerialNo)
                    .collect(Collectors.toList());
            List<MeterReadingEnergySummary> energySummaries = meterReadingDao.getMeterReadingEnergySummary(billCycle, serialNumbers);
            Map<String, MeterReadingEnergySummary> energySummaryMap = energySummaries.stream()
                    .collect(Collectors.toMap(MeterReadingEnergySummary::getSerialNo, summary -> summary));
            System.out.println("MeterReadingEnergySummary s fetched successfully");

            // Attach readings to corresponding meter points
            System.out.println("Attaching meter readings to corresponding meter points");
            for (MeterReadingRecordModel reading : meterReadings) {
                for (MeterPointModel point : meterPoints) {
                    if (point.getId().equals(reading.getPointId())) {
                        point.getMeterReadingRecordModels().add(reading);
                        point.setStatus("Success");
                    }
                }
            }
            // Meter reading energy summaries attaching to meter points (separately to avoid duplication)
            System.out.println("Energy summary details preparing");
            for (MeterPointModel point : meterPoints) {
                MeterReadingEnergySummary summary = energySummaryMap.get(point.getSerialNo());
                if (summary != null) {
                    point.setImportEnergy(summary.getImportEnergy());
                    point.setExportEnergy(summary.getExportEnergy());
                    point.setExportCoincidentPeak(summary.getExportCoincidentPeak());
                    point.setImportCoincidentPeak(summary.getImportCoincidentPeak());
                }
            }

            //loading the error meter points-------------------------------
            System.out.println("Checking for error meters");
            if(!meterPoints.isEmpty()&&meterPoints.size()>0){
                List<MeterReadingErrLog> errorMeterList = meterReadingDao.getErrorMeterList(billCycle,division,province);
                //checking the error meters present in the meterPoints with above errorMeterList
                for (MeterReadingErrLog errorLog : errorMeterList) {
                    for (MeterPointModel point : meterPoints) {
                        if (errorLog.getSerialNo().equals(point.getSerialNo())) {
                            point.setStatus("Error");
                            point.setErrorReason(errorLog.getReason());
                        }
                    }
                }
            }

            // Fetch and attach energy summary (province overall)
            ProvinceEnergySummary total = meterReadingDao.getProvinceEnergySummary(billCycle, division, province);
            model.addAttribute("energySummary", total);


            try {
                System.out.println("Getting details for table header");
                BillCycle bc = meterProcessDao.getBillCycle(billCycle);
                Date prevDate = new SimpleDateFormat("yyyy-MM-dd").parse(bc.getBillYear() + "-" + bc.getBillMonth() + "-01");
                Date currntDate =  new SimpleDateFormat("yyyy-MM-dd").parse(bc.getBillYear() + "-" + bc.getBillMonth()+1 + "-01");
                model.addAttribute("billCycle", bc.getBillCycleNo());
                model.addAttribute("billYear", bc.getBillYear());
                model.addAttribute("billMonth",
                        java.time.Month.of(bc.getBillMonth().intValue()).name().toLowerCase().substring(0, 1).toUpperCase()
                                + java.time.Month.of(bc.getBillMonth().intValue()).name().toLowerCase().substring(1)
                );
                model.addAttribute("coincidentPeakDate", new SimpleDateFormat("yyyy-MM-dd").format(bc.getCoincidentPeakDate()));;
                model.addAttribute("coincidentPeakTime", new SimpleDateFormat("HH:mm:ss").format(bc.getCoincidentPeakDate()));
                model.addAttribute("currentDate", new SimpleDateFormat("yyyy-MM-dd").format(currntDate));
                model.addAttribute("previousDate", new SimpleDateFormat("yyyy-MM-dd").format(prevDate));
            }catch(Exception e) {
                System.out.println("Error in Getting details for table header: " + e.getMessage());
                //e.printStackTrace();//
            }
            model.addAttribute("thisBillCycle",billCycle);
            model.addAttribute("meterReadingFileList", meterPoints);

        } catch (Exception e) {
            model.addAttribute("msg", "An error occurred while fetching meter readings: ");
            System.out.println(e.getMessage());
            //e.printStackTrace();//
        }
        return "pts/licenseeBilling/viewReading/meterReadingTable";
    }

    private Connection getReportDbConnection()
    {
        Connection conn = null;
		/*String connStr = configDao.getConfigValue("REPORT_DB_CON_STR", appName);
		String user = configDao.getConfigValue("REPORT_DB_USER", appName);
		String pwd = configDao.getConfigValue("REPORT_DB_PWD", appName);*/

        String connStr ="jdbc:oracle:thin:@10.128.0.56:1521:hqorad1";
        String user = "pstdb";
        String pwd = "devPSTDB";
		/*
		String connStr ="jdbc:oracle:thin:@10.128.0.56:1521:hqorad1";
		String user = "dacons12";
		String pwd = "dacons12";*/
        try
        {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(connStr,user,pwd);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

//    @Transactional
//    @RequestMapping(value = "/processFiles", method = RequestMethod.GET)
//    public String readFiles(
//            @RequestParam("billCycle") String billCycle,
//            @RequestParam("division") String division,
//            @RequestParam("province") String province,
//            Model model) {
//
//        String fileName = "D:\\New folder (2)\\440\\LECO\\WPNL\\ANK\\ANK_F01\\211279951-LP 01.xls";
//
//        try (BufferedReader br = new BufferedReader(new FileReader(fileName))) {
//            String line;
//            int rowIndex = 0; // Track the current row index
//            int targetRow = 8; // Row index to read (0-based for A9)
//            int targetColumn = 3; // Column index to read (0-based for A)
//
//            while ((line = br.readLine()) != null) {
//                if (rowIndex == targetRow) {
//                    String[] columns = line.split("\\t"); // Split by tab
//                    if (targetColumn < columns.length) {
//                        String cellValue = columns[targetColumn];
//                        System.out.println("Value at A9: " + cellValue);
//                    } else {
//                        System.out.println("Column index out of bounds for row " + (targetRow + 1));
//                    }
//                    break; // Exit after reading the target row
//                }
//                rowIndex++;
//            }
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//
//        return "pts/licenseeBilling/processReading/processTable";
//    }

//          date 2025-08-26
//    @Transactional
//    @RequestMapping(value = "/processFiles", method = RequestMethod.GET)
//    public String readFiles(
//            @RequestParam("billCycle") String billCycle,
//            @RequestParam("division") String division,
//            @RequestParam("province") String province,
//            Model model) {
//
//        String fileName = "D:\\New folder (2)\\440\\LECO\\WPNL\\ANK\\ANK_F01\\211279951-LP 01.xls";
//
//        try (BufferedReader br = new BufferedReader(new FileReader(fileName))) {
//            String line;
//            int rowIndex = 2; // Track the current row index
//            int targetRow = 2; // Row index to read (0-based)
//            int targetColumn = 1; // Column index to read (0-based)
//
//            while ((line = br.readLine()) != null) {
//                String[] columns = line.split("\\t"); // Split by tab
//
//                // Print all columns for debugging
//                for (String col : columns) {
//                    System.out.print(col + "\t");
//                    System.out.print(" | ");
//                }
//                System.out.println();
//
////                // Check if the current row is the target row
////                if (rowIndex == targetRow) {
////                    System.out.println("+++++++++++++++++++++++++++++++++");
////                    if (targetColumn < columns.length) {
////                        String cellValue = columns[targetColumn];
////                        System.out.println("Value at row " + (targetRow + 1) + ", column " + (targetColumn + 1) + ": " + cellValue);
////
////                        // Check for matches
////                        if (cellValue.matches("[A-Z]\\d+")) {
////                            System.out.println("Matched pattern [A-Z]\\d+: " + cellValue);
////                        } else if (cellValue.matches("[A-Z]+")) {
////                            System.out.println("Matched pattern [A-Z]+: " + cellValue);
////                        } else {
////                            System.out.println("No match for the cell value: " + cellValue);
////                        }
////                    } else {
////                        System.out.println("Column index out of bounds for row " + (targetRow + 1));
////                    }
////                }
//
//
//
//                rowIndex++;
//            }
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//
//        return "pts/licenseeBilling/processReading/processTable";
//    }



    //process all files for a bill cycle=========================================
    @Transactional
    @RequestMapping(value = "/processFiles", method = RequestMethod.GET)
    public String readFiles(
            @RequestParam("billCycle") String billCycle,
            @RequestParam("division") String division,
            @RequestParam("province") String province,
            Model model) {
//        String basePath = ConfigProperties.getProperty("FILE_PATH");
//        String fullPath = basePath + billCycle + "\\"+division + "\\" + province+ "\\";

        String basePath = "D:\\New folder (2)";
        String fullPath = basePath + "\\" + billCycle + "\\" + division + "\\" + province + "\\";

        System.out.println("Full path for processing files: " + fullPath);
        try {

            System.out.println("Processing for bill cycle: " + billCycle +
                    ", division: " + division + ", province: " + province);

            //check if upload is locked and processing is not locked
            meterProcessDao.checkProcessAvailability(Long.parseLong(billCycle), division, province);

            //check for existing batch records (re processing)-------------------------------------------
            Boolean prevLog = meterProcessDao.checkPreviousReadingLogs(Long.parseLong(billCycle), division, province);
            if(prevLog) {
                System.out.println("Batch process already completed");
                meterProcessDao.clearExistingMeterReading(Long.parseLong(billCycle), division, province);
                System.out.println("All existing records cleared");
            }

            //----------------------------------------
            //  Process excel files & calculations
            //----------------------------------------

            System.out.println("Files processing started");
            List<MeterReading> meterReadingList = new ArrayList<>();
            try{
                excelMeterReader.extractExcelFiles(fullPath, billCycle);
                meterReadingList = excelMeterReader.getProcessedMeterReadings();
            }catch (Exception e) {
                System.out.println("Error in batch processing: " + e.getMessage());
                model.addAttribute("msg", ExceptionHandler.handleException(e));
                return "pts/licenseeBilling/processReading/processTable";
            }
            System.out.println("Files processing successfully");


            //save to LOG summary for batch processing------------------------------------
            MeterReadingLog mrLog = new MeterReadingLog();
            mrLog.setBillCycle(meterProcessDao.setBillCycle_relation(Long.parseLong(billCycle)));
            mrLog.setLicense(meterProcessDao.setLicense_relation(division));
            mrLog.setProvince(meterProcessDao.setProvince_relation(province));
            mrLog.setProcessedBy("SYSTEM");
            mrLog.setProcessedDate(new Date());
            mrLog.setFilesRead(excelMeterReader.getSuccessFileCount());
            mrLog.setFiles(excelMeterReader.getSuccessFileCount()+excelMeterReader.getErrorFileCount());
            if(excelMeterReader.getErrorFileCount() > 0) {
                mrLog.setStatus("WARN");
            } else {
                mrLog.setStatus("OK");
            }
            System.out.println("Log summary evaluated successfully");

            List<MeterReadingFileModel> meterReadingFileModelList = excelMeterReader.getMeterReadingFilesModelList();

            //Log error files----------------------------------------------------------
            System.out.println("Error files logging started");
            List<MeterReadingErrLog> meterReadingErrLogList = new ArrayList<>();
            for (MeterReadingFileModel meterReadingFileModel : meterReadingFileModelList) {
                if(Objects.equals(meterReadingFileModel.getStatus(), "ERROR")) {
                    MeterReadingErrLog mrLogError = new MeterReadingErrLog();
                    mrLogError.setSerialNo(meterReadingFileModel.getSerialNo());
                    mrLogError.setCebSerialNo(meterReadingFileModel.getCebSerialNo());
                    mrLogError.setReason(meterReadingFileModel.getErrorReason());
                    mrLogError.setUpdatedDate(new Date());
                    mrLogError.setAttempts(1L);
                    mrLogError.setStatus("UNSOLVED");
                    meterReadingErrLogList.add(mrLogError);
                }
            }
            System.out.println("Error files logged successfully");


            //MeterReading Energy Summary calculation-------------------------------
            System.out.println("Meter reading Energy Summary calculation started");
            List<MeterReadingEnergySummary> meterReadingEnergyList = meterProcessDao.calculateMeterReadingEnergySummary(meterReadingFileModelList, Long.parseLong(billCycle));
            System.out.println("Meter reading Energy Summary calculated successfully.");

            //Province energy calculation-----------------------------------------------
            System.out.println("Province Energy Summary calculation started");
            ProvinceEnergySummary totalEnergy = meterProcessDao.calculateProvinceEnergySummary(meterReadingFileModelList, Long.parseLong(billCycle), division, province);
            System.out.println("Province Energy Summary calculated successfully");


            //----------------------------------------
            //  DB writing
            //----------------------------------------
//            try{
//                System.out.println("DB writing started");
//                meterProcessDao.saveMeterReadingList(meterReadingList);// excel meter readings
//                System.out.println("Meter readings saved successfully");
//                MeterReadingLog mrl = meterProcessDao.saveMeterReadingLog(mrLog);// log summary
//                System.out.println("Log summary saved successfully");
//                meterProcessDao.saveMeterReadingLogErrorList(meterReadingErrLogList,mrl);// log errors
//                System.out.println("Log errors saved successfully");
//                meterProcessDao.saveMeterReadingEnergySummary(meterReadingEnergyList);//meter reading energy summary
//                System.out.println("Meter reading energy summary saved successfully");
//                meterProcessDao.saveProvinceEnergySummary(totalEnergy); //total energy summary
//                System.out.println("Total energy summary saved successfully");
//                System.out.println("DB writing completed successfully");
//                meterProcessDao.lockProvinceProcess(Long.parseLong(billCycle), division, province);
//                System.out.println("Province process locked");
//            }catch (Exception e) {
//                System.out.println("Error in DB writing: " + e.getMessage());
//                model.addAttribute("msg", "Error while saving to Database");
//                return "pts/licenseeBilling/processReading/processTable";
//            }
            meterProcessDao.saveMeterReadingMain( meterReadingList , mrLog ,  meterReadingErrLogList ,  meterReadingEnergyList , totalEnergy ,  billCycle ,  division , province);


            //returning result views--------------------------------------
            model.addAttribute("processSummary",meterProcessDao.getMeterReadingFileModelList());
            model.addAttribute("energySummary",totalEnergy);
            BillCycle bc = excelMeterReader.getBillCycleObj();
            Date prevDate = new SimpleDateFormat("yyyy-MM-dd").parse(bc.getBillYear() + "-" + bc.getBillMonth() + "-01");
            Date currntDate =  new SimpleDateFormat("yyyy-MM-dd").parse(bc.getBillYear() + "-" + bc.getBillMonth()+1 + "-01");
            model.addAttribute("billCycle", bc.getBillCycleNo());
            model.addAttribute("billYear", bc.getBillYear());
            model.addAttribute("billMonth",
                    java.time.Month.of(bc.getBillMonth().intValue()).name().toLowerCase().substring(0, 1).toUpperCase()
                            + java.time.Month.of(bc.getBillMonth().intValue()).name().toLowerCase().substring(1)
            );
            model.addAttribute("coincidentPeakDate", new SimpleDateFormat("yyyy-MM-dd").format(bc.getCoincidentPeakDate()));;
            model.addAttribute("coincidentPeakTime", new SimpleDateFormat("HH:mm:ss").format(bc.getCoincidentPeakDate()));
            model.addAttribute("currentDate", new SimpleDateFormat("yyyy-MM-dd").format(currntDate));
            model.addAttribute("previousDate", new SimpleDateFormat("yyyy-MM-dd").format(prevDate));

            return "pts/licenseeBilling/processReading/processTable";

        } catch (Exception e) {
            System.out.println("Endpoint error occurred: " + e.getMessage());
            model.addAttribute("msg", ExceptionHandler.handleException(e));
            return "pts/licenseeBilling/processReading/processTable";
        }
    }


//    @Transactional
//    @RequestMapping(value = "/processFiles", method = RequestMethod.GET)
//    public String readFiles(
//            @RequestParam("billCycle") String billCycle,
//            @RequestParam("division") String division,
//            @RequestParam("province") String province,
//            Model model) {
//
//        // Base folder path
//        String basePath = "D:\\New folder (2)";
//        String folderPath = basePath + "\\" + billCycle + "\\" + division + "\\" + province + "\\";
//        System.out.println("Full path for processing files: " + folderPath);
//
//        try {
//            System.out.println("new line in the try block");
//            File folder = new File(folderPath);
//            System.out.println("new line in the try block");
//            if (!folder.exists() || !folder.isDirectory()) {
//                System.out.println("new line in the try block");
//                throw new IOException("Folder not found: " + folderPath);
//            }
//            System.out.println("comes to the Process Folder method");
//            // process all files recursively
//            processFolder(folder);
//            System.out.println("end to the Process Folder method");
//
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            model.addAttribute("msg", ExceptionHandler.handleException(e));
//            return "pts/licenseeBilling/processReading/processTable";
//        }
//
//        return "pts/licenseeBilling/processReading/processTable";
//    }
//
//    // ✅ Recursively process folders
//    private void processFolder(File folder) throws Exception {
//        System.out.println("in the Process Folder method");
//        File[] files = folder.listFiles();
//        if (files == null) return;
//
//        for (File file : files) {
//            if (file.isDirectory()) {
//                processFolder(file); // recursive call
//            } else if (file.getName().toLowerCase().endsWith(".tsv")|| file.getName().toLowerCase().endsWith(".txt")||
//                    file.getName().toLowerCase().endsWith(".xls") || file.getName().toLowerCase().endsWith(".xlsx")) {
//                readTextFile(file);
//            }
//        }
//    }
//
//    // ✅ Read tab-delimited file
//    private void readTextFile(File file) throws Exception {
//        System.out.println("Reading file: " + file.getAbsolutePath());
//
//        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
//            String line;
//            while ((line = br.readLine()) != null) {
//                // Split by tab (and remove extra spaces)
//                String[] columns = line.trim().split("\\t+");
//
//                for (String col : columns) {
//                    System.out.print(col + "\t");
//                }
//                System.out.println();
//            }
//        }
//    }

//    @Transactional
//    @RequestMapping(value = "/processFiles", method = RequestMethod.GET)
//    public String readFiles(
//            @RequestParam("billCycle") String billCycle,
//            @RequestParam("division") String division,
//            @RequestParam("province") String province,
//            Model model) {
//
//        // Base folder path
//        //String basePath = "D:\\New folder (2)\\";
//        String basePath = "D:\\GIT\\PTS_NEW\\ReadingFiles\\ProcessFiles\\";
//        String folderPath = basePath + billCycle + "\\" + division + "\\" + province + "\\";
//        System.out.println("Full path for processing files: " + folderPath);
//
//        try {
//            System.out.println("new line in the try block");
//            File folder = new File(folderPath);
//            System.out.println("new line in the try block");
//            if (!folder.exists() || !folder.isDirectory()) {
//                System.out.println("new line in the try block");
//                throw new IOException("Folder not found: " + folderPath);
//            }
//            System.out.println("comes to the Process Folder method");
//            // process all files recursively
//            processFolder(folder);
//            System.out.println("end to the Process Folder method");
//
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            model.addAttribute("msg", ExceptionHandler.handleException(e));
//            return "pts/licenseeBilling/processReading/processTable";
//        }
//
//        return "pts/licenseeBilling/processReading/processTable";
//    }
//
//    // ✅ Recursively process folders
//    private void processFolder(File folder) throws Exception {
//        System.out.println("in the Process Folder method");
//        File[] files = folder.listFiles();
//        if (files == null) return;
//
//        for (File file : files) {
//            if (file.isDirectory()) {
//                processFolder(file); // recursive call
//            } else if (file.getName().toLowerCase().endsWith(".tsv")|| file.getName().toLowerCase().endsWith(".txt")||
//                    file.getName().toLowerCase().endsWith(".xls") || file.getName().toLowerCase().endsWith(".xlsx")) {
//                readTextFile(file);
//            }
//        }
//    }
//
//    // ✅ Read tab-delimited file
//    private void readTextFile(File file) throws Exception {
//        System.out.println("Reading file: " + file.getAbsolutePath());
//
//        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
//            String line;
//            while ((line = br.readLine()) != null) {
//                // Split by tab (and remove extra spaces)
//                String[] columns = line.trim().split("\\t+");
//
//                for (String col : columns) {
//                    System.out.print(col + "\t");
//                }
//                System.out.println();
//            }
//        }
//    }

    @Transactional
    @RequestMapping(value = "/viewInvoice", method = RequestMethod.GET)
    public String checkInvoice(
            @RequestParam("billCycle") String billCycle,
            @RequestParam("division") String division,
            Model model
    ){
        System.out.println("Checking invoice...");
        Invoice inv;
        BillCycle bc;
        List<InvoiceTxn> invoiceTXNlist;
        try{
            inv  = invoiceDao.checkInvoice(Long.parseLong(billCycle), division);
            bc = meterProcessDao.getBillCycle(Long.parseLong(billCycle));// for table properties
            invoiceTXNlist = invoiceDao.getInvoiceTxnList(Long.parseLong(billCycle), division);
        }catch(Exception e){
            System.out.println("Error checking invoice: " + e.getMessage());
            model.addAttribute("msg", "An error while checking invoice");
            return "ok";
        }

        if(inv == null){
            model.addAttribute("msg", "No invoice found for bill cycle " + billCycle + " :  " + division);
            return "pts/licenseeBilling/invoice/invoiceTable";
        }
        if(inv.getTotalInvoiceCharge() == null){
            model.addAttribute("msg", "No invoice found for bill cycle " + billCycle + " :  " + division);
            return "pts/licenseeBilling/invoice/invoiceTable";
        }
        model.addAttribute("billYear", bc.getBillYear());
        model.addAttribute("billMonth",
                java.time.Month.of(bc.getBillMonth().intValue()).name().toLowerCase().substring(0, 1).toUpperCase()
                        + java.time.Month.of(bc.getBillMonth().intValue()).name().toLowerCase().substring(1)
        );
        model.addAttribute("coincidentPeakDate", new SimpleDateFormat("yyyy-MM-dd").format(bc.getCoincidentPeakDate()));;
        model.addAttribute("coincidentPeakTime", new SimpleDateFormat("HH:mm:ss").format(bc.getCoincidentPeakDate()));
        model.addAttribute("recordedPeakDemand",bc.getRecordedPeakDemand());
        model.addAttribute("invoiceDate", new SimpleDateFormat("yyyy-MM-dd").format(inv.getInvoiceCreatedDate()));;
        model.addAttribute("invoice", inv);
        model.addAttribute("invoiceTXNlist", invoiceTXNlist);

        return "pts/licenseeBilling/invoice/invoiceTable";
    }

    @Transactional
    @RequestMapping(value = "/provEnergySum", method = RequestMethod.GET)
    public String showProvinceEnergySummary(
            @RequestParam("billCycle") String billCycle,
            @RequestParam("division") String division,
            Model model
    ) {
        List<ProvinceEnergySummaryModel> list;
        try {
            invoiceDao.prepareProvinceSummary(Long.parseLong(billCycle), division);
            list = invoiceDao.getProvinceEnergySummaryList();
            model.addAttribute("SummaryList", list);
        } catch (Exception e) {
            System.out.println("Error showing province energy summary: " + e.getMessage());
            model.addAttribute("msg", "No province energy summary found");
        }
        return "pts/licenseeBilling/billCalculate/provinceEnergySummaryTable";
    }

    @Transactional
    @RequestMapping(value = "/addInvoiceTxn", method = RequestMethod.POST)
    public String addInvoiceTxn(@RequestBody InvoiceTXNmodel invoiceTxnModel, Model model) {
        System.out.println("Adding invoice transactions list");
        try {
            //checking whether the invoice is already created or not
            Invoice inv = invoiceDao.checkInvoice(Long.parseLong(invoiceTxnModel.getBillCycleNo()), invoiceTxnModel.getLicenseCode());
            if (inv == null) {//create a new empty invoice
                System.out.println("Creating new empty invoice");
                Invoice invEmpty = new Invoice();
                InvoiceId invEmptyId = new InvoiceId();
                invEmptyId.setBillCycleNo(Long.parseLong(invoiceTxnModel.getBillCycleNo()));
                invEmptyId.setLicenseCode(invoiceTxnModel.getLicenseCode());
                invEmpty.setId(invEmptyId);
                invEmpty.setIsCalcClosed(0L);
                invoiceDao.saveInvoice(invEmpty);
            }

            InvoiceTxn txn = new InvoiceTxn();
            txn.setBillCycleNo(Long.parseLong(invoiceTxnModel.getBillCycleNo()));
            txn.setLicenseCode(invoiceTxnModel.getLicenseCode());
            txn.setTxnCode(invoiceTxnModel.getTxnCode());
            txn.setDescription(invoiceTxnModel.getDescription());
            txn.setCharge(invoiceTxnModel.getCharge());

            invoiceDao.addInvoiceTxn(txn);

            List<InvoiceTxn> invoiceTXNlist = invoiceDao.getInvoiceTxnList(Long.parseLong(invoiceTxnModel.getBillCycleNo()), invoiceTxnModel.getLicenseCode());
            model.addAttribute("invoiceTXNlist", invoiceTXNlist);

            return "pts/licenseeBilling/billCalculate/txnParamTable";

        } catch (Exception e) {
            return "Error adding invoice transactions: " + e.getMessage();
        }
    }

    @Transactional
    @RequestMapping(value = "/invoiceTxn", method = RequestMethod.PUT)
    public String editInvoiceTxn(@RequestBody InvoiceTXNmodel invoiceTxnModel,Model model) {

        List<InvoiceTxn> invoiceTXNlist = invoiceDao.getInvoiceTxnList(Long.parseLong(invoiceTxnModel.getBillCycleNo()), invoiceTxnModel.getLicenseCode());
        model.addAttribute("invoiceTXNlist", invoiceTXNlist);

        return "pts/licenseeBilling/billCalculate/txnParamTable";

    }

    @Transactional
    @RequestMapping(value = "/deleteInvoiceTxn", method = RequestMethod.POST)
    public String deleteInvoiceTxn(
         @RequestParam("billCycle") String billCycle,
         @RequestParam("division") String division,
         @RequestParam("txnId") String txnId,
         Model model)
    {
        System.out.println("Deleting invoice transaction with ID: " + txnId);
        invoiceDao.deleteInvoiceTxn(Long.parseLong(txnId));
        List<InvoiceTxn> invoiceTXNlist = invoiceDao.getInvoiceTxnList(Long.parseLong(billCycle), division);
        model.addAttribute("invoiceTXNlist", invoiceTXNlist);

        return "pts/licenseeBilling/billCalculate/txnParamTable";

    }

    @Transactional
    @RequestMapping(value = "/getInvoiceTxn", method = RequestMethod.GET)
    public String getInvoiceTxn(
            @RequestParam("billCycle") String billCycle,
            @RequestParam("division") String division,
            Model model) {
        System.out.println("Getting invoice transactions list");
        try {
            List<InvoiceTxn> invoiceTXNlist = invoiceDao.getInvoiceTxnList(Long.parseLong(billCycle), division);
            model.addAttribute("invoiceTXNlist", invoiceTXNlist);
            return "pts/licenseeBilling/billCalculate/txnParamTable";
        } catch (Exception e) {
            System.out.println("Error getting invoice transactions: " + e.getMessage());
            return "pts/licenseeBilling/billCalculate/txnParamTable";
        }
    }

    @Transactional
    @RequestMapping(value = "/calculateBill", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> calculateBill(
            @RequestParam("billCycle") String billCycle,
            @RequestParam("division") String division) {
        System.out.println("Checking if bill is finalized");
        Invoice invc = invoiceDao.checkInvoice(Long.parseLong(billCycle), division);
        if(invc!= null && invc.getIsCalcClosed()==1L){
            System.out.println("Bill is already finalized");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Bill is finalized, no changes allowed");
        }
        System.out.println("Checking province energy summary completion status");
        Boolean isCompleted = invoiceDao.isProvinceSummaryCompleted(Long.parseLong(billCycle), division);
        if (!isCompleted) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("All provinces are not finalized yet");
        }else{
            System.out.println("Province energy summary is completed");
            System.out.println("Bill calculation started");
            try {
                Invoice inv = invoiceDao.prepareInvoice(Long.parseLong(billCycle), division);
                System.out.println("Bill calculation completed");
                if (inv == null) {
                    return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                            .body("Error while calculating the bill");
                } else {
                    invoiceDao.saveInvoice(inv);
                    return ResponseEntity.status(HttpStatus.CREATED).body("Bill calculation completed");
                }
            } catch (Exception e) {
                System.out.println("Error during bill calculation: " + e.getMessage());
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                        .body(ExceptionHandler.handleException(e));
            }
        }
    }

    @Transactional
    @RequestMapping(value = "/finalizeBill", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> finalizeBill(
            @RequestParam("billCycle") String billCycle,
            @RequestParam("division") String division,
            Model model) {
        System.out.println("Finalizing the bill");
        try {
            invoiceDao.finalizeBill(Long.parseLong(billCycle), division);
            return ResponseEntity.status(HttpStatus.OK)
                    .body("Bill finalized successfully for bill cycle " + billCycle + " : " + division);
        } catch (Exception e) {
            System.out.println("Error bill finalizing: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error while finalizing the bill: " + e.getMessage());
        }
    }



//    @Transactional
//    @RequestMapping(value = "/printViewReading", method = RequestMethod.GET)
//    @ResponseBody
//    public void printViewReading(
//            @RequestParam("billCycle") String billCycle,
//            @RequestParam("division") String division,
//            HttpServletResponse response)
//    {
//        Connection conn = null;
//        System.out.println("+++++++++++++++++++++downloadEstimatecostCenter 1" );
//        try
//        {
//            HashMap<String, Object> hmParams = new HashMap<String, Object>();
//            hmParams.put("@billCycle", Integer.parseInt(billCycle));
//            hmParams.put("LicenseCode", division);
//
//            conn = getReportDbConnection();
//            String path1 = ConfigProperties.getReportPath() ;
//
//            File file = new File(path1  + "LECO_Energy_Bill.jrxml" );
//            System.out.println("downloadEstimatecostCenter 3" );
//
//            //if(!file.exists())
//            //     throw new RuntimeException("File " + file + " not found. The report design must be compiled first.");
//
//            System.out.println("text 32");
//            JasperPrint jasperPrint =null;
//            JRPdfExporter pdf=null;
//
//            String invoicePath = path1   +  "LECO_Energy_Bill.jrxml";
//
//            System.out.println("text 33" +invoicePath);
//            JasperReport jasperReport =  JasperCompileManager.compileReport(invoicePath);
//            System.out.println("Executing SQL for report: " + jasperReport.getQuery().getText());
//            // Set up JasperReports font
//            System.out.println("text 34" );
//
//            System.out.println("jasperReport"+ jasperReport);
//            System.out.println("hmParams"+ hmParams);
//            System.out.println("conn"+ conn);
//
//            jasperPrint = JasperFillManager.fillReport(jasperReport, hmParams, conn);
//
//            System.out.println("text 35" );
//            pdf = new JRPdfExporter();
//            System.out.println("downloadEstimatecostCenter 4"  );
//
//
//            System.out.println("text 37" );
//
//            Calendar calendar = Calendar.getInstance();
//
//            pdf.setParameter(JRPdfExporterParameter.CHARACTER_ENCODING, "UTF-8");
//            String pdfPath= path1 + billCycle+"Energy_Bill.pdf";
//
//            //File pdfFile = new File( pdfPath);
//            System.out.println("pdfPath" +pdfPath );
//            pdf.setParameter(JRPdfExporterParameter.JASPER_PRINT, jasperPrint);
//            pdf.setParameter(JRPdfExporterParameter.OUTPUT_FILE_NAME,  pdfPath);
//            pdf.exportReport();
//            System.out.println("downloadEstimatecostCenter 5"+pdfPath );
//
//
////            File pdfFile = new File( pdfPath);
////            if (pdfFile.exists())
////            {
////                response.setContentType("application/pdf");
////                response.setHeader("Content-Disposition", "inline; filename=\"billCycle+\"Energy_Bill.pdf\"\"");
////                response.setContentLengthLong(pdfFile.length());
////
////                try (InputStream in = new FileInputStream(pdfFile);
////                     OutputStream out = response.getOutputStream()) {
////                    byte[] buffer = new byte[8192];
////                    int bytesRead;
////                    while ((bytesRead = in.read(buffer)) != -1) {
////                        out.write(buffer, 0, bytesRead);
////                    }
////                }
////
////
////            }
//        }
//
//
//        catch (Exception ex)
//        {
//            ex.printStackTrace();
//        }
//    	/*finally
//    	{
//	        System.out.println("Joboxxxxxxxxx conn.close();xxxxx dclose");
//	        if(conn!=null)
//	            conn.close();
//        }*/
//
//    }

    @Transactional
    @RequestMapping(value = "/printInv", method = RequestMethod.GET)
    @ResponseBody
    public void printInvoice(
            @RequestParam("billCycle") String billCycle,
            @RequestParam("division") String division,
            HttpServletResponse response)
    {
        Connection conn = null;

        try
        {
            HashMap<String, Object> hmParams = new HashMap<String, Object>();
            hmParams.put("@billCycle", Integer.parseInt(billCycle));
            hmParams.put("LicenseCode", division);

            conn = getReportDbConnection();
            String path1 = ConfigProperties.getProperty("REPORT_PATH") ;

            File file = new File(path1  + "Bulk_Bill_Licence_H.jrxml" );
            System.out.println("downloadEstimatecostCenter 3" );

            //if(!file.exists())
            //     throw new RuntimeException("File " + file + " not found. The report design must be compiled first.");

            System.out.println("text 32");
            JasperPrint jasperPrint =null;
            JRPdfExporter pdf=null;

            String invoicePath = path1   +  "Bulk_Bill_Licence_H.jrxml";

            System.out.println("text 33" +invoicePath);
            JasperReport jasperReport =  JasperCompileManager.compileReport(invoicePath);
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


            System.out.println("text 37" );

            Calendar calendar = Calendar.getInstance();

            pdf.setParameter(JRPdfExporterParameter.CHARACTER_ENCODING, "UTF-8");
            String pdfPath= path1 +"439.pdf";

            //File pdfFile = new File( pdfPath);
            System.out.println("pdfPath" +pdfPath );
            pdf.setParameter(JRPdfExporterParameter.JASPER_PRINT, jasperPrint);
            pdf.setParameter(JRPdfExporterParameter.OUTPUT_FILE_NAME,  pdfPath);
            pdf.exportReport();
            System.out.println("downloadEstimatecostCenter 5"+pdfPath );


            File pdfFile = new File( pdfPath);
            if (pdfFile.exists())
            {
                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "inline; filename=\"439.pdf\"");
                response.setContentLengthLong(pdfFile.length());

                try (InputStream in = new FileInputStream(pdfFile);
                     OutputStream out = response.getOutputStream()) {
                    byte[] buffer = new byte[8192];
                    int bytesRead;
                    while ((bytesRead = in.read(buffer)) != -1) {
                        out.write(buffer, 0, bytesRead);
                    }
                }


            }
        }


        catch (Exception ex)
        {
            ex.printStackTrace();
        }
    	/*finally
    	{
	        System.out.println("Joboxxxxxxxxx conn.close();xxxxx dclose");
	        if(conn!=null)
	            conn.close();
        }*/

    }

 //   -----------------------------------------------------
//    print engry bill
    //-----------------------------------------------------
 @Transactional
 @RequestMapping(value = "/printEnergyBill", method = RequestMethod.GET)
 @ResponseBody
 public void printEnergyBill(
         @RequestParam("billCycle") String billCycle,
         @RequestParam("division") String division,
         HttpServletResponse response)
 {
     Connection conn = null;

     try
     {
         HashMap<String, Object> hmParams = new HashMap<String, Object>();
         hmParams.put("@billCycle", Integer.parseInt(billCycle));
         hmParams.put("LicenseCode", division);

         conn = getReportDbConnection();
         String path1 = ConfigProperties.getProperty("REPORT_PATH") ;

         File file = new File(path1  + "LECO_Energy_Bill.jrxml" );
         System.out.println("downloadEstimatecostCenter 3" );

         //if(!file.exists())
         //     throw new RuntimeException("File " + file + " not found. The report design must be compiled first.");

         System.out.println("text 32");
         JasperPrint jasperPrint =null;
         JRPdfExporter pdf=null;

         String invoicePath = path1   +  "LECO_Energy_Bill.jrxml";

         System.out.println("text 33" +invoicePath);
         JasperReport jasperReport =  JasperCompileManager.compileReport(invoicePath);
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


         System.out.println("text 37" );

         Calendar calendar = Calendar.getInstance();

         pdf.setParameter(JRPdfExporterParameter.CHARACTER_ENCODING, "UTF-8");
         String pdfPath= path1 +"439_Energy_Bill.pdf";

         //File pdfFile = new File( pdfPath);
         System.out.println("pdfPath" +pdfPath );
         pdf.setParameter(JRPdfExporterParameter.JASPER_PRINT, jasperPrint);
         pdf.setParameter(JRPdfExporterParameter.OUTPUT_FILE_NAME,  pdfPath);
         pdf.exportReport();
         System.out.println("downloadEstimatecostCenter 5"+pdfPath );


         File pdfFile = new File( pdfPath);
         if (pdfFile.exists())
         {
             response.setContentType("application/pdf");
             response.setHeader("Content-Disposition", "inline; filename=\"439_Energy_Bill.pdf\"");
             response.setContentLengthLong(pdfFile.length());

             try (InputStream in = new FileInputStream(pdfFile);
                  OutputStream out = response.getOutputStream()) {
                 byte[] buffer = new byte[8192];
                 int bytesRead;
                 while ((bytesRead = in.read(buffer)) != -1) {
                     out.write(buffer, 0, bytesRead);
                 }
             }


         }
     }


     catch (Exception ex)
     {
         ex.printStackTrace();
     }
    	/*finally
    	{
	        System.out.println("Joboxxxxxxxxx conn.close();xxxxx dclose");
	        if(conn!=null)
	            conn.close();
        }*/

 }

//    @Transactional
//    @RequestMapping(value = "/printInv", method = RequestMethod.GET)
//    @ResponseBody
//    public void printInvoice(
//            @RequestParam("billCycle") String billCycle,
//            @RequestParam("division") String division,
//            HttpServletResponse response) {
//        Connection conn = null;
//        try {
//            // Establish database connection
//            Class.forName("oracle.jdbc.driver.OracleDriver");
//            conn = DriverManager.getConnection(
//                    "jdbc:oracle:thin:@10.128.0.56:1521:hqorad1",
//                    "pstdb",
//                    "devPSTDB"
//            );
//
//            // Set up parameters
//            Map<String, Object> parameters = new HashMap<>();
//            parameters.put("billCycle", Long.parseLong(billCycle));
//            parameters.put("License", division);
//
//            // Compile and fill sub-report first
//            String tailPath = "D:/GIT/PTS_NEW/Reports/LECO_BILL_TAIL.jrxml";
//            JasperReport subReport = JasperCompileManager.compileReport(tailPath);
//            parameters.put("SUBREPORT", subReport);
//
//            // Compile and fill main report
//            String mainPath = "D:/GIT/PTS_NEW/Reports/LECO_BILL_HEAD.jrxml";
//            JasperReport mainReport = JasperCompileManager.compileReport(mainPath);
//            JasperPrint jasperPrint = JasperFillManager.fillReport(mainReport, parameters, conn);
//
//            // Export to PDF
//            response.setContentType("application/pdf");
//            response.setHeader("Content-Disposition", "attachment; filename=\"invoice_" + billCycle + "_" + division + ".pdf\"");
//
//            JRPdfExporter exporter = new JRPdfExporter();
//            exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
//            exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, response.getOutputStream());
//            exporter.exportReport();
//
//        } catch (Exception e) {
//            System.out.println(e.getMessage());
//        } finally {
//            if (conn != null) {
//                try {
//                    conn.close();
//                } catch (Exception e) {
//                    System.out.println(e.getMessage());
//                }
//            }
//        }
//    }
}
