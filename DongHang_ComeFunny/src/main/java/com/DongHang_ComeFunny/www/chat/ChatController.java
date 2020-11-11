package com.DongHang_ComeFunny.www.chat;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.DongHang_ComeFunny.www.model.vo.User;

@Controller
public class ChatController {

	@RequestMapping(value = "/chat/chat", method = RequestMethod.GET)
	public ModelAndView chat(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User sessionUser = (User)session.getAttribute("logInInfo");		
		if(sessionUser != null) {
			mav.setViewName("/chat/chat");
		} else {
			mav.addObject("alertMsg", "로그인 후에 이용해주시기 바랍니다.");
			mav.addObject("url", "../user/login");
			mav.setViewName("/common/result");
		}
		
		return mav;
	}
}