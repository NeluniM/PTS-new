package com.it.ceb.pts.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.it.ceb.pts.domain.*;
import com.it.ceb.pts.model.BillCycleModel;
import com.it.ceb.pts.model.ModelService;
import com.it.ceb.pts.model.TariffModel;
import com.it.ceb.pts.repo.*;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.*;


@Controller
public class ConfigController {

    @Autowired
    private BillCycleDao billCycleDao;
    @Autowired
    private ProvinceDao provinceDao;
    @Autowired
    private DistributionLicenseDao DistributionLicenseDao;
    @Autowired
    private ModelService modelService;
    @Autowired
    private ProvinceConfigDao provinceConfigDao;
    @Autowired
    private TariffDao tariffDao;
    @Autowired
    private TariffCategoryDao tariffCategoryDao;

    // Use consistent date format for both GET and POST
    private static final SimpleDateFormat CONSISTENT_DATE_FORMAT = new SimpleDateFormat("M/d/yyyy H:mm");

    //-------------------------------------------------------------------------------------------
    //						licensee Billing
    //-------------------------------------------------------------------------------------------

    @Transactional
    @RequestMapping(value = "/config", method = RequestMethod.GET)
    public String viewConfig(Model model,
                             @RequestParam(value="billCycleNo" ,required = false) String billCycleNo) throws Exception {
        String bc="";
        if(!Objects.equals(billCycleNo, "")){
            bc = provinceConfigDao.getCurrentBillCycle().getBillCycleNo().toString();
        }

        // Get current bill cycle for auto-fill
        BillCycle currentBillCycle = provinceConfigDao.getCurrentBillCycle();
        String currentBillCycleNo = "";
        if (currentBillCycle != null) {
            currentBillCycleNo = currentBillCycle.getBillCycleNo().toString();
        }

        List<DistributionLicense> licenseList = DistributionLicenseDao.getLicenseList();
        List<Province> provinceList = provinceDao.getAllProvince();
        model.addAttribute("billCycleNo", bc);
        model.addAttribute("currentBillCycleNo", currentBillCycleNo); // Add this line
        model.addAttribute("licenseList", licenseList);
        model.addAttribute("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
        return "pts/licenseeBilling/config/config";
    }//    @Transactional
//    @RequestMapping(value = "/config", method = RequestMethod.GET)
//    public String viewConfig(Model model) throws Exception {
//        List<DistributionLicense> licenseList = DistributionLicenseDao.getLicenseList();
//        List<Province> provinceList = provinceDao.getAllProvince();
//        model.addAttribute("licenseList", licenseList);
//        model.addAttribute("provinceList", new ObjectMapper().writeValueAsString(modelService.getAllProvinces(provinceList)));
//        return "pts/licenseeBilling/config/config";
//    }

    // Tariff
    @Transactional
    @RequestMapping(value = "/tariff", method = RequestMethod.GET)
    public String tariff(TariffModel model) throws Exception {
        return "pts/licenseeBilling/tariff/tariff";
    }

    @Transactional
    @RequestMapping(value = "/tariffConfig", method = RequestMethod.GET)
    public String tariffConfig(Model model) throws Exception {
        // Load tariff data automatically when page loads
        List<Tariff> tariffs = tariffDao.findAllOrderByCurrentFirst();
        List<TariffModel> tariffModels = new ArrayList<>();

        for (Tariff tariff : tariffs) {
            TariffModel tariffModel = new TariffModel();
            tariffModel.setTariffId(tariff.getTariffId());
            tariffModel.setTariffCategoryCode(tariff.getTariffCategoryCode().getTariffCategoryCode());
            tariffModel.setValidFrom(tariff.getValidFrom());
            tariffModel.setValidTill(tariff.getValidTill());
            tariffModel.setIsCurrent(tariff.getIsCurrent());
            tariffModel.setRate(tariff.getRate());

            // Add TariffCategory details
            tariffModel.setTariffName(tariff.getTariffCategoryCode().getTariffName());
            tariffModel.setTarrifType(tariff.getTariffCategoryCode().getTarrifType());
            tariffModel.setGroupKey(tariff.getTariffCategoryCode().getGroupKey());

            tariffModels.add(tariffModel);
        }

        // Sort and group tariffs by type
        List<TariffModel> sortedTariffModels = sortAndGroupTariffsByType(tariffModels);

        model.addAttribute("tariffList", sortedTariffModels);
        return "pts/licenseeBilling/tariff/tariffConfig";
    }


    // Include remark in the response
    private String convertMonthToString(BigDecimal month) {
        if (month == null) return "";
        int monthInt = month.intValue();
        String[] monthNames = {
                "", "January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"
        };
        return (monthInt >= 1 && monthInt <= 12) ? monthNames[monthInt] : "";
    }

    // Utility method to convert String month name to BigDecimal
    private BigDecimal convertStringToMonth(String monthName) {
        if (monthName == null || monthName.trim().isEmpty()) return null;
        Map<String, Integer> monthMap = new HashMap<>();
        monthMap.put("January", 1);
        monthMap.put("February", 2);
        monthMap.put("March", 3);
        monthMap.put("April", 4);
        monthMap.put("May", 5);
        monthMap.put("June", 6);
        monthMap.put("July", 7);
        monthMap.put("August", 8);
        monthMap.put("September", 9);
        monthMap.put("October", 10);
        monthMap.put("November", 11);
        monthMap.put("December", 12);
        Integer monthInt = monthMap.get(monthName);
        return monthInt != null ? new BigDecimal(monthInt) : null;
    }

    // Get BillCycle Details

    @RequestMapping(value = "/getBillCycleDetails", method = RequestMethod.GET)
    @ResponseBody
    public BillCycleModel getBillCycleDetails(@RequestParam("billCycleNo") Long billCycleNo) {
        try {
            BillCycle billCycle = billCycleDao.findByBillCycleNo(billCycleNo);

            if (billCycle != null) {
                BillCycleModel model = new BillCycleModel();
                model.setBillCycleNo(billCycle.getBillCycleNo());
                model.setBillYear(billCycle.getBillYear());
                model.setBillMonth(billCycle.getBillMonth());
                model.setBillMonthName(convertMonthToString(billCycle.getBillMonth()));
                model.setIsCurrent(billCycle.getIsCurrent());
                model.setRecordedPeakDemand(billCycle.getRecordedPeakDemand() != null ? billCycle.getRecordedPeakDemand() : 0L);
                model.setRemarks(billCycle.getRemarks() != null ? billCycle.getRemarks() : "");

                // Use consistent date format (M/d/yyyy H:mm) for both GET and POST
                if (billCycle.getCoincidentPeakDate() != null) {
                    model.setCoincidentPeakDate(CONSISTENT_DATE_FORMAT.format(billCycle.getCoincidentPeakDate()));
                } else {
                    model.setCoincidentPeakDate("");
                }

                return model;
            }
            return null;
        } catch (Exception e) {
            System.out.println("Error in getBillCycleDetails: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }



    // Update Bill Cycle Details
    @RequestMapping(value = "/updateBillCycleDetails", method = RequestMethod.POST)
    @ResponseBody
    @Transactional
    public ResponseEntity<?> updateBillCycleDetails(@RequestBody BillCycleModel request) {
        try {
            System.out.println("Received update request: " + request);
            System.out.println("CoincidentPeakDate received: " + request.getCoincidentPeakDate());

            BillCycle billCycle = billCycleDao.findByBillCycleNo(request.getBillCycleNo());

            if (billCycle == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Bill Cycle not found");
            }

            if (billCycle.getIsCurrent() != null && billCycle.getIsCurrent().compareTo(1L) == 0) {
                billCycle.setBillYear(request.getBillYear());
                // Convert string month name to BigDecimal
                BigDecimal billMonth = convertStringToMonth(request.getBillMonthName());
                if (billMonth == null) {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid bill month name");
                }
                billCycle.setBillMonth(billMonth);
                billCycle.setIsCurrent(1L);
                billCycle.setRecordedPeakDemand(request.getRecordedPeakDemand() != null ? request.getRecordedPeakDemand().longValue() : 0L);
                billCycle.setRemarks(request.getRemarks() != null ? request.getRemarks() : "");

                // Parse date with multiple format attempts
                if (request.getCoincidentPeakDate() != null && !request.getCoincidentPeakDate().trim().isEmpty()) {
                    try {
                        String dateStr = request.getCoincidentPeakDate().trim();
                        System.out.println("Attempting to parse date: '" + dateStr + "'");

                        Date parsedDate = null;

                        // Try multiple date formats
                        SimpleDateFormat[] formats = {
                                new SimpleDateFormat("M/d/yyyy H:mm"),
                                new SimpleDateFormat("MM/dd/yyyy HH:mm"),
                                new SimpleDateFormat("M/d/yyyy HH:mm"),
                                new SimpleDateFormat("MM/dd/yyyy H:mm")
                        };

                        for (SimpleDateFormat format : formats) {
                            try {
                                format.setLenient(false);
                                parsedDate = format.parse(dateStr);
                                System.out.println("Successfully parsed date with format: " + format.toPattern());
                                break;
                            } catch (Exception e) {
                                // Continue to next format
                                System.out.println("Failed to parse with format: " + format.toPattern());
                            }
                        }

                        if (parsedDate != null) {
                            billCycle.setCoincidentPeakDate(parsedDate);
                            System.out.println("Date set to: " + parsedDate);
                        } else {
                            System.out.println("Could not parse date with any format");
                            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                                    .body("Invalid date format for coincidentPeakDate. Expected formats: M/d/yyyy H:mm or MM/dd/yyyy HH:mm");
                        }
                    } catch (Exception e) {
                        System.out.println("Exception parsing date: " + e.getMessage());
                        e.printStackTrace();
                        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                                .body("Invalid date format for coincidentPeakDate: " + e.getMessage());
                    }
                } else {
                    billCycle.setCoincidentPeakDate(null);
                    System.out.println("Date set to null");
                }

                billCycle.setUpdatedBy(LocalDate.now());
                billCycle.setUpdatedDate(LocalDate.now().toString());

                // Save and flush to ensure immediate persistence
                billCycleDao.save(billCycle);
                System.out.println("Bill cycle saved successfully");

                return ResponseEntity.ok("Bill Cycle updated successfully");
            } else {
                return ResponseEntity.status(HttpStatus.FORBIDDEN)
                        .body("Data is readonly as IsCurrent is not set to 1");
            }
        } catch (Exception e) {
            System.out.println("Exception in updateBillCycleDetails: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("An error occurred: " + e.getMessage());
        }
    }

    @RequestMapping(value = "/provinceConfig", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public Map<String, Object> fetchProvinceConfig(
            @RequestParam("billCycleNo") Long billCycleNo,
            @RequestParam("licenseCode") String licenseCode,
            @RequestParam("provinceCode") String provinceCode) {
        Map<String, Object> response = new HashMap<>();
        try {
            // First check if bill cycle exists
            BillCycle billCycle = billCycleDao.findByBillCycleNo(billCycleNo);
            if (billCycle == null) {
                response.put("error", "Bill Cycle not found");
                response.put("message", "No Bill Cycle found with number: " + billCycleNo);
                return response;
            }

            // Then try to get province config
            ProvinceConfig provinceConfig = provinceConfigDao.getProvinceConfig(billCycleNo, licenseCode, provinceCode);

            if (provinceConfig == null) {
                response.put("error", "Province Configuration not found");
                response.put("message", "No Province Configuration found for the given parameters.");
                return response;
            }

            // Creating province config object
            Map<String, Object> provinceConf = new HashMap<>();
            provinceConf.put("provinceCode", provinceConfig.getProvinceCode().getProvinceCode());
            provinceConf.put("licenseCode", provinceConfig.getLicenseCode().getLicenseCode());
            provinceConf.put("billCycleNo", provinceConfig.getBillCycleNo().getBillCycleNo());
            provinceConf.put("isUploadLocked", provinceConfig.getIsUploadLocked());

            Long isCurrent = provinceConfigDao.isBillCycleCurrent(billCycleNo);

            response.put("provinceConfig", provinceConf);
            response.put("isCurrent", isCurrent);
            response.put("success", true);

            System.out.println("Province config found: " + provinceConf);

            return response;
        } catch (Exception e) {
            System.out.println("Error in fetchProvinceConfig: " + e.getMessage());
            e.printStackTrace();
            response.put("error", "Database error");
            response.put("message", "An error occurred while fetching data: " + e.getMessage());
            return response;
        }
    }


    @Transactional
    @RequestMapping(value = "/updateProvinceConfig", method = RequestMethod.POST)
    public ResponseEntity<?> updateProvinceConfig(
            @RequestParam("billCycleNo") Long billCycleNo,
            @RequestParam("licenseCode") String licenseCode,
            @RequestParam("provinceCode") String provinceCode,
            @RequestParam("isUploadLocked") String isUploadLocked
    ) {
        try {
            ProvinceConfig provinceConfig = provinceConfigDao.getProvinceConfig(billCycleNo, licenseCode,provinceCode);
            System.out.println(provinceConfig);

            if (provinceConfig == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("No Province Configuration found for the given parameters.");
            }

            System.out.println("Current Province Config: " + provinceConfig);
            // Update the provinceConfig object with new values
            provinceConfig.setIsUploadLocked("true".equalsIgnoreCase(isUploadLocked) ? 1L : 0L);
            if(provinceConfig.getIsUploadLocked()==0L){
                System.out.println("upload locked set to 0");
                provinceConfig.setIsReadingProcessLocked(0L);
            }
//            provinceConfig.setIsReadingProcessLocked("true".equalsIgnoreCase(isReadingProcessLocked) ? 1L : 0L);
            if(provinceConfig.getIsUploadLocked()==0L){
                System.out.println("upload locked set to 0");
                provinceConfig.setIsReadingProcessLocked(0L);
            }

            // Save the updated provinceConfig object
            provinceConfigDao.save(provinceConfig);

            return ResponseEntity.ok("Province configurations updated successfully");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred: " + e.getMessage());
        }
    }

    //-------------------------------------------------------------------------------------------
    //						Tariff Configuration
    //-------------------------------------------------------------------------------------------

    // Get calculated dates for new tariff popup
    @RequestMapping(value = "/getCalculatedTariffDates", method = RequestMethod.GET, produces = "application/json")
    @ResponseBody
    public ResponseEntity<Map<String, String>> getCalculatedTariffDates() {
        try {
            System.out.println("Getting calculated tariff dates...");
            // Get current tariffs to find the latest validFrom and validTill dates
            List<Tariff> currentTariffs = tariffDao.findAllOrderByCurrentFirst();

            System.out.println("Found " + (currentTariffs != null ? currentTariffs.size() : 0) + " current tariffs");

            if (currentTariffs == null || currentTariffs.isEmpty()) {
                System.out.println("No current tariffs found");
                Map<String, String> errorResponse = new HashMap<>();
                errorResponse.put("error", "No current tariffs found to calculate new dates");
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorResponse);
            }

            // Get the first current tariff to extract dates (assuming all current tariffs have same dates)
            Tariff firstCurrentTariff = currentTariffs.get(0);
            LocalDate currentValidFrom = firstCurrentTariff.getValidFrom();
            LocalDate currentValidTill = firstCurrentTariff.getValidTill();

            System.out.println("Current validFrom: " + currentValidFrom);
            System.out.println("Current validTill: " + currentValidTill);

            if (currentValidFrom == null || currentValidTill == null) {
                System.out.println("Current tariff dates are null");
                Map<String, String> errorResponse = new HashMap<>();
                errorResponse.put("error", "Current tariff dates are null");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorResponse);
            }

            // Calculate new dates by adding 6 months
            LocalDate newValidFrom = currentValidFrom.plusMonths(6);
            LocalDate newValidTill = currentValidTill.plusMonths(6);

            System.out.println("Calculated validFrom: " + newValidFrom);
            System.out.println("Calculated validTill: " + newValidTill);

            Map<String, String> calculatedDates = new HashMap<>();
            calculatedDates.put("validFrom", newValidFrom.toString());
            calculatedDates.put("validTill", newValidTill.toString());

            System.out.println("Returning calculated dates: " + calculatedDates);
            return ResponseEntity.ok(calculatedDates);

        } catch (Exception e) {
            System.out.println("Error in getCalculatedTariffDates: " + e.getMessage());
            e.printStackTrace();
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", "An error occurred while calculating tariff dates: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }    // Update Tariff
    @RequestMapping(value = "/updateTariff", method = RequestMethod.POST)
    @ResponseBody
    @Transactional
    public ResponseEntity<?> updateTariff(@RequestBody TariffModel tariffModel) {
        try {
            // Validation
            if (tariffModel.getTariffId() == null) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Tariff ID is required");
            }

            if (tariffModel.getValidFrom() == null || tariffModel.getValidTill() == null) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Valid From and Valid Till dates are required");
            }

            if (tariffModel.getValidFrom().compareTo(tariffModel.getValidTill()) >= 0) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Valid From date must be before Valid Till date");
            }

            Tariff tariff = tariffDao.findById(tariffModel.getTariffId());

            if (tariff == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Tariff not found");
            }

            // Only allow editing if it's the current tariff
            if (tariff.getIsCurrent() != 1L) {
                return ResponseEntity.status(HttpStatus.FORBIDDEN)
                        .body("Only current tariff can be edited");
            }

            // Only update the allowed fields: validFrom, validTill, and rate
            // DO NOT update tariffCategoryCode - keep it as is
            tariff.setValidFrom(tariffModel.getValidFrom());
            tariff.setValidTill(tariffModel.getValidTill());
            tariff.setRate(tariffModel.getRate());

            // Keep all other fields unchanged (tariffCategoryCode, isCurrent, etc.)
            tariffDao.save(tariff);

            return ResponseEntity.ok("Tariff updated successfully");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("An error occurred: " + e.getMessage());
        }
    }

    // Save All Tariffs
    // Save All Tariffs
    @RequestMapping(value = "/saveAllTariffs", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    @Transactional
    public ResponseEntity<?> saveAllTariffs(@RequestBody List<TariffModel> tariffModels) {
        try {
            // Validate input
            if (tariffModels == null || tariffModels.isEmpty()) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Tariff data cannot be null or empty");
            }

            // Validate that exactly 8 records are provided
            if (tariffModels.size() != 8) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body("Exactly 8 tariff records are required. Received: " + tariffModels.size());
            }

            // Tariff name-to-category code mapper
            Map<String, String> tariffCategoryCodeMapper = new HashMap<>();
            tariffCategoryCodeMapper.put("Energy Day Tariff", "DAY_TRF");
            tariffCategoryCodeMapper.put("Energy Peak Tariff", "PEAK_TRF");
            tariffCategoryCodeMapper.put("Energy Off Peak Tariff", "OFFP_TRF");
            tariffCategoryCodeMapper.put("Capacity Tariff", "CAP_TRF");
            tariffCategoryCodeMapper.put("Day Upward Adjustment Factor", "DAY_ADJ_FACTOR");
            tariffCategoryCodeMapper.put("Peak Upward Adjustment Factor", "PEAK_ADJ_FACTOR");
            tariffCategoryCodeMapper.put("Off Peak Upward Adjustment Factor", "OFFP_ADJ_FACTOR");
            tariffCategoryCodeMapper.put("Peak Demand Factor", "PEAK_DMN_FACTOR");

            List<Tariff> tariffs = new ArrayList<>();
            List<String> expectedCategoryCodes = new ArrayList<>(tariffCategoryCodeMapper.values());

            for (TariffModel tariffModel : tariffModels) {
                // Validation
                if (tariffModel.getTariffName() == null || tariffModel.getTariffName().isBlank()) {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Tariff Name is required");
                }
                if (tariffModel.getValidFrom() == null || tariffModel.getValidTill() == null) {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Valid From and Valid Till dates are required");
                }
                if (tariffModel.getValidFrom().compareTo(tariffModel.getValidTill()) >= 0) {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Valid From date must be before Valid Till date");
                }
                if (tariffModel.getRate() == null) {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Rate is required");
                }

                // Map tariff name to category code
                String tariffCategoryCode = tariffCategoryCodeMapper.get(tariffModel.getTariffName());
                if (tariffCategoryCode == null) {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                            .body("Invalid Tariff Name: " + tariffModel.getTariffName());
                }

                // Validate tariffCategoryCode against the input (if provided)
                if (tariffModel.getTariffCategoryCode() != null && !tariffModel.getTariffCategoryCode().equals(tariffCategoryCode)) {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                            .body("Tariff Category Code mismatch for tariff: " + tariffModel.getTariffName());
                }

                TariffCategory tariffCategory = tariffCategoryDao.findByTariffCategoryCode(tariffCategoryCode);
                if (tariffCategory == null) {
                    return ResponseEntity.status(HttpStatus.NOT_FOUND)
                            .body("Tariff Category not found for code: " + tariffCategoryCode);
                }

                Tariff tariff = new Tariff();
                tariff.setTariffCategoryCode(tariffCategory);
                tariff.setRate(tariffModel.getRate());
                tariff.setValidFrom(tariffModel.getValidFrom());
                tariff.setValidTill(tariffModel.getValidTill());
                tariff.setIsCurrent(1L); // Set new tariffs as current
                tariff.setUpdatedUser(tariffModel.getUpdatedUser() != null ? tariffModel.getUpdatedUser() : "SYSTEM");
                tariff.setUpdatedTime(LocalDate.now());

                tariffs.add(tariff);
            }

            // Validate that all 8 expected category codes are present
            List<String> providedCategoryCodes = tariffs.stream()
                    .map(t -> t.getTariffCategoryCode().getTariffCategoryCode())
                    .collect(Collectors.toList());

            for (String expectedCode : expectedCategoryCodes) {
                if (!providedCategoryCodes.contains(expectedCode)) {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                            .body("Missing required tariff category: " + expectedCode);
                }
            }

            // This will automatically update previous records to non-current and add new ones as current
            tariffDao.addTariffs(tariffs);

            return ResponseEntity.ok("Tariffs saved successfully. Previous tariffs updated to non-current.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("An error occurred while saving tariffs: " + e.getMessage());
        }
    }


    @Transactional
    @RequestMapping(value = "/getNonCurrentTariffs", method = RequestMethod.GET)
    public String getNonCurrentTariffs(Model model) {
        try {
            List<Tariff> nonCurrentTariffs = tariffDao.findAllNonCurrentTariffs();
            List<TariffModel> tariffModels = new ArrayList<>();

            if (nonCurrentTariffs != null && !nonCurrentTariffs.isEmpty()) {
                for (Tariff tariff : nonCurrentTariffs) {
                    TariffModel tariffModel = new TariffModel();
                    tariffModel.setTariffId(tariff.getTariffId());
                    tariffModel.setTariffCategoryCode(tariff.getTariffCategoryCode().getTariffCategoryCode());
                    tariffModel.setValidFrom(tariff.getValidFrom());
                    tariffModel.setValidTill(tariff.getValidTill());
                    tariffModel.setIsCurrent(tariff.getIsCurrent());
                    tariffModel.setRate(tariff.getRate());

                    // Add TariffCategory details
                    tariffModel.setTariffName(tariff.getTariffCategoryCode().getTariffName());
                    tariffModel.setTarrifType(tariff.getTariffCategoryCode().getTarrifType());
                    tariffModel.setGroupKey(tariff.getTariffCategoryCode().getGroupKey());

                    tariffModels.add(tariffModel);
                }
            }

            // Sort and group tariffs by type
            List<TariffModel> sortedTariffModels = sortAndGroupTariffsByType(tariffModels);

            System.out.println("Non-current tariff models: " + sortedTariffModels.size());
            model.addAttribute("tariffList", sortedTariffModels);
            return "pts/licenseeBilling/tariff/nonCurrentTariffTable";

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("tariffList", new ArrayList<>());
            return "pts/licenseeBilling/tariff/nonCurrentTariffTable";
        }
    }

    @Transactional
    @RequestMapping(value = "/getAllTariffs", method = RequestMethod.GET)
    public String getAllTariffs(Model model) {
        try {
            List<Tariff> allTariffs = tariffDao.findAllOrderByCurrentFirst();
            List<TariffModel> tariffModels = new ArrayList<>();

            if (allTariffs != null && !allTariffs.isEmpty()) {
                for (Tariff tariff : allTariffs) {
                    TariffModel tariffModel = new TariffModel();
                    tariffModel.setTariffId(tariff.getTariffId());
                    tariffModel.setTariffCategoryCode(tariff.getTariffCategoryCode().getTariffCategoryCode());
                    tariffModel.setValidFrom(tariff.getValidFrom());
                    tariffModel.setValidTill(tariff.getValidTill());
                    tariffModel.setIsCurrent(tariff.getIsCurrent());
                    tariffModel.setRate(tariff.getRate());

                    // Add TariffCategory details
                    tariffModel.setTariffName(tariff.getTariffCategoryCode().getTariffName());
                    tariffModel.setTarrifType(tariff.getTariffCategoryCode().getTarrifType());
                    tariffModel.setGroupKey(tariff.getTariffCategoryCode().getGroupKey());

                    tariffModels.add(tariffModel);
                }
            }

            // Sort and group tariffs by type
            List<TariffModel> sortedTariffModels = sortAndGroupTariffsByType(tariffModels);

            System.out.println("Current tariff models: " + sortedTariffModels.size());
            model.addAttribute("tariffList", sortedTariffModels);
            return "pts/licenseeBilling/tariff/currentTariffTable";

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("tariffList", new ArrayList<>());
            return "pts/licenseeBilling/tariff/currentTariffTable";
        }
    }
    // Add this method to your ConfigController class
    private List<TariffModel> sortAndGroupTariffsByType(List<TariffModel> tariffModels) {
        // Define the mapping of tariff names to tariff types
        Map<String, String> tariffNameToTypeMapping = new HashMap<>();

        // ENERGY TARIFF group
        tariffNameToTypeMapping.put("Energy Off Peak Tariff", "ENERGY TARIFF");
        tariffNameToTypeMapping.put("Energy Peak Tariff", "ENERGY TARIFF");
        tariffNameToTypeMapping.put("Energy Day Tariff", "ENERGY TARIFF");

        // CAPACITY TARIFF group
        tariffNameToTypeMapping.put("Capacity Tariff", "CAPACITY TARIFF");

        // ADJUSTMENT FACTOR group
        tariffNameToTypeMapping.put("Peak Demand Factor", "ADJUSTMENT FACTOR");
        tariffNameToTypeMapping.put("Peak Upward Adjustment Factor", "ADJUSTMENT FACTOR");
        tariffNameToTypeMapping.put("Day Upward Adjustment Factor", "ADJUSTMENT FACTOR");
        tariffNameToTypeMapping.put("Off Peak Upward Adjustment Factor", "ADJUSTMENT FACTOR");

        // Define the order of tariff types
        Map<String, Integer> typeOrder = new HashMap<>();
        typeOrder.put("ENERGY TARIFF", 1);
        typeOrder.put("CAPACITY TARIFF", 2);
        typeOrder.put("ADJUSTMENT FACTOR", 3);

        // Define the order within each type
        Map<String, Integer> nameOrderWithinType = new HashMap<>();
        // Energy tariff order
        nameOrderWithinType.put("Energy Day Tariff", 1);
        nameOrderWithinType.put("Energy Peak Tariff", 2);
        nameOrderWithinType.put("Energy Off Peak Tariff", 3);

        // Capacity tariff order
        nameOrderWithinType.put("Capacity Tariff", 1);

        // Adjustment factor order
        nameOrderWithinType.put("Day Upward Adjustment Factor", 1);
        nameOrderWithinType.put("Peak Upward Adjustment Factor", 2);
        nameOrderWithinType.put("Off Peak Upward Adjustment Factor", 3);
        nameOrderWithinType.put("Peak Demand Factor", 4);

        // Update tariff models with the correct tariff type
        for (TariffModel tariff : tariffModels) {
            String mappedType = tariffNameToTypeMapping.get(tariff.getTariffName());
            if (mappedType != null) {
                tariff.setTarrifType(mappedType);
            }
        }

        // Sort the tariff models
        return tariffModels.stream()
                .sorted((t1, t2) -> {
                    // First sort by tariff type order
                    Integer type1Order = typeOrder.getOrDefault(t1.getTarrifType(), 999);
                    Integer type2Order = typeOrder.getOrDefault(t2.getTarrifType(), 999);

                    int typeComparison = type1Order.compareTo(type2Order);
                    if (typeComparison != 0) {
                        return typeComparison;
                    }

                    // Then sort by name order within the same type
                    Integer name1Order = nameOrderWithinType.getOrDefault(t1.getTariffName(), 999);
                    Integer name2Order = nameOrderWithinType.getOrDefault(t2.getTariffName(), 999);

                    int nameComparison = name1Order.compareTo(name2Order);
                    if (nameComparison != 0) {
                        return nameComparison;
                    }

                    // Finally sort by isCurrent (current tariffs first)
                    return Long.compare(t2.getIsCurrent(), t1.getIsCurrent());
                })
                .collect(Collectors.toList());
    }

}