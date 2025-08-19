package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.*;
import com.it.ceb.pts.model.MeterPointModel;
import com.it.ceb.pts.model.MeterReadingErrorModel;
import com.it.ceb.pts.model.MeterReadingRecordModel;
import com.it.ceb.pts.model.MeterReadingResultModel;

import java.time.LocalDate;
import java.util.List;

public interface MeterReadingDao {
    List<MeterReading> findByReadingId(Long id);
    List<MeterReading> findByBillCycleNo(Long billCycleNo);
    List<MeterReading> findByCreatedDate(LocalDate createdDate);

    List<MeterPoint> findByLicenseCode(String licenseCode);

    List<MeterReading> findByProvinceCode(String provinceCode);

    List<MeterReading> findByBillCycleNoAndCreatedDate(Long billCycleNo, LocalDate createdDate);
    List<MeterReading> findByCreatedDateBetween(LocalDate startDate, LocalDate endDate);
    long countByBillCycleNo(Long billCycleNo);
    long countByCreatedDate(LocalDate createdDate);

    // New method to fetch records
    List<MeterReading> viewAllMeterReadings(String billCycleNo) throws Exception;

    List<MeterReading> viewAllMeterReadingsFilt(String billCycle, String licenseCode, String provinceCode) throws Exception;

    List<MeterReading> getMeterReadings(Long billCycle) throws Exception;
    List<MeterReadingResultModel> getMeterReadingsFull(Long billCycle, String division, String province) throws Exception ;


    //public List<MeterReadingResultModel> getMeterReadingsFull(Long billCycle, String division, String province) throws Exception;

    public List<MeterReadingErrorModel> getMeterReadingErrors(Long billCycle, String division, String province) throws Exception;
    public List<MeterReadingErrLog> getErrorMeterList(Long billCycle, String division, String province) throws Exception;

    //public List<MeterReadingResultModel> getMeterReadingsFullList(Long billCycle) throws Exception;

    public List<MeterReadingRecordModel> getMeterReadings(Long billCycleNo, String provinceCode, String licenseCode) throws Exception;
    List<MeterPointModel> getMeterPoints(String provinceCode, String licenseCode) throws Exception;

    List<MeterReadingEnergySummary> getMeterReadingEnergySummary(Long billCycle, List<String> serialNumbers) throws Exception;

    LocalDate getCoincidentPeakDate(Long billCycleNo) throws Exception;

    ProvinceEnergySummary getProvinceEnergySummary(Long billCycle, String division, String province) throws Exception;
    List<MeterReadingResultModel> getMeterReadingsFullList(Long billCycle) throws Exception;

    List<MeterReading> findAllBySerialNoAndBillCycle(String serialNo, Long billCycleNo);
    void save(MeterReading meterReading);
    MeterReading findBySerialNoAndBillCycleAndMeasureName(String serialNo, Long billCycleNo, String measureName);
    long getNextReadingId();

    // province config methods
    public ProvinceConfig findByBillCycleAndLicenseCodeAndProvinceCode(Long billCycleNo, String licenseCode, String provinceCode);
}