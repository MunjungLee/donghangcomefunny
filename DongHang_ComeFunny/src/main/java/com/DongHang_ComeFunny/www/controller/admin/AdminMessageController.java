package com.DongHang_ComeFunny.www.controller.admin;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.DongHang_ComeFunny.www.model.service.admin.AdminMessageService;
import com.DongHang_ComeFunny.www.model.vo.Admin;
import com.DongHang_ComeFunny.www.model.vo.Message;

@Controller
@RequestMapping("/admin/message")
public class AdminMessageController {

	@Autowired
	AdminMessageService adminMessageService;
	
	@RequestMapping("/write")
	public ModelAndView write() {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("admin/message/write");
		return mav;
	}
	
	@RequestMapping(value = "/writeImpl", method = RequestMethod.POST)
	public ModelAndView writeImpl(	Message writeMessageInfo,
									HttpSession session
									) {
		ModelAndView mav = new ModelAndView();
		
		Admin admin = (Admin) session.getAttribute("adminLoginInfo");
		writeMessageInfo.setMsUNo(admin.getaNo());
		
			adminMessageService.writeMessage(writeMessageInfo);
			mav.setViewName("redirect:/admin/message/list");
			return mav;
		
	}
	
	// ajax 검색창
	@RequestMapping("/searchUser")
	public ModelAndView searchUser() {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("admin/message/searchUser");
		return mav;
		
	}
	
		
}
