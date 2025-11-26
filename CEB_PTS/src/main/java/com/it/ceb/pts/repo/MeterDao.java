package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.Meter;
import com.it.ceb.pts.domain.MeterHeader;

public interface MeterDao {

    Meter getMeterByCebSerialNo(String cebSerialNo);

    void saveMeter(Meter meter);

    void saveMeterHeader(MeterHeader header);
}
