package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.TariffCategory;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class TariffCategoryDaoImpl implements TariffCategoryDao {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<TariffCategory> findAll() {
        try {
            TypedQuery<TariffCategory> query = entityManager.createQuery(
                    "SELECT tc FROM TariffCategory tc ORDER BY tc.tariffCategoryCode",
                    TariffCategory.class
            );
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public TariffCategory findByTariffCategoryCode(String tariffCategoryCode) {
        try {
            TypedQuery<TariffCategory> query = entityManager.createQuery(
                    "SELECT tc FROM TariffCategory tc WHERE tc.tariffCategoryCode = :tariffCategoryCode",
                    TariffCategory.class
            );
            query.setParameter("tariffCategoryCode", tariffCategoryCode);
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }
}
