package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.Tariff;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Repository
public class TariffDaoImpl implements TariffDao {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public Tariff findById(Long tariffId) {
        try {
            TypedQuery<Tariff> query = entityManager.createQuery(
                    "SELECT t FROM Tariff t WHERE t.tariffId = :tariffId",
                    Tariff.class
            );
            query.setParameter("tariffId", tariffId);
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public List<Tariff> findAllOrderByCurrentFirst() {
        try {
            TypedQuery<Tariff> query = entityManager.createQuery(
                    "SELECT t FROM Tariff t JOIN FETCH t.tariffCategoryCode WHERE t.isCurrent = 1L ",
                    Tariff.class
            );
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Tariff> findAllNonCurrentTariffs() {
        try {
            TypedQuery<Tariff> query = entityManager.createQuery(
                    "SELECT t FROM Tariff t JOIN FETCH t.tariffCategoryCode WHERE t.isCurrent = 0L ORDER BY t.tariffCategoryCode.tarrifType, t.validFrom DESC",
                    Tariff.class
            );
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    @Transactional
    public Tariff save(Tariff tariff) {
        try {
            if (tariff.getTariffId() == null) {
                entityManager.persist(tariff);
            } else {
                tariff = entityManager.merge(tariff);
            }
            //entityManager.flush();
            return tariff;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    @Transactional
    public List<Tariff> saveAll(List<Tariff> tariffs) {
        try {
            List<Tariff> savedTariffs = new ArrayList<>();
            for (Tariff tariff : tariffs) {
                if (tariff.getTariffId() == null) {
                    entityManager.persist(tariff);
                } else {
                    tariff = entityManager.merge(tariff);
                }
                savedTariffs.add(tariff);
            }
            // entityManager.flush();
            return savedTariffs;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Tariff> findAll() {
        try {
            TypedQuery<Tariff> query = entityManager.createQuery(
                    "SELECT t FROM Tariff t ORDER BY t.tariffId",
                    Tariff.class
            );
            return query.getResultList();
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public Tariff findByCategoryCode(String categoryCode) {
        try {
            TypedQuery<Tariff> query = entityManager.createQuery(
                    "SELECT t FROM Tariff t JOIN t.tariffCategoryCode tc WHERE tc.tariffCategoryCode = :categoryCode",
                    Tariff.class
            );
            query.setParameter("categoryCode", categoryCode);
            return query.getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public List<Tariff> findCurrentTariffsByCategoryCodes(List<String> categoryCodes) {
        try {
            TypedQuery<Tariff> query = entityManager.createQuery(
                    "SELECT t FROM Tariff t WHERE t.isCurrent = 1L AND t.tariffCategoryCode.tariffCategoryCode IN :categoryCodes",
                    Tariff.class
            );
            query.setParameter("categoryCodes", categoryCodes);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    @Transactional
    @Override
    public void updatePreviousRecordsToNonCurrent() {
        try {
            System.out.println("Updating previous current records to non-current");
            int updatedCount = entityManager.createQuery(
                    "UPDATE Tariff t SET t.isCurrent = 0L WHERE t.isCurrent = 1L"
            ).executeUpdate();
            System.out.println("Updated " + updatedCount + " records to non-current");
            // entityManager.flush();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to update previous records to non-current", e);
        }
    }

    @Transactional
    @Override
    public void addTariffs(List<Tariff> tariffs) {
        System.out.println("Adding to tariffs");

        // First, update all current records to non-current
        updatePreviousRecordsToNonCurrent();

        // Then add new tariffs
        for (Tariff tariff : tariffs) {
            System.out.println("Adding tariff: " + tariff.getTariffCategoryCode().getTariffName());
            BigDecimal nextVal = (BigDecimal) entityManager
                    .createNativeQuery("SELECT TARIFF_SEQ.NEXTVAL FROM SYS.DUAL")
                    .getSingleResult();
            System.out.println("Next value for TARIFF_SEQ: " + nextVal);
            tariff.setTariffId(nextVal.longValue());
            System.out.println("Setting tariff ID: " + tariff.getTariffId());
            entityManager.persist(tariff);
            System.out.println("Persisted tariff: " + tariff.getTariffCategoryCode().getTariffName());
        }
        System.out.println("Tariffs added successfully");
    }
}