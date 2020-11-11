package com.DongHang_ComeFunny.www.controller.admin;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.DongHang_ComeFunny.www.model.service.admin.AdminLoginService;
import com.DongHang_ComeFunny.www.model.vo.Admin;
import com.DongHang_ComeFunny.www.model.vo.User;

@Controller
@RequestMapping("/admin")
public class AdminLoginController {
	
	@Autowired
	AdminLoginService adminLoginService;
	
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public ModelAndView login(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
		User sessionUser =(User)session.getAttribute("logInInfo");
		if(sessionAdmin != null) {
			mav.setViewName("/admin/main");
			return mav;
		}else if (sessionUser != null) {
			mav.addObject("alertMsg", "관리자만 이용 가능합니다.");
			mav.addObject("url", "/admin/main");
			mav.setViewName("common/result");
			return mav;
		}
		mav.setViewName("/admin/login");
		return mav;
	}
	
	@RequestMapping(value="/loginimpl", method=RequestMethod.POST)
	public String loginImpl(
			@RequestParam Map<String, Object> commandMap
			, HttpSession session
			, Model model
			) {

		Admin res = adminLoginService.loginAdmin(commandMap);
		//로그인에 성공한다면
		if(res != null) {
			session.setAttribute("adminLoginInfo", res);
		} else {
			model.addAttribute("alertMsg", "해당 담당자에게 문의해주세요");
			model.addAttribute("url", "login");
		}

		return "redirect:/admin/main";
	}
	
    @RequestMapping("/logout")
    public String logout(Model model, HttpSession session) {
        session.invalidate();
        model.addAttribute("alertMsg", "로그아웃 되었습니다.");
		model.addAttribute("url", "/admin/login");
        return "common/result";
    }

}
