package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.TariffCategory;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TariffCategoryDao {

    @Query("SELECT tc FROM TariffCategory tc ORDER BY tc.tariffCategoryCode")
    List<TariffCategory> findAll();

    @Query("SELECT tc FROM TariffCategory tc WHERE tc.tariffCategoryCode = :tariffCategoryCode")
    TariffCategory findByTariffCategoryCode(@Param("tariffCategoryCode") String tariffCategoryCode);
}
