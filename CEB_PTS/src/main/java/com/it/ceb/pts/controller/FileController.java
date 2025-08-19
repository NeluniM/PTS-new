package com.it.ceb.pts.controller;

import com.fasterxml.jackson.databind.ObjectMapper;

import com.it.ceb.pts.domain.*;
import com.it.ceb.pts.repo.*;
import com.it.ceb.util.common.ConfigProperties;
import com.it.ceb.util.common.ZipExtractor;
import com.it.ceb.pts.model.ModelService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//import net.sf.jasperreports.repo.InputStreamResource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
//import java.io.FileInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class FileController {

    @Autowired
    private FileUploadHeaderDao fileUploadHeaderDao;

    @Autowired
    private DistributionLicenseDao distributionLicenseDao;

    @Autowired
    private ProvinceDao provinceDao;

    @Autowired
    private ModelService modelService;

    @Autowired
    private BillCycleDao billCycleDao;

    @Autowired
    private DistributionLicenseDao DistributionLicenseDao;


    //file uploading
    @Transactional
    @RequestMapping(value = "/uploadFile", method = RequestMethod.GET)
    public ModelAndView uploadFile(@ModelAttribute("model") FileUploadModel fileUploadModel) throws Exception{
        List<DistributionLicense> licenseList = DistributionLicenseDao.getLicenseList();
        List<Province> provinceList = provinceDao.getAllProvince();
        fileUploadModel.setLicenseList(licenseList);
        fileUploadModel.setProvinceList(provinceList);
        ModelAndView mv= new ModelAndView("pts/licenseeBilling/uploadFiles/fileUpload", "model", fileUploadModel);
        mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
        return mv;
    }

    //view upload meter points
    @Transactional
    @RequestMapping(value = "/viewFile", method = RequestMethod.GET)
    public String viewMeterPoints(Model model) throws Exception{
       // BillCycle billCycle = meterProcessDao.getCurrentBillCycle();
        Long billCycle = billCycleDao.getCurrentBillCycleNo();
        List<DistributionLicense> licenseList = DistributionLicenseDao.getLicenseList();
        List<Province> provinceList = provinceDao.getAllProvince();
        model.addAttribute("licenseList",licenseList);
        model.addAttribute("provinceList",new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
        model.addAttribute("billCycleNo", billCycle);
        return "pts/licenseeBilling/viewFiles/viewFile"; // Return the same page after form submission
    }

//    //====================working controller ================================
//    @Transactional
//    @PostMapping("/UploadingMeterReadingFileS")
//    public ModelAndView uploadingMeterReadingFileS(
//            HttpServletRequest request,
//            @RequestParam("files") MultipartFile[] files,
//            @RequestParam(value = "overwriteDecision", required = false) String overwriteDecision,
//            @ModelAttribute("model") FileUploadModel model) throws Exception {
//
//        System.out.println("overwriteDecision: " + overwriteDecision);
//
//        ModelAndView mv = new ModelAndView("pts/licenseeBilling/uploadFiles/fileUpload", "model", model);
//
//        String division = model.getDivision();
//        String billCycle = model.getBillCycle();
//        String province = model.getProvince();
//
//        try {
//            // Check if the province is locked
//            Long isLocked = fileUploadHeaderDao.isUploadLocked(billCycle, division, province);
//            if (isLocked == 1 ) {
//                model.setErrorMessage("Upload is locked for the selected province: " + province);
//                // Load dropdown lists
//                List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
//                List<Province> provinceList = provinceDao.getAllProvince();
//                model.setLicenseList(licenseList);
//                model.setProvinceList(provinceList);
//                mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
//                return mv; // Stop further processing
//
//            }else {
//
//                String zipSavePath = ConfigProperties.getReportPath() + File.separator + billCycle + File.separator + division + File.separator + province + "_zip";
//                String extractionPath = ConfigProperties.getReportPath() + File.separator + billCycle + File.separator + division + File.separator + province;
//
//                boolean filesProcessed = false;
//                StringBuilder processingResults = new StringBuilder();
//                boolean hasValidZipFiles = false;
//
//                // Check if all files are valid .zip files
//                for (MultipartFile file : files) {
//                    if (!file.isEmpty()) {
//                        String originalFilename = file.getOriginalFilename();
//                        if (originalFilename == null || !originalFilename.toLowerCase().endsWith(".zip")) {
//                            model.setErrorMessage(  originalFilename +" is not a valid file type. Only .zip files are allowed.");
//
//                            List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
//                            List<Province> provinceList = provinceDao.getAllProvince();
//                            model.setLicenseList(licenseList);
//                            model.setProvinceList(provinceList);
//                            mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
//                            return mv; // Return immediately with the error message
//                        }
//                        hasValidZipFiles = true;
//                    }
//                }
//
//                if (!hasValidZipFiles) {
//                    model.setErrorMessage("No files were uploaded.");
//                    // Load dropdown lists
//                    List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
//                    List<Province> provinceList = provinceDao.getAllProvince();
//                    model.setLicenseList(licenseList);
//                    model.setProvinceList(provinceList);
//                    mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
//                    return mv;
//                }
//
//                File zipDir = null;
//                File extractDir = null;
//
//                if (hasValidZipFiles) {
//                    zipDir = new File(zipSavePath);
//                    extractDir = new File(extractionPath);
//
//                    if (!zipDir.exists() && !zipDir.mkdirs()) {
//                        model.setErrorMessage("Failed to create ZIP directory: " + zipSavePath);
//                        return mv;
//                    }
//
//                    if (!extractDir.exists() && !extractDir.mkdirs()) {
//                        model.setErrorMessage("Failed to create extraction directory: " + extractionPath);
//                        return mv;
//                    }
//                }
//
//                for (MultipartFile file : files) {
//                    if (!file.isEmpty()) {
//                        String originalFilename = file.getOriginalFilename();
//                        if (originalFilename == null || !originalFilename.toLowerCase().endsWith(".zip")) {
//                            processingResults.append("Skipping invalid file: ").append(originalFilename).append("\n");
//                            continue;
//                        }
//
//                        String uniqueFilename = originalFilename;
//
//
//                        if (isFileAlreadyUploaded(billCycle, division, province, originalFilename)) {
//                            model.setFileNameConflict(true);
//                            model.setOriginalFileName(originalFilename);
//                            uniqueFilename = generateUniqueFileName(originalFilename, billCycle, division, province);
//                            processingResults.append("Duplicate found. File renamed to: ").append(uniqueFilename).append("\n");
//                        }
//
////                        // Check if file already exists
////                        if (isFileAlreadyUploaded(billCycle, division, province, originalFilename)) {
////
////                            System.out.println("isFileAllreadyUploaded  "+isFileAlreadyUploaded(billCycle, division, province, originalFilename));
////                            // If user hasn't confirmed yet, return with conflict flag
////                            if (overwriteDecision == null || overwriteDecision.isEmpty()) {
////                                model.setFileNameConflict(true);
////                                model.setOriginalFileName(originalFilename);
////                                mv.addObject("fileNameConflict", true);
////                                mv.addObject("originalFileName", originalFilename);
////                                mv.setViewName("pts/licenseeBilling/fileUpload"); // Ensure the correct JSP is being returned
////                                // request.setAttribute("fileNameConflict", true);
////                              //  model.setErrorMessage("File '" + originalFilename + "' already exists. Do you want to overwrite or upload as a new file?");
////
////                                System.out.println("==============================enter to the alert box method=============================");
////                                // Load dropdown lists
////                                List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
////                                List<Province> provinceList = provinceDao.getAllProvince();
////                                model.setLicenseList(licenseList);
////                                model.setProvinceList(provinceList);
////                                mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
////                                return mv;
////                            }
////
////                            System.out.println("==============================before the cancel button =============================");
////                            // User said to cancel the upload
////                            if ("CANCEL".equalsIgnoreCase(overwriteDecision)) {
////                                processingResults.append("User cancelled upload for: ").append(originalFilename).append("\n");
////
////                                model.setErrorMessage("Cancel the override file save.\n");
////                                System.out.println("cancel button in the alert box ");
////                                continue;
////                            }
////
////                            System.out.println("==============================before the yes button=========================================");
////
////                            // User said to upload with a new name
////                            if ("YES".equalsIgnoreCase(overwriteDecision)) {
////                                System.out.println("yes button in the alert box ");
////
////                                uniqueFilename = generateUniqueFileName(originalFilename, billCycle, division, province);
////                            }
////
////                            // If "YES", we proceed with overwriting the same filename
////                        }
//
//                        // Save the file
//                        File zipFile = new File(zipDir, uniqueFilename);
//                        file.transferTo(zipFile);
//
//                        // Delete existing extraction folder
//                        if (extractDir.exists()) {
//                            deleteDirectory(extractDir);
//                        }
//
//                        // Extract zip contents
//                        ZipExtractor.unzip(zipFile.getAbsolutePath(), extractionPath);
//
//                        // Move contents from extracted folder (e.g., /WPNL/) to main path
//                        // Move contents of the extracted folder to the parent folder
//                        File extractedFolder = new File(extractionPath, province);
//                        if (extractedFolder.exists() && extractedFolder.isDirectory()) {
//                            File[] extractedFiles = extractedFolder.listFiles();
//                            if (extractedFiles != null) {
//                                for (File extractedFile : extractedFiles) {
//                                    Files.move(
//                                            extractedFile.toPath(),
//                                            new File(extractionPath, extractedFile.getName()).toPath(),
//                                            StandardCopyOption.REPLACE_EXISTING
//                                    );
//                                }
//                            }
//                            // Delete the now-empty extracted folder
//                            deleteDirectory(extractedFolder);
//                        }
//
//                        try {
//                            FileUploadHeader header = new FileUploadHeader();
//                            header.setBillCycleNo(Long.parseLong(billCycle));
//                            header.setLicenseCode(division);
//                            header.setProvinceCode(province);
//                            header.setFileName(uniqueFilename);
//                            header.setIsUploaded(1L);
//                            header.setUploadedBy("system");
//                            header.setUploadedDate(LocalDateTime.now());
//                            //  header.setFileType("ZIP");
//
//                            fileUploadHeaderDao.save(header);
//
//                            processingResults.append("Saved metadata for: ").append(originalFilename).append("\n");
//                            filesProcessed = true;
//
//                        } catch (Exception e) {
//                            processingResults.append("Error saving metadata for: ").append(originalFilename)
//                                    .append(" - ").append(e.getMessage()).append("\n");
//                        }
//                    }
//                }
//
//                System.out.println("end the file uploading process");
//                System.out.println("filesProcessed: " + filesProcessed);
//
//                if (filesProcessed) {
//                    model.setSuccessMessage("Files processed successfully.\n");
//                    System.out.println("Files processed successfully.");
//                } else {
//                    model.setErrorMessage("No files were processed.\n");
//                    System.out.println("No files were processed.");
//                }
//
//                // Load dropdown lists
//                List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
//                List<Province> provinceList = provinceDao.getAllProvince();
//                model.setLicenseList(licenseList);
//                model.setProvinceList(provinceList);
//                mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
//
//                return mv;
//
//
//
//
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            model.setErrorMessage("Error checking upload lock status: " + e.getMessage());
//            // Load dropdown lists
//            List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
//            List<Province> provinceList = provinceDao.getAllProvince();
//            model.setLicenseList(licenseList);
//            model.setProvinceList(provinceList);
//            mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
//            return mv; // Stop further processing
//        }
//    }


////  ===================  testing controller file Upload  01=======================
//
//    @Transactional
//    @PostMapping("/UploadingMeterReadingFileS")
//    public ModelAndView uploadingMeterReadingFileS(
//            HttpServletRequest request,
//            @RequestParam("files") MultipartFile[] files,
//            @RequestParam(value = "overwriteDecision", required = false) String overwriteDecision,
//            @ModelAttribute("model") FileUploadModel model) throws Exception {
//
//        System.out.println("overwriteDecision: " + overwriteDecision);
//
//        ModelAndView mv = new ModelAndView("pts/licenseeBilling/uploadFiles/fileUpload", "model", model);
//        ModelAndView mv1 = new ModelAndView("pts/licenseeBilling/uploadFiles/fileAlert", "model", model);
//
//        String division = model.getDivision();
//        String billCycle = model.getBillCycle();
//        String province = model.getProvince();
//
//        try {
//            // Check if the province is locked
//            Long isLocked = fileUploadHeaderDao.isUploadLocked(billCycle, division, province);
//            if (isLocked == 1 ) {
//                model.setErrorMessage("Upload is locked for the selected province: " + province);
//                // Load dropdown lists
//                List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
//                List<Province> provinceList = provinceDao.getAllProvince();
//                model.setLicenseList(licenseList);
//                model.setProvinceList(provinceList);
//                mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
//                return mv; // Stop further processing
//
//            }else {
//
//                String zipSavePath = ConfigProperties.getReportPath() + File.separator + billCycle + File.separator + division + File.separator + province + "_zip";
//                String extractionPath = ConfigProperties.getReportPath() + File.separator + billCycle + File.separator + division + File.separator + province;
//
//                boolean filesProcessed = false;
//                StringBuilder processingResults = new StringBuilder();
//                boolean hasValidZipFiles = false;
//
//                // Check if all files are valid .zip files
//                for (MultipartFile file : files) {
//                    if (!file.isEmpty()) {
//                        String originalFilename = file.getOriginalFilename();
//                        if (originalFilename == null || !originalFilename.toLowerCase().endsWith(".zip")) {
//                            model.setErrorMessage("Invalid file type: " + originalFilename + ". Only .zip files are allowed.");
//
//                            List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
//                            List<Province> provinceList = provinceDao.getAllProvince();
//                            model.setLicenseList(licenseList);
//                            model.setProvinceList(provinceList);
//                            mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
//                            return mv; // Return immediately with the error message
//                        }
//                        hasValidZipFiles = true;
//                    }
//                }
//
//                if (!hasValidZipFiles) {
//                    model.setErrorMessage("No files were uploaded.");
//                    // Load dropdown lists
//                    List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
//                    List<Province> provinceList = provinceDao.getAllProvince();
//                    model.setLicenseList(licenseList);
//                    model.setProvinceList(provinceList);
//                    mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
//                    return mv;
//                }
//
//                File zipDir = null;
//                File extractDir = null;
//
//                if (hasValidZipFiles) {
//                    zipDir = new File(zipSavePath);
//                    extractDir = new File(extractionPath);
//
//                    if (!zipDir.exists() && !zipDir.mkdirs()) {
//                        model.setErrorMessage("Failed to create ZIP directory: " + zipSavePath);
//                        return mv;
//                    }
//
//                    if (!extractDir.exists() && !extractDir.mkdirs()) {
//                        model.setErrorMessage("Failed to create extraction directory: " + extractionPath);
//                        return mv;
//                    }
//                }
//
//                for (MultipartFile file : files) {
//                    if (!file.isEmpty()) {
//                        String originalFilename = file.getOriginalFilename();
//                        if (originalFilename == null || !originalFilename.toLowerCase().endsWith(".zip")) {
//                            processingResults.append("Skipping invalid file: ").append(originalFilename).append("\n");
//                            continue;
//                        }
//
//                        String uniqueFilename = originalFilename;
//
//                    System.out.println("=============before the null button ======================");
//                    System.out.println("overwriteDecision : " + overwriteDecision);
//                        if (overwriteDecision == null) {
//                            System.out.println("yes button in the alert box ");
//                            if (isFileAlreadyUploaded(billCycle, division, province, originalFilename)) {
//                                model.setFileNameConflict(true);
//                                model.setOriginalFileName(originalFilename);
//                                // uniqueFilename = generateUniqueFileName(originalFilename, billCycle, division, province);
//                                mv.addObject("fileNameConflict", true);
//                                mv.addObject("originalFileName", originalFilename);
//                              //  mv.setViewName("pts/licenseeBilling/fileUpload"); // Ensure the correct JSP is returned
//                                System.out.println("==============================enter to the duplicate checking method =============================");
//
////                                // Load dropdown lists
////                                List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
////                                List<Province> provinceList = provinceDao.getAllProvince();
////                                model.setLicenseList(licenseList);
////                                model.setProvinceList(provinceList);
////                                mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
////                                return mv;
//
//                                return mv1; // Return immediately to show the alert box
//                            }else {
//
//                                //   saveAndExtractFile( file, uniqueFilename, zipDir, extractionPath, province,billCycle, division, originalFilename, processingResults)
//
//                                // Save the file
//                                File zipFile = new File(zipDir, uniqueFilename);
//                                file.transferTo(zipFile);
//
//                                // Delete existing extraction folder
//                                if (extractDir.exists()) {
//                                    deleteDirectory(extractDir);
//                                }
//
//                                // Extract zip contents
//                                ZipExtractor.unzip(zipFile.getAbsolutePath(), extractionPath);
//
//                                // Move contents from extracted folder (e.g., /WPNL/) to main path
//                                // Move contents of the extracted folder to the parent folder
//                                File extractedFolder = new File(extractionPath, province);
//                                if (extractedFolder.exists() && extractedFolder.isDirectory()) {
//                                    File[] extractedFiles = extractedFolder.listFiles();
//                                    if (extractedFiles != null) {
//                                        for (File extractedFile : extractedFiles) {
//                                            Files.move(
//                                                    extractedFile.toPath(),
//                                                    new File(extractionPath, extractedFile.getName()).toPath(),
//                                                    StandardCopyOption.REPLACE_EXISTING
//                                            );
//                                        }
//                                    }
//                                    // Delete the now-empty extracted folder
//                                    deleteDirectory(extractedFolder);
//                                }
//
//                                try {
//                                    FileUploadHeader header = new FileUploadHeader();
//                                    header.setBillCycleNo(Long.parseLong(billCycle));
//                                    header.setLicenseCode(division);
//                                    header.setProvinceCode(province);
//                                    header.setFileName(uniqueFilename);
//                                    header.setIsUploaded(1L);
//                                    header.setUploadedBy("system");
//                                    header.setUploadedDate(LocalDateTime.now());
//                                    //  header.setFileType("ZIP");
//
//                                    fileUploadHeaderDao.save(header);
//
//                                    processingResults.append("Saved metadata for: ").append(originalFilename).append("\n");
//                                    filesProcessed = true;
//
//                                } catch (Exception e) {
//                                    processingResults.append("Error saving metadata for: ").append(originalFilename)
//                                            .append(" - ").append(e.getMessage()).append("\n");
//                                }
//                            }
//                        }
//
//                            System.out.println("==============================before the yes button=========================================");
//
//                            // User said to upload with a new name
//                            if (overwriteDecision == "YES") {
//                                System.out.println("yes button in the alert box ");
//
//                                uniqueFilename = generateUniqueFileName(originalFilename, billCycle, division, province);
//
//                                // Save the file
//                                File zipFile = new File(zipDir, uniqueFilename);
//                                file.transferTo(zipFile);
//
//                                // Delete existing extraction folder
//                                if (extractDir.exists()) {
//                                    deleteDirectory(extractDir);
//                                }
//
//                                // Extract zip contents
//                                ZipExtractor.unzip(zipFile.getAbsolutePath(), extractionPath);
//
//                                // Move contents from extracted folder (e.g., /WPNL/) to main path
//                                // Move contents of the extracted folder to the parent folder
//                                File extractedFolder = new File(extractionPath, province);
//                                if (extractedFolder.exists() && extractedFolder.isDirectory()) {
//                                    File[] extractedFiles = extractedFolder.listFiles();
//                                    if (extractedFiles != null) {
//                                        for (File extractedFile : extractedFiles) {
//                                            Files.move(
//                                                    extractedFile.toPath(),
//                                                    new File(extractionPath, extractedFile.getName()).toPath(),
//                                                    StandardCopyOption.REPLACE_EXISTING
//                                            );
//                                        }
//                                    }
//                                    // Delete the now-empty extracted folder
//                                    deleteDirectory(extractedFolder);
//                                }
//
//                                try {
//                                    FileUploadHeader header = new FileUploadHeader();
//                                    header.setBillCycleNo(Long.parseLong(billCycle));
//                                    header.setLicenseCode(division);
//                                    header.setProvinceCode(province);
//                                    header.setFileName(uniqueFilename);
//                                    header.setIsUploaded(1L);
//                                    header.setUploadedBy("system");
//                                    header.setUploadedDate(LocalDateTime.now());
//                                    //  header.setFileType("ZIP");
//
//                                    fileUploadHeaderDao.save(header);
//
//                                    processingResults.append("Saved metadata for: ").append(originalFilename).append("\n");
//                                    filesProcessed = true;
//
//                                } catch (Exception e) {
//                                    processingResults.append("Error saving metadata for: ").append(originalFilename)
//                                            .append(" - ").append(e.getMessage()).append("\n");
//                                }
//                            }
//
//                    }
//                }
//
//                System.out.println("end the file uploading process");
//                System.out.println("filesProcessed: " + filesProcessed);
//
//                if (filesProcessed) {
//                    model.setSuccessMessage("Files processed successfully.\n");
//                    System.out.println("Files processed successfully.");
//                } else {
//                    model.setErrorMessage("No files were processed.\n");
//                    System.out.println("No files were processed.");
//                }
//
//                // Load dropdown lists
//                List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
//                List<Province> provinceList = provinceDao.getAllProvince();
//                model.setLicenseList(licenseList);
//                model.setProvinceList(provinceList);
//                mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
//
//                return mv;
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            model.setErrorMessage("Error checking upload lock status: " + e.getMessage());
//            // Load dropdown lists
//            List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
//            List<Province> provinceList = provinceDao.getAllProvince();
//            model.setLicenseList(licenseList);
//            model.setProvinceList(provinceList);
//            mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
//            return mv; // Stop further processing
//        }
//    }



        //====================testing controller 02================================
    @Transactional
    @PostMapping("/UploadingMeterReadingFileS")
    public ModelAndView uploadingMeterReadingFileS(
            HttpServletRequest request,
            @RequestParam("files") MultipartFile[] files,
            @RequestParam(value = "overwriteDecision", required = false) String overwriteDecision,
            @ModelAttribute("model") FileUploadModel model) throws Exception {

        System.out.println("overwriteDecision: " + overwriteDecision);

        ModelAndView mv = new ModelAndView("pts/licenseeBilling/uploadFiles/fileUpload", "model", model);
        ModelAndView mv1 = new ModelAndView("pts/licenseeBilling/uploadFiles/fileConformationBox", "model", model);
        ModelAndView mv2 = new ModelAndView("pts/licenseeBilling/uploadFiles/fileAlertBox", "model", model);

        String division = model.getDivision();
        String billCycle = model.getBillCycle();
        String province = model.getProvince();

        try {
            // Check if the province is locked
            Long isLocked = fileUploadHeaderDao.isUploadLocked(billCycle, division, province);
            if (isLocked == 1 ) {
                model.setErrorMessage("Upload is locked for the selected province: " + province);
                // Load dropdown lists
                List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
                List<Province> provinceList = provinceDao.getAllProvince();
                model.setLicenseList(licenseList);
                model.setProvinceList(provinceList);
                mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
                return mv2.addObject("errorMessage","Upload is locked for the selected province: " + province); // Stop further processing

            }else {

                String zipSavePath = ConfigProperties.getProperty("FILE_PATH") + billCycle + File.separator + division + File.separator + province + "_zip";
                String extractionPath = ConfigProperties.getProperty("FILE_PATH") + billCycle + File.separator + division + File.separator + province;

                boolean filesProcessed = false;
                StringBuilder processingResults = new StringBuilder();
                boolean hasValidZipFiles = false;

                // Check if all files are valid .zip files
                for (MultipartFile file : files) {
                    if (!file.isEmpty()) {
                        String originalFilename = file.getOriginalFilename();
                        if (originalFilename == null || !originalFilename.toLowerCase().endsWith(".zip")) {
                            model.setErrorMessage("Invalid file type: " + originalFilename + ". Only .zip files are allowed.");

                            List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
                            List<Province> provinceList = provinceDao.getAllProvince();
                            model.setLicenseList(licenseList);
                            model.setProvinceList(provinceList);
                            mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
                            return mv2.addObject("errorMessage","Invalid file type: " + originalFilename + ". Only .zip files are allowed."); // Return immediately with the error message
                        }
                        hasValidZipFiles = true;
                    }
                }

                if (!hasValidZipFiles) {
                    model.setErrorMessage("No files were uploaded.");
                    // Load dropdown lists
                    List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
                    List<Province> provinceList = provinceDao.getAllProvince();
                    model.setLicenseList(licenseList);
                    model.setProvinceList(provinceList);
                    //mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
                    return mv2.addObject("errorMessage","No files were uploaded.");                }

                File zipDir = null;
                File extractDir = null;

                if (hasValidZipFiles) {
                    zipDir = new File(zipSavePath);
                    extractDir = new File(extractionPath);

                    if (!zipDir.exists() && !zipDir.mkdirs()) {
                       // model.setErrorMessage("Failed to create ZIP directory: " + zipSavePath);
                        return mv2.addObject("errorMessage","Failed to create ZIP directory: " + zipSavePath);
                    }

                    if (!extractDir.exists() && !extractDir.mkdirs()) {
                       // model.setErrorMessage("Failed to create extraction directory: " + extractionPath);
                        return mv2.addObject("errorMessage","Failed to create extraction directory: " + extractionPath);
                    }
                }

                for (MultipartFile file : files) {
                    if (!file.isEmpty()) {
                        String originalFilename = file.getOriginalFilename();
                        if (originalFilename == null || !originalFilename.toLowerCase().endsWith(".zip")) {
                            processingResults.append("Skipping invalid file: ").append(originalFilename).append("\n");
                            continue;
                        }

                        String uniqueFilename = originalFilename;


//                        if (isFileAlreadyUploaded(billCycle, division, province, originalFilename)) {
//                            model.setFileNameConflict(true);
//                            model.setOriginalFileName(originalFilename);
//                            uniqueFilename = generateUniqueFileName(originalFilename, billCycle, division, province);
//                            processingResults.append("Duplicate found. File renamed to: ").append(uniqueFilename).append("\n");
//                        }

                        // Check if file already exists
                        if (isFileAlreadyUploaded(billCycle, division, province, originalFilename)) {

                            System.out.println("isFileAllreadyUploaded  "+isFileAlreadyUploaded(billCycle, division, province, originalFilename));
                            // If user hasn't confirmed yet, return with conflict flag
                            if (overwriteDecision == null || overwriteDecision.isEmpty()) {
                                model.setFileNameConflict(true);
                                model.setOriginalFileName(originalFilename);
                               // mv.addObject("fileNameConflict", true);
                               // mv.addObject("originalFileName", originalFilename);
                                //mv.setViewName("pts/licenseeBilling/fileUpload"); // Ensure the correct JSP is being returned
                                // request.setAttribute("fileNameConflict", true);
                              //  model.setErrorMessage("File '" + originalFilename + "' already exists. Do you want to overwrite or upload as a new file?");

                                System.out.println("==============================enter to the alert box method=============================");
                                // Load dropdown lists
                                List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
                                List<Province> provinceList = provinceDao.getAllProvince();
                                model.setLicenseList(licenseList);
                                model.setProvinceList(provinceList);
                                mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
                                return mv1;
                            }

                            System.out.println("==============================before the cancel button =============================");
                            // User said to cancel the upload
                            if ("CANCEL".equalsIgnoreCase(overwriteDecision)) {
                                processingResults.append("User cancelled upload for: ").append(originalFilename).append("\n");

                                model.setSuccessMessage("Cancel the override file save.\n");
                                System.out.println("cancel button in the alert box ");
                                // Load dropdown lists
                                List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
                                List<Province> provinceList = provinceDao.getAllProvince();
                                model.setLicenseList(licenseList);
                                model.setProvinceList(provinceList);
                                mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
                                return mv;
                            }

                            System.out.println("==============================before the yes button=========================================");

                            // User said to upload with a new name
                            if ("YES".equalsIgnoreCase(overwriteDecision)) {
                                System.out.println("yes button in the alert box ");

                                uniqueFilename = generateUniqueFileName(originalFilename, billCycle, division, province);
                            }

                            // If "YES", we proceed with overwriting the same filename
                        }

                        // Save the file
                        File zipFile = new File(zipDir, uniqueFilename);
                        file.transferTo(zipFile);

                        // Delete existing extraction folder
                        if (extractDir.exists()) {
                            deleteDirectory(extractDir);
                        }

                        // Extract zip contents
                        ZipExtractor.unzip(zipFile.getAbsolutePath(), extractionPath);

                        // Move contents from extracted folder (e.g., /WPNL/) to main path
                        // Move contents of the extracted folder to the parent folder
                        File extractedFolder = new File(extractionPath, province);
                        if (extractedFolder.exists() && extractedFolder.isDirectory()) {
                            File[] extractedFiles = extractedFolder.listFiles();
                            if (extractedFiles != null) {
                                for (File extractedFile : extractedFiles) {
                                    Files.move(
                                            extractedFile.toPath(),
                                            new File(extractionPath, extractedFile.getName()).toPath(),
                                            StandardCopyOption.REPLACE_EXISTING
                                    );
                                }
                            }
                            // Delete the now-empty extracted folder
                            deleteDirectory(extractedFolder);
                        }

                        try {
                            FileUploadHeader header = new FileUploadHeader();
                            header.setBillCycleNo(Long.parseLong(billCycle));
                            header.setLicenseCode(division);
                            header.setProvinceCode(province);
                            header.setFileName(uniqueFilename);
                            header.setIsUploaded(1L);
                            header.setUploadedBy("system");
                            header.setUploadedDate(LocalDateTime.now());
                            //  header.setFileType("ZIP");

                            fileUploadHeaderDao.save(header);

                            processingResults.append("Saved metadata for: ").append(originalFilename).append("\n");
                            filesProcessed = true;

                        } catch (Exception e) {
                            processingResults.append("Error saving metadata for: ").append(originalFilename)
                                    .append(" - ").append(e.getMessage()).append("\n");
                        }
                    }
                }

                System.out.println("end the file uploading process");
                System.out.println("filesProcessed: " + filesProcessed);

                if (filesProcessed) {
                    mv2.addObject("successMessage", "Files uploaded successfully.\n");
                    model.setSuccessMessage("Files uploaded successfully.\n");
                    System.out.println("Files uploaded successfully.");
                } else {
                    mv2.addObject("errorMessage", "No files were uploaded.\n");
                    model.setErrorMessage("No files were uploaded.\n");
                    System.out.println("No files were uploaded.");
                }


                model.setSuccessMessage("Files uploaded successfully.");
                // Load dropdown lists
                List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
                List<Province> provinceList = provinceDao.getAllProvince();
                model.setLicenseList(licenseList);
                model.setProvinceList(provinceList);
                mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
                return mv2.addObject("successMessage", "Files uploaded successfully.");

            }
        } catch (Exception e) {
            e.printStackTrace();
            model.setErrorMessage("Error checking upload lock status: " + e.getMessage());
            // Load dropdown lists
            List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
            List<Province> provinceList = provinceDao.getAllProvince();
            model.setLicenseList(licenseList);
            model.setProvinceList(provinceList);
            mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
            return mv2.addObject("errorMessage","Error checking upload lock status: " + e.getMessage()); // Stop further processing
        }
    }




    private void saveAndExtractFile(MultipartFile file, String uniqueFilename, String zipDir, String extractionPath, String province, String billCycle, String division, String originalFilename, StringBuilder processingResults) throws IOException {
        // Save the file
        File zipFile = new File(zipDir, uniqueFilename);
        file.transferTo(zipFile);

        // Delete existing extraction folder
        File extractDir = new File(extractionPath);
        if (extractDir.exists()) {
            deleteDirectory(extractDir);
        }

        // Extract zip contents
        ZipExtractor.unzip(zipFile.getAbsolutePath(), extractionPath);

        // Move contents from extracted folder (e.g., /WPNL/) to main path
        File extractedFolder = new File(extractionPath, province);
        if (extractedFolder.exists() && extractedFolder.isDirectory()) {
            File[] extractedFiles = extractedFolder.listFiles();
            if (extractedFiles != null) {
                for (File extractedFile : extractedFiles) {
                    Files.move(
                            extractedFile.toPath(),
                            new File(extractionPath, extractedFile.getName()).toPath(),
                            StandardCopyOption.REPLACE_EXISTING
                    );
                }
            }
            // Delete the now-empty folder
            deleteDirectory(extractedFolder);
        }

        try {
            FileUploadHeader header = new FileUploadHeader();
            header.setBillCycleNo(Long.parseLong(billCycle));
            header.setLicenseCode(division);
            header.setProvinceCode(province);
            header.setFileName(uniqueFilename);
            header.setIsUploaded(1L);
            header.setUploadedBy("system");
            header.setUploadedDate(LocalDateTime.now());

            fileUploadHeaderDao.save(header);

            processingResults.append("Saved metadata for: ").append(originalFilename).append("\n");
        } catch (Exception e) {
            processingResults.append("Error saving metadata for: ").append(originalFilename)
                    .append(" - ").append(e.getMessage()).append("\n");
        }
    }

//    @Transactional
//    @PostMapping("/UploadingMeterReadingFileS")
//    public ModelAndView uploadingMeterReadingFileS(
//            HttpServletRequest request,
//            @RequestParam("files") MultipartFile[] files,
//            @ModelAttribute("model") FileUploadModel model) throws Exception {
//    	ModelAndView mv = new ModelAndView("pts/licenseeBilling/fileUpload", "model", model);
//
//    	try
//    	{
//        String division = model.getDivision();
//        String billCycle = model.getBillCycle();
//        String province = model.getProvince();
//
//        String zipSavePath = ConfigProperties.getReportPath() + File.separator + billCycle + File.separator + division + File.separator + province;
//        String extractionPath = ConfigProperties.getReportPath() + File.separator + billCycle + File.separator + division + File.separator + province + "_zip";
//
//        System.out.println("zipSavePath "+zipSavePath);
//        System.out.println("extractionPath "+extractionPath);
//        boolean filesProcessed = false;
//        StringBuilder processingResults = new StringBuilder();
//        boolean hasValidZipFiles = false;
//
//        for (MultipartFile file : files) {
//            if (!file.isEmpty() && file.getOriginalFilename() != null &&
//                    file.getOriginalFilename().toLowerCase().endsWith(".zip")) {
//                hasValidZipFiles = true;
//                break;
//            }
//        }
//        System.out.println("hasValidZipFiles "+hasValidZipFiles);
//
//        File zipDir = null;
//        File extractDir = null;
//
//        if (hasValidZipFiles) {
//            zipDir = new File(zipSavePath);
//            extractDir = new File(extractionPath);
//
//            if (!zipDir.exists() && !zipDir.mkdirs()) {
//                model.setErrorMessage("Failed to create ZIP directory: " + zipSavePath);
//                return mv;
//            }
//
//            if (!extractDir.exists() && !extractDir.mkdirs()) {
//                model.setErrorMessage("Failed to create extraction directory: " + extractionPath);
//                return mv;
//            }
//        }
//
//        for (MultipartFile file : files) {
//            if (!file.isEmpty()) {
//                String originalFilename = file.getOriginalFilename();
//                if (originalFilename == null || !originalFilename.toLowerCase().endsWith(".zip")) {
//                    processingResults.append("Skipping invalid file: ").append(originalFilename).append("\n");
//                    continue;
//                }
//
//                String uniqueFilename = originalFilename;
//                System.out.println("uniqueFilename "+uniqueFilename);
//                if (isFileAlreadyUploaded(billCycle, division, province, originalFilename)) {
//                    model.setFileNameConflict(true);
//                    model.setOriginalFileName(originalFilename);
//                    uniqueFilename = generateUniqueFileName(originalFilename, billCycle, division, province);
//                    processingResults.append("Duplicate found. File renamed to: ").append(uniqueFilename).append("\n");
//                }
//
//                File zipFile = new File(zipDir, uniqueFilename);
//                file.transferTo(zipFile);
//
//                ZipExtractor.unzip(zipFile.getAbsolutePath(), extractionPath,province);
//
//                // Move contents of the extracted folder to the parent folder
//                File extractedFolder = new File(extractionPath, province);
//                if (extractedFolder.exists() && extractedFolder.isDirectory()) {
//                    File[] extractedFiles = extractedFolder.listFiles();
//                    if (extractedFiles != null) {
//                        for (File extractedFile : extractedFiles) {
//                            Files.move(
//                                    extractedFile.toPath(),
//                                    new File(extractionPath, extractedFile.getName()).toPath(),
//                                    StandardCopyOption.REPLACE_EXISTING
//                            );
//                        }
//                    }
//                    // Delete the now-empty extracted folder
//                    deleteDirectory(extractedFolder);
//                }
//
//                System.out.println("unzip done !!! ");
//
//                try {
//                    FileUploadHeader header = new FileUploadHeader();
//                    header.setBillCycleNo(Long.parseLong(billCycle));
//                    header.setLicenseCode(division);
//                    header.setProvinceCode(province);
//                    header.setFileName(uniqueFilename);
//                    header.setIsUploaded(1L);
//                    header.setUploadedBy("System");
//                    header.setUploadedDate(LocalDate.now());
//
//
//                    fileUploadHeaderDao.save(header);
//
//                    processingResults.append("Saved metadata for: ").append(originalFilename).append("\n");
//                    filesProcessed = true;
//
//                } catch (Exception e) {
//                	e.printStackTrace();
//                    processingResults.append("Error saving metadata for: ").append(originalFilename)
//                            .append(" - ").append(e.getMessage()).append("\n");
//                }
//            }
//        }
//
//        if (filesProcessed) {
//            model.setSuccessMessage("Files processed successfully.\n" + processingResults);
//        } else {
//            model.setErrorMessage("No files were processed.\n" + processingResults);
//        }
//
//
//        }
//    	catch(Exception e)
//    	{
//    		e.printStackTrace();
//    	}
//
//        System.out.println("========================enter to the fileSeletor after uploading file =====================");
//
//        // Load dropdown lists
//        List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
//        List<Province> provinceList = provinceDao.getAllProvince();
//        model.setLicenseList(licenseList);
//        model.setProvinceList(provinceList);
//        mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
//        System.out.println("========================exit to the fileSeletor after uploading file =====================");
//
//        return mv;
//    }

//        //==================== testing controller 04 ================================
//    @Transactional
//    @PostMapping("/UploadingMeterReadingFileS")
//    public ModelAndView uploadingMeterReadingFileS(
//            HttpServletRequest request,
//            @RequestParam("files") MultipartFile[] files,
//            @RequestParam(value = "overwriteDecision", required = false) String overwriteDecision,
//            @ModelAttribute("model") FileUploadModel model) throws Exception {
//
//        System.out.println("overwriteDecision: " + overwriteDecision);
//
//        ModelAndView mv = new ModelAndView("pts/licenseeBilling/uploadFiles/fileUpload", "model", model);
//
//        String division = model.getDivision();
//        String billCycle = model.getBillCycle();
//        String province = model.getProvince();
//
//        try {
//            // Check if the province is locked
//            Long isLocked = fileUploadHeaderDao.isUploadLocked(billCycle, division, province);
//            if (isLocked == 1 ) {
//                model.setErrorMessage("Upload is locked for the selected province: " + province);
//                // Load dropdown lists
//                List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
//                List<Province> provinceList = provinceDao.getAllProvince();
//                model.setLicenseList(licenseList);
//                model.setProvinceList(provinceList);
//                mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
//                return mv; // Stop further processing
//
//            }else {
//
//                String zipSavePath = ConfigProperties.getReportPath() + File.separator + billCycle + File.separator + division + File.separator + province + "_zip";
//                String extractionPath = ConfigProperties.getReportPath() + File.separator + billCycle + File.separator + division + File.separator + province;
//
//                boolean filesProcessed = false;
//                StringBuilder processingResults = new StringBuilder();
//                boolean hasValidZipFiles = false;
//
//                // Check if all files are valid .zip files
//                for (MultipartFile file : files) {
//                    if (!file.isEmpty()) {
//                        String originalFilename = file.getOriginalFilename();
//                        if (originalFilename == null || !originalFilename.toLowerCase().endsWith(".zip")) {
//                            model.setErrorMessage(  originalFilename +" is not a valid file type. Only .zip files are allowed.");
//
//                            List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
//                            List<Province> provinceList = provinceDao.getAllProvince();
//                            model.setLicenseList(licenseList);
//                            model.setProvinceList(provinceList);
//                            mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
//                            return mv; // Return immediately with the error message
//                        }
//                        hasValidZipFiles = true;
//                    }
//                }
//
//                if (!hasValidZipFiles) {
//                    model.setErrorMessage("No files were uploaded.");
//                    // Load dropdown lists
//                    List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
//                    List<Province> provinceList = provinceDao.getAllProvince();
//                    model.setLicenseList(licenseList);
//                    model.setProvinceList(provinceList);
//                    mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
//                    return mv;
//                }
//
//                File zipDir = null;
//                File extractDir = null;
//
//                if (hasValidZipFiles) {
//                    zipDir = new File(zipSavePath);
//                    extractDir = new File(extractionPath);
//
//                    if (!zipDir.exists() && !zipDir.mkdirs()) {
//                        model.setErrorMessage("Failed to create ZIP directory: " + zipSavePath);
//                        return mv;
//                    }
//
//                    if (!extractDir.exists() && !extractDir.mkdirs()) {
//                        model.setErrorMessage("Failed to create extraction directory: " + extractionPath);
//                        return mv;
//                    }
//                }
//
//                for (MultipartFile file : files) {
//                    if (!file.isEmpty()) {
//                        String originalFilename = file.getOriginalFilename();
//                        if (originalFilename == null || !originalFilename.toLowerCase().endsWith(".zip")) {
//                            processingResults.append("Skipping invalid file: ").append(originalFilename).append("\n");
//                            continue;
//                        }
//
//                        String uniqueFilename = originalFilename;
//
//
//                        if (isFileAlreadyUploaded(billCycle, division, province, originalFilename)) {
//                            model.setFileNameConflict(true);
//                            model.setOriginalFileName(originalFilename);
//                            uniqueFilename = generateUniqueFileName(originalFilename, billCycle, division, province);
//                            processingResults.append("Duplicate found. File renamed to: ").append(uniqueFilename).append("\n");
//                        }
//
////                        // Check if file already exists
////                        if (isFileAlreadyUploaded(billCycle, division, province, originalFilename)) {
////
////                            System.out.println("isFileAllreadyUploaded  "+isFileAlreadyUploaded(billCycle, division, province, originalFilename));
////                            // If user hasn't confirmed yet, return with conflict flag
////                            if (overwriteDecision == null || overwriteDecision.isEmpty()) {
////                                model.setFileNameConflict(true);
////                                model.setOriginalFileName(originalFilename);
////                                mv.addObject("fileNameConflict", true);
////                                mv.addObject("originalFileName", originalFilename);
////                                mv.setViewName("pts/licenseeBilling/fileUpload"); // Ensure the correct JSP is being returned
////                                // request.setAttribute("fileNameConflict", true);
////                              //  model.setErrorMessage("File '" + originalFilename + "' already exists. Do you want to overwrite or upload as a new file?");
////
////                                System.out.println("==============================enter to the alert box method=============================");
////                                // Load dropdown lists
////                                List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
////                                List<Province> provinceList = provinceDao.getAllProvince();
////                                model.setLicenseList(licenseList);
////                                model.setProvinceList(provinceList);
////                                mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
////                                return mv;
////                            }
////
////                            System.out.println("==============================before the cancel button =============================");
////                            // User said to cancel the upload
////                            if ("CANCEL".equalsIgnoreCase(overwriteDecision)) {
////                                processingResults.append("User cancelled upload for: ").append(originalFilename).append("\n");
////
////                                model.setErrorMessage("Cancel the override file save.\n");
////                                System.out.println("cancel button in the alert box ");
////                                continue;
////                            }
////
////                            System.out.println("==============================before the yes button=========================================");
////
////                            // User said to upload with a new name
////                            if ("YES".equalsIgnoreCase(overwriteDecision)) {
////                                System.out.println("yes button in the alert box ");
////
////                                uniqueFilename = generateUniqueFileName(originalFilename, billCycle, division, province);
////                            }
////
////                            // If "YES", we proceed with overwriting the same filename
////                        }
//
//                        // Save the file
//                        File zipFile = new File(zipDir, uniqueFilename);
//                        file.transferTo(zipFile);
//
//                        // Delete existing extraction folder
//                        if (extractDir.exists()) {
//                            deleteDirectory(extractDir);
//                        }
//
//                        // Extract zip contents
//                        ZipExtractor.unzip(zipFile.getAbsolutePath(), extractionPath);
//
//                        // Move contents from extracted folder (e.g., /WPNL/) to main path
//                        // Move contents of the extracted folder to the parent folder
//                        File extractedFolder = new File(extractionPath, province);
//                        if (extractedFolder.exists() && extractedFolder.isDirectory()) {
//                            File[] extractedFiles = extractedFolder.listFiles();
//                            if (extractedFiles != null) {
//                                for (File extractedFile : extractedFiles) {
//                                    Files.move(
//                                            extractedFile.toPath(),
//                                            new File(extractionPath, extractedFile.getName()).toPath(),
//                                            StandardCopyOption.REPLACE_EXISTING
//                                    );
//                                }
//                            }
//                            // Delete the now-empty extracted folder
//                            deleteDirectory(extractedFolder);
//                        }
//
//                        try {
//                            FileUploadHeader header = new FileUploadHeader();
//                            header.setBillCycleNo(Long.parseLong(billCycle));
//                            header.setLicenseCode(division);
//                            header.setProvinceCode(province);
//                            header.setFileName(uniqueFilename);
//                            header.setIsUploaded(1L);
//                            header.setUploadedBy("system");
//                            header.setUploadedDate(LocalDateTime.now());
//                            //  header.setFileType("ZIP");
//
//                            fileUploadHeaderDao.save(header);
//
//                            processingResults.append("Saved metadata for: ").append(originalFilename).append("\n");
//                            filesProcessed = true;
//
//                        } catch (Exception e) {
//                            processingResults.append("Error saving metadata for: ").append(originalFilename)
//                                    .append(" - ").append(e.getMessage()).append("\n");
//                        }
//                    }
//                }
//
//                System.out.println("end the file uploading process");
//                System.out.println("filesProcessed: " + filesProcessed);
//
//                if (filesProcessed) {
//                    model.setSuccessMessage("Files processed successfully.\n");
//                    System.out.println("Files processed successfully.");
//                } else {
//                    model.setErrorMessage("No files were processed.\n");
//                    System.out.println("No files were processed.");
//                }
//
//                // Load dropdown lists
//                List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
//                List<Province> provinceList = provinceDao.getAllProvince();
//                model.setLicenseList(licenseList);
//                model.setProvinceList(provinceList);
//                mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
//
//                return mv;
//
//
//
//
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            model.setErrorMessage("Error checking upload lock status: " + e.getMessage());
//            // Load dropdown lists
//            List<DistributionLicense> licenseList = distributionLicenseDao.getLicenseList();
//            List<Province> provinceList = provinceDao.getAllProvince();
//            model.setLicenseList(licenseList);
//            model.setProvinceList(provinceList);
//            mv.addObject("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
//            return mv; // Stop further processing
//        }
//    }


    // Utility method to delete a directory and its contents
    private boolean deleteDirectory(File directory) {
        if (directory.isDirectory()) {
            File[] files = directory.listFiles();
            if (files != null) {
                for (File file : files) {
                    deleteDirectory(file);
                }
            }
        }
        return directory.delete();
    }

    private String generateUniqueFileName(String baseName, String billCycle, String division, String province) {
        String nameWithoutExt = baseName;
        String extension = "";

        int dotIndex = baseName.lastIndexOf('.');
        if (dotIndex > 0) {
            nameWithoutExt = baseName.substring(0, dotIndex);
            extension = baseName.substring(dotIndex);
        }

        String candidate = baseName;
        int counter = 1;
        while (isFileAlreadyUploaded(billCycle, division, province, candidate)) {
            candidate = nameWithoutExt + counter + extension;
            counter++;
        }

        return candidate;
    }

    private boolean isFileAlreadyUploaded(String billCycle, String division, String province, String fileName) {
        try {
            FileUploadHeader existing = fileUploadHeaderDao.findByCompositeKeyAndFileName(
                    Long.parseLong(billCycle), division, province, fileName);
            return existing != null;
        } catch (Exception e) {
            return false;
        }
    }

    /*
    private String getUserName(HttpServletRequest request) {
        try {
            if (request.getUserPrincipal() != null) {
                String username = request.getUserPrincipal().getName();
                return username.length() > 15 ? username.substring(0, 15) : username;
            }
        } catch (Exception e) {
            // log if needed
        }
        return "system";
    }*/

    @Transactional
    @GetMapping(value = "/getBillCycle", produces = "text/plain")
    public @ResponseBody String getBillCycle() throws Exception {
        Long billCycle = billCycleDao.getCurrentBillCycleNo();
        if(billCycle!=null)
            return billCycle.toString();
        else
            return "";
    }

    @Transactional
    @GetMapping("/viewUploadDetails")
    public ModelAndView viewUploads(@RequestParam("billCycle") String billCycle,
                                    @RequestParam("division") String division,
                                    Model model) {
        System.out.println("==============enter to the method ======================");
        ModelAndView modelAndView = new ModelAndView("pts/licenseeBilling/viewFiles/viewFile");

        try {
            List<FileUploadHeader> uploadDetails = fileUploadHeaderDao.getUploadDetails(billCycle, division);

            if (!uploadDetails.isEmpty()) {

                // Group files by province name and sort by uploaded date
                Map<String, List<FileUploadHeader>> groupedByProvince = uploadDetails.stream()
                        .peek(upload -> {
                            String provinceName = fileUploadHeaderDao.getProvinceName(upload.getProvinceCode());
                            upload.setProvinceCode(provinceName); // Replace province code with province name

//                            // Fetch isUploadLocked value for the province
//                            Long isUploadLocked = fileUploadHeaderDao.isUploadLocked(billCycle, division, upload.getProvinceCode());
//                            upload.setIsUploadLocked(isUploadLocked); // Assuming FileUploadHeader has a field for isUploadLocked

                        })
                        .sorted(Comparator.comparing(FileUploadHeader::getUploadedDate).reversed()) // Sort by uploaded date (latest first)
                        .collect(Collectors.groupingBy(FileUploadHeader::getProvinceCode)); // Group by province name

                modelAndView.addObject("groupedUploadDetails", groupedByProvince);
                System.out.println("========22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222"+groupedByProvince);
            }

            // Add selected billCycle and division to the ModelAndView
            modelAndView.addObject("selectedBillCycle", billCycle);
            modelAndView.addObject("selectedDivision", division);

            List<DistributionLicense> licenseList = DistributionLicenseDao.getLicenseList();
            List<Province> provinceList = provinceDao.getAllProvince();
            model.addAttribute("licenseList", licenseList);
            model.addAttribute("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
            model.addAttribute("billCycleNo", billCycle);

            System.out.println("============Grouped uploadDetails size: ================ " + uploadDetails.size());

            return modelAndView;

        } catch (Exception e) {
            System.err.println("Error occurred while fetching upload details: " + e.getMessage());
            e.printStackTrace();
            return new ModelAndView("errorPage", "errorMessage", "Failed to fetch upload details.");
        }
    }

    @GetMapping("/downloadZipFile")
    public void downloadZipFile(
            @RequestParam("fileName") String fileName,
            @RequestParam("billCycle") String billCycle,
            @RequestParam("division") String division,
            @RequestParam("province") String province,
            HttpServletResponse response) throws IOException {

        // Construct the file path
        String filePath = ConfigProperties.getProperty("FILE_PATH") + billCycle + File.separator + division + File.separator + province +"_zip"+ File.separator + fileName;
        File file = new File(filePath);

        // Check if the file exists
        if (!file.exists()) {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            response.getWriter().write("File not found: " + fileName);
            return;
        }

        // Set response headers for file download
        response.setContentType("application/zip");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        response.setContentLengthLong(file.length());

        // Write the file to the response output stream
        try (FileInputStream fis = new FileInputStream(file);
             OutputStream os = response.getOutputStream()) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
        }
    }

    @GetMapping("/generateDownloadUrl")
    @ResponseBody
    public String generateDownloadUrl(
            @RequestParam("fileName") String fileName,
            @RequestParam("billCycle") Long billCycle,
            @RequestParam("division") String division,
            @RequestParam("province") String province) {
        // Base URL for the download endpoint
        String baseUrl = "/PTS/downloadZipFile";

        // Construct the URL with query parameters
        String downloadUrl = String.format("%s?fileName=%s&billCycle=%d&division=%s&province=%s",
                baseUrl,
                fileName,
                billCycle,
                division,
                province);

        return downloadUrl; // Return the URL as a response
    }

//    @GetMapping("/downloadZipFile")
//    public ResponseEntity<InputStreamResource> downloadFile(
//            @RequestParam("billCycle") String billCycle,
//            @RequestParam("licensee") String licensee,
//            @RequestParam("province") String province,
//            @RequestParam("fileName") String fileName) throws IOException {
//
//        String basePath = ConfigProperties.getReportPath();
//        String filePath = basePath + File.separator
//                + billCycle + File.separator
//                + licensee + File.separator
//                + province + File.separator
//                + fileName;
//
//        File file = new File(filePath);
//        System.out.println("Download file path: " + filePath);
//        if (!file.exists()) {
//            return ResponseEntity.notFound().build();
//        }
//
//        InputStreamResource resource = new InputStreamResource(new FileInputStream(file));
//        return ResponseEntity.ok()
//                .contentType(MediaType.APPLICATION_OCTET_STREAM)
//                .contentLength(file.length())
//                .header("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"")
//                .body(resource);
//    }
//
//
//
//    private List<String> getFileList(String folderPath)
//    {
//        File folder = new File(folderPath);
//
//        List<String> fileNames = new ArrayList<>();
//        if (folder.exists() && folder.isDirectory())
//        {
//            for (File file : folder.listFiles())
//            {
//                if (file.isFile())
//                {
//                    fileNames.add(file.getName());
//                }
//            }
//        }
//        return fileNames;
//    }



    @GetMapping("/getProvinceName")
    public @ResponseBody String getProvinceName(@RequestParam("provinceCode") String provinceCode) {
        try {
            String provinceName = fileUploadHeaderDao.getProvinceName(provinceCode);
            return provinceName != null ? provinceName : "Unknown Province";
        } catch (Exception e) {
            e.printStackTrace();
            return "Error fetching province name";
        }
    }


//    //download zip file
//    @GetMapping("/download")
//    public ResponseEntity<InputStreamResource> downloadFile(
//            @RequestParam("billCycle") String billCycle,
//            @RequestParam("licensee") String licensee,
//            @RequestParam("province") String province,
//            @RequestParam("pssCode") String pssCode,
//            @RequestParam("meterPointCode") String meterPointCode,
//            @RequestParam("fileName") String fileName) throws IOException {
//
//        String basePath = ConfigProperties.getReportPath();
//        String filePath = basePath + File.separator
//                + billCycle + File.separator
//                + licensee + File.separator
//                + province + File.separator
//                + pssCode + File.separator
//                + meterPointCode + File.separator
//                + fileName;
//
//        File file = new File(filePath);
//        System.out.println("Download file path: " + filePath);
//        if (!file.exists()) {
//            return ResponseEntity.notFound().build();
//        }
//
//        InputStreamResource resource = new InputStreamResource(new FileInputStream(file));
//        return ResponseEntity.ok()
//                .contentType(MediaType.APPLICATION_OCTET_STREAM)
//                .contentLength(file.length())
//                .header("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"")
//                .body(resource);
//    }
//
//
//
//    private List<String> getFileList(String folderPath)
//    {
//        File folder = new File(folderPath);
//
//        List<String> fileNames = new ArrayList<>();
//        if (folder.exists() && folder.isDirectory())
//        {
//            for (File file : folder.listFiles())
//            {
//                if (file.isFile())
//                {
//                    fileNames.add(file.getName());
//                }
//            }
//        }
//        return fileNames;
//
//    }

//    // File: src/main/java/com/it/ceb/pts/controller/FileController.java
//    @Transactional
//    @PostMapping("/updateProvinceConfig")
//    public ResponseEntity<String> updateProvinceConfig(
//            @RequestParam("billCycle") String billCycle,
//            @RequestParam("provinceCode") String provinceCode,
//            @RequestParam("divisionCode") String divisionCode,
//            @RequestParam("isUploadLocked") Long isUploadLocked,
//            @RequestParam("isReadingProcessLocked") Long isReadingProcessLocked) {
//        try {
//            ProvinceConfig provinceConfig = new ProvinceConfig();
//            provinceConfig.setBillCycleNo(new BillCycle(Long.parseLong(billCycle)));
//            provinceConfig.setProvinceCode(new Province(provinceCode));
//            provinceConfig.setLicenseCode(new DistributionLicense(divisionCode));
//            provinceConfig.setIsUploadLocked(isUploadLocked);
//            provinceConfig.setIsReadingProcessLocked(isReadingProcessLocked);
//
//            fileUploadHeaderDao.save(provinceConfig); // Save the configuration using DAO
//
//            return ResponseEntity.ok("Province configuration updated successfully.");
//        } catch (Exception e) {
//            e.printStackTrace();
//            return ResponseEntity.status(HttpServletResponse.SC_INTERNAL_SERVER_ERROR)
//                    .body("Failed to update province configuration: " + e.getMessage());
//        }
//    }



    @GetMapping("/getProvinceCode")
    @ResponseBody
    public String getProvinceCode(@RequestParam("provinceName") String provinceName) {
        try {
            String provinceCode = provinceDao.getProvinceCodeByName(provinceName);
            return provinceCode != null ? provinceCode : "Unknown Province";
        } catch (Exception e) {
            e.printStackTrace();
            return "Error fetching province code";
        }
    }

    @RequestMapping(value = "/getProvinceConfigDetails", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public List<Map<String, Object>> getProvinceConfigDetails(
            @RequestParam("billCycleNo") Long billCycleNo,
            @RequestParam("licenseCode") String licenseCode) {
        try {
            List<Object[]> results = fileUploadHeaderDao.findLockStatusByParams(billCycleNo, licenseCode, null);
            List<Map<String, Object>> response = new ArrayList<>();

            for (Object[] result : results) {
                Map<String, Object> provinceData = new HashMap<>();
                provinceData.put("provinceCode", result[0]);
                provinceData.put("isUploadLocked", result[1]);
                response.add(provinceData);
            }
            return response;
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }

    @GetMapping("/getUploadLockStatus")
    @ResponseBody
    public String getUploadLockStatus(
            @RequestParam("billCycle") Long billCycle,
            @RequestParam("licenseCode") String licenseCode,
            @RequestParam("provinceCode") String provinceCode) {
        try {
            Long isUploadLocked = fileUploadHeaderDao.findUploadLockStatus(billCycle, licenseCode, provinceCode);
            if (isUploadLocked != null) {
                return "Upload Lock Status: " + isUploadLocked;
            } else {
                return "No data found for the given parameters.";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "Error occurred while fetching upload lock status.";
        }
    }


    @RequestMapping(value = "/updateIsUploadLocked", method = RequestMethod.POST)
    @ResponseBody
    @Transactional
    public ResponseEntity<?> updateIsUploadLocked(
            @RequestParam("billCycleNo") Long billCycleNo,
            @RequestParam("licenseCode") String licenseCode,
            @RequestParam("provinceCode") String provinceCode,
            @RequestParam("isUploadLocked") String isUploadLocked) {
        try {
            boolean updated = fileUploadHeaderDao.updateIsUploadLocked(billCycleNo, licenseCode, provinceCode, "true".equalsIgnoreCase(isUploadLocked) ? 1L : 0L);

            if (updated) {
                return ResponseEntity.ok("isUploadLocked updated successfully.");
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("ProvinceConfig not found for the given parameters.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred: " + e.getMessage());
        }
    }

    //======================================================================================
    // this is the method to update the isUploadLocked status in the ProvinceConfig table
    //======================================================================================

//    @Override
//    @Transactional
//    public boolean updateIsUploadLocked(Long billCycleNo, String licenseCode, String provinceCode, Long isUploadLocked) {
//        TypedQuery<ProvinceConfig> query = entityManager.createQuery(
//                "SELECT pc FROM ProvinceConfig pc " +
//                        "WHERE pc.id.billCycleNo = :billCycleNo " +
//                        "AND pc.id.licenseCode = :licenseCode " +
//                        "AND pc.provinceCode.provinceCode = :provinceCode",
//                ProvinceConfig.class);
//
//        query.setParameter("billCycleNo", billCycleNo);
//        query.setParameter("licenseCode", licenseCode);
//        query.setParameter("provinceCode", provinceCode);
//
//        List<ProvinceConfig> results = query.getResultList();
//
//        if (results.size() == 1) {
//            ProvinceConfig provinceConfig = results.get(0);
//            provinceConfig.setIsUploadLocked(isUploadLocked);
//            entityManager.merge(provinceConfig);
//            return true;
//        }
//
//        return false; // No matching record or multiple records found
//    }

}
