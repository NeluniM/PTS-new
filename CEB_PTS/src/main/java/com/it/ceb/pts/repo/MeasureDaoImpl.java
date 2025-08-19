package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.Measure;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;

@Repository
public class MeasureDaoImpl implements MeasureDao {
    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public Measure findByName(String measureName) {
        return entityManager.createQuery(
                        "SELECT m FROM Measure m WHERE m.measureName = :measureName", Measure.class)
                .setParameter("measureName", measureName)
                .getSingleResult();
    }
}