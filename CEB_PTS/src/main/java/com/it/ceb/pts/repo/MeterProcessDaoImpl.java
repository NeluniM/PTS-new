package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.*;
import com.it.ceb.util.common.exceptions.ConfigException;
import com.it.ceb.pts.model.MeterReadingFileModel;
import com.it.ceb.pts.model.MeterReadingRecordModel;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;
import java.util.stream.Collectors;


@Repository
public class MeterProcessDaoImpl implements MeterProcessDao {

    @PersistenceContext
    private EntityManager entityManager;

    private List<MeterReadingFileModel> meterReadingFileModelList;

    //-----------------------------------------------------------------------------------
    //                             General
    //-----------------------------------------------------------------------------------

    @Override
    public BillCycle getCurrentBillCycle() {
        try {
            TypedQuery<BillCycle> query = entityManager.createQuery(
                    "SELECT b FROM BillCycle b WHERE b.isCurrent = 1",
                    BillCycle.class);
            return query.getSingleResult();
        } catch (Exception e) {
            System.out.println("Error while getting current bill cycle: " + e.getMessage());
            //e.printStackTrace();//
            return null;
        }
    }

    @Override
    @Transactional(readOnly = true)
    public List<String> getEnergyPrefixes() {
        try {
            TypedQuery<String> query = entityManager.createQuery(
                    "SELECT m.energyPrefix FROM MeterModel m",
                    String.class);
            return query.getResultList();
        } catch (Exception e) {
            System.out.println("error while getting the meter by serial no");
            System.out.println(e.getMessage());
            //e.printStackTrace();//
            return null;
        }
    }

    @Override
    public MeterPoint getMeterPointBySerialNo(String serialNo) {
        try {
            TypedQuery<MeterPoint> query = entityManager.createQuery(
                    "SELECT m FROM MeterPoint m WHERE m.meter.serialNo= :serialNo",
                    MeterPoint.class
            );
            query.setParameter("serialNo", serialNo);
            return query.getSingleResult();
        } catch (Exception e) {
            System.out.println("error while getting the meter by serial no");
            System.out.println(e.getMessage());
            //e.printStackTrace();//
            return null;
        }
    }

    @Transactional(readOnly = true)
    @Override
    public BillCycle getBillCycle(Long billCycleNo) throws Exception {
        try {
            TypedQuery<BillCycle> query = entityManager.createQuery(
                    "SELECT b FROM BillCycle b WHERE b.billCycleNo = :billCycleNo",
                    BillCycle.class);
            query.setParameter("billCycleNo", billCycleNo);
            if(query.getResultList().isEmpty()){
                throw new ConfigException("Bill cycle is not set");
            }
            if(query.getSingleResult().getBillYear()== null){
                throw new ConfigException("Bill cycle year is not set");
            } else if(query.getSingleResult().getBillMonth()== null){
                throw new ConfigException("Bill cycle month is not set");
            }if(query.getSingleResult().getCoincidentPeakDate()== null){
                throw new ConfigException("Coincident-peak date is not set");
            }
            return query.getSingleResult();
        } catch (Exception e) {
            System.out.println("Error while getting bill cycle: " + e.getMessage());
            //e.printStackTrace();//
            if (e instanceof ConfigException){
                throw e;
            }else{
                throw new ConfigException("Failed while getting bill cycle details");
            }
        }
    }


    @Transactional(readOnly = true)
    @Override
    public Void checkProcessAvailability(Long billCycleNo, String license, String province) throws ConfigException {
        try{
            TypedQuery<ProvinceConfig> query = entityManager.createQuery(
                    "SELECT p FROM ProvinceConfig p WHERE p.id.billCycleNo = :billCycleNo " +
                            "AND p.id.licenseCode = :license AND p.id.provinceCode = :province ",
                    ProvinceConfig.class);
            query.setParameter("billCycleNo", billCycleNo);
            query.setParameter("license", license);
            query.setParameter("province", province);
            if(query.getResultList().isEmpty() ||
                query.getSingleResult().getIsUploadLocked()==null||
                query.getSingleResult().getIsReadingProcessLocked()==null){
                throw new ConfigException("Province config is not set");
            }
            if(query.getSingleResult().getIsUploadLocked().equals(0L)){
                throw new ConfigException("File upload is unlocked (for the province)");
            }
            if(query.getSingleResult().getIsReadingProcessLocked().equals(1L)){
                throw new ConfigException("File processing is locked (for the province)");
            }
            return null;
        }catch (Exception e){
            System.out.println("Error while retrieving province config " + e.getMessage());
            if (e instanceof ConfigException){
                throw e;
            }else{
                throw new ConfigException("Failed while getting province config details");
            }
        }
    }

    @Transactional
    @Override
    public Void clearExistingMeterReading(Long billCycleNo, String license, String province) {

        System.out.println("Deleting existing records");
        //Meter reading logs------------------------------------------------------------
        try {
            System.out.println("Clearing existing meter reading logs");
            entityManager.createQuery(
                            "DELETE FROM MeterReadingLog m WHERE m.billCycle.billCycleNo = :billCycleNo " +
                                    "AND m.license.licenseCode = :license AND m.province.provinceCode = :province")
                    .setParameter("billCycleNo", billCycleNo)
                    .setParameter("license", license)
                    .setParameter("province", province)
                    .executeUpdate();
            System.out.println("Meter-Reading-Log cleared");

        } catch (Exception e) {
            System.out.println("Error clearing existing meter reading logs: " + e.getMessage());
            //e.printStackTrace();//
        }

        //Meter reading ------------------------------------------------------------------
        List<String> serialNoList = new ArrayList<>();
        try {
            // Retrieve all SerialNos from MeterPoint (div + prov)
            serialNoList = entityManager.createQuery(
                            "SELECT m.serialNo FROM MeterPoint m WHERE m.licenseCode = :license " +
                                    "AND (m.licenseCode = 'LECO' AND m.province2.provinceCode = :province OR m.province1.provinceCode = :province)",
                            String.class)
                    .setParameter("license", license)
                    .setParameter("province", province)
                    .getResultList();

            // Delete from MeterReading
            entityManager.createQuery(
                            "DELETE FROM MeterReading m WHERE m.billCycle.billCycleNo = :billCycleNo " +
                                    "AND m.serialNo IN :serialNos")
                    .setParameter("billCycleNo", billCycleNo)
                    .setParameter("serialNos", serialNoList)
                    .executeUpdate();
            System.out.println("Meter-Readings cleared");
        } catch (Exception e) {
            System.out.println("Error clearing existing meter readings: " + e.getMessage());
            //e.printStackTrace();//
        }

        //Meter reading energy summaries------------------------------------------------
        try{
            entityManager.createQuery(
                            "DELETE FROM MeterReadingEnergySummary m WHERE m.serialNo IN :serialNos AND m.billCycle = :billCycleNo")
                    .setParameter("billCycleNo", billCycleNo)
                    .setParameter("serialNos", serialNoList)
                    .executeUpdate();
            System.out.println("Meter-Readings-Summaries cleared");

        }catch (Exception e) {
            System.out.println("Error clearing existing meter reading energy summaries: " + e.getMessage());
            //e.printStackTrace();//
        }

        //Province energy summary ---------------------------------------------------
        try {
            entityManager.createQuery(
                            "DELETE FROM ProvinceEnergySummary p WHERE p.billCycleNo = :billCycleNo " +
                                    "AND p.licenseCode = :license AND p.provinceCode = :province")
                    .setParameter("billCycleNo", billCycleNo)
                    .setParameter("license", license)
                    .setParameter("province", province)
                    .executeUpdate();
            System.out.println("Province-Energy-Summaries cleared");
        } catch (Exception e) {
            System.out.println("Error clearing existing province energy summaries: " + e.getMessage());
            //e.printStackTrace();//
        }

        return null;

    }

    //-----------------------------------------------------------------------------------
    //                   Meter Reading
    //-----------------------------------------------------------------------------------

    @Override
    @Transactional
    public void saveMeterReading(MeterReading meterReading) {
        entityManager.persist(meterReading);
    }

    @Override
    @Transactional
    public List<MeterReading> saveMeterReadingList(List<MeterReading> meterReadingsList) throws Exception{
        System.out.println("saveMeterReadingList 01");
        for (MeterReading meterReading : meterReadingsList) {

           // System.out.println("meterReadings " + meterReading.getSerialNo());
            System.out.println("meterReadings " + meterReading.getSerialNo());
            System.out.println("bill cycle " + meterReading.getBillCycle());
            System.out.println("meter Reading " + meterReading.getCurrentReading());
//            System.out.println("meter Reading " + meterReading.getCurrentReading());
            System.out.println("saveMeterReadingList 02");
            entityManager.persist(meterReading);
            System.out.println("saveMeterReadingList 03");
        }
        System.out.println("saveMeterReadingList 04");
        try {
//            entityManager.flush();
        } catch (Exception e) {
            e.printStackTrace();
            throw e; // rethrow after logging
        }
        System.out.println("saveMeterReadingList 05");
        return meterReadingsList;
    }

    @Override
    public BillCycle setBillCycle_relation(Long billCycleNo){
        return entityManager.find(BillCycle.class, billCycleNo);
    }

    @Override
    public Meter setMeter_relation(String CEBserialNo){
        Meter mt = entityManager.find(Meter.class, CEBserialNo);
        if (mt == null) {
            mt = new Meter();
            mt.setCebSerialNo(CEBserialNo);
            entityManager.persist(mt);
        }
        return mt;
    }

    @Override
    public Measure setMeasure_relation(Long measureId){
        Measure msr = entityManager.find(Measure.class, measureId);
        if (msr == null) {
            msr = new Measure();
            msr.setMeasureId(measureId);
            entityManager.persist(msr);
        }
        return msr;
    }

    @Transactional
    @Override
    public void lockProvinceProcess(Long billCycleNo, String licenseCode, String provinceCode) {
        try {
            ProvinceConfig provinceConfig =
                    entityManager.createQuery(
                                    "SELECT p FROM ProvinceConfig p " +
                                            "WHERE p.billCycleNo.billCycleNo = :billCycleNo AND p.licenseCode.licenseCode = :licenseCode " +
                                            "AND p.provinceCode.provinceCode = :provinceCode", ProvinceConfig.class)
                            .setParameter("billCycleNo", billCycleNo)
                            .setParameter("licenseCode", licenseCode)
                            .setParameter("provinceCode", provinceCode)
                            .getSingleResult();
            provinceConfig.setIsReadingProcessLocked(1L); // Lock the process
            entityManager.merge(provinceConfig);
        } catch (Exception e) {
            System.out.println("Error locking province process: " + e.getMessage());
            //e.printStackTrace();//
        }
    }


    //  -------------   helper methods for meter reading table properties ------------------------

    @Override
    public Boolean checkPreviousReadingLogs(Long billCycleNo, String license, String province){
        TypedQuery<MeterReadingLog> query = entityManager.createQuery(
                "SELECT m FROM MeterReadingLog m WHERE m.license.licenseCode= :license AND m.province.provinceCode= :province AND m.billCycle.billCycleNo= :billCycleNo",
                MeterReadingLog.class);
        query.setParameter("license", license);
        query.setParameter("province", province);
        query.setParameter("billCycleNo", billCycleNo);
        if(query.getResultList().isEmpty()){
            return false;
        }else{
            return true;
        }
    }

    @Transactional(readOnly = true)
    @Override
    public List<MeterReading> getPreviousReading(String serialNo, Long billCycleNo) {
        Long prevBillCycleNo = billCycleNo - 1;
        try {
            TypedQuery<MeterReading> query = entityManager.createQuery(
                    "SELECT m FROM MeterReading m WHERE m.serialNo= :serialNo AND m.billCycle.billCycleNo= :billCycleNo",
                    MeterReading.class);
            query.setParameter("serialNo", serialNo);
            query.setParameter("billCycleNo", prevBillCycleNo);
            return query.getResultList();
        } catch (Exception e) {
            System.out.println("Error while getting previous readings:"+e.getMessage());
            //e.printStackTrace();//
            return Collections.emptyList();
        }
    }

    @Override
    public BigDecimal matchPreviousReading(Long measureId, List<MeterReading> readings) {
        if (readings == null || readings.isEmpty()) {
            return new BigDecimal("0");
        }

        for (MeterReading reading : readings) {
            if (reading.getMeasure().getMeasureId().equals(measureId)) {
                return reading.getCurrentReading();
            }
        }
        return new BigDecimal("0");
    }

    @Override
    @Transactional(readOnly = true)
    public List<MeasureCell> getMeasureCellById(String modelId, String fileType) {
        try {
            TypedQuery<MeasureCell> query = entityManager.createQuery(
                    "SELECT m FROM MeasureCell m WHERE m.modelId= :modelId AND m.fileType = :fileType",
                    MeasureCell.class
            );
            query.setParameter("modelId", Long.parseLong(modelId));
            query.setParameter("fileType", fileType);
            List<MeasureCell> result = query.getResultList();
            return result.isEmpty() ? null : result;
        } catch (Exception e) {
            System.out.println("error while getting the measure cell by model id");
            System.out.println(e.getMessage());
            //e.printStackTrace();//
            return null;
        }
    }



    //-----------------------------------------------------------------------------------
    //                   Meter Reading Log
    //-----------------------------------------------------------------------------------

    @Transactional
    @Override
    public MeterReadingLog saveMeterReadingLog(MeterReadingLog meterReadingLog) {
        entityManager.persist(meterReadingLog);
        return meterReadingLog;
    }

    @Override
    public Province setProvince_relation(String provinceCode){
        return entityManager.find(Province.class, provinceCode);
    }

    @Override
    public DistributionLicense setLicense_relation(String licenseCode){
        return  entityManager.find(DistributionLicense.class, licenseCode);
    }


    //-----------------------------------------------------------------------------------
    //                   Meter Reading Error Log
    //-----------------------------------------------------------------------------------

    @Transactional
    @Override
    public void saveMeterReadingLogError(MeterReadingErrLog meterReadingLogError) {
        entityManager.persist(meterReadingLogError);
    }

    @Transactional
    @Override
    public void saveMeterReadingLogErrorList(List<MeterReadingErrLog> meterReadingLogErrorList, MeterReadingLog meterReadingLog) {
        for (MeterReadingErrLog meterReadingErrLog : meterReadingLogErrorList) {
            meterReadingErrLog.setMeterReadingLog(meterReadingLog);
            entityManager.persist(meterReadingErrLog);
        }
    }

    @Override
    public MeterReadingLog setMeterReadingLog_relation(Long readingId){
        return entityManager.find(MeterReadingLog.class, readingId);
    }

    //-----------------------------------------------------------------------------------
    //                   Energy calculation
    //-----------------------------------------------------------------------------------

    private List<Tariff> getTariff(String licenseCode) {
        TypedQuery<Tariff> query = entityManager.createQuery(
                "SELECT t FROM Tariff t WHERE " +
                        " t.licenseCode.licenseCode = :licenseCode" +
                        " AND t.isCurrent = 1",
                Tariff.class);
        query.setParameter("licenseCode", licenseCode);
        return query.getResultList();
    }

    @Override
    public ProvinceEnergySummary calculateProvinceEnergySummary(
            List<MeterReadingFileModel> meterReadingsFileList,
            Long BillCycleNo,
            String licenseCode,
            String provinceCode) throws ConfigException {
        ProvinceEnergySummary totalEn = new ProvinceEnergySummary();
        totalEn.setBillCycleNo(BillCycleNo);
        totalEn.setLicenseCode(licenseCode);
        totalEn.setProvinceCode(provinceCode);
        totalEn.setDayEnergy(BigDecimal.ZERO);
        totalEn.setPeakEnergy(BigDecimal.ZERO);
        totalEn.setOffPeakEnergy(BigDecimal.ZERO);
        totalEn.setCoincidentPeak(BigDecimal.ZERO);

        for (MeterReadingFileModel meterReadingfile : meterReadingsFileList) {
            //DPO energies
            for (MeterReadingRecordModel meterReading : meterReadingfile.getMeterReadingRecordModelList()) {
                if ("D".equals(meterReading.getDpo())) {
                    totalEn.setDayEnergy(totalEn.getDayEnergy().add(meterReading.getEnergy()));
                } else if ("P".equals(meterReading.getDpo())) {
                    totalEn.setPeakEnergy(totalEn.getPeakEnergy().add(meterReading.getEnergy()));
                } else if ("O".equals(meterReading.getDpo())) {
                    totalEn.setOffPeakEnergy(totalEn.getOffPeakEnergy().add(meterReading.getEnergy()));
                }
            }

            //coincident peak
            totalEn.setCoincidentPeak(
                    totalEn.getCoincidentPeak().add(meterReadingfile.getImportCoincidentPeak()));
            totalEn.setCoincidentPeak(
                    totalEn.getCoincidentPeak().add(meterReadingfile.getExportCoincidentPeak()));
        }


        //upward adjustment ---------------------------------
        System.out.println("Calculating upward adjustments");
        List<Tariff> tariff = getTariff(licenseCode);

        if(tariff == null || tariff.isEmpty()) {
            System.out.println("Empty tariff set for license code: " + licenseCode);
            throw new ConfigException("No tariff set for energy adjustment");
        }
        if (!tariff.stream().map(t -> t.getTariffCategoryCode().getTariffCategoryCode())
                  .collect(Collectors.toSet())
                  .containsAll(Set.of("DAY_ADJ_FACTOR", "PEAK_ADJ_FACTOR", "OFFP_ADJ_FACTOR", "PEAK_DMN_FACTOR"))) {
           System.out.println("Missing required tariff categories for license code: " + licenseCode);
           throw new ConfigException("All the tariff is not set for energy adjustment");
        }

        for (Tariff tar : tariff) {
            switch (tar.getTariffCategoryCode().getTariffCategoryCode()) {
                case "DAY_ADJ_FACTOR" -> {
                    totalEn.setDayEnergyAdj(totalEn.getDayEnergy().multiply(tar.getRate()).setScale(0, RoundingMode.HALF_UP));
                }
                case "PEAK_ADJ_FACTOR" -> {
                    totalEn.setPeakEnergyAdj(totalEn.getPeakEnergy().multiply(tar.getRate()).setScale(0, RoundingMode.HALF_UP));
                }
                case "OFFP_ADJ_FACTOR" -> {
                    totalEn.setOffPeakEnergyAdj(totalEn.getOffPeakEnergy().multiply(tar.getRate()).setScale(0, RoundingMode.HALF_UP));
                }
                case "PEAK_DMN_FACTOR" -> {
                    totalEn.setCoincidentPeakAdj(totalEn.getCoincidentPeak().add(tar.getRate()));
                }
            }
        }

        return  totalEn;
    }

    @Override
    @Transactional
    public void saveProvinceEnergySummary(ProvinceEnergySummary totalEn) {
        try{
            entityManager.persist(totalEn);
        }catch (Exception e) {
            System.out.println("an error occured :" + e.getMessage());
            //e.printStackTrace();//
        }
    }

    @Transactional
    @Override
    public void saveMeterReadingEnergySummary(List<MeterReadingEnergySummary> meterReadingEn) {
        for (MeterReadingEnergySummary total : meterReadingEn) {
            try{
                entityManager.persist(total);
            }catch (Exception e){
                System.out.println("an error occured while saving meter reading energy summary:"+e.getMessage());
                //e.printStackTrace();//
            }
        }
    }

    @Override
    public List<MeterReadingEnergySummary> calculateMeterReadingEnergySummary(List<MeterReadingFileModel> meterReadings, Long BillCycleNo) {
        List<MeterReadingEnergySummary> meterReadingEnergySummeries = new ArrayList<>();
        this.meterReadingFileModelList = new ArrayList<>();

        for (MeterReadingFileModel meterReadingFile : meterReadings) {

            if(meterReadingFile.getMeterReadingRecordModelList() != null){

                MeterReadingEnergySummary meterReadingEnergySummary = new MeterReadingEnergySummary();
                meterReadingEnergySummary.setBillCycle(BillCycleNo);
                meterReadingEnergySummary.setSerialNo(meterReadingFile.getSerialNo());
                meterReadingEnergySummary.setCebSerialNo(meterReadingFile.getCebSerialNo());
                meterReadingEnergySummary.setExportCoincidentPeak(meterReadingFile.getExportCoincidentPeak());
                meterReadingEnergySummary.setImportCoincidentPeak(meterReadingFile.getImportCoincidentPeak());

                for (MeterReadingRecordModel meterProcessRecord : meterReadingFile.getMeterReadingRecordModelList()) {
                    if ("I".equals(meterProcessRecord.getImportExport())) {
                        meterReadingEnergySummary.setImportEnergy(
                                meterReadingEnergySummary.getImportEnergy().add(meterProcessRecord.getEnergy()));
                    } else if ("E".equals(meterProcessRecord.getImportExport())) {
                        meterReadingEnergySummary.setExportEnergy(
                                meterReadingEnergySummary.getExportEnergy().add(meterProcessRecord.getEnergy()));
                    }
                }

                meterReadingFile.setImportEnergy(meterReadingEnergySummary.getImportEnergy());
                meterReadingFile.setExportEnergy(meterReadingEnergySummary.getExportEnergy());
                meterReadingEnergySummeries.add(meterReadingEnergySummary);
            }

        }
        this.meterReadingFileModelList = meterReadings;
        return meterReadingEnergySummeries;
    }


    @Override
    public List<MeterReadingFileModel> getMeterReadingFileModelList() {
        return this.meterReadingFileModelList;
    }

    private Boolean checkCurrentBillCycle(Long billCycleNo) {
        //check whether this is the curent bill cycle (is current ==1)
        TypedQuery<Long> query = entityManager.createQuery(
                "SELECT bc.isCurrent FROM BillCycle bc WHERE bc.billCycleNo = :billCycleNo",
                Long.class);
        query.setParameter("billCycleNo", billCycleNo);

        try {
            Long isCurrent = query.getSingleResult();
            return isCurrent != null && isCurrent == 1;
        } catch (Exception e) {
            System.out.println("Error checking current bill cycle: " + e.getMessage());
            //e.printStackTrace();//
            return false;
        }
    }


    @Transactional
    @Override
    public void saveMeterReadingMain(List<MeterReading> meterReadingList , MeterReadingLog mrLog , List<MeterReadingErrLog> meterReadingErrLogList , List<MeterReadingEnergySummary> meterReadingEnergyList ,ProvinceEnergySummary totalEnergy , String billCycle , String division , String province) {
        try{
            System.out.println("DB writing started");
            saveMeterReadingList(meterReadingList);// excel meter readings
            System.out.println("Meter readings saved successfully");
            MeterReadingLog mrl = saveMeterReadingLog(mrLog);// log summary
            System.out.println("Log summary saved successfully");
            saveMeterReadingLogErrorList(meterReadingErrLogList,mrl);// log errors
            System.out.println("Log errors saved successfully");
            saveMeterReadingEnergySummary(meterReadingEnergyList);//meter reading energy summary
            System.out.println("Meter reading energy summary saved successfully");
            saveProvinceEnergySummary(totalEnergy); //total energy summary
            System.out.println("Total energy summary saved successfully");
            System.out.println("DB writing completed successfully");
            lockProvinceProcess(Long.parseLong(billCycle), division, province);
            System.out.println("Province process locked");
        }
        catch (Exception e) {
            //System.out.println("Error checking current bill cycle: " + e.getMessage());
            e.printStackTrace();//
    }
    }



}