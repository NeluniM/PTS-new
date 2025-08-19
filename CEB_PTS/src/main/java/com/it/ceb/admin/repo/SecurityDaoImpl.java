package com.it.ceb.admin.repo;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


//import javax.persistence.criteria.CriteriaBuilder;
//import javax.persistence.criteria.CriteriaQuery;
//import javax.persistence.criteria.Root;
import jakarta.persistence.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.it.ceb.admin.domain.SausermAdmin;
import com.it.ceb.admin.domain.SausermMm;
import com.it.ceb.admin.domain.Sausrdpm;

//import com.mis.util.common.Format;

//import com.mis.domain.Member;
//import com.mis.security.domain.LoginDetail;
//import com.mis.security.domain.Sauserm;
@Repository("adminSecurityDaoImpl")
@Transactional
public class SecurityDaoImpl implements SecurityDao {

	@Autowired
	private EntityManager em;


	//@SuppressWarnings("unchecked")
	@SuppressWarnings("unchecked")
	@Override
	public String getPassword(String userName) {
		String qryStr = "SELECT s.pswrd FROM SausermAdmin s WHERE TRIM(s.userId)=:userName";
		Query query = em.createQuery(qryStr);
		query.setParameter("userName", userName.toUpperCase());
		List<String> list = query.getResultList();
		//System.out.println(list);
		if (list.isEmpty())
			return null;
		else if (list.size() == 1)
			return list.get(0);
		throw new NonUniqueResultException();




	}

	@SuppressWarnings("unchecked")
	@Override
	public List<String> getAuthorizedCostCenters(String userName) {
		//em;
		String qryStr = "SELECT TRIM(s.id.deptId) FROM Sausrdpm s WHERE TRIM(s.id.userId)=:userName";
		Query query = em.createQuery(qryStr);
		query.setParameter("userName", userName.toUpperCase());
		List<String> list = query.getResultList();
		return list;
	}

	@Override
	public Boolean validateLogin(String userName, String password) throws Exception {
		return validate(userName.trim().toUpperCase(),password);
	}

	@SuppressWarnings("unchecked")
	@Override
	public String getCostCenter(String userName) {
		String qryStr = "SELECT TRIM(rptUser) FROM SausermAdmin s WHERE TRIM(s.userId)=:userName";
		Query query = em.createQuery(qryStr);
		query.setParameter("userName", userName.toUpperCase());
		List<String> list = query.getResultList();
		if (list.isEmpty())
			return null;
		else if (list.size() == 1)
			return list.get(0).trim();
		throw new NonUniqueResultException();
	}

	@SuppressWarnings("unchecked")
	@Override
	public String getAuthorizedLevel(String userName) {
		String qryStr = "SELECT userLevel FROM SausermAdmin s WHERE TRIM(s.userId)=:userName";
		Query query = em.createQuery(qryStr);
		query.setParameter("userName", userName.toUpperCase());
		List<String> list = query.getResultList();
		if (list.isEmpty())
			return null;
		else if (list.size() == 1)
			return list.get(0);
		throw new NonUniqueResultException();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<String> getUserList(String deptId, String userLevel) {
		String qryStr = "SELECT TRIM(userId) FROM SausermAdmin s WHERE TRIM(s.rptUser)=:rptUser AND s.userLevel =:userLevel and s.status=2";
		Query query = em.createQuery(qryStr);
		query.setParameter("rptUser", deptId);
		query.setParameter("userLevel", userLevel);
		List<String> list = query.getResultList();
		return list;

	}

	//@SuppressWarnings("unchecked")
	@Override
	public void updateUserLevel(String deptId, String userId, String userLevel) {
		String qryStr = "UPDATE SausermAdmin s SET s.userLevel =:userLevel WHERE TRIM(s.userId)=:userId AND TRIM(s.rptUser)=:rptUser";
		Query query = em.createQuery(qryStr);
		query.setParameter("rptUser", deptId);
		query.setParameter("userId", userId);
		query.setParameter("userLevel", userLevel);
		query.executeUpdate();



	}






	@SuppressWarnings("unchecked")
	@Override
	public String getNextLogId(String logIdPrefix) {
		String sequence=null;
		String like=logIdPrefix+"%";
		String strQuery="select a.logId from LoginDetail a " +
				"where a.logId like :like ORDER BY 1 DESC";
		Query query=em.createQuery(strQuery);//SELECT MIS.TEST4_SEQ.NEXTVAL() FROM DUAL
		query.setParameter("like", like);
		List<String> list = query.getResultList();
		if (list.size()!=0){
			sequence=query.getResultList().get(0).toString().trim();
			System.out.println(sequence);
			sequence=sequence.substring(14);//total 18 chars  year 12
			Integer i=Integer.parseInt(sequence)+1;
			sequence=i.toString();
			System.out.println(sequence);
		}else{
			sequence="0001";
			System.out.println(sequence);
		}
		if(sequence.length()==1)
			return logIdPrefix+"000"+sequence;
		else if (sequence.length()==2)
			return logIdPrefix+"00"+sequence;
		else if (sequence.length()==3)
			return logIdPrefix+"0"+sequence;
		else
			return logIdPrefix+sequence;
	}




	private Boolean validatePng(String userName, String password){
		String passwordDB=getPassword(userName);
		return password.equals(passwordDB);
	}

	/*
	 *
	 * encription
	 *
	 *
	 */
	/**
	 * This is the public interface to validated user name an password
	 *
	 * @param userName
	 * @param password
	 * @return
	 * @throws Exception
	 */
	private  Boolean validate(String userName, String password) throws Exception {

		Boolean valiity = false;

		Double M_PS = 0d;
		Double M_PU = 0d;
		Double M_P = 0d;

		String m_User = CheckPass(userName);

		if (!(m_User.trim().equals(""))) {
			String m_Pass = CheckPass(password);
			if (!(m_Pass.trim().equals(""))) {
				M_PS = Double.parseDouble(m_Pass);
				M_PU = Double.parseDouble(m_User);

				M_P = ((M_PU + M_PS) / 100005600000.9987);

				if (chkPassworEquality(M_P.toString(), userName)) {
					valiity = true;
				}

			}
		}

		return valiity;
	}



	/**
	 * This will check the password an the encrypted value.
	 *
	 * @param M_P
	 * @param userName
	 * @return
	 * @throws Exception
	 */
	private boolean chkPassworEquality(String M_P, String userName)
			throws Exception {
		String password=getPassword(userName);
		//System.out.println("dbpwd:"+password);

		boolean result = false;

		if (password!=null)
		{
			//System.out.println(password);
			Double dbVal = Double.parseDouble(password);
			Double enteredVal = Double.parseDouble(M_P);

			//System.out.println("dbVal"+dbVal);
			//System.out.println("enteredVal"+enteredVal);
			Double roundUp = 0d;

			DecimalFormat twoDForm = new DecimalFormat("#.########");
			roundUp = Double.valueOf(twoDForm.format(enteredVal / dbVal));

			if (roundUp.equals(1.00000000)) {
				result = true;

			}

		}


		return result;
	}


	private boolean chkPassworEqualityPNG(String M_P, String userName)	throws Exception {
		String password=getPassword(userName);
		//System.out.println("dbpwd:"+password);

		boolean result = false;

		if (password!=null)
		{
			//System.out.println(password);
			Double dbVal = Double.parseDouble(password);
			Double enteredVal = Double.parseDouble(M_P);

			//System.out.println("dbVal"+dbVal);
			//System.out.println("enteredVal"+enteredVal);
			Double roundUp = 0d;

			DecimalFormat twoDForm = new DecimalFormat("#.########");
			roundUp = Double.valueOf(twoDForm.format(enteredVal / dbVal));

			if (roundUp.equals(1.00000000)) {
				result = true;

			}

		}


		return result;
	}


	/**
	 *
	 * @param literal
	 * @return
	 */
	private String CheckPass(String literal) {

		Integer PAS_LEN = 1;
		String M_PASS = "";
		String M_PASS1 = "";

		char[] cArray = literal.trim().toCharArray();

		ArrayList<String> strList = new ArrayList<String>();

		for (int i = 0; i < cArray.length; i++) {
			strList.add(Character.toString(cArray[i]));
		}

		int cArrayLength = cArray.length;

		Long LEN_TOT = 0l;

		while (PAS_LEN <= 10) {
			Long PAS_CHAR = 0l;
			Long POS_CHAR = 0l;

			if (cArrayLength < PAS_LEN) {
				if (PAS_LEN == 0) {
					PAS_CHAR = 9999l;
				} else {
					PAS_CHAR = LEN_TOT;
				}
			} else {
				PAS_CHAR = decrypt(strList.get(PAS_LEN - 1));
			}
			if (PAS_CHAR.equals(0)) {
				M_PASS = "";
				M_PASS1 = M_PASS;
				break;
			}

			POS_CHAR = decrypt(PAS_LEN.toString());

			Long ENC_CHAR = PAS_CHAR + POS_CHAR;
			LEN_TOT = LEN_TOT + ENC_CHAR;

			if (M_PASS.equals("")) {
				M_PASS = ENC_CHAR.toString();
			} else {
				M_PASS = M_PASS.concat(ENC_CHAR.toString());
			}
			PAS_LEN = PAS_LEN + 1;
		}

		M_PASS1 = M_PASS;

		return M_PASS1;

	}

	/**
	 * Actual decrypting happens here. !! Values are directly taken from MITFIN
	 * Service.
	 *
	 * @param IN_STR
	 * @return
	 */
	private Long decrypt(String IN_STR) {

		Long OUT_CHAR = 0l;

		if (IN_STR.equals("A"))
			OUT_CHAR = 2457l;
		else if (IN_STR.equals("B"))
			OUT_CHAR = 2459l;
		else if (IN_STR.equals("C"))
			OUT_CHAR = 2460l;
		else if (IN_STR.equals("D"))
			OUT_CHAR = 2461l;
		else if (IN_STR.equals("E"))
			OUT_CHAR = 2462l;
		else if (IN_STR.equals("F"))
			OUT_CHAR = 2463l;
		else if (IN_STR.equals("G"))
			OUT_CHAR = 2464l;
		else if (IN_STR.equals("H"))
			OUT_CHAR = 2465l;
		else if (IN_STR.equals("I"))
			OUT_CHAR = 2466l;
		else if (IN_STR.equals("J"))
			OUT_CHAR = 2468l;
		else if (IN_STR.equals("K"))
			OUT_CHAR = 2469l;
		else if (IN_STR.equals("L"))
			OUT_CHAR = 2470l;
		else if (IN_STR.equals("M"))
			OUT_CHAR = 2471l;
		else if (IN_STR.equals("N"))
			OUT_CHAR = 2472l;
		else if (IN_STR.equals("O"))
			OUT_CHAR = 2472l;
		else if (IN_STR.equals("P"))
			OUT_CHAR = 2473l;
		else if (IN_STR.equals("Q"))
			OUT_CHAR = 2473l;
		else if (IN_STR.equals("R"))
			OUT_CHAR = 2474l;
		else if (IN_STR.equals("S"))
			OUT_CHAR = 2475l;
		else if (IN_STR.equals("T"))
			OUT_CHAR = 2476l;
		else if (IN_STR.equals("U"))
			OUT_CHAR = 2478l;
		else if (IN_STR.equals("V"))
			OUT_CHAR = 2478l;
		else if (IN_STR.equals("W"))
			OUT_CHAR = 2479l;
		else if (IN_STR.equals("X"))
			OUT_CHAR = 2481l;
		else if (IN_STR.equals("Y"))
			OUT_CHAR = 2482l;
		else if (IN_STR.equals("Z"))
			OUT_CHAR = 2483l;
		else if (IN_STR.equals("a"))
			OUT_CHAR = 4055l;
		else if (IN_STR.equals("b"))
			OUT_CHAR = 4056l;
		else if (IN_STR.equals("c"))
			OUT_CHAR = 4057l;
		else if (IN_STR.equals("d"))
			OUT_CHAR = 4060l;
		else if (IN_STR.equals("e"))
			OUT_CHAR = 4061l;
		else if (IN_STR.equals("f"))
			OUT_CHAR = 4063l;
		else if (IN_STR.equals("g"))
			OUT_CHAR = 4064l;
		else if (IN_STR.equals("h"))
			OUT_CHAR = 4065l;
		else if (IN_STR.equals("i"))
			OUT_CHAR = 4066l;
		else if (IN_STR.equals("j"))
			OUT_CHAR = 4068l;
		else if (IN_STR.equals("k"))
			OUT_CHAR = 4069l;
		else if (IN_STR.equals("l"))
			OUT_CHAR = 5470l;
		else if (IN_STR.equals("m"))
			OUT_CHAR = 5471l;
		else if (IN_STR.equals("n"))
			OUT_CHAR = 5472l;
		else if (IN_STR.equals("o"))
			OUT_CHAR = 5472l;
		else if (IN_STR.equals("p"))
			OUT_CHAR = 5473l;
		else if (IN_STR.equals("q"))
			OUT_CHAR = 5473l;
		else if (IN_STR.equals("r"))
			OUT_CHAR = 5474l;
		else if (IN_STR.equals("s"))
			OUT_CHAR = 5475l;
		else if (IN_STR.equals("t"))
			OUT_CHAR = 5476l;
		else if (IN_STR.equals("u"))
			OUT_CHAR = 5478l;
		else if (IN_STR.equals("v"))
			OUT_CHAR = 5478l;
		else if (IN_STR.equals("w"))
			OUT_CHAR = 5479l;
		else if (IN_STR.equals("x"))
			OUT_CHAR = 5481l;
		else if (IN_STR.equals("y"))
			OUT_CHAR = 5482l;
		else if (IN_STR.equals("z"))
			OUT_CHAR = 9999l;
		else if (IN_STR.equals("0"))
			OUT_CHAR = 2502l;
		else if (IN_STR.equals("1"))
			OUT_CHAR = 2503l;
		else if (IN_STR.equals("2"))
			OUT_CHAR = 2504l;
		else if (IN_STR.equals("3"))
			OUT_CHAR = 2505l;
		else if (IN_STR.equals("4"))
			OUT_CHAR = 2506l;
		else if (IN_STR.equals("5"))
			OUT_CHAR = 2507l;
		else if (IN_STR.equals("6"))
			OUT_CHAR = 2508l;
		else if (IN_STR.equals("7"))
			OUT_CHAR = 2509l;
		else if (IN_STR.equals("8"))
			OUT_CHAR = 2561l;
		else if (IN_STR.equals("9"))
			OUT_CHAR = 2562l;
		else if (IN_STR.equals("10"))
			OUT_CHAR = 2563l;
		else
			OUT_CHAR = 0l;

		return OUT_CHAR;

	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

	@SuppressWarnings("unchecked")
	@Override
	public SausermAdmin getSauserm(String userName) {
		//System.out.println("userName : "+ userName);
		String qryStr = "SELECT s FROM SausermAdmin s WHERE TRIM(s.userId)=:userName";
		Query query = em.createQuery(qryStr);
		query.setParameter("userName", userName.trim().toUpperCase());
		List<SausermAdmin> list = query.getResultList();
		//System.out.println("list : "+ list);

		if (list.isEmpty())
			return null;
		else if (list.size() == 1)
			return list.get(0);
		throw new NonUniqueResultException();

	}

	@Override
	public List<SausermAdmin> getAllUserByRptUser(String rpt_user, String user_level) {
		System.out.println(rpt_user + "/" + user_level);
		String qryStr = "SELECT s FROM SausermAdmin s WHERE TRIM(s.rptUser)=:rpt_user  and TRIM(s.userLevel)=:user_level and s.status=2";
		Query query = em.createQuery(qryStr);
		query.setParameter("rpt_user", rpt_user.trim());
		query.setParameter("user_level", user_level.trim());
		return query.getResultList();
	}

	@Override
	public List<SausermMm> getAllUserByRptUserMMS(String rpt_user,String user_level) {
		String qryStr = "SELECT s FROM SausermMm s WHERE TRIM(s.rptUser)=:rpt_user  and TRIM(s.userLevel)=:user_level and s.status=2";
		Query query = em.createQuery(qryStr);
		query.setParameter("rpt_user", rpt_user);
		query.setParameter("user_level", user_level);
		return query.getResultList();
	}


	@Override
	public Boolean validateLoginPNG(String userName, String password)
			throws Exception {
		// TODO Auto-generated method stub
		return validatePng(userName.trim().toUpperCase(),password);
	}

	@Override
	public SausermMm getSausermMms(String userName) {
		System.out.println("userName : "+ userName);
		userName = userName.trim();
		String qryStr = "SELECT s FROM SausermMm s WHERE TRIM(s.userId)=trim(:userName)";
		Query query = em.createQuery(qryStr);
		query.setParameter("userName", userName);
		List<SausermMm> list = query.getResultList();

		if (list.isEmpty())
			return null;
		else if (list.size() == 1)
			return list.get(0);
		throw new NonUniqueResultException();
	}

	@Override
	public List<SausermMm> getUserList(String userLevel) {
		String qryStr = "SELECT s FROM SausermMm s WHERE TRIM(s.userLevel)=:user_level";
		Query query = em.createQuery(qryStr);
		query.setParameter("user_level", userLevel);
		return query.getResultList();
	}

	@Override
	public List<SausermAdmin> getAllUserByRptUser(String rpt_user,
												  List<String> user_leve) {

		System.out.println("rpt_user"+rpt_user + "user_leve" + user_leve);

		String qryStr = "SELECT s FROM SausermAdmin s WHERE TRIM(s.rptUser)=:rpt_user  and TRIM(s.userLevel) IN (:user_level) and s.status =2";
		Query query = em.createQuery(qryStr);
		query.setParameter("rpt_user", rpt_user.trim());
		query.setParameter("user_level", user_leve);
		return query.getResultList();
	}

	@Override
	public List<SausermMm> getAllUserByRptUserMMS(String rpt_user,
												  List<String> user_leve) {
		String qryStr = "SELECT s FROM SausermMm s WHERE TRIM(s.rptUser)=:rpt_user  and TRIM(s.userLevel) IN (:user_level) and s.status =2";
		Query query = em.createQuery(qryStr);
		query.setParameter("rpt_user", rpt_user);
		query.setParameter("user_level", user_leve);
		return query.getResultList();
	}


	@Override
	public List<SausermAdmin> getAllUserByRptUserCC(String rpt_user, List<String> user_leve, String loginUserLevel) {
		String qryStr;
		if (loginUserLevel.equalsIgnoreCase("ES") || loginUserLevel.equalsIgnoreCase("DEO")) {
			qryStr = "SELECT s FROM SausermAdmin s WHERE TRIM(s.rptUser)=:rpt_user AND TRIM(s.userLevel) IN (:user_level) AND s.userId LIKE '%DCC%' AND s.status = 2";
		} else {
			qryStr = "SELECT s FROM SausermAdmin s WHERE TRIM(s.rptUser)=:rpt_user AND TRIM(s.userLevel) IN (:user_level) AND s.status = 2";
		}
		Query query = em.createQuery(qryStr);
		query.setParameter("rpt_user", rpt_user);
		query.setParameter("user_level", user_leve);
		return query.getResultList();
	}

	@Override
	public void updateSauserMMS(SausermMm mm) {
		System.out.println("test1");
		try {
			mm.setChangeDt(new Date());
			mm.setExpiryDt(new Date());
			mm.setEntDt(new Date());
			mm.setEntDt(new Date());
			mm.setModiDt(new Date());
			mm.setConfDt(new Date());
			System.out.println("test2");

			em.merge(mm);
			System.out.println("test3");




		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("test4");

			e.printStackTrace();
			System.out.println("test5");

		}
	}

	@Override
	public void saveSauserMMS(SausermMm mm) {
		try {
			/*DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			Date today = Calendar.getInstance().getTime();
			String reportDate = df.format(today);
			*/

			System.out.println("test6");

			mm.setChangeDt(new Date());
			mm.setExpiryDt(new Date());
			mm.setEntDt(new Date());
			mm.setEntDt(new Date());
			mm.setModiDt(new Date());
			mm.setConfDt(new Date());
			System.out.println("test7");

			em.persist(mm);
			System.out.println("test8");

		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("test9");

			e.printStackTrace();
			System.out.println("test10");

		}

	}

	@Override
	public void updateSauser(String userId,String userName) {
		System.out.println("test888888");

		try {
			String qryStr = "UPDATE SausermAdmin s set s.userNm =:userName WHERE TRIM(s.userId)=trim(:userId)";
			Query query = em.createQuery(qryStr);
			query.setParameter("userName", userName.trim());
			query.setParameter("userId", userId);

			query.executeUpdate();
			System.out.println("test888888");

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


	}

	@Override
	public void saveSauser(SausermAdmin mm) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<SausermAdmin> getAllUserByRptUserEEES(String rpt_user,
													  String user_leve) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Sausrdpm> getAuthorizedCostCentersList(String userName) {
		String qryStr = "SELECT s FROM Sausrdpm s WHERE TRIM(s.id.userId)=:userName";
		Query query = em.createQuery(qryStr);
		query.setParameter("userName", userName.toUpperCase());
		List<Sausrdpm> list = query.getResultList();
		return list;
	}


}