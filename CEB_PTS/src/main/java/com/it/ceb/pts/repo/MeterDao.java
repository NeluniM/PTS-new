package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.Meter;
import com.it.ceb.pts.domain.MeterHeader;


import java.util.List;

public interface MeterDao {

    // -------------------------
    // Existing methods
    // -------------------------
    Meter getMeterByCebSerialNo(String cebSerialNo);

    void saveMeter(Meter meter);

    void saveMeterHeader(MeterHeader header);

    long getMeterHeaderCountForYear(int year);

    String getLastCebSerialNo();

    String getLastCebSerialForYear(String year2Digits);

    void saveMeterList(List<Meter> meters);

    // -------------------------
    // ✅ REQUIRED for your feature
    // -------------------------
    Meter getMeterBySerialNo(String serialNo);

    void softDeleteMeterBySerialNo(String serialNo);

    // 🔥 FIX: get max numeric CEB serial for year
    int getNextCebSerialNumberForYear(String year2Digits);



}
