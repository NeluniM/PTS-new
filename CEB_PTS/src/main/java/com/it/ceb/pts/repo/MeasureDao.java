package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.Measure;

public interface MeasureDao {
    Measure findByName(String measureName);
}