package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.Meter;
import com.it.ceb.pts.domain.MeterHeader;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import org.jboss.logging.Logger;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Repository
public class MeterDaoImpl implements MeterDao {

    private static final Logger LOGGER = Logger.getLogger(MeterDaoImpl.class);

    @PersistenceContext
    private EntityManager entityManager;

    // ---------------------------------------------------------
    //  SEARCH BY CEB SERIAL NO
    // ---------------------------------------------------------
    @Override
    public Meter getMeterByCebSerialNo(String cebSerialNo) {
        try {
            TypedQuery<Meter> query = entityManager.createQuery(
                    "SELECT m FROM Meter m WHERE m.cebSerialNo = :cebSerialNo",
                    Meter.class
            );
            query.setParameter("cebSerialNo", cebSerialNo);
            return query.getSingleResult();
        } catch (Exception e) {
            LOGGER.info("Meter not found for CEB Serial No: " + cebSerialNo);
            return null;
        }
    }

    // ---------------------------------------------------------
    //  SEARCH BY PHYSICAL SERIAL NO
    // ---------------------------------------------------------
    @Override
    public Meter getMeterBySerialNo(String serialNo) {
        try {
            return entityManager.createQuery(
                            "SELECT m FROM Meter m WHERE m.serialNo = :serialNo",
                            Meter.class
                    )
                    .setParameter("serialNo", serialNo)
                    .getSingleResult();
        } catch (Exception e) {
            LOGGER.info("Meter not found for Serial No: " + serialNo);
            return null;
        }
    }

    // ---------------------------------------------------------
    //  SAVE METER
    // ---------------------------------------------------------
    @Override
    @Transactional
    public void saveMeter(Meter meter) {
        if (meter != null) {
            entityManager.merge(meter);
        }
    }

    // ---------------------------------------------------------
    //  SAVE METER HEADER
    // ---------------------------------------------------------
    @Override
    @Transactional
    public void saveMeterHeader(MeterHeader header) {
        if (header != null) {
            entityManager.merge(header);
        }
    }

    // ---------------------------------------------------------
    //  SOFT DELETE BY SERIAL NO  ✅ FINAL FIX
    // ---------------------------------------------------------
    @Override
    @Transactional
    public void softDeleteMeterBySerialNo(String serialNo) {

        int deleted = entityManager.createQuery(
                        "DELETE FROM Meter m WHERE m.serialNo = :serialNo"
                )
                .setParameter("serialNo", serialNo)
                .executeUpdate();

        if (deleted == 0) {
            LOGGER.info("No meter deleted for Serial No: " + serialNo);
        } else {
            LOGGER.info("Meter deleted successfully. Serial No: " + serialNo);
        }
    }



    // ---------------------------------------------------------
    //  HEADER COUNT FOR YEAR
    // ---------------------------------------------------------
    @Override
    public long getMeterHeaderCountForYear(int year) {
        try {
            String prefix = "TRM/BATCH/" + year + "/";

            TypedQuery<Long> query = entityManager.createQuery(
                    "SELECT COUNT(h) FROM MeterHeader h WHERE h.batchId LIKE :prefix",
                    Long.class
            );
            query.setParameter("prefix", prefix + "%");

            return query.getSingleResult();
        } catch (Exception e) {
            LOGGER.info("Error counting headers: " + e.getMessage());
            return 0;
        }
    }

    // ---------------------------------------------------------
    //  GET LAST CEB SERIAL
    // ---------------------------------------------------------
    @Override
    public String getLastCebSerialNo() {
        try {
            TypedQuery<String> query = entityManager.createQuery(
                    "SELECT m.cebSerialNo FROM Meter m ORDER BY m.cebSerialNo DESC",
                    String.class
            );
            query.setMaxResults(1);
            return query.getSingleResult();
        } catch (Exception e) {
            LOGGER.info("No previous CEB Serial found, starting fresh.");
            return null;
        }
    }

    // ---------------------------------------------------------
    //  GET LAST CEB SERIAL FOR YEAR
    // ---------------------------------------------------------
    @Override
    public String getLastCebSerialForYear(String year2Digits) {
        try {
            TypedQuery<String> query = entityManager.createQuery(
                    "SELECT m.cebSerialNo FROM Meter m " +
                            "WHERE m.cebSerialNo LIKE :prefix " +
                            "ORDER BY m.cebSerialNo DESC",
                    String.class
            );
            query.setParameter("prefix", "TRM/METER/" + year2Digits + "/%");
            query.setMaxResults(1);
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }

    // ---------------------------------------------------------
    //  SAVE METER LIST
    // ---------------------------------------------------------
    @Override
    @Transactional
    public void saveMeterList(List<Meter> meters) {
        if (meters == null || meters.isEmpty()) return;

        for (Meter meter : meters) {
            entityManager.merge(meter);
        }
    }

    @Override
    public int getNextCebSerialNumberForYear(String year2Digits) {
        try {
            String jpql = """
            SELECT MAX(
                CAST(SUBSTRING(m.cebSerialNo, LENGTH(m.cebSerialNo) - 4, 5) AS integer)
            )
            FROM Meter m
            WHERE m.cebSerialNo LIKE :prefix
            """;

            Integer max = entityManager.createQuery(jpql, Integer.class)
                    .setParameter("prefix", "TRM/METER/" + year2Digits + "/%")
                    .getSingleResult();

            return (max == null) ? 1 : max + 1;

        } catch (Exception e) {
            LOGGER.error("Error getting next CEB serial number", e);
            return 1;
        }
    }

}
