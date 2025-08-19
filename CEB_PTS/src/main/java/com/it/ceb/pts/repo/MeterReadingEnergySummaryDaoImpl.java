package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.MeterReadingEnergySummary;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class MeterReadingEnergySummaryDaoImpl implements MeterReadingEnergySummaryDao {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public MeterReadingEnergySummary findByBillCycleAndSerialNo(Long billCycle, String serialNo) {
        try {
            return entityManager.createQuery(
                            "SELECT m FROM MeterReadingEnergySummary m WHERE m.billCycle = :billCycle AND m.serialNo = :serialNo",
                            MeterReadingEnergySummary.class)
                    .setParameter("billCycle", billCycle)
                    .setParameter("serialNo", serialNo)
                    .getSingleResult();
        } catch (jakarta.persistence.NoResultException e) {
            return null;
        }
    }

    @Override
    @Transactional
    public void update(MeterReadingEnergySummary summary) {
        entityManager.merge(summary);
        entityManager.flush();
        entityManager.clear();
    }

    @Override
    public Long getNextSummaryId() {
        Long maxId = (Long) entityManager.createQuery(
                "SELECT COALESCE(MAX(m.summaryId), 0) FROM MeterReadingEnergySummary m"
        ).getSingleResult();
        return maxId + 1;
    }

    @Override
    @Transactional
    public void insert(MeterReadingEnergySummary summary) {
        entityManager.persist(summary);
        entityManager.flush();
        entityManager.clear();
    }
}