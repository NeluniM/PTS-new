package com.it.ceb.pts.controller;


import com.it.ceb.pts.domain.*;
import com.it.ceb.pts.model.ModelService;
import com.it.ceb.pts.repo.*;
import com.it.ceb.util.common.ExcelMeterReader;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class LoginController {

	//private String basePath ="C:\\Users\\Dhammika Mahendra\\Documents\\CEB Projects\\PowerTrading_resourcefile\\CEB_PTS_res\\";

	@Autowired
	private DistributionLicenseDao DistributionLicenseDao;
	@Autowired
	private ExcelMeterReader excelMeterReader;
	@Autowired
	private ModelService modelService;
	@Autowired
	private ProvinceDao provinceDao;
	@Autowired
	private MeterPointDao meterPointDao;
	@Autowired
	private SecurityDao securityDao;

	//login page =============================================================================
	@RequestMapping(value = "WelcomePTS", method = RequestMethod.GET)
	public ModelAndView WelcomePTS(@ModelAttribute("model")  LoginModel loginModel,BindingResult bindingResult, HttpServletRequest request,HttpServletResponse response) throws Exception {
		return new ModelAndView("pts/login", "model", loginModel);

	}

	//Main Home page ===========================================================================
	@RequestMapping(value = "/home", method = RequestMethod.POST)
	public ModelAndView admindashboardpts(@ModelAttribute("cbrsModel") CbrsModel cbrsModel, HttpServletRequest request) {
		return new ModelAndView("pts/home", "model", cbrsModel);
	}

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public ModelAndView admindashboardpts2(@ModelAttribute("cbrsModel") CbrsModel cbrsModel, HttpServletRequest request) {
		return new ModelAndView("pts/home", "model", cbrsModel);
	}

	//licenseeeBillingHome
	@Transactional
	@RequestMapping(value = "/licenseeBillingHome", method = RequestMethod.GET)
	public String licenseeBillingHome(Model model) throws Exception{
		return "pts/licenseeBilling/licenseeBillingHome"; // Return the same page after form submission
	}

	//consumerBillingHome
	@Transactional
	@RequestMapping(value = "/consumerBillingHome", method = RequestMethod.GET)
	public String consumerBillingHome(Model model) throws Exception{
		return "pts/consumerBilling/consumerBillingHome";
	}

	//login validation ===========================================================================
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView login(@RequestParam("userName") String userName,
							  @RequestParam("password") String password,
							  HttpServletRequest request) throws Exception {

		boolean isValidLogin = securityDao.validateLogin(userName, password);

		if (isValidLogin) {
			Sauserm user = securityDao.getSauserm(userName);
			request.getSession().setAttribute("loggedUser", user.getUserId().toUpperCase());
			request.getSession().setAttribute("USER_LEVEL", user.getUserLevel());
			String deptId = user.getRptUser() != null ? user.getRptUser().trim() : "";
			request.getSession().setAttribute("deptId", deptId);

			return new ModelAndView("pts/home", "success", "Login Success");
		} else {
			return new ModelAndView("pts/login", "errorMsg", "Invalid User name or Password");
		}
	}


}
