package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.FileUploadHeader;
import com.it.ceb.pts.domain.ProvinceConfig;

import java.util.List;

public interface FileUploadHeaderDao {
    void save(FileUploadHeader header) throws Exception;

    void update(FileUploadHeader header) throws Exception;

    FileUploadHeader findById(Long uploadId);

    boolean exists(Long uploadId);

    List<FileUploadHeader> findByBillCycleAndLicenseeAndProvince(
            Long billCycle, String licensee, String province);

    FileUploadHeader findByCompositeKeyAndFileName(
            Long billCycle, String licensee, String province, String fileName);

    Long countUploadedFiles(Long billCycle, String licensee, String province);

    void delete(Long uploadId) throws Exception;

    List<FileUploadHeader> findByBillCycle(Long billCycle);

    public long countFilesByBillCycleAndProvinceAndLicense(Long billCycle, String licenseCode, String provinceCode);

    // public Long generateNextUploadId() throws Exception;

    int countByBillCycleAndLicenseAndProvince(Long billCycle, String licenseCode, String provinceCode);

    List<FileUploadHeader> getUploadDetails(String billCycle, String division);

    public String getProvinceName(String provinceCode);

//    void save(ProvinceConfig provinceConfig) throws Exception;

    public Long isUploadLocked(String billCycle, String division, String provinceCode);

    public List<ProvinceConfig> getConfigsForCycleAndLicense(Long billCycleNo, String licenseCode);

    public List<Object[]> findLockStatusByParams(Long billCycleNo, String licenseCode, String provinceCode);

    public Long findUploadLockStatus(Long billCycle, String licenseCode, String provinceCode);


    //province config===============================================
    public boolean updateIsUploadLocked(Long billCycleNo, String licenseCode, String provinceCode, Long isUploadLocked);


}