package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.Meter;
import com.it.ceb.pts.domain.MeterHeader;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import org.jboss.logging.Logger;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

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
            LOGGER.info("Error fetching Meter by CEB Serial No: " + e.getMessage());
            return null;
        }
    }

    @Override
    @Transactional
    public void saveMeter(Meter meter) {
        if (meter == null) return;
        entityManager.merge(meter);
    }

    @Override
    @Transactional
    public void saveMeterHeader(MeterHeader header) {
        if (header == null) return;
        entityManager.merge(header);
    }
}
