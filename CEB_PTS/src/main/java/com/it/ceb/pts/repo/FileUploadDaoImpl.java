package com.it.ceb.pts.repo;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;


import com.it.ceb.pts.domain.FileUpload;

@Repository
@Transactional
public class FileUploadDaoImpl implements FileUploadDao {
	@Autowired
    private EntityManager em;
	
	@Override
	public void save(FileUpload obj) {
		em.persist(obj);
		
	}

	@Override
	public List<FileUpload> getListFileUpload() {
		String qryStr = "SELECT p FROM FileUpload p";
		Query query = em.createQuery(qryStr);
		List<FileUpload> list = query.getResultList();
		return list;
	}
	
	

}
