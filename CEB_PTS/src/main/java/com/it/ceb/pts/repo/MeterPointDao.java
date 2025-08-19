package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.MeterPoint;


public interface MeterPointDao {

    MeterPoint findBySerialNo(String serialNo) ;

}

