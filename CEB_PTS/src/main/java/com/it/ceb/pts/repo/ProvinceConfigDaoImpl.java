package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.BillCycle;
import com.it.ceb.pts.domain.ProvinceConfig;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class ProvinceConfigDaoImpl implements ProvinceConfigDao {

    @PersistenceContext
    private EntityManager entityManager;

    public ProvinceConfig findByParams(Long billCycleNo, String licenseCode) {
        TypedQuery<ProvinceConfig> query = entityManager.createQuery(
                "SELECT pc FROM ProvinceConfig pc " +
                        "WHERE pc.id.billCycleNo = :billCycleNo " +
                        "AND pc.id.licenseCode = :licenseCode " ,

                ProvinceConfig.class);

        query.setParameter("billCycleNo", billCycleNo);
        query.setParameter("licenseCode", licenseCode);


        return query.getSingleResult();
    }

    @Override
    @Transactional
    public ProvinceConfig save(ProvinceConfig provinceConfig) {
        if (provinceConfig.getBillCycleNo() == null) {
            entityManager.persist(provinceConfig);
            return provinceConfig;
        } else {
            return entityManager.merge(provinceConfig);
        }
    }

    @Override
    public Long isBillCycleCurrent(Long billCycleNo) {
        TypedQuery<Long> query = entityManager.createQuery(
                "SELECT bc.isCurrent FROM BillCycle bc WHERE bc.billCycleNo = :billCycleNo",
                Long.class);
        query.setParameter("billCycleNo", billCycleNo);
        return query.getSingleResult();
        }

        @Override
        public ProvinceConfig getProvinceConfig(Long billCycleNo, String licenseCode, String provinceCode) {
            try {
                TypedQuery<ProvinceConfig> query = entityManager.createQuery(
                        "SELECT pc FROM ProvinceConfig pc " +
                                "WHERE pc.id.billCycleNo = :billCycleNo " +
                                "AND pc.id.licenseCode = :licenseCode " +
                                "AND pc.id.provinceCode = :provinceCode" ,
                        ProvinceConfig.class);

                query.setParameter("billCycleNo", billCycleNo);
                query.setParameter("licenseCode", licenseCode);
                query.setParameter("provinceCode", provinceCode);

                return query.getSingleResult();
            } catch (jakarta.persistence.NoResultException e) {
                System.out.println("No ProvinceConfig found for billCycleNo: " + billCycleNo +
                                  ", licenseCode: " + licenseCode + ", provinceCode: " + provinceCode);
                return null;
            } catch (Exception e) {
                System.out.println("Error while getting province config: " + e.getMessage());
                e.printStackTrace();
                return null;
            }
        }
    @Override
    public BillCycle getCurrentBillCycle() {
        try {
            TypedQuery<BillCycle> query = entityManager.createQuery(
                    "SELECT b FROM BillCycle b WHERE b.isCurrent = 1",
                    BillCycle.class);
            return query.getSingleResult();
        } catch (Exception e) {
            System.out.println("Error while getting current bill cycle: " + e.getMessage());
            //e.printStackTrace();//
            return null;
        }
    }

}