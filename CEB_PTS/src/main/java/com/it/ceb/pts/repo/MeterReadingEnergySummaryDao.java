package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.MeterReadingEnergySummary;

public interface MeterReadingEnergySummaryDao {
    MeterReadingEnergySummary findByBillCycleAndSerialNo(Long billCycle, String serialNo);
    void update(MeterReadingEnergySummary summary);
    void insert(MeterReadingEnergySummary summary);
    Long getNextSummaryId();
}