package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.MeterPoint;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class MeterPointDaoImpl implements MeterPointDao {

    @PersistenceContext
    private EntityManager entityManager;

    @Transactional(readOnly = true)
    public MeterPoint findBySerialNo(String serialNo) {
        String jpql = "SELECT m FROM MeterPoint m WHERE m.serialNo = :serialNo";
        TypedQuery<MeterPoint> query = entityManager.createQuery(jpql, MeterPoint.class);
        query.setParameter("serialNo", serialNo);
        return query.getResultStream().findFirst().orElse(null);
    }

    @Override
    @Transactional
    public void save(MeterPoint meterPoint) {
        entityManager.merge(meterPoint);
        entityManager.flush(); // 🔥 forces Oracle insert
    }


}