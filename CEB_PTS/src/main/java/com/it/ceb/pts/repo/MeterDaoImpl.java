package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.Meter;
import com.it.ceb.pts.domain.MeterHeader;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import org.jboss.logging.Logger;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public class MeterDaoImpl implements MeterDao {

    private static final Logger LOGGER = Logger.getLogger(MeterDaoImpl.class);

    @PersistenceContext
    private EntityManager entityManager;

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

    @Override
    @Transactional
    public void saveMeter(Meter meter) {
        if (meter != null) {
            entityManager.merge(meter);
        }
    }

    @Override
    @Transactional
    public void saveMeterHeader(MeterHeader header) {
        if (header != null) {
            entityManager.merge(header);
        }
    }

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
    //   NEW — GET LAST CEB SERIAL FOR SPECIFIC YEAR
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
            return null; // no records for this year
        }
    }

    @Override
    @Transactional
    public void saveMeterList(List<Meter> meters) {
        if (meters == null || meters.isEmpty()) return;

        for (Meter meter : meters) {
            entityManager.merge(meter);
        }
    }
}
