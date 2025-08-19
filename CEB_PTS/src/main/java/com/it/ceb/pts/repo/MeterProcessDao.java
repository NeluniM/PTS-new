package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.*;
import com.it.ceb.util.common.exceptions.ConfigException;
import com.it.ceb.pts.model.MeterReadingFileModel;

import java.math.BigDecimal;
import java.util.List;

public interface MeterProcessDao {

    BillCycle getCurrentBillCycle();

    //--------------------------------------------------------------------------
    //                         Meter Reading
    //--------------------------------------------------------------------------

    //basic retrievals
    List<String> getEnergyPrefixes();
    MeterPoint getMeterPointBySerialNo(String serialNo);
    BillCycle getBillCycle(Long billCycleNo) throws Exception;

    //validations
    Void clearExistingMeterReading(Long billCycleNo, String license, String province);
    Void checkProcessAvailability(Long billCycleNo, String license, String province) throws ConfigException;

    //Excel support--------------------------------------
    Boolean checkPreviousReadingLogs( Long billCycleNo, String license, String province);
    List<MeasureCell> getMeasureCellById(String modelId, String fileType);
    List<MeterReading> getPreviousReading(String serialNo, Long billCycleNo);
    BigDecimal matchPreviousReading(Long measureId, List<MeterReading> readings);


    //DB write-----------------------------
    void saveMeterReading(MeterReading meterReading);
    List<MeterReading> saveMeterReadingList(List<MeterReading> meterReadingsList) throws Exception;
    BillCycle setBillCycle_relation(Long billCycleNo);
    Meter setMeter_relation(String serialNo);
    Measure setMeasure_relation(Long measureId);
    void lockProvinceProcess(Long billCycleNo, String licenseCode, String provinceCode);

    //--------------------------------------------------------------------------
    //                         Logging
    //--------------------------------------------------------------------------

    //DB write-----------------------------
    MeterReadingLog saveMeterReadingLog(MeterReadingLog meterReadingLog);
    Province setProvince_relation(String provinceCode);
    DistributionLicense setLicense_relation(String licenseCode);

    //--------------------------------------------------------------------------
    //                        Error Logging
    //--------------------------------------------------------------------------

    //DB write-----------------------------
    void saveMeterReadingLogError(MeterReadingErrLog meterReadingLogError);
    void saveMeterReadingLogErrorList(List<MeterReadingErrLog> meterReadingLogErrorList, MeterReadingLog meterReadingLog);
    MeterReadingLog setMeterReadingLog_relation(Long readingId);


    //--------------------------------------------------------------------------
    //                         Energy summaries
    //--------------------------------------------------------------------------
    List<MeterReadingEnergySummary> calculateMeterReadingEnergySummary(List<MeterReadingFileModel> meterReadings, Long BillCycleNo);
    ProvinceEnergySummary calculateProvinceEnergySummary(List<MeterReadingFileModel> meterReadingsFileList, Long BillCycleNo,
                                                         String licenseCode, String provinceCode) throws ConfigException;

    //DB write-----------------------------
    void saveProvinceEnergySummary(ProvinceEnergySummary totalEn);
    void saveMeterReadingEnergySummary(List<MeterReadingEnergySummary> meterReadingEn);

    List<MeterReadingFileModel> getMeterReadingFileModelList();

    public void saveMeterReadingMain(List<MeterReading> meterReadingList , MeterReadingLog mrLog , List<MeterReadingErrLog> meterReadingErrLogList , List<MeterReadingEnergySummary> meterReadingEnergyList ,ProvinceEnergySummary totalEnergy , String billCycle , String division , String province) ;

}