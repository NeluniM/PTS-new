package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.BillCycle;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import jakarta.transaction.Transactional;

import org.springframework.stereotype.Repository;

@Repository

public class BillCycleDaoImpl implements BillCycleDao {


    @PersistenceContext
    private EntityManager entityManager;
    @Override
    public BillCycle findByBillCycleNo(Long billCycleNo) {
        try {
            String jpql = "SELECT b FROM BillCycle b WHERE b.billCycleNo = :billCycleNo";
            TypedQuery<BillCycle> query = entityManager.createQuery(jpql, BillCycle.class);
            query.setParameter("billCycleNo", billCycleNo);
            return query.getSingleResult();
        } catch (jakarta.persistence.NoResultException e) {
            System.out.println("No BillCycle found for billCycleNo: " + billCycleNo);
            return null;
        } catch (Exception e) {
            System.out.println("Error while getting bill cycle: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    @Override
    @Transactional
    public BillCycle updateBillCycleDetails(BillCycle billCycle) {
        if (billCycle.getBillCycleNo() == null) {
            entityManager.persist(billCycle);
            return billCycle;
        } else {
            return entityManager.merge(billCycle);
        }
    }

    @Override
    @Transactional
    public BillCycle save(BillCycle billCycle) {
        if (billCycle.getBillCycleNo() == null) {
            entityManager.persist(billCycle);
            return billCycle;
        } else {
            return entityManager.merge(billCycle);
        }
    }
    
    @Override
    public Long getCurrentBillCycleNo() {
    	Long currentCycle = null;
    	try
    	{
    		TypedQuery<Long> query = entityManager.createQuery(
                    "SELECT b.billCycleNo FROM BillCycle b WHERE b.isCurrent = 1",
                    Long.class
            );
    		currentCycle = query.getSingleResult();
    	}
        catch(Exception e)
    	{
        	e.printStackTrace();
    	}
    	return currentCycle;
    }

}
