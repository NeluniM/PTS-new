package com.it.ceb.util.common;

public final class EstimateStatus {
	/*public static final String NEW="75";
	public static final String SAVED="23";
	public static final String MODIFIED="75";
	//public static final String EST_APPROVAL="44";
	public static final String EST_APPROVAL_ES="44";
	public static final String EST_APPROVAL_EA="45";
	public static final String EST_APPROVAL_EE="46";
	public static final String EST_APPROVAL_CE="47";
	public static final String EST_APPROVAL_DGM="48";
	public static final String EST_APPROVAL_AGM="49";
	public static final String EST_REJECTED="31";
	public static final String EST_APPROVED="30";
	public static final String EST_POSTING="33";
	public static final String EST_POSTED="22";
	public static final String JOB_POSTED="22";
	public static final String JOB_ONGOING="1";
	public static final String JOB_RIVISION="5";
	//public static final String JOB_APPROVAL="55";
	public static final String JOB_APPROVAL_ES="55";
	public static final String JOB_APPROVAL_EA="56";
	public static final String JOB_APPROVAL_EE="57";
	public static final String JOB_APPROVAL_CE="61";
	public static final String JOB_APPROVAL_DGM="58";
	public static final String JOB_APPROVAL_AGM="59";
	public static final String JOB_REJECTED="41";
	public static final String JOB_APPROVED="60";
	public static final String JOB_SOFT_CLOSED="4";
	public static final String JOB_EXPORTED="6";
	public static final String JOB_HARD_CLOSED="3";
*/
	/**
	 * @param args
	 */
	
	public static final String NEW="75";
	public static final String SAVED="23";
	public static final String MODIFIED="75";
	public static final String CANCELLED="76";
	//public static final String EST_APPROVAL="44";
	//public static final String EST_APPROVAL_ES="43";
	public static final String EST_APPROVAL_ES="44";
	public static final String EST_APPROVAL_EA="45";
	public static final String EST_APPROVAL_EE="46";
	public static final String EST_APPROVAL_CE="47";
	public static final String EST_APPROVAL_DGM="48";
	public static final String EST_APPROVAL_AGM="49";
	public static final String EST_APPROVAL_PLCE="51";
	//public static final String EST_APPROVAL_COMCE="51";

	
	public static final String EST_REJECTED="31";
	public static final String EST_APPROVED="30";
	public static final String EST_POSTING="33";
	public static final String EST_POSTED="22";
	public static final String JOB_POSTED="22";
	public static final String JOB_ONGOING="1";
	public static final String JOB_RIVISION="5";
	public static final String JOB_CREATED="23";
	//public static final String JOB_APPROVAL="55";
	public static final String JOB_APPROVAL_ES="55";
	public static final String JOB_APPROVAL_EA="56";
	public static final String JOB_APPROVAL_EE="57";
	public static final String JOB_APPROVAL_CE="61";
	public static final String JOB_APPROVAL_DGM="58";
	public static final String JOB_APPROVAL_AGM="59";
	public static final String JOB_REJECTED="41";
	public static final String JOB_APPROVED="60";
	public static final String JOB_SOFT_CLOSED="4";
	public static final String JOB_SOFT_CLOSEDPE="7";
	public static final String JOB_EXPORTED="6";
	public static final String JOB_HARD_CLOSED="3";

	//public static final String REVISED_JOB_TO_BE_APPROVAL_CE="61";
	//public static final String REVISED_JOB_APPROVED="1";
	//public static final String REVISED_JOB="5";
	public static final String UPDATED_REVISED_JOB="25";
	//public static final String REVISED_JOB_REJECTED="81";
	
	public static void main(String[] args) {
		System.out.println(EstimateStatus.NEW);
		System.out.println(EstimateStatus.SAVED);
		System.out.println(EstimateStatus.MODIFIED);
		//System.out.println(EstimateStatus.EST_APPROVAL);
		System.out.println(EstimateStatus.EST_REJECTED);
		System.out.println(EstimateStatus.EST_APPROVED);
		System.out.println(EstimateStatus.EST_POSTING);
		System.out.println(EstimateStatus.EST_POSTED);
		System.out.println(EstimateStatus.JOB_ONGOING);
		System.out.println(EstimateStatus.JOB_RIVISION);
		//System.out.println(EstimateStatus.JOB_APPROVAL);
		System.out.println(EstimateStatus.JOB_REJECTED);
		System.out.println(EstimateStatus.JOB_APPROVED);
		System.out.println(EstimateStatus.JOB_SOFT_CLOSED);
		System.out.println(EstimateStatus.JOB_HARD_CLOSED);

	}
	
	
	public String searchStatus(Integer key)
	{
		switch (key) {
		case 75:
			return "Any Modification can  be done to the estimate";			 
		case 23:
			return "Saved Estimate";			 
		case 44:
			return "To be Approved by ES";	
		case 45:
			return "To be Approved by EA";	
		case 46:
			return "To be Approved by EE";
		case 47:
			return "To be Approved by CE";	
		case 48:
			return "To be Approved by DGM";	
		case 49:
			return "To be Approved by AGM";	
		case 31:
			return "This estimate has rejected";		 
		case 30:
			return "This estimate has approved (PIV II can issue for this estimate)";			 
		case 33:
			return "PIV II Confirmed but Job number has not generated";			 
		case 22:
			return "to be Generated Job number";			 
		case 1:
			return "Job transfered to MITFIN for issue materials to the contractor";
		case 5:
			return "This job is to be revised";
		case 25:
			return "Any Modification can  be done to the revised estimate";
		case 55:
			return "Job revised. Revised Estimate to be Approved by ES";
		case 50:
			return "To be Recommend by Planning CE";
		case 51:
			return "To be Recommend by Commercial CE";
		case 56:
			return "Job revised. Revised Estimate to be Approved by EA";
		case 57:
			return "Job revised. Revised Estimate to be Approved by EE";
		case 61:
			return "Job revised. Revised Estimate to be Approved by CE";	
		case 58:
			return "Job revised. Revised Estimate to be Approved by DGM";
		case 59:
			return "Job revised. Revised Estimate to be Approved by AGM";
		case 60:
			return "This job has approved";
		case 41:
			return "This job has rejected";
		case 4:
			return "Soft Closed Job";
		case 3:
			return "Hard Closed Job";
		case 6:
			return "Exported Job";
		case 80:
			return "This estimate has opened through SPS System !!!!";

		default:
			return "";
			 
		}
	}

}
