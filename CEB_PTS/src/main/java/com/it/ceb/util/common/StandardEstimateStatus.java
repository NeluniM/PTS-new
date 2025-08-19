package com.it.ceb.util.common;
import java.util.Map;
import java.util.HashMap;
import java.util.EnumSet;
public enum StandardEstimateStatus {
	
	UNKNOWN(-1L, "UNKNOWN"),
	NEW_APPLICATION(1L, "New Estimate"),
	APPLICATION_MODIFIED(2L, "Modified Estimate "),
	REJECTED_BY(5L, "Rejected by"),
	TO_BE_CHECKED_BY_ELECTRICAL_SUPIRINTENDENT(8L, "To be validate by Electrical Supirintantdant"),
	//TO_BE_CHECKED_BY_ELECTRICAL_SUPIRINTENDENT2(9L, "To be validate by Electrical Supirintantdant"),
	TO_BE_VALIDATED_BY_ELECTRICAL_ENGINEER(10L, "To be validate by Electrical Engineer"),
	REJECTED_BY_ELECTRICAL_ENG(5L, "Rejected by Electrical Engineer"),
	VALIDATED_BY_ELECTRICAL_ENG(12L, "Validated by Electrical Engineer"),
	
	TO_BE_VALIDATED_BY_PLANNING_ENGINEER(20L, "To be validate by Planning Engineer"),
	REJECTED_BY_PLANNING_ENG(5L, "Rejected by Planning Engineer"),
	VALIDATED_BY_PLANNING_ENG(21L, "Validated by Planning Engineer"),
	
	TO_BE_VALIDATED_BY_CE(30L, "To be validate by Chief Engineer"),
	TO_BE_VALIDATED_BY_PLANNING_CE(35L, "To be validate by Planning Chief Engineer"),
	REJECTED_BY_CE(5L, "Rejected by Chief Engineer"),
	VALIDATED_BY_CE(32L, "Approved by Chief Engineer/To be Approved by DGM"),
	
	TO_BE_APPROVED_BY_DGM(40L, "To be Approved by DGM"),
	TO_BE_APPROVED_BY_AGM(41L, "To be Approved by DGM"),
	
	REJECTED_BY_DGM(5L, "Rejected by DGM"),
	VALIDATED_BY_DGM(42L, "Approved by DGM"),
	

	APPROVED_ESTIMATES(50L, "Approved Estimates"),
	
	PIVII_TO_BE_CONFIRMED_BY_DEO(56L, "To be confirmed By DEO"),
	
	
	PIVII_TO_BE_CONFIRMED_BY_ACCOUNT_REV(55L, "To be confirmed By ACCT_REV"),
	
	PIVII_CONFIRMATION(60L, "PIV II Confirmed"),
	
	PIVII_FOR_SECDEPOSIT(61L, "PIV II For Security Deposit"),

	SEND_FOR_CONSTRUCTION_MAINTENANCE(70L, "Sent for Construction/Maintenance"),
	
	JOB_ALLOCATED(80L, " Work Estimate Job Allocated By Construction"),
	
	JOB_CANCELLATION(90L, " Standard Estimate Cancelled");
	
	//SEND_FOR_ACCOUNTANT_REVENUE(60L, "Send For Accountant Revenue");

    private final String name;
    private final Long key;
   
    private static final Map<Long, StandardEstimateStatus> applicationStatusKeyMap = new HashMap<Long, StandardEstimateStatus>();
    private static final Map<String, StandardEstimateStatus> applicationStatusNameMap = new HashMap<String, StandardEstimateStatus>();

    static {
		for (StandardEstimateStatus e : EnumSet.allOf(StandardEstimateStatus.class)) {
			applicationStatusKeyMap.put(e.getKey(), e);
			applicationStatusNameMap.put(e.getName(), e);
		}
	}

    private StandardEstimateStatus(Long value, String name) {
        this.name = name;
        this.key = value;
       
    }

    public String getName() {
        return name;
    }

    public Long getKey() {
        return key;
    }

   

    public String toString() {
        return "StandardEstimateStatus[key: " + key + "name: " + name + " ]";
    }

    public static StandardEstimateStatus getType(String name) {
        if (applicationStatusNameMap.containsKey(name))
            return applicationStatusNameMap.get(name);
        else
            return UNKNOWN;
    }

    public static StandardEstimateStatus getType(Long key) {
        if (applicationStatusKeyMap.containsKey(key))
            return applicationStatusKeyMap.get(key);
        else
            return UNKNOWN;
    }
}
