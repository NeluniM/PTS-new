package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.Tariff;

import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TariffDao {

    @Query("SELECT t FROM Tariff t WHERE t.tariffId = :tariffId")
    Tariff findById(@Param("tariffId") Long tariffId);

    @Query("SELECT t FROM Tariff t ")
    List<Tariff> findAllOrderByCurrentFirst();

    @Query("SELECT t FROM Tariff t WHERE t.isCurrent = 0L ORDER BY t.validFrom DESC")
    List<Tariff> findAllNonCurrentTariffs();

    Tariff save(Tariff tariff);

    @Transactional
    @Modifying
    List<Tariff> saveAll(List<Tariff> tariffs);

    List<Tariff> findAll();

    @Query("SELECT t FROM Tariff t JOIN t.tariffCategoryCode tc WHERE tc.tariffCategoryCode = :categoryCode")
    Tariff findByCategoryCode(@Param("categoryCode") String categoryCode);

    void addTariffs(List<Tariff> tariffs);

    // New method to update isCurrent status of previous records
    @Transactional
    @Modifying
    void updatePreviousRecordsToNonCurrent();

    // New method to find current tariffs by category codes
    @Query("SELECT t FROM Tariff t WHERE t.isCurrent = 1L AND t.tariffCategoryCode.tariffCategoryCode IN :categoryCodes")
    List<Tariff> findCurrentTariffsByCategoryCodes(@Param("categoryCodes") List<String> categoryCodes);
}