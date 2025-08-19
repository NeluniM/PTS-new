package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.Province;
import com.it.ceb.pts.domain.DistributionLicense;
import jakarta.persistence.TypedQuery;
import org.springframework.stereotype.Repository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.Collections;
import java.util.List;

@Repository
public class DistributionLicenseDaoImpl implements DistributionLicenseDao {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<DistributionLicense> getLicenseList() throws Exception {
        try{
            TypedQuery<DistributionLicense> query = entityManager.createQuery("SELECT s FROM DistributionLicense s", DistributionLicense.class);
            return query.getResultList();
        }catch(Exception e){
            System.out.println(e.getMessage());
            return Collections.emptyList();
        }
    }

    @Override
    public List<Province> getProvinceByLicense(String licenseCode) {
        try {
            TypedQuery<Province> query = entityManager.createQuery(
                    "SELECT p FROM Province p WHERE p.licenseCode = :licenseCode",
                    Province.class
            );
            query.setParameter("licenseCode", licenseCode);
            return query.getResultList();
        } catch (Exception e) {
            System.out.println("errorrrrrrrrrrrrrrrrrrrrrrrr");
            System.out.println(e.getMessage());
            return Collections.emptyList();
        }
    }


//    public List<licenseList_dropDown> getLicenseList_dropDown() throws Exception {
//        try{
//            TypedQuery<DistributionLicense> query = entityManager.createQuery("SELECT s FROM DistributionLicense s", DistributionLicense.class);
//            List<DistributionLicense> results = query.getResultList();
//            List<licenseList_dropDown> dropdownList = new ArrayList<>();
//
//            for (DistributionLicense result : results) {
//                licenseList_dropDown item = new licenseList_dropDown();
//                item.licenseCode = result.getLicenseCode();
//                item.licenseName = result.getLicenseName();
//                dropdownList.add(item);
//            }
//            return dropdownList;
//        }catch(Exception e){
//            System.out.println(e.getMessage());
//            return Collections.emptyList();
//        }
//    }
}
