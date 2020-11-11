package com.DongHang_ComeFunny.www.controller.main;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.DongHang_ComeFunny.www.model.service.main.DoService;
import com.DongHang_ComeFunny.www.model.service.main.GoService;
import com.DongHang_ComeFunny.www.model.service.main.MainService;

@Controller
public class MainController {
	
	@Autowired MainService mainService;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public ModelAndView main() {
		System.out.println("[GET] /main");
		
		//함께가요, 함께해요, BEST호스트, BEST후기 가지고오기
		ModelAndView mav = new ModelAndView();
		Map<String, Object> list = mainService.selectMainList();
		
		mav.addObject("list", list);
		mav.setViewName("main/main");
		
		return mav;
	}
}
