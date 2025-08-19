package com.it.ceb.admin.controller;

import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class BaseController {

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String welcome(ModelMap model) {

		return "redirect:admin/index";
		

	}
	
	@ExceptionHandler(NullPointerException.class)
	public String handleNullException(NullPointerException ex) {

	//ModelAndView model = new ModelAndView();
	//model.setViewName("MMS_Login");

	//model.addObject("errMsg", "this is null Exception.class");
	System.out.println("Exception occured3.........");
	//return model;
	return "MMS_Login";
	} 

}
