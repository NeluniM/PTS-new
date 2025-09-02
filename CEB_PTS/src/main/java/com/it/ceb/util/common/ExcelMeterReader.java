package com.it.ceb.util.common;

import com.it.ceb.pts.domain.*;
import com.it.ceb.pts.repo.MeterProcessDao;
import com.it.ceb.util.common.exceptions.ConfigException;
import com.it.ceb.util.common.exceptions.CorruptedCellException;
import com.it.ceb.util.common.exceptions.CorruptedFileException;
import com.it.ceb.util.common.exceptions.WrongBillMonthException;
import com.it.ceb.pts.model.MeterReadingFileModel;
import com.it.ceb.pts.model.MeterReadingRecordModel;
import jakarta.annotation.PostConstruct;
import org.apache.commons.io.FilenameUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellReference;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.*;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.nio.file.NoSuchFileException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
@Transactional
public class ExcelMeterReader {

    @Autowired
    private MeterProcessDao meterDao;

    private static final List<String> EXCEL_EXTENSIONS = Arrays.asList("xls", "xlsx");
    private List<String> energyPrefixes;

    private Long billCycle;
    private BillCycle billCycleObj;
    private Long successCount = 0L;
    private Long errorCount = 0L;
    private List<MeterReadingFileModel> meterReadingFileModelList = new ArrayList<>();
    private String coincidentPeak;
    private String coincidentPeak2;
    private String coincidentPeak3;

    private List<MeterReading> meterReadings = new ArrayList<>();

    @PostConstruct
    private void init() {
        this.energyPrefixes = meterDao.getEnergyPrefixes();
    }


    //===================================================================================
    //                             Batch process of excel files
    //===================================================================================

    //Entering method------------------------------------------------------
    @Transactional
    public void extractExcelFiles(String folderPath,String billCycle) throws Exception {
        File folder = new File(folderPath);
        if (!folder.exists() || !folder.isDirectory()) {
            System.out.println("Empty folder or No access folder");
            throw new NoSuchFileException("No such folder/files found");
        }
        this.billCycle = Long.parseLong(billCycle);
        this.successCount = 0L;
        this.errorCount = 0L;
        this.meterReadingFileModelList = new ArrayList<>();
        this.meterReadings = new ArrayList<>();
        try{
            this.billCycleObj = meterDao.getBillCycle(Long.parseLong(billCycle));
            Date date = this.billCycleObj.getCoincidentPeakDate();
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
            SimpleDateFormat dateFormat2 = new SimpleDateFormat("M/d/yy H:mm");
            SimpleDateFormat dateFormat3 = new SimpleDateFormat("MM/d/yyyy H:mm:ss");
            this.coincidentPeak = dateFormat.format(date);
            this.coincidentPeak2 = dateFormat2.format(date);
            this.coincidentPeak3 = dateFormat3.format(date);
            System.out.println("Coincident peak date: " + this.coincidentPeak + " | " + this.coincidentPeak2 + " | " + this.coincidentPeak3);
        }catch (Exception e){
            //e.printStackTrace();//
            if (e instanceof ConfigException){
                throw e;
            }else{
                throw new ConfigException("Failed while getting bill cycle details");
            }
        }
        searchExcelFiles(folder);
    }

    //Iterate and explore folders (like deep search)------------------------
    private void searchExcelFiles(File folder) throws NoSuchFileException {

        FileFilter excelFilter = file -> {
            if (file.isDirectory()) return true;
            String extension = FilenameUtils.getExtension(file.getName()).toLowerCase();
            if (!EXCEL_EXTENSIONS.contains(extension)) return false;

            String nameWithoutExtension = FilenameUtils.removeExtension(file.getName());
            String[] parts = nameWithoutExtension.split("-");
            if (parts.length != 2) return false;

            return energyPrefixes.contains(parts[1]);
        };

        File[] files = folder.listFiles(excelFilter);

        if (files == null) {
            System.out.println("Skipping folder (No access or empty): " + folder.getPath());
            throw new NoSuchFileException("No files found in the folder");
        }

        // loop for every files of a folder
        for (File file : files) {
            if (file.isDirectory()) {
                searchExcelFiles(file);
            } else {
                processFile(file, billCycle);
            }
        }
    }

    //file access and reading----------------------------------------------------------
    //(with in one excel file)
    private void processFile(File file, Long billCycle) {

        String nameWithoutExtension = FilenameUtils.removeExtension(file.getName());//SerialNo
        String serialNo = nameWithoutExtension.split("-")[0];

        //Preparing MeterReadingFileModel details [FOR RESULT SET]----------------------------
        MeterReadingFileModel meterReadingFileModel = new MeterReadingFileModel();
        meterReadingFileModel.setSerialNo(serialNo);
        meterReadingFileModel.setFileName(file.getName());

        MeterPoint meterPoint = meterDao.getMeterPointBySerialNo(serialNo);//which model

        if(meterPoint == null){
            //when point is not found in CEB database
            System.out.println("Meter point not found for serial number: " + serialNo);
            meterReadingFileModel.setStatus("ERROR");
            meterReadingFileModel.setErrorReason("Unknown Meter point");
            meterReadingFileModelList.add(meterReadingFileModel);
            errorCount++;
        }else{
            //when point is found in CEB database
            Long modelId = meterPoint.getMeter().getMeterHeader().getMeterModel().getModelId();
            meterReadingFileModel.setCebSerialNo(meterPoint.getMeter().getCebSerialNo());
            meterReadingFileModel.setPss(meterPoint.getPrimarySubstation().getPssName());
            meterReadingFileModel.setArea(meterPoint.getArea().getAreaName());

            //MeasureCells of a model to be read (for Energy profiles)
            List<MeasureCell> cellAddr= meterDao.getMeasureCellById(modelId.toString(), "EP");
            if(cellAddr == null){
                System.out.println("No measure cells found for model ID: " + modelId);
                meterReadingFileModel.setStatus("ERROR");
                meterReadingFileModel.setErrorReason("No measure cells defined (EP)");
                meterReadingFileModelList.add(meterReadingFileModel);
                errorCount++;
                return;
            }
            for(MeasureCell cell: cellAddr){
                if(cell.getCell()==null ||cell.getCell().isEmpty()){
                    System.out.println("Not all EP measure cells are defined for model : " + modelId);
                    meterReadingFileModel.setStatus("ERROR");
                    meterReadingFileModel.setErrorReason("Not all EP measure cells defined");
                    meterReadingFileModelList.add(meterReadingFileModel);
                    errorCount++;
                    return;
                }
            }

            Map<Long,BigDecimal> cellReadings;//(measureId + reading) value pairs
            try{
                //read excel file content to extract values---------------------------------
                cellReadings = readMeterReadingCellValues(cellAddr, file);

                List<MeterReading> prevMeterReadings = new ArrayList<>();
                try {
                    prevMeterReadings = meterDao.getPreviousReading(serialNo, billCycle);//for previous readings
                } catch (Exception e) {
                    System.out.println("Couldn't retrieve previous readings for "+meterPoint.getSerialNo());
                    System.out.println(e.getMessage());
                    //e.printStackTrace();//
                }

                //---------------------------------------------------------------------
                //    preparing object format for  database saving (Meter readings list)
                //---------------------------------------------------------------------

                //only to store this meter point's list of meter readings
                List<MeterReading> meterReadingsTemp = new ArrayList<>();

                //Create MeterReading objects loop-wise for the measureId set
                assert cellReadings != null;
                for (Map.Entry<Long, BigDecimal> entry : cellReadings.entrySet()) {
                    Long measureId = entry.getKey();
                    BigDecimal reading = entry.getValue();

                    MeterReading meterReading = new MeterReading();
                    meterReading.setCurrentReading(reading);
                    meterReading.setBillCycle(this.billCycleObj);
                    meterReading.setMeter(meterPoint.getMeter());
                    meterReading.setSerialNo(serialNo);
                    meterReading.setCreatedBy("SYSTEM");
                    meterReading.setCreatedDate(new Date());
                    meterReading.setPoint(meterPoint);

                    BigDecimal prevRead = meterDao.matchPreviousReading(measureId, prevMeterReadings);
                    meterReading.setPreviousReading(prevRead);
                    meterReading.setEnergy(prevRead.compareTo(BigDecimal.ZERO) == 0 ? BigDecimal.ZERO : reading.subtract(prevRead));

                    if(entry.getKey()==4||entry.getKey()==5||entry.getKey()==6){
                        meterReading.setEnergy(meterReading.getEnergy().multiply(new BigDecimal(-1)));
                    }

                    Measure msr = meterDao.setMeasure_relation(measureId);
                    meterReading.setMeasure(msr);

                    meterReading.setReadingMethod("AUTO");
                    meterReadings.add(meterReading);//whole measurement set
                    meterReadingsTemp.add(meterReading);//only for this round (measurement set)
                }


                //converting MeterReading entities into meterReadingFileRecordModel [FOR RESULT VIEW ]

                List<MeterReadingRecordModel> meterReadingRecordModelList = new ArrayList<>();
                for (MeterReading meterReading : meterReadingsTemp) {
                    MeterReadingRecordModel meterProcessRecordModel = new MeterReadingRecordModel();
                    meterProcessRecordModel.setReadingId(meterReading.getReadingId());
                    meterProcessRecordModel.setMeasure(meterReading.getMeasure().getMeasureName());
                    meterProcessRecordModel.setCurrentReading(meterReading.getCurrentReading());
                    meterProcessRecordModel.setPreviousReading(meterReading.getPreviousReading());
                    meterProcessRecordModel.setEnergy(meterReading.getEnergy());
                    meterProcessRecordModel.setDpo(meterReading.getMeasure().getDayPeakOff());
                    meterProcessRecordModel.setImportExport(meterReading.getMeasure().getImportOrExport());
                    meterReadingRecordModelList.add(meterProcessRecordModel);
                }
                meterReadingFileModel.setMeterReadingRecordModelList(meterReadingRecordModelList);

                //--------------------------------------
                //      coincident peak reading
                //--------------------------------------
                BigDecimal[] coincidentPeak = null; //exp & imp values

                coincidentPeak = getCoincidentPeak(file.getParent(),meterPoint);
                meterReadingFileModel.setExportCoincidentPeak(coincidentPeak[0]);
                meterReadingFileModel.setImportCoincidentPeak(coincidentPeak[1]);
                //System.out.println("Coincident peak read successfully");
                meterReadingFileModel.setStatus("SUCCESS");
                successCount++;

                meterReadingFileModelList.add(meterReadingFileModel);

            }catch (Exception e){
                errorCount++;
                meterReadingFileModel.setStatus("ERROR");
                if(e.getClass().equals(WrongBillMonthException.class) ||
                        e.getClass().equals(CorruptedFileException.class) ||
                        e.getClass().equals(CorruptedCellException.class) ||
                        e.getClass().equals(ConfigException.class) ||
                        e.getClass().equals(FileNotFoundException.class)){
                    meterReadingFileModel.setErrorReason(e.getMessage());
                }else{
                    System.out.println(e.getMessage() + "for meter :"+meterPoint.getSerialNo());
                    meterReadingFileModel.setErrorReason("Unknown file error");
                }
                meterReadingFileModelList.add(meterReadingFileModel);
                System.out.println("Error processing excel file: " + e.getMessage());
                //e.printStackTrace();//
            }
        }

    }

    //==========================================================================
    //          Reading type handling
    //==========================================================================

    //Cell value reading ----------------------------------
    private Map<Long, BigDecimal> readMeterReadingCellValues(List<MeasureCell> cellAddresses, File file) throws ConfigException, IOException, CorruptedFileException, CorruptedCellException {

        Map<Long, BigDecimal> readings = new HashMap<>();
        String extension = FilenameUtils.getExtension(file.getName()).toLowerCase();

//        try (FileInputStream fis = new FileInputStream(file)) {
//            Workbook workbook;
//
//            try {
//                if ("xlsx".equals(extension)) {
//                    workbook = new XSSFWorkbook(fis);
//                } else{
//                    workbook = new HSSFWorkbook(fis);
//                }
//            } catch (IOException e) {
//                //e.printStackTrace();//
//                throw new CorruptedFileException("Couldn't open (EP)");
//            }
//
//
//            Sheet sheet = workbook.getSheetAt(0); // Assuming first sheet
//
//            for (MeasureCell cell : cellAddresses) {
//                BigDecimal val;
//                if (cell.getCell().matches("[A-Z]\\d+")) {
//                    val = CurrentReadingCalc(readSpecificCell(sheet, cell.getCell()) , cell.getValueCalc());
//                } else if (cell.getCell().matches("[A-Z]")) {
//                    val = CurrentReadingCalc(readLastCellInColumn(sheet, cell.getCell()), cell.getValueCalc());
//                } else {
//                    throw new ConfigException("Invalid cell address format");
//                }
//
//                readings.put(cell.getMeasureId(), val);
//            }
//            return readings;
//
//        } catch (Exception e) {
//            //e.printStackTrace();//
//            throw e;
//        }



//
//        System.out.println("+++++++++++++++Reading as text file for testing...+++++++++++++++");
//         workable on the in the 2025-08-28
//        String fileName = "D:\\New folder (2)\\440\\LECO\\WPNL\\ANK\\ANK_F01\\211279951-LP 01.xls";
//
//        try (BufferedReader br = new BufferedReader(new FileReader(fileName))) {
//            String line;
//            int rowIndex = 0; // Track the current row index
//            int targetRow = 18; // Row index to read (0-based for A9)
//            int targetColumn = 2; // Column index to read (0-based for A)
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
//            return readings;
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//        return null;




        String fileName = "D:\\New folder (2)\\440\\LECO\\WPNL\\ANK\\ANK_F01\\211279951-LP 01.xls";

        try (BufferedReader br = new BufferedReader(new FileReader(fileName))) {
            String line;
//            int rowIndex = 0; // Track the current row index
//            int targetRow = 18; // Row index to read (0-based for A9)
//            int targetColumn = 2; // Column index to read (0-based for A)
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
//            return readings;



        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;


    }

    //Calculation of current reading------------------------
    private BigDecimal CurrentReadingCalc(String value, String operator){
        try {
            if (operator == null || operator.trim().isEmpty()) {
                return new BigDecimal(value).setScale(0, RoundingMode.HALF_UP);
            }

            value = value.trim();
            operator = operator.trim();
            //float numericValue = Float.parseFloat(value);
            String op = operator.substring(0, 1);
            float operand = Float.parseFloat(operator.substring(1));

            BigDecimal result = switch (op) {
                case "*" -> new BigDecimal(value).multiply(new BigDecimal(operand));
                case "/" -> new BigDecimal(value).divide(new BigDecimal(operand), RoundingMode.HALF_UP);
                default -> throw new ConfigException("Invalid divisor for LP readings");
            };

            return result.setScale(0, RoundingMode.HALF_UP);

        } catch (NumberFormatException e) {
            //e.printStackTrace();//
            throw new IllegalArgumentException("Invalid numeric format", e);
        } catch (Exception e) {
            //e.printStackTrace();//
            throw new IllegalArgumentException("Error in calculation", e);
        }
    }

    //coincident peak reading--------------------------------
    private BigDecimal[] getCoincidentPeak(String parentDir, MeterPoint meterPoint) throws CorruptedFileException, IOException, CorruptedCellException, ConfigException {

        File folder = new File(parentDir);
        if (!folder.exists() || !folder.isDirectory()) {
            System.out.println("Empty directory");
            throw new FileNotFoundException("No files found (Empty directory)");
        }

        String filePrefix = meterPoint.getMeter().getMeterHeader().getMeterModel().getLoadPrefix();

        FileFilter lpFilter = file -> {
            if (file.isDirectory()) return false;
            String extension = FilenameUtils.getExtension(file.getName()).toLowerCase();
            if (!EXCEL_EXTENSIONS.contains(extension)) return false;
            String nameWithoutExtension = FilenameUtils.removeExtension(file.getName());
            return nameWithoutExtension.matches("[a-zA-Z0-9]+-" + filePrefix + ".*");
        };

        File[] lpFiles = folder.listFiles(lpFilter);
        if (lpFiles == null || lpFiles.length == 0) {
            System.out.println("No LP files found");
            throw new FileNotFoundException("No LP files found");
        }

        //retrieving the measure cells for coin. peak reading
        List<MeasureCell> msrCell = meterDao.getMeasureCellById(
                meterPoint.getMeter().getMeterHeader().getMeterModel().getModelId().toString(),
                "LP"
        );
        if(msrCell==null){
            throw new ConfigException("No measure cells defined (LP)");
        }


        File excelFile = lpFiles[0];
        String extension = FilenameUtils.getExtension(excelFile.getName()).toLowerCase();
        Workbook workbook;

        try {
            if ("xlsx".equals(extension)) {
                workbook = new XSSFWorkbook(new FileInputStream(excelFile));
            } else {
                workbook = new HSSFWorkbook(new FileInputStream(excelFile));
            }
        } catch (IOException e) {
            //e.printStackTrace(); // Handle the exception as needed
            throw new CorruptedFileException("Couldn't open (LP)");
        }

        //assigning the coefficient for division
        String coef = msrCell.get(1).getValueCalc();
        int divideCoef = 1;

        if (coef != null) {
            coef = coef.trim();
            try{
                if (coef.startsWith("/")) {
                    divideCoef = Integer.parseInt(coef.substring(1));
                } else if (coef.startsWith("*")) {
                    divideCoef = (int) (1 / Float.parseFloat(coef.substring(1)));
                }
            }catch(Exception e){
                throw new ConfigException("Invalid divisor for coin.peak.");
            }

        }

        Sheet sheet = workbook.getSheetAt(0);

        BigDecimal expValue = null;
        BigDecimal impValue= null;
        long reverse = msrCell.get(1).getReversed() != null ? msrCell.get(1).getReversed() : 1L;

        if (this.coincidentPeak != null) {

            //getting the coincident peak column (this is only for F/M/T cell combination)
            String cell="";
            if(msrCell.get(0).getCell().trim().equals("FMT")){
                cell=meterPoint.getPeakDemandColumn();
                if(cell.isEmpty()){throw new ConfigException("No peak demand column defined");}
            }else{
                cell=msrCell.get(0).getCell();
            }

            if (msrCell.get(0).getCell().trim().equals(msrCell.get(1).getCell().trim())) {
                String tmp = readMatchingColumnValue(sheet, "B", cell, this.coincidentPeak);
                if(tmp == null || tmp.isEmpty()){ tmp= readMatchingColumnValue(sheet, "B", cell, this.coincidentPeak2);}
                if(tmp == null || tmp.isEmpty()){ tmp= readMatchingColumnValue(sheet, "B", cell, this.coincidentPeak3);}
                if(tmp == null || tmp.isEmpty()){
                    throw new CorruptedCellException("Coincident peak not found");
                }
                tmp = tmp.replaceAll("^(-?\\d+(\\.\\d+)?).*", "$1");
                BigDecimal tmpVal = new BigDecimal(tmp).divide(new BigDecimal(divideCoef),3,RoundingMode.HALF_UP);
                tmpVal= tmpVal.multiply(new BigDecimal(reverse));
                if(tmpVal.compareTo(BigDecimal.ZERO) >= 0){
                    expValue = tmpVal;
                }else{
                    impValue = tmpVal;
                }

            }else{
                String tmpExp = readMatchingColumnValue(sheet, "B", cell, this.coincidentPeak);
                if(tmpExp == null || tmpExp.isEmpty()){ tmpExp= readMatchingColumnValue(sheet, "B", cell, this.coincidentPeak2);}
                if(tmpExp == null || tmpExp.isEmpty()){ tmpExp= readMatchingColumnValue(sheet, "B", cell, this.coincidentPeak3);}
                String tmpImp = readMatchingColumnValue(sheet, "B", msrCell.get(1).getCell(), this.coincidentPeak);
                if(tmpImp == null || tmpImp.isEmpty()){ tmpImp= readMatchingColumnValue(sheet, "B", msrCell.get(0).getCell(), this.coincidentPeak2);}
                if(tmpImp == null || tmpImp.isEmpty()){ tmpImp= readMatchingColumnValue(sheet, "B", msrCell.get(0).getCell(), this.coincidentPeak3);}

                if((tmpImp == null || tmpImp.isEmpty()) && ( tmpExp == null || tmpExp.isEmpty())){
                    throw new CorruptedCellException("Coincident peak not found");
                }
                if(!(tmpImp == null || tmpImp.isEmpty())){
                    tmpImp = tmpImp.replaceAll("^(-?\\d+(\\.\\d+)?).*", "$1");
                    impValue = new BigDecimal(tmpImp).divide(new BigDecimal(divideCoef),3,RoundingMode.HALF_UP);;
                }
                if(!(tmpExp == null || tmpExp.isEmpty())){
                    tmpExp = tmpExp.replaceAll("^(-?\\d+(\\.\\d+)?).*", "$1");
                    expValue = new BigDecimal(tmpExp).divide(new BigDecimal(divideCoef),3,RoundingMode.HALF_UP);;
                }
                if(reverse == -1L){
                    BigDecimal tmp = expValue;
                    expValue = impValue;
                    impValue = tmp;
                }
            }
        }
        workbook.close();

        BigDecimal[] returnArr = new BigDecimal[2];
        returnArr[0] = expValue != null ? expValue : BigDecimal.ZERO;
        returnArr[1] = impValue != null ? impValue : BigDecimal.ZERO;
        return returnArr;

    }


    //==========================================================================
    //          cell reading operations
    //==========================================================================

    //type of cell to be read-------------------------------
    private String readSpecificCell(Sheet sheet, String cellAddress) {
        CellReference cellReference = new CellReference(cellAddress);
        Row row = sheet.getRow(cellReference.getRow());
        if (row == null) return null;

        Cell cell = row.getCell(cellReference.getCol());
        return getCellValueAsString(cell);
    }

    private String readLastCellInColumn(Sheet sheet, String columnLetter) {
        int columnIndex = CellReference.convertColStringToIndex(columnLetter);
        String lastValue = null;

        for (Row row : sheet) {
            Cell cell = row.getCell(columnIndex);
            if (cell != null) {
                String value = getCellValueAsString(cell);
                if (value != null && !value.trim().isEmpty()) {
                    lastValue = value;
                }
            }
        }
        return lastValue;
    }
    private String readMatchingColumnValue(Sheet sheet, String col1, String col2, String col1value) {
        int col1Index = CellReference.convertColStringToIndex(col1);
        int col2Index = CellReference.convertColStringToIndex(col2);

        for (Row row : sheet) {
            Cell cell1 = row.getCell(col1Index);
            if (cell1 != null) {
                String value = getCellValueAsString(cell1);
                if (value != null && value.equals(col1value)) {
                    Cell cell2 = row.getCell(col2Index);
                    return getCellValueAsString(cell2);
                }
            }
        }

        return null;
    }


    //cell value retrieval---------------------------------
    private String getCellValueAsString(Cell cell) {
        if (cell == null) return "";

        DataFormatter formatter = new DataFormatter(Locale.US);

        return switch (cell.getCellType()) {
            case STRING -> cell.getStringCellValue();
            case NUMERIC -> {
                if (DateUtil.isCellDateFormatted(cell)) {
                    yield formatter.formatCellValue(cell);
                } else {
                    yield new BigDecimal(cell.getNumericCellValue()).toPlainString();
                }
            }
            case BOOLEAN -> String.valueOf(cell.getBooleanCellValue());
            case FORMULA -> {
                try {
                    yield new BigDecimal(cell.getNumericCellValue()).toPlainString();
                } catch (Exception e) {
                    yield formatter.formatCellValue(cell);
                }
            }
            case BLANK -> "";
            case ERROR -> String.valueOf(cell.getErrorCellValue());
            default -> {
                yield formatter.formatCellValue(cell);
            }
        };
    }


    //=========================================================================
    //             Data retrieval methods (of class object)
    //=========================================================================

    public Long getSuccessFileCount() {return this.successCount;}
    public Long getErrorFileCount() {return this.errorCount;}
    public List<MeterReadingFileModel> getMeterReadingFilesModelList() { return this.meterReadingFileModelList; }
    public List<MeterReading> getProcessedMeterReadings() {return this.meterReadings;}
    public BillCycle getBillCycleObj() {return this.billCycleObj;}
}