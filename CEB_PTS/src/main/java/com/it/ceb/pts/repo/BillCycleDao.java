package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.BillCycle;

import org.springframework.stereotype.Repository;



@Repository
public interface BillCycleDao {

    BillCycle findByBillCycleNo(Long billCycleNo);
    BillCycle updateBillCycleDetails(BillCycle billCycle);

    BillCycle save(BillCycle billCycle);
	Long getCurrentBillCycleNo();
   }
