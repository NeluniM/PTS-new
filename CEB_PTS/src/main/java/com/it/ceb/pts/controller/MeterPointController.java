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

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRPdfExporterParameter;
import net.sf.jasperreports.engine.util.JRLoader;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;



import java.io.File;
import java.io.FileInputStream;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;
import org.jboss.logging.Logger;

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
    private MeterProcessDao meterDao;

    private static final Logger LOGGER = Logger.getLogger(MeterPointController.class);



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
        LOGGER.info("get MeterReadings method called");
        List<MeterPointModel> meterPoints = new ArrayList<>();
        try {
            List<MeterReadingRecordModel> meterReadings = meterReadingDao.getMeterReadings(billCycle, province, division);
            meterPoints = meterReadingDao.getMeterPoints(province, division);
            LOGGER.info("MeterReadings & MeterPoints fetched successfully");

            //getting serial no's to get the meter reading summary detail
            List<String> serialNumbers = meterPoints.stream()
                    .map(MeterPointModel::getSerialNo)
                    .collect(Collectors.toList());
            List<MeterReadingEnergySummary> energySummaries = meterReadingDao.getMeterReadingEnergySummary(billCycle, serialNumbers);
            Map<String, MeterReadingEnergySummary> energySummaryMap = energySummaries.stream()
                    .collect(Collectors.toMap(MeterReadingEnergySummary::getSerialNo, summary -> summary));
            LOGGER.info("MeterReadingEnergySummary s fetched successfully");

            // Attach readings to corresponding meter points
            LOGGER.info("Attaching meter readings to corresponding meter points");
            for (MeterReadingRecordModel reading : meterReadings) {
                for (MeterPointModel point : meterPoints) {
                    if (point.getId().equals(reading.getPointId())) {
                        point.getMeterReadingRecordModels().add(reading);
                        point.setStatus("Success");
                    }
                }
            }
            // Meter reading energy summaries attaching to meter points (separately to avoid duplication)
            LOGGER.info("Energy summary details preparing");
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
            LOGGER.info("Checking for error meters");
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
                LOGGER.info("Getting details for table header");
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
                LOGGER.info("Error in Getting details for table header: " + e.getMessage());
                //e.printStackTrace();//
            }
            model.addAttribute("thisBillCycle",billCycle);
            model.addAttribute("meterReadingFileList", meterPoints);

        } catch (Exception e) {
            model.addAttribute("msg", "An error occurred while fetching meter readings: ");
            LOGGER.info(e.getMessage());
            //e.printStackTrace();//
        }
        return "pts/licenseeBilling/viewReading/meterReadingTable";
    }

    /*testing method*/
    @Transactional
    @RequestMapping(value = "/processFilesTest", method = RequestMethod.GET)
    public String readFiles(
            @RequestParam("billCycle") String billCycle,
            @RequestParam("division") String division,
            @RequestParam("province") String province,
            Model model) {
        try
        {
            String basePath = ConfigProperties.getReadingFilePath();

            String fileName = basePath+"\\440\\LECO\\SP1L\\AMB\\AMB_T01\\211279918-BH.xls";
            List<MeasureCell> cellAddresses= meterDao.getMeasureCellById("14", "EP");
            System.out.println("@@@@@@@@@@file reading for testing with fileName"+fileName);
	        /*try (BufferedReader br = new BufferedReader(new FileReader(fileName))) {
	            String line;
	            while ((line = br.readLine()) != null) {
	                // Split by tab (and remove extra spaces)
	                String[] columns = line.trim().split("\\t+");

	                for (String col : columns) {
	                    System.out.print(col + "\t");
	                }
	                System.out.println();
	            }
	        } catch (IOException e) {
	            e.printStackTrace();
	        }*/
            for (MeasureCell cell : cellAddresses) {
                //BigDecimal val;
                System.out.println("model column value "+cell.getReadCol());
                System.out.println("model row value "+cell.getReadRow());
                if(cell.getReadRow()==null && cell.getReadCol()==null)
                {
                    System.out.println("no any cell to read");

                }
                else if(cell.getReadRow()==null)
                {
                    System.out.println("reading last row........");
                    String cellVal = excelMeterReader.readLastRowOfColumn(fileName, cell.getReadCol());
                    System.out.println("read last row"+cellVal);
                }
                else
                {
                    System.out.println("reading cel value.............");
                    String cellVal = excelMeterReader.readCellValue(fileName,  cell.getReadCol(), cell.getReadRow().intValue());
                    System.out.println("read cell value"+cellVal);
                }
	            /*if (cell.getCell().matches("[A-Z]\\d+")) {
	            	System.out.println("cell value is given ");
	                //val = CurrentReadingCalc(readSpecificCell(sheet, cell.getCell()) , cell.getValueCalc());
	            } else if (cell.getCell().matches("[A-Z]")) {
	            	System.out.println("reading last roiw ");
	                //val = CurrentReadingCalc(readLastCellInColumn(sheet, cell.getCell()), cell.getValueCalc());
	            } else {
	                //throw new ConfigException("Invalid cell address format");
	            }*/

                //readings.put(cell.getMeasureId(), val);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }



        return "pts/licenseeBilling/processReading/processTable";
    }








    //process all files for a bill cycle original=========================================
    @Transactional
    @RequestMapping(value = "/processFiles", method = RequestMethod.GET)
    public String readFilesOri(
            @RequestParam("billCycle") String billCycle,
            @RequestParam("division") String division,
            @RequestParam("province") String province,
            Model model) {
        //String basePath = ConfigProperties.getReportPath();
        String basePath = ConfigProperties.getReadingFilePath();
        String fullPath = basePath +"\\"+ billCycle + "\\"+division + "\\" + province+ "\\";
        LOGGER.info("Full path for processing files: " + fullPath);
        try {

            LOGGER.info("Processing for bill cycle: " + billCycle +
                    ", division: " + division + ", province: " + province);

            //check if upload is locked and processing is not locked
            meterProcessDao.checkProcessAvailability(Long.parseLong(billCycle), division, province);

            //check for existing batch records (re processing)-------------------------------------------
            Boolean prevLog = meterProcessDao.checkPreviousReadingLogs(Long.parseLong(billCycle), division, province);
            if(prevLog) {
                LOGGER.info("Batch process already completed");
                meterProcessDao.clearExistingMeterReading(Long.parseLong(billCycle), division, province);
                LOGGER.info("All existing records cleared");
            }

            //----------------------------------------
            //  Process excel files & calculations
            //----------------------------------------

            LOGGER.info("Files processing started");
            List<MeterReading> meterReadingList = new ArrayList<>();
            try{
                excelMeterReader.extractExcelFiles(fullPath, billCycle);
                meterReadingList = excelMeterReader.getProcessedMeterReadings();
            }catch (Exception e) {
                LOGGER.info("Error in batch processing: " + e.getMessage());
                model.addAttribute("msg", ExceptionHandler.handleException(e));
                return "pts/licenseeBilling/processReading/processTable";
            }
            LOGGER.info("Files processing successfully");


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
            LOGGER.info("Log summary evaluated successfully");

            List<MeterReadingFileModel> meterReadingFileModelList = excelMeterReader.getMeterReadingFilesModelList();

            //Log error files----------------------------------------------------------
            LOGGER.info("Error files logging started");
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
            LOGGER.info("Error files logged successfully");


            //MeterReading Energy Summary calculation-------------------------------
            LOGGER.info("Meter reading Energy Summary calculation started");
            List<MeterReadingEnergySummary> meterReadingEnergyList = meterProcessDao.calculateMeterReadingEnergySummary(meterReadingFileModelList, Long.parseLong(billCycle));
            LOGGER.info("Meter reading Energy Summary calculated successfully.");

            //Province energy calculation-----------------------------------------------
            LOGGER.info("Province Energy Summary calculation started");
            ProvinceEnergySummary totalEnergy = meterProcessDao.calculateProvinceEnergySummary(meterReadingFileModelList, Long.parseLong(billCycle), division, province);
            LOGGER.info("Province Energy Summary calculated successfully");


            //----------------------------------------
            //  DB writing
            //----------------------------------------
            try{
                LOGGER.info("DB writing started");
                meterProcessDao.saveMeterReadings(meterReadingList,
                        meterReadingEnergyList,
                        totalEnergy,
                        Long.parseLong(billCycle),
                        division,
                        province);
                //meterProcessDao.saveMeterReadingList(meterReadingList);// excel meter readings
                LOGGER.info("Meter readings saved successfully");
                MeterReadingLog mrl = meterProcessDao.saveMeterReadingLog(mrLog);// log summary
                LOGGER.info("Log summary saved successfully");
                meterProcessDao.saveMeterReadingLogErrorList(meterReadingErrLogList,mrl);// log errors
                LOGGER.info("Log errors saved successfully");
                //meterProcessDao.saveMeterReadingEnergySummary(meterReadingEnergyList);//meter reading energy summary
                LOGGER.info("Meter reading energy summary saved successfully");
                //meterProcessDao.saveProvinceEnergySummary(totalEnergy); //total energy summary
                LOGGER.info("Total energy summary saved successfully");
                LOGGER.info("DB writing completed successfully");
                //meterProcessDao.lockProvinceProcess(Long.parseLong(billCycle), division, province);
                LOGGER.info("Province process locked");
            }catch (Exception e) {
                LOGGER.info("Error in DB writing: " + e.getMessage());
                model.addAttribute("msg", "Error while saving to Database");
                return "pts/licenseeBilling/processReading/processTable";
            }


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
            LOGGER.info("Endpoint error occurred: " + e.getMessage());
            model.addAttribute("msg", ExceptionHandler.handleException(e));
            return "pts/licenseeBilling/processReading/processTable";
        }
    }


    @Transactional
    @RequestMapping(value = "/viewInvoice", method = RequestMethod.GET)
    public String checkInvoice(
            @RequestParam("billCycle") String billCycle,
            @RequestParam("division") String division,
            Model model
    ){
        LOGGER.info("Checking invoice...");
        Invoice inv;
        BillCycle bc;
        List<InvoiceTxn> invoiceTXNlist;
        try{
            bc = meterProcessDao.getBillCycle(Long.parseLong(billCycle));// for table properties
            LOGGER.info("billcycle@@"+bc);
            if(bc==null)
            {
                model.addAttribute("msg", "Bill cycle no does not exist " + billCycle + " :  " + division);
                return "pts/licenseeBilling/invoice/invoiceTable";
            }
            inv  = invoiceDao.checkInvoice(Long.parseLong(billCycle), division);
            LOGGER.info("invoice@@"+inv);
            if(inv == null){
                model.addAttribute("msg", "No invoice found for bill cycle " + billCycle + " :  " + division);
                return "pts/licenseeBilling/invoice/invoiceTable";
            }
            invoiceTXNlist = invoiceDao.getInvoiceTxnList(Long.parseLong(billCycle), division);
            LOGGER.info("invoiceTXNlist@@"+invoiceTXNlist);
            if(inv.getTotalInvoiceCharge() == null){
                model.addAttribute("msg", "No invoice found for bill cycle " + billCycle + " :  " + division);
                return "pts/licenseeBilling/invoice/invoiceTable";
            }
        }catch(Exception e){
            e.printStackTrace();
            LOGGER.info("Error checking invoice: " + e.getMessage());
            model.addAttribute("msg", "An error while checking invoice");
            return "ok";
        }

        /*if(inv == null){
            model.addAttribute("msg", "No invoice found for bill cycle " + billCycle + " :  " + division);
            return "pts/licenseeBilling/invoice/invoiceTable";
        }
        if(inv.getTotalInvoiceCharge() == null){
            model.addAttribute("msg", "No invoice found for bill cycle " + billCycle + " :  " + division);
            return "pts/licenseeBilling/invoice/invoiceTable";
        }*/
        model.addAttribute("billYear", bc.getBillYear());
        model.addAttribute("billMonth",
                java.time.Month.of(bc.getBillMonth().intValue()).name().toLowerCase().substring(0, 1).toUpperCase()
                        + java.time.Month.of(bc.getBillMonth().intValue()).name().toLowerCase().substring(1)
        );
        model.addAttribute("coincidentPeakDate", new SimpleDateFormat("yyyy-MM-dd").format(bc.getCoincidentPeakDate()));;
        model.addAttribute("coincidentPeakTime", new SimpleDateFormat("HH:mm:ss").format(bc.getCoincidentPeakDate()));
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
            LOGGER.info("Error showing province energy summary: " + e.getMessage());
            model.addAttribute("msg", "No province energy summary found");
        }
        return "pts/licenseeBilling/billCalculate/provinceEnergySummaryTable";
    }

    @Transactional
    @RequestMapping(value = "/addInvoiceTxn", method = RequestMethod.POST)
    public String addInvoiceTxn(@RequestBody InvoiceTXNmodel invoiceTxnModel, Model model) {
        LOGGER.info("Adding invoice transactions list");
        try {
            //checking whether the invoice is already created or not
            Invoice inv = invoiceDao.checkInvoice(Long.parseLong(invoiceTxnModel.getBillCycleNo()), invoiceTxnModel.getLicenseCode());
            if (inv == null) {//create a new empty invoice
                LOGGER.info("Creating new empty invoice");
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
        LOGGER.info("Deleting invoice transaction with ID: " + txnId);
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
        LOGGER.info("Getting invoice transactions list");
        try {
            List<InvoiceTxn> invoiceTXNlist = invoiceDao.getInvoiceTxnList(Long.parseLong(billCycle), division);
            model.addAttribute("invoiceTXNlist", invoiceTXNlist);
            return "pts/licenseeBilling/billCalculate/txnParamTable";
        } catch (Exception e) {
            LOGGER.info("Error getting invoice transactions: " + e.getMessage());
            return "pts/licenseeBilling/billCalculate/txnParamTable";
        }
    }

    @Transactional
    @RequestMapping(value = "/calculateBill", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<String> calculateBill(
            @RequestParam("billCycle") String billCycle,
            @RequestParam("division") String division) {
        LOGGER.info("Checking if bill is finalized");
        Invoice invc = invoiceDao.checkInvoice(Long.parseLong(billCycle), division);
        if(invc!= null && invc.getIsCalcClosed()==1L){
            LOGGER.info("Bill is already finalized");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Bill is finalized, no changes allowed");
        }
        LOGGER.info("Checking province energy summary completion status");
        Boolean isCompleted = invoiceDao.isProvinceSummaryCompleted(Long.parseLong(billCycle), division);
        if (!isCompleted) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("All provinces are not finalized yet");
        }else{
            LOGGER.info("Province energy summary is completed");
            LOGGER.info("Bill calculation started");
            try {
                Invoice inv = invoiceDao.prepareInvoice(Long.parseLong(billCycle), division);
                LOGGER.info("Bill calculation completed");
                if (inv == null) {
                    return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                            .body("Error while calculating the bill");
                } else {
                    invoiceDao.saveInvoice(inv);
                    return ResponseEntity.status(HttpStatus.CREATED).body("Bill calculation completed");
                }
            } catch (Exception e) {
                LOGGER.info("Error during bill calculation: " + e.getMessage());
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
        LOGGER.info("Finalizing the bill");
        try {
            invoiceDao.finalizeBill(Long.parseLong(billCycle), division);
            return ResponseEntity.status(HttpStatus.OK)
                    .body("Bill finalized successfully for bill cycle " + billCycle + " : " + division);
        } catch (Exception e) {
            LOGGER.info("Error bill finalizing: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error while finalizing the bill: " + e.getMessage());
        }
    }

    /*@Transactional
    @RequestMapping(value = "/printInv", method = RequestMethod.GET)
    @ResponseBody
    public void printInvoice(
            @RequestParam("billCycle") String billCycle,
            @RequestParam("division") String division,
            HttpServletResponse response) {
        Connection conn = null;
        LOGGER.info("calling printInvoice");
        try {
            // Establish database connection
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(
                    "jdbc:oracle:thin:@10.128.0.56:1521:hqorad1",
                    "pstdb",
                    "devPSTDB"
            );

            LOGGER.info("bill cycle "+Long.parseLong(billCycle));
            LOGGER.info("division "+division);
            // Set up parameters
            Map<String, Object> parameters = new HashMap<>();
            parameters.put("@billCycle", Long.parseLong(billCycle));
            parameters.put("LicenseCode", division);

            // Compile and fill sub-report first
            String reportPath = ConfigProperties.getReportPath() ;
            String reportFile = reportPath+"Bulk_Bill_Licence_H.jrxml";
            LOGGER.info("reportPath "+reportPath);
            LOGGER.info("reportFile "+reportFile);
            //JasperReport jasperReport = JasperCompileManager.compileReport(getClass().getResourceAsStream(reportFile));
            JasperReport jasperReport = JasperCompileManager.compileReport(reportFile);


            // Compile and fill main report

            //JasperReport mainReport = JasperCompileManager.compileReport(mainPath);
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, conn);

            String reportPdfName = reportPath+"Invoice_"+billCycle+".pdf";
            // Export to PDF
            //response.setContentType("application/pdf");
            //response.setHeader("Content-Disposition", "attachment; filename=\"" + reportOutName  + ".pdf\"");

            JRPdfExporter exporter = new JRPdfExporter();
            exporter.setParameter(JRPdfExporterParameter.CHARACTER_ENCODING, "UTF-8");
            exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
            exporter.setParameter(JRPdfExporterParameter.OUTPUT_FILE_NAME, reportPdfName);
            //exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, response.getOutputStream());
            exporter.exportReport();

            try {
                response.setContentType("application/pdf");
                //response.addHeader("Content-Disposition", "attachment; filename="+pdfPath);
                response.setHeader("Content-Disposition", "attachment; filename=\"" + reportPdfName  + ".pdf\"");

                InputStream inputStream = new FileInputStream(new File( reportPdfName)); //load the file
                IOUtils.copy(inputStream, response.getOutputStream());
                response.flushBuffer();
                LOGGER.info("pdfPath" +reportPdfName );

            } catch (FileNotFoundException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

        } catch (Exception e) {
           e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    LOGGER.info(e.getMessage());
                }
            }
        }
    }*/

    public void generateReportPDF (HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)throws Exception {
        byte[] bytes = null;
        bytes = JasperRunManager.runReportToPdf(jasperReport,parameters,conn);
        resp.reset();
        resp.resetBuffer();
        resp.setContentType("application/pdf");
        resp.setContentLength(bytes.length);
        ServletOutputStream ouputStream = resp.getOutputStream();
        ouputStream.write(bytes, 0, bytes.length);
        ouputStream.flush();
        ouputStream.close();
    }

    private JasperReport getCompiledFile(String jrxmlFile,String jasperFile) throws JRException {
        File reportFile = new File(	jasperFile);
        JasperCompileManager.compileReportToFile(jrxmlFile,jasperFile);
        JasperReport jasperReport = (JasperReport) JRLoader.loadObjectFromFile(reportFile.getPath());
        return jasperReport;
        //return null;
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
            String path1 = ConfigProperties.getReportPath() ;

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
    /*
    @Transactional
    @RequestMapping(value = "/printInv", method = RequestMethod.GET)
    @ResponseBody
    public void printInvoice(
            @RequestParam("billCycle") String billCycle,
            @RequestParam("division") String division,
            HttpServletResponse response) {
		Connection conn = null;
		boolean canPrint = false;

		try
		{
			conn = getReportDbConnection();
			LOGGER.info("create conn printInvoicePaidCopy");

			Map<String, Object> parameters = new HashMap<>();
            parameters.put("@billCycle", Long.parseLong(billCycle));
            parameters.put("LicenseCode", division);

			String REPORT_DIRECTORY = ConfigProperties.getReportPath() ;
			LOGGER.info("REPORT_DIRECTORY"+REPORT_DIRECTORY);

			//gg
			String jrxmlFile = REPORT_DIRECTORY+"Bulk_Bill_Licence_H.jrxml";
			String jasperFile = REPORT_DIRECTORY+"Bulk_Bill_Licence_H.jasper";
			LOGGER.info("jrxmlFile"+jrxmlFile);

			JasperReport jasperReport = getCompiledFile(jrxmlFile,jasperFile);
			generateReportPDF(response, parameters, jasperReport, conn);

			conn.close();
			LOGGER.info("close conn printInvoicePaidCopy");



		}
		catch (Exception sqlExp)
		{
			sqlExp.printStackTrace();
		} finally
		{
			if (conn != null)
			{
				try
				{
					conn.close();
					conn = null;
					LOGGER.info("close conn printInvoicePaidCopy finally");
				}
				catch (SQLException e)
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}

		}

	}
    ****/


    /*
    @GetMapping("/printInv")
    public ResponseEntity<byte[]> printInvoice(@RequestParam String division, @RequestParam String billCycle) throws IOException {
        // Load or generate the PDF
        byte[] pdfBytes = ...;

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_PDF);
        headers.setContentDispositionFormData("inline", "invoice.pdf");

        return ResponseEntity.ok()
                .headers(headers)
                .body(pdfBytes);
    }*/




}





