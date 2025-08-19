package com.it.ceb.pts.repo;

import java.util.List;

import com.it.ceb.pts.domain.FileUpload;

public interface FileUploadDao {
	
	public void save(FileUpload obj);
	
	public List<FileUpload>  getListFileUpload();

}
