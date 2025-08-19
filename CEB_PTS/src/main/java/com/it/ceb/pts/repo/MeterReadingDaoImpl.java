package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.*;
import com.it.ceb.pts.model.MeterPointModel;
import com.it.ceb.pts.model.MeterReadingErrorModel;
import com.it.ceb.pts.model.MeterReadingRecordModel;
import com.it.ceb.pts.model.MeterReadingResultModel;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Repository
@Transactional
public class MeterReadingDaoImpl implements MeterReadingDao {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<MeterReading> findByReadingId(Long id) {
        return null;
    }

    @Override
    public List<MeterReading> findByBillCycleNo(Long billCycleNo) {
        return null;
    }

    @Override
    public List<MeterReading> findByCreatedDate(LocalDate createdDate) {
        return null;
    }

    @Override
    public List<MeterPoint> findByLicenseCode(String licenseCode) {
        return null;
    }

    @Override
    public List<MeterReading> findByProvinceCode(String provinceCode) {
        return null;
    }


    @Override
    public List<MeterReading> findByBillCycleNoAndCreatedDate(Long billCycleNo, LocalDate createdDate) {
        return null;
    }

    @Override
    public List<MeterReading> findByCreatedDateBetween(LocalDate startDate, LocalDate endDate) {
        return null;
    }

    @Override
    public long countByBillCycleNo(Long billCycleNo) {
        return 0;
    }

    @Override
    public long countByCreatedDate(LocalDate createdDate) {
        return 0;
    }


//    @Override
//    public List<MeterReading> viewAllMeterReadings(String licenseCode, String provinceCode) {
//        TypedQuery<MeterReading> query = entityManager.createQuery(
//                "SELECT m.meter.meterReadings FROM MeterPoint m WHERE " +
//                        "m.licenseCode = :licenseCode " +
//                        "AND m.province2.provinceCode = :provinceCode ",
//                MeterReading.class);
//
//        query.setParameter("licenseCode", licenseCode);
//        query.setParameter("provinceCode", provinceCode);
//        return query.getResultList();
//    }


    @Override
    public List<MeterReading> viewAllMeterReadings(String billCycleNo) throws Exception {
        try {
            TypedQuery<MeterReading> query = entityManager.createQuery("SELECT m FROM MeterReading m WHERE m.billCycle.billCycleNo=:billCycleNo", MeterReading.class);
            query.setParameter("billCycleNo", Long.parseLong(billCycleNo));
            return query.getResultList();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            //e.printStackTrace();//
            throw new Exception("An error occurred while fetching the records.");
        }
    }

    @Override
    public List<MeterReading> viewAllMeterReadingsFilt(String billCycle, String licenseCode, String provinceCode) throws Exception {
        try {
            TypedQuery<MeterReading> query =
                    entityManager.createQuery("SELECT mr FROM MeterReading mr "+
                                    "JOIN Meter m ON mr.meter.cebSerialNo = m.cebSerialNo "+
                                    "JOIN MeterPoint mp ON m.cebSerialNo = mp.meter.cebSerialNo "+
                                    "WHERE mr.billCycle.billCycleNo = :billCycle "+
                                    "AND mp.licenseCode = :licenseCode " +
                                    "AND mp.province2.provinceCode = :provinceCode "
                            , MeterReading.class);
            query.setParameter("provinceCode", provinceCode);
            query.setParameter("licenseCode", licenseCode);
            query.setParameter("billCycle", Long.parseLong(billCycle));
            return query.getResultList();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            //e.printStackTrace();//
            throw new Exception("An error occurred while fetching the records.");
        }
    }

    @Override
    public List<MeterReading> getMeterReadings(Long billCycle) throws Exception {
        try {
            System.out.println("Meter Reading Table Data");
            TypedQuery<MeterReading> query = entityManager.createQuery("SELECT m FROM MeterReading m "
                            + "WHERE m.billCycle.billCycleNo = :billCycle",
                    MeterReading.class);
            query.setParameter("billCycle", billCycle);
            return query.getResultList();

        } catch (Exception e) {
            System.out.println(e.getMessage());
            //e.printStackTrace();//
            throw new Exception("An error occurred while fetching the records.");
        }
    }


    @Override
    public List<MeterReadingResultModel> getMeterReadingsFull(Long billCycle, String division, String province) throws Exception {
        try {
            TypedQuery<MeterReadingResultModel> query = entityManager.createQuery(
                    "SELECT new com.it.ceb.pts.model.MeterReadingResultModel( " +
                            "mr.readingId, mr.serialNo, mr.meter.cebSerialNo, " +
                            "mr.measure.measureName, mr.currentReading, mr.previousReading, mr.energy, "+
                            "pss.pssName, mp.area.areaName) " +
                            "FROM MeterReading mr " +
                            "JOIN mr.point mp " +
                            "JOIN mp.primarySubstation pss " +
                            "WHERE mr.billCycle.billCycleNo = :billCycle " +
                            "AND (CASE WHEN :division = 'LECO' THEN mp.province2.provinceCode ELSE mp.province1.provinceCode END) = :province " +
                            "AND mp.licenseCode = :division " +
                            "ORDER BY mr.readingId",
                    MeterReadingResultModel.class);
            query.setParameter("billCycle", billCycle);
            query.setParameter("province", province);
            query.setParameter("division", division);
            return query.getResultList();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            //e.printStackTrace();//
            throw new Exception("An error occurred while fetching the records.");
        }
    }

    @Override
    public List<MeterReadingResultModel> getMeterReadingsFullList(Long billCycle) throws Exception {
        try {
            TypedQuery<MeterReadingResultModel> query = entityManager.createQuery(
                    "SELECT new com.it.ceb.pts.model.MeterReadingResultModel( " +
                            "mr.readingId, mr.serialNo, mr.meter.cebSerialNo, " +
                            "mr.measure.measureName, mr.currentReading, mr.previousReading, mr.energy, "+
                            "mp.primarySubstation.pssName, mp.area.areaName) " +
                            "FROM MeterPoint mp " +
                            "LEFT JOIN FETCH MeterReading mr " +
                            "ON mp.pointId=mr.point.pointId " +
                            "AND mr.billCycle.billCycleNo = :billCycle ",
                    MeterReadingResultModel.class);
            query.setParameter("billCycle", billCycle);
            return query.getResultList();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            //e.printStackTrace();//
            throw new Exception("An error occurred while fetching the records.");
        }
    }

    @Override
    public List<MeterReadingErrorModel> getMeterReadingErrors(Long billCycle, String division, String province) throws Exception{
        //getting logId for the given billCycle, division, province (from MeterReadingLog)
        Long logID = 0L;
        System.out.println("billCycle: " + billCycle + " division: " + division + " province: " + province);
        try{
            TypedQuery<Long> query = entityManager.createQuery("SELECT mrl.readingLogId FROM MeterReadingLog mrl " +
                    "WHERE mrl.billCycle.billCycleNo = : billCycle " +
                    "AND mrl.license.licenseCode = : division " +
                    "AND mrl.province.provinceCode = : province", Long.class);
            query.setParameter("billCycle", billCycle);
            query.setParameter("division", division);
            query.setParameter("province", province);
            logID= query.getSingleResult();
        }catch (Exception e){
            System.out.println(e.getMessage());
            //e.printStackTrace();//
            throw new Exception("An error occurred while fetching the records.");
        }

        //getting the error records for the given logID (related to a particular batch process)
        try{
            TypedQuery<MeterReadingErrorModel> query = entityManager.createQuery("SELECT " +
                    "new com.it.ceb.pts.model.MeterReadingErrorModel" +
                    "(mr.serialNo, mr.cebSerialNo, mr.errorLogId, mr.status, mr.reason, mr.attempts) " +
                    "FROM MeterReadingErrLog mr " +
                    "WHERE mr.meterReadingLog.id = :logID", MeterReadingErrorModel.class);
            query.setParameter("logID", logID);
            return query.getResultList();
        }catch (Exception e){
            System.out.println(e.getMessage());
            //e.printStackTrace();//
            throw new Exception("An error occurred while fetching the records.");
        }
    }


    @Override
    public List<MeterReadingRecordModel> getMeterReadings(Long billCycleNo, String provinceCode, String licenseCode) throws Exception {
        try {
            TypedQuery<MeterReadingRecordModel> query = entityManager.createQuery(
                    "SELECT new com.it.ceb.pts.model.MeterReadingRecordModel(" +
                            "mr.readingId, mr.measure.measureName, mr.currentReading, mr.previousReading, " +
                            "mr.energy, mr.point.id, mr.measure.dayPeakOff, mr.measure.importOrExport) " +
                            "FROM MeterReading mr " +
                            "JOIN MeterPoint mp ON mr.point.id = mp.id " +
                            "WHERE mr.billCycle.billCycleNo = :billCycleNo " +
                            "AND mp.licenseCode = :licenseCode " +
                            "AND (CASE WHEN :licenseCode = 'LECO' THEN mp.province2.provinceCode ELSE mp.province1.provinceCode END) = :provinceCode " +
                            "GROUP BY mr.point.id, mr.measure.measureId, mr.readingId, mr.measure.measureName, " +
                            "mr.currentReading, mr.previousReading, mr.energy, mr.measure.dayPeakOff, mr.measure.importOrExport " +
                            "ORDER BY mr.point.id, mr.measure.measureId",
                    MeterReadingRecordModel.class);

            query.setParameter("billCycleNo", billCycleNo);
            query.setParameter("licenseCode", licenseCode);
            query.setParameter("provinceCode", provinceCode);

            return query.getResultList();
        }
        catch (Exception e){
            System.out.println(e.getMessage());
            //e.printStackTrace();//
            throw new RuntimeException("An error occurred while fetching the records.");
        }
    }
    @Override
    public List<MeterPointModel> getMeterPoints(String provinceCode, String licenseCode) throws Exception {
        try {
            TypedQuery<MeterPointModel>query = entityManager.createQuery("SELECT " +
                            "new com.it.ceb.pts.model.MeterPointModel(mp.id,mp.serialNo,mp.meter.cebSerialNo,mp.area.areaName,mp.primarySubstation.pssName) " +
                            "FROM MeterPoint mp " +
                            "WHERE (CASE WHEN :licenseCode = 'LECO' THEN mp.province2.provinceCode ELSE mp.province1.provinceCode END) = :provinceCode " +
                            "AND mp.licenseCode = :licenseCode",
                    MeterPointModel.class);
            query.setParameter("provinceCode", provinceCode);
            query.setParameter("licenseCode", licenseCode);
            return query.getResultList();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            //e.printStackTrace();//
            throw new Exception("An error occurred while fetching the point records.");
        }
    }

    @Override
    public List<MeterReadingEnergySummary> getMeterReadingEnergySummary(Long billCycle, List<String> serialNumbers) throws Exception {
        try {
            TypedQuery<MeterReadingEnergySummary> query = entityManager.createQuery(
                    "SELECT mres FROM MeterReadingEnergySummary mres " +
                            "WHERE mres.billCycle = :billCycle " +
                            "AND mres.serialNo IN :serialNumbers",
                    MeterReadingEnergySummary.class);

            query.setParameter("billCycle", billCycle);
            query.setParameter("serialNumbers", serialNumbers);
            List<MeterReadingEnergySummary> result = query.getResultList();
            return result != null ? result : new ArrayList<>();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            //e.printStackTrace();//
            throw new Exception("An error occurred while fetching the energy summary records.");
        }
    }

    @Override
    public List<MeterReadingErrLog> getErrorMeterList(Long billCycle, String division, String province) throws Exception{

        //getting logId for the given billCycle, division, province (from MeterReadingLog)
        Long logID = 0L;
        try{
            TypedQuery<Long> query = entityManager.createQuery("SELECT mrl.readingLogId FROM MeterReadingLog mrl " +
                    "WHERE mrl.billCycle.billCycleNo = : billCycle " +
                    "AND mrl.license.licenseCode = : division " +
                    "AND mrl.province.provinceCode = : province ", Long.class);
            query.setParameter("billCycle", billCycle);
            query.setParameter("division", division);
            query.setParameter("province", province);
            try {
                logID = query.getSingleResult();
            } catch (jakarta.persistence.NoResultException e) {
                //e.printStackTrace();//
                return new ArrayList<>();
            }
        }catch (Exception e){
            System.out.println(e.getMessage());
            //e.printStackTrace();//
            throw new Exception("An error occurred while fetching the records.");
        }

        //getting the error meters list (CEBserialNO) the given logID (related to a particular batch process)
        try{
            TypedQuery<MeterReadingErrLog> query = entityManager.createQuery("SELECT mrel FROM MeterReadingErrLog mrel" +
                    " WHERE mrel.meterReadingLog.readingLogId = : logID " +
                    "AND mrel.status = : status and mrel.cebSerialNo is not null", MeterReadingErrLog.class);
            query.setParameter("logID", logID);
            query.setParameter("status", "UNSOLVED");
            return query.getResultList();
        }catch (Exception e){
            System.out.println(e.getMessage());
            //e.printStackTrace();//
            throw new Exception("An error occurred while fetching the records.");
        }
    }

    @Override
    public LocalDate getCoincidentPeakDate(Long billCycleNo) throws Exception {
        try {
            TypedQuery<LocalDate> query = entityManager.createQuery(
                    "SELECT bc.coincidentPeakDate FROM BillCycle bc WHERE bc.billCycleNo = :billCycleNo",
                    LocalDate.class);
            query.setParameter("billCycleNo", billCycleNo);
            return query.getSingleResult();
        } catch (Exception e) {
            System.out.println("Error getting coincident peak date: " + e.getMessage());
            //e.printStackTrace();//
            throw new Exception("An error occurred while fetching the coincident peak date.");
        }
    }

    @Override
    public ProvinceEnergySummary getProvinceEnergySummary(Long billCycle, String division, String province) throws Exception {
        try {
            TypedQuery<ProvinceEnergySummary> query = entityManager.createQuery(
                    "SELECT es FROM ProvinceEnergySummary es " +
                            "WHERE es.billCycleNo = :billCycle " +
                            "AND es.licenseCode = :division " +
                            "AND es.provinceCode = :province ",
                    ProvinceEnergySummary.class);

            query.setParameter("billCycle", billCycle);
            query.setParameter("division", division);
            query.setParameter("province", province);

            try {
                return query.getSingleResult();
            } catch (jakarta.persistence.NoResultException e) {
                return new ProvinceEnergySummary();
            }
        } catch (Exception e) {
            System.out.println("Error getting energy summary: " + e.getMessage());
            //e.printStackTrace();//
            throw new Exception("An error occurred while fetching the energy summary records.");
        }
    }

    //  Gihani
    //display previousReading, currentReading, and energy
    @Override
    public List<MeterReading> findAllBySerialNoAndBillCycle(String serialNo, Long billCycleNo) {
        String jpql = "SELECT mr FROM MeterReading mr JOIN FETCH mr.measure WHERE mr.serialNo = :serialNo AND mr.billCycle.billCycleNo = :billCycleNo ORDER BY mr.createdDate";
        List<MeterReading> result = entityManager.createQuery(jpql, MeterReading.class)
                .setParameter("serialNo", serialNo)
                .setParameter("billCycleNo", billCycleNo)
                .getResultList();
        System.out.println("DAO: Found " + result.size() + " readings for serialNo=" + serialNo + ", billCycleNo=" + billCycleNo);
        return result;
    }


    @Override
    public void save(MeterReading meterReading) {
        if (meterReading.getReadingId() == null) {
            entityManager.persist(meterReading);
        } else {
            entityManager.merge(meterReading);
        }
        entityManager.flush();
    }

    @Override
    public MeterReading findBySerialNoAndBillCycleAndMeasureName(String serialNo, Long billCycleNo, String measureName) {
        String jpql = "SELECT mr FROM MeterReading mr JOIN FETCH mr.measure WHERE mr.serialNo = :serialNo AND mr.billCycle.billCycleNo = :billCycleNo AND mr.measure.measureName = :measureName";
        List<MeterReading> result = entityManager.createQuery(jpql, MeterReading.class)
                .setParameter("serialNo", serialNo)
                .setParameter("billCycleNo", billCycleNo)
                .setParameter("measureName", measureName)
                .getResultList();
        return result.isEmpty() ? null : result.get(0);
    }

    @Override
    public long getNextReadingId() {
        Long maxId = (Long) entityManager.createQuery(
                "SELECT COALESCE(MAX(m.readingId), 0) FROM MeterReading m"
        ).getSingleResult();
        return maxId + 1;
    }

    //province config methods
    @Override
    public ProvinceConfig findByBillCycleAndLicenseCodeAndProvinceCode(Long billCycleNo, String licenseCode, String provinceCode) {
        try {
            String jpql = "SELECT pc FROM ProvinceConfig pc " +
                    "WHERE pc.billCycleNo.billCycleNo = :billCycleNo " +
                    "AND pc.licenseCode.licenseCode = :licenseCode " +
                    "AND pc.provinceCode.provinceCode = :provinceCode";
            return entityManager.createQuery(jpql, ProvinceConfig.class)
                    .setParameter("billCycleNo", billCycleNo)
                    .setParameter("licenseCode", licenseCode)
                    .setParameter("provinceCode", provinceCode)
                    .getResultStream()
                    .findFirst()
                    .orElse(null);
        } catch (Exception e) {
            System.out.println("Error fetching ProvinceConfig: " + e.getMessage());
            return null;
        }
    }
}