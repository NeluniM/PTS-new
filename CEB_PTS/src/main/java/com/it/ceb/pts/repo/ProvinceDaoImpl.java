package com.it.ceb.pts.repo;

import java.util.HashMap;
import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.it.ceb.pts.domain.Province;

@Repository
@Transactional
public class ProvinceDaoImpl implements ProvinceDao {
	
	@Autowired
    private EntityManager em;

	@PersistenceContext
	private EntityManager entityManager;
	
	
	@SuppressWarnings("unchecked")
	@Override
	public HashMap<String, String> getProvinceListToLicense(String licenceCode) throws Exception
	{
		String qryStr = "SELECT s FROM Province s where s.licenseCode =:licenseCode";
		Query query = em.createQuery(qryStr);
		query.setParameter("licenseCode", licenceCode);
		List<Province> provinceList = query.getResultList();
		HashMap<String, String> provinceMap = new HashMap<String, String>();
	    for (Province province : provinceList) {
	    	provinceMap.put(province.getProvinceCode(), province.getProvinceName());
	    }
		return provinceMap;
		
	}


	@Override
	public List<Province> getProvinceByDivition(String licenceCode) {
		String qryStr = "SELECT s FROM Province s where s.licenseCode =:licenseCode";
		Query query = em.createQuery(qryStr);
		query.setParameter("licenseCode", licenceCode);
		List<Province> provinceList = query.getResultList();
		return provinceList;
	}


	@Override
	public List<Province> getAllProvince() {
		String qryStr = "SELECT s FROM Province s where status = 1";
		Query query = em.createQuery(qryStr);
		List<Province> provinceList = query.getResultList();
		return provinceList;
	}

	@Override
	public String getProvinceCodeByName(String provinceName) {
		try {
			String query = "SELECT p.provinceCode FROM Province p WHERE p.provinceName = :provinceName";
			return entityManager.createQuery(query, String.class)
					.setParameter("provinceName", provinceName)
					.getSingleResult();
		} catch (NoResultException e) {
			return null; // Return null if no matching province is found
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("Error fetching province code by name: " + e.getMessage());
		}
	}

}
