package com.it.ceb.pts.controller;

import com.it.ceb.pts.domain.*;
import com.it.ceb.pts.repo.*;
import com.it.ceb.util.common.ConfigProperties;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
public class SearchController {
    @Autowired
    private MeterReadingDao meterReadingDao;
    @Autowired
    private MeterPointDao meterPointDao;
    @Autowired
    private FileUploadHeaderDao fileUploadHeaderDao;
    @Autowired
    private MeterReadingEnergySummaryDao meterReadingEnergySummaryDao;
    @Autowired
    private MeasureDao measureDao;
    @Autowired
    private BillCycleDao billCycleDao;



    //=================================================================
    //							Meter Search
    //=================================================================

    //Search meter readings=============================================

    // Show the empty search form
    @GetMapping("/meterSearch")
    public String showSearchForm(
            @RequestParam(value = "billCycle", required = false) String billCycle,
            @RequestParam(value = "serialNo", required = false) String serialNo,
            Model model) {

        MeterSearchModel meterSearchModel = new MeterSearchModel();

        if (billCycle == null || billCycle.trim().isEmpty()) {
            Long currentBillCycleNo = billCycleDao.getCurrentBillCycleNo();
            if (currentBillCycleNo != null) {
                meterSearchModel.setBillCycle(currentBillCycleNo.toString());
                model.addAttribute("currentBillCycle", currentBillCycleNo.toString());
            }
        } else {
            meterSearchModel.setBillCycle(billCycle);
        }

        if (serialNo != null && !serialNo.trim().isEmpty() && meterSearchModel.getBillCycle() != null) {
            meterSearchModel.setSerialNo(serialNo);
            return searchBySerialNo(meterSearchModel, model);
        } else {
            model.addAttribute("meterSearchModel", meterSearchModel);
            model.addAttribute("searchPerformed", false);
            return "pts/licenseeBilling/meterSearch/meterSearch";
        }
    }


    @PostMapping("/findMeterSearch")
    @Transactional
    public String searchBySerialNo(@ModelAttribute("meterSearchModel") MeterSearchModel meterSearchModel, Model model) {
        model.addAttribute("searchPerformed", true);
        try {
            String serialNo = meterSearchModel.getSerialNo();
            String billCycle = meterSearchModel.getBillCycle();
            String licenseCode = meterSearchModel.getLicenseCode();
            String provinceCode = meterSearchModel.getProvinceCode();

            if (licenseCode == null || provinceCode == null) {
                MeterPoint meterPoint = meterPointDao.findBySerialNo(serialNo);
                if (meterPoint != null) {
                    if (licenseCode == null) licenseCode = meterPoint.getLicenseCode();
                    if (provinceCode == null && meterPoint.getProvince2() != null) {
                        provinceCode = meterPoint.getProvince2().getProvinceCode();
                    }
                }
            }

            boolean isBillCycleCurrent = false;
            try {
                if (billCycle != null && !billCycle.trim().isEmpty()) {
                    BillCycle bc = billCycleDao.findByBillCycleNo(Long.parseLong(billCycle));
                    isBillCycleCurrent = (bc != null && bc.getIsCurrent() != null && bc.getIsCurrent() == 1L);
                }
            } catch (Exception e) {
                isBillCycleCurrent = false;
            }
            model.addAttribute("isBillCycleCurrent", isBillCycleCurrent);

            boolean isReadingProcessLocked = true;
            try {
                if (billCycle != null && !billCycle.trim().isEmpty() && licenseCode != null && !licenseCode.trim().isEmpty()) {
                    ProvinceConfig pc = meterReadingDao.findByBillCycleAndLicenseCodeAndProvinceCode(Long.parseLong(billCycle), licenseCode, provinceCode);
                    isReadingProcessLocked = (pc != null && pc.getIsReadingProcessLocked() != null && pc.getIsReadingProcessLocked() != 0L);
                }
            } catch (Exception e) {
                isReadingProcessLocked = true;
            }
            model.addAttribute("isReadingProcessLocked", isReadingProcessLocked);

            System.out.println("DEBUG: billCycle=" + billCycle + ", licenseCode=" + licenseCode + ", provinceCode=" + provinceCode);
            System.out.println("DEBUG: isBillCycleCurrent=" + isBillCycleCurrent);
            System.out.println("DEBUG: isReadingProcessLocked=" + isReadingProcessLocked);
            boolean disableUpload = !isBillCycleCurrent || isReadingProcessLocked;
            System.out.println("DEBUG: disableUpload=" + disableUpload);
            model.addAttribute("disableUpload", disableUpload);

            if (serialNo != null && !serialNo.trim().isEmpty() && billCycle != null && !billCycle.trim().isEmpty()) {
                MeterPoint meterPoint = meterPointDao.findBySerialNo(serialNo);

                if (meterPoint != null) {
                    meterSearchModel.setMeterPointName(meterPoint.getMeterPointName());
                    meterSearchModel.setPrimarySubstationName(
                            meterPoint.getPrimarySubstation() != null ? meterPoint.getPrimarySubstation().getPssName() : null
                    );
                    meterSearchModel.setLicenseCode(meterPoint.getLicenseCode());
                    meterSearchModel.setProvinceCode(meterPoint.getProvince1() != null ? meterPoint.getProvince1().getProvinceCode() : null);
                    if (meterPoint.getProvince1() != null) {
                        meterSearchModel.setProvinceName(meterPoint.getProvince1().getProvinceName());
                    }
                    if (meterPoint.getArea() != null) {
                        meterSearchModel.setAreaName(meterPoint.getArea().getAreaName());
                    }
                    meterSearchModel.setPrimarySubstationCode(
                            meterPoint.getPrimarySubstation() != null ? meterPoint.getPrimarySubstation().getPssCode() : null
                    );
                    meterSearchModel.setMeterPointCode(meterPoint.getMeterPointCode());
                    meterSearchModel.setMeterPointName(meterPoint.getMeterPointName());

                    if (meterPoint.getProvince2() != null) {
                        meterSearchModel.setLecoProvinceCode(meterPoint.getProvince2().getProvinceCode());
                    } else {
                        meterSearchModel.setLecoProvinceCode(null);
                    }

                    // Fetch MeterReadings for serial and bill cycle
                    List<MeterReading> readings = meterReadingDao.findAllBySerialNoAndBillCycle(serialNo, Long.parseLong(billCycle));

                    List<MeterReadingTableRow> tableRows = new ArrayList<>();
                    MeterReadingTableRow coincidentPeakImportRow = null;
                    MeterReadingTableRow coincidentPeakExportRow = null;

                    for (MeterReading reading : readings) {
                        MeterReadingTableRow row = new MeterReadingTableRow();
                        row.setPreviousReading(reading.getPreviousReading() != null ? reading.getPreviousReading().toString() : "");
                        row.setCurrentReading(reading.getCurrentReading() != null ? reading.getCurrentReading().toString() : "");
                        row.setEnergy(reading.getEnergy() != null ? reading.getEnergy().toString() : "");
                        row.setReadingMethod(reading.getReadingMethod());
                        if (reading.getMeasure() != null) {
                            row.setMeasureName(reading.getMeasure().getMeasureName());
                            row.setImportOrExport(reading.getMeasure().getImportOrExport());
                            row.setDayPeakOff(reading.getMeasure().getDayPeakOff());
                        }
                        String curr = row.getCurrentReading();
                        row.setEditable("0".equals(curr) || "0.0".equals(curr));

                        // Handle coincident peak rows
                        if ("Coincident Peak Import".equalsIgnoreCase(row.getMeasureName())) {
                            coincidentPeakImportRow = row;
                            continue;
                        }
                        if ("Coincident Peak Export".equalsIgnoreCase(row.getMeasureName())) {
                            coincidentPeakExportRow = row;
                            continue;
                        }
                        tableRows.add(row);
                    }

                    // --- for totals ---
                    double importTotal = 0;
                    double exportTotal = 0;
                    for (MeterReadingTableRow row : tableRows) {
                        String energyStr = row.getEnergy();
                        double energy = 0;
                        try { energy = Double.parseDouble(energyStr); } catch (Exception e) {}
                        if ("Import".equalsIgnoreCase(row.getImportOrExport()) || "I".equalsIgnoreCase(row.getImportOrExport())) {
                            importTotal += energy;
                        } else if ("Export".equalsIgnoreCase(row.getImportOrExport()) || "E".equalsIgnoreCase(row.getImportOrExport())) {
                            exportTotal += energy;
                        }
                    }
                    MeterReadingEnergySummary summary = meterReadingEnergySummaryDao.findByBillCycleAndSerialNo(Long.parseLong(billCycle), serialNo);
                    if (summary != null) {
                        model.addAttribute("importCoincidentPeak", summary.getImportCoincidentPeak());
                        model.addAttribute("exportCoincidentPeak", summary.getExportCoincidentPeak());
                    }
                    model.addAttribute("importTotal", importTotal);
                    model.addAttribute("exportTotal", exportTotal);
                    // --- End totals block ---

                    model.addAttribute("meterReadings", tableRows);
                    model.addAttribute("coincidentPeakImportRow", coincidentPeakImportRow);
                    model.addAttribute("coincidentPeakExportRow", coincidentPeakExportRow);
                    model.addAttribute("searchSuccess", true);
                    model.addAttribute("meterSearchModel", meterSearchModel);

                    // --- fetch uploaded files for the bill cycle ---
                    try {
                        String filePath = ConfigProperties.getProperty("FILE_PATH")
                                + billCycle + File.separator
                                + meterPoint.getLicenseCode() + File.separator
                                + (meterPoint.getProvince2() != null ? meterPoint.getProvince2().getProvinceCode() : "") + File.separator
                                + (meterPoint.getPrimarySubstation() != null ? meterPoint.getPrimarySubstation().getPssCode() : "") + File.separator
                                + meterPoint.getMeterPointCode();

                        List<String> fileList = getFileList(filePath);
                        meterSearchModel.setReadingFileList(fileList);
                    } catch (Exception e) {
                        model.addAttribute("uploadedFiles", null);
                        model.addAttribute("uploadedFilesError", "Error loading uploaded files: " + e.getMessage());
                    }
                    // --- End uploaded files block ---

                } else {
                    model.addAttribute("searchSuccess", false);
                    model.addAttribute("errorMessage", "Invalid serial number: " + serialNo);
                    model.addAttribute("meterSearchModel", meterSearchModel);
                }
            } else {
                model.addAttribute("searchSuccess", false);
                model.addAttribute("errorMessage", "Please enter both serial number and bill cycle.");
                model.addAttribute("meterSearchModel", meterSearchModel);
            }
        } catch (Exception e) {
            model.addAttribute("meterSearchModel", meterSearchModel);
            model.addAttribute("searchSuccess", false);
            model.addAttribute("errorMessage", "An error occurred: " + e.getMessage());
            model.addAttribute("isBillCycleCurrent", false);
        }
        return "pts/licenseeBilling/meterSearch/meterSearch";
    }


    @PostMapping("/saveMeterReadings")
    @Transactional
    public String saveMeterReadings(HttpServletRequest request, Model model) {
        String serialNo = request.getParameter("serialNo");
        String billCycle = request.getParameter("billCycle");
        String remark = request.getParameter("remark");

        if (remark != null) {
            remark = remark.trim();
        }

        String[] measureTypes = {"DayExport", "PeakExport", "OffPeakExport", "DayImport", "PeakImport", "OffPeakImport"};
        boolean anyUpdated = false;

        for (String type : measureTypes) {
            String energyParam = request.getParameter("energy_" + type);
            String currentReadingParam = request.getParameter("currentReading_" + type);
            String measureName = request.getParameter("measureName_" + type);

            boolean hasValue = (currentReadingParam != null && !currentReadingParam.trim().isEmpty())
                    || (energyParam != null && !energyParam.trim().isEmpty());

            if (measureName != null && hasValue) {
                try {
                    MeterReading reading = meterReadingDao.findBySerialNoAndBillCycleAndMeasureName(serialNo, Long.parseLong(billCycle), measureName);
                    boolean changed = false;

                    if (reading == null) {
                        reading = new MeterReading();
                        reading.setReadingId(meterReadingDao.getNextReadingId());
                        BillCycle bc = new BillCycle();
                        bc.setBillCycleNo(Long.parseLong(billCycle));
                        reading.setBillCycle(bc);
                        reading.setSerialNo(serialNo);
                        reading.setMeasure(measureDao.findByName(measureName));
                        MeterPoint meterPoint = meterPointDao.findBySerialNo(serialNo);
                        reading.setPoint(meterPoint);
                        if (meterPoint != null && meterPoint.getMeter() != null) {
                            reading.setMeter(meterPoint.getMeter());
                        }
                        changed = true;
                    }

                    if (currentReadingParam != null && !currentReadingParam.trim().isEmpty()) {
                        try {
                            BigDecimal newVal = new BigDecimal(currentReadingParam.trim());
                            if (reading.getCurrentReading() == null || reading.getCurrentReading().compareTo(newVal) != 0) {
                                reading.setCurrentReading(newVal);
                                changed = true;
                            }
                        } catch (NumberFormatException e) {
                            System.out.println("Invalid currentReading for " + measureName + ": " + currentReadingParam);
                        }
                    }
                    if (energyParam != null && !energyParam.trim().isEmpty()) {
                        try {
                            BigDecimal newVal = new BigDecimal(energyParam.trim());
                            if (reading.getEnergy() == null || reading.getEnergy().compareTo(newVal) != 0) {
                                reading.setEnergy(newVal);
                                changed = true;
                            }
                        } catch (NumberFormatException e) {
                            System.out.println("Invalid energy for " + measureName + ": " + energyParam);
                        }
                    }
                    if (changed) {
                        reading.setUpdatedBy("system");
                        reading.setUpdatedDate(new java.util.Date());
                        reading.setReadingMethod("MANU");
                        meterReadingDao.save(reading);
                        anyUpdated = true;
                    }
                } catch (Exception ex) {
                    System.out.println("Error saving reading for " + measureName + ": " + ex.getMessage());
                    ex.printStackTrace();
                }
            }
        }

        // Check if any readings exist for this serialNo and billCycle
        List<MeterReading> readings = meterReadingDao.findAllBySerialNoAndBillCycle(serialNo, Long.parseLong(billCycle));
        double importTotal = 0;
        double exportTotal = 0;
        for (MeterReading reading : readings) {
            if (reading.getMeasure() != null && reading.getEnergy() != null) {
                String io = reading.getMeasure().getImportOrExport();
                if ("Import".equalsIgnoreCase(io) || "I".equalsIgnoreCase(io)) {
                    importTotal += reading.getEnergy().doubleValue();
                } else if ("Export".equalsIgnoreCase(io) || "E".equalsIgnoreCase(io)) {
                    exportTotal += reading.getEnergy().doubleValue();
                }
            }
        }

        // If no readings, but serial exists in MeterPoint, insert summary with remark
        if (readings.isEmpty()) {
            MeterPoint meterPoint = meterPointDao.findBySerialNo(serialNo);
            if (meterPoint != null) {
                MeterReadingEnergySummary summary = meterReadingEnergySummaryDao.findByBillCycleAndSerialNo(Long.parseLong(billCycle), serialNo);
                if (summary == null) {
                    summary = new MeterReadingEnergySummary();
                    summary.setSummaryId(meterReadingEnergySummaryDao.getNextSummaryId());
                    summary.setBillCycle(Long.parseLong(billCycle));
                    summary.setSerialNo(serialNo);
                    summary.setImportEnergy(BigDecimal.valueOf(importTotal));
                    summary.setExportEnergy(BigDecimal.valueOf(exportTotal));
                    summary.setRemark(remark);
                    meterReadingEnergySummaryDao.insert(summary);
                    anyUpdated = true; // Set to true on insert
                } else {
                    if ((summary.getRemark() == null && remark != null && !remark.isEmpty()) ||
                            (summary.getRemark() != null && !summary.getRemark().equals(remark))) {
                        summary.setRemark(remark);
                        meterReadingEnergySummaryDao.update(summary);
                        anyUpdated = true; // Set to true on update
                    }
                }
            }
        } else {
            MeterReadingEnergySummary summary = meterReadingEnergySummaryDao.findByBillCycleAndSerialNo(Long.parseLong(billCycle), serialNo);
            if (summary != null) {
                boolean summaryChanged = false;
                if (summary.getImportEnergy() == null || summary.getImportEnergy().doubleValue() != importTotal) {
                    summary.setImportEnergy(BigDecimal.valueOf(importTotal));
                    summaryChanged = true;
                }
                if (summary.getExportEnergy() == null || summary.getExportEnergy().doubleValue() != exportTotal) {
                    summary.setExportEnergy(BigDecimal.valueOf(exportTotal));
                    summaryChanged = true;
                }
                if ((summary.getRemark() == null && remark != null && !remark.isEmpty()) ||
                        (summary.getRemark() != null && !summary.getRemark().equals(remark))) {
                    summary.setRemark(remark);
                    summaryChanged = true;
                }
                if (summaryChanged) {
                    meterReadingEnergySummaryDao.update(summary);
                    anyUpdated = true;
                }
            } else {
                summary = new MeterReadingEnergySummary();
                summary.setSummaryId(meterReadingEnergySummaryDao.getNextSummaryId());
                summary.setBillCycle(Long.parseLong(billCycle));
                summary.setSerialNo(serialNo);
                summary.setImportEnergy(BigDecimal.valueOf(importTotal));
                summary.setExportEnergy(BigDecimal.valueOf(exportTotal));
                summary.setRemark(remark);
                meterReadingEnergySummaryDao.insert(summary);
                anyUpdated = true;
            }
        }

        MeterSearchModel meterSearchModel = new MeterSearchModel();
        meterSearchModel.setSerialNo(serialNo);
        meterSearchModel.setBillCycle(billCycle);
        meterSearchModel.setRemark(remark);

        boolean isBillCycleCurrent = false;
        try {
            if (billCycle != null && !billCycle.trim().isEmpty()) {
                BillCycle bc = billCycleDao.findByBillCycleNo(Long.parseLong(billCycle));
                isBillCycleCurrent = (bc != null && bc.getIsCurrent() != null && bc.getIsCurrent() == 1L);
            }
        } catch (Exception e) {
            isBillCycleCurrent = false;
        }
        model.addAttribute("isBillCycleCurrent", isBillCycleCurrent);

        if (anyUpdated) {
            model.addAttribute("saveSuccess", true);
        } else {
            model.addAttribute("saveSuccess", false);
            model.addAttribute("saveMessage", "No changes detected.");
        }
        return searchBySerialNo(meterSearchModel, model);
    }

    @GetMapping("/viewUploadedFiles")
    @Transactional(readOnly = true)
    public String viewUploadedFilesByBillCycle(
            @RequestParam("billCycle") String billCycle,
            Model model) {
        System.out.println("viewUploadedFilesByBillCycle!!!!!");
        try {
            List<FileUploadHeader> uploadedFiles = fileUploadHeaderDao.findByBillCycle(Long.parseLong(billCycle));
            model.addAttribute("uploadedFiles", uploadedFiles);
        } catch (Exception e) {
            model.addAttribute("uploadedFiles", null);
            model.addAttribute("uploadedFilesError", "Error loading uploaded files: " + e.getMessage());
        }
        return "pts/comp/searchMeterReading :: uploadedFilesList";
    }


    @GetMapping("/file/view")
    @ResponseBody
    public ResponseEntity<FileSystemResource> viewFile(
            @RequestParam("billCycle") String billCycle,
            @RequestParam("licensee") String licensee,
            @RequestParam("province") String province,
            @RequestParam("fileName") String fileName) {
        String basePath = "C:/Report";
        String filePath = basePath + "/" + billCycle + "/" + licensee + "/" + province + "/" + fileName;
        File file = new File(filePath);
        if (file.exists()) {
            FileSystemResource resource = new FileSystemResource(file);
            // Use generic octet-stream for unknown types, or set specific type if needed
            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
                    .body(resource);
        } else {
            return ResponseEntity.notFound().build();
        }
    }




    @GetMapping("/download")
    public ResponseEntity<InputStreamResource> downloadFile(
            @RequestParam("billCycle") String billCycle,
            @RequestParam("licensee") String licensee,
            @RequestParam("province") String province,
            @RequestParam("pssCode") String pssCode,
            @RequestParam("meterPointCode") String meterPointCode,
            @RequestParam("fileName") String fileName) throws IOException {

        String basePath = ConfigProperties.getProperty("FILE_PATH");
        String filePath = basePath
                + billCycle + File.separator
                + licensee + File.separator
                + province +  File.separator
                + pssCode + File.separator
                + meterPointCode + File.separator
                + fileName;

        File file = new File(filePath);
        System.out.println("Download file path: " + filePath);
        if (!file.exists()) {
            return ResponseEntity.notFound().build();
        }

        InputStreamResource resource = new InputStreamResource(new FileInputStream(file));
        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_OCTET_STREAM)
                .contentLength(file.length())
                .header("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"")
                .body(resource);
    }



    private List<String> getFileList(String folderPath)
    {
        File folder = new File(folderPath);

        List<String> fileNames = new ArrayList<>();
        if (folder.exists() && folder.isDirectory())
        {
            for (File file : folder.listFiles())
            {
                if (file.isFile())
                {
                    fileNames.add(file.getName());
                }
            }
        }
        return fileNames;
    }

    // enables upload when isBillCycleCurrent == true(1) and isReadingProcessLocked == false(0)
    @PostMapping("/uploadFile")
    public String uploadFile(
            @RequestParam("fileUpload") MultipartFile[] files,
            @RequestParam("billCycle") String billCycle,
            @RequestParam("licenseCode") String licenseCode,
            @RequestParam("provinceCode") String provinceCode,
            @RequestParam("pssCode") String pssCode,
            @RequestParam("meterPointCode") String meterPointCode,
            @RequestParam(value = "serialNo", required = false) String serialNo,
            Model model) {

        if (licenseCode == null || provinceCode == null) {
            MeterPoint meterPoint = meterPointDao.findBySerialNo(serialNo);
            if (meterPoint != null) {
                if (licenseCode == null) licenseCode = meterPoint.getLicenseCode();
                if (provinceCode == null && meterPoint.getProvince2() != null) {
                    provinceCode = meterPoint.getProvince2().getProvinceCode();
                }
            }
        }

        boolean isBillCycleCurrent = false;
        try {
            if (billCycle != null && !billCycle.trim().isEmpty()) {
                BillCycle bc = billCycleDao.findByBillCycleNo(Long.parseLong(billCycle));
                isBillCycleCurrent = (bc != null && bc.getIsCurrent() != null && bc.getIsCurrent() == 1L);
            }
        } catch (Exception e) {
            isBillCycleCurrent = false;
        }
        model.addAttribute("isBillCycleCurrent", isBillCycleCurrent);

        boolean isReadingProcessLocked = true;
        try {
            if (billCycle != null && !billCycle.trim().isEmpty() && licenseCode != null && !licenseCode.trim().isEmpty()) {
                ProvinceConfig pc = meterReadingDao.findByBillCycleAndLicenseCodeAndProvinceCode(Long.parseLong(billCycle), licenseCode, provinceCode);
                isReadingProcessLocked = (pc != null && pc.getIsReadingProcessLocked() != null && pc.getIsReadingProcessLocked() != 0L);
            }
        } catch (Exception e) {
            isReadingProcessLocked = true;
        }
        model.addAttribute("isReadingProcessLocked", isReadingProcessLocked);

        // Only allow upload if bill cycle is current(1) AND reading process is NOT locked(0)
        System.out.println("DEBUG: billCycle=" + billCycle + ", licenseCode=" + licenseCode + ", provinceCode=" + provinceCode);
        System.out.println("DEBUG: isBillCycleCurrent=" + isBillCycleCurrent);
        System.out.println("DEBUG: isReadingProcessLocked=" + isReadingProcessLocked);
        boolean disableUpload = !isBillCycleCurrent || isReadingProcessLocked;
        System.out.println("DEBUG: disableUpload=" + disableUpload);
        model.addAttribute("disableUpload", disableUpload);

        String uploadSuccess = null;
        String uploadError = null;

        if (files == null || files.length == 0) {
            uploadError = "Error in uploading: No files selected.";
        } else {
            boolean anySuccess = false;
            StringBuilder errorMsg = new StringBuilder();
            for (MultipartFile file : files) {
                if (file == null || file.isEmpty()) {
                    errorMsg.append("No file selected. ");
                    continue;
                }
                String fileName = file.getOriginalFilename();
                if (fileName == null || !(fileName.endsWith(".xlsx") || fileName.endsWith(".xls") || fileName.endsWith(".csv"))) {
                    errorMsg.append("Invalid file type for ").append(fileName).append(". ");
                    continue;
                }
                long maxFileSize = 5 * 1024 * 1024;
                if (file.getSize() > maxFileSize) {
                    errorMsg.append("File size exceeds 5 MB: ").append(fileName).append(". ");
                    continue;
                }
                try {
                    String uploadDir = ConfigProperties.getProperty("FILE_PATH")
                            + billCycle + File.separator
                            + licenseCode + File.separator
                            + provinceCode  + File.separator
                            + pssCode + File.separator
                            + meterPointCode;
                    File dir = new File(uploadDir);
                    if (!dir.exists()) dir.mkdirs();
                    File dest = new File(dir, fileName);
                    if (dest.exists()) dest.delete();
                    file.transferTo(dest);
                    anySuccess = true;
                } catch (IOException e) {
                    errorMsg.append("File uploading fail. ");
                } catch (Exception e) {
                    errorMsg.append("File uploading fail. ");
                }
            }
            if (anySuccess) {
                uploadSuccess = "Successfully uploaded.";
            }
            if (errorMsg.length() > 0) {
                uploadError = errorMsg.toString();
            }
        }

        MeterSearchModel meterSearchModel = new MeterSearchModel();
        meterSearchModel.setBillCycle(billCycle);
        meterSearchModel.setLicenseCode(licenseCode);
        meterSearchModel.setLecoProvinceCode(provinceCode);
        meterSearchModel.setPrimarySubstationCode(pssCode);
        meterSearchModel.setMeterPointCode(meterPointCode);
        meterSearchModel.setSerialNo(serialNo);

        String view = searchBySerialNo(meterSearchModel, model);

        if (uploadSuccess != null) {
            model.addAttribute("uploadSuccess", uploadSuccess);
        }
        if (uploadError != null) {
            model.addAttribute("uploadError", uploadError);
        }
        return view;
    }
}