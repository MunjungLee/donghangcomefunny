package com.DongHang_ComeFunny.www.exception;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import common.exception.CustomException;
import common.exception.ErrorCode;

@Controller
//지정한 패키지 내의 모든 Controller 가
//해당 클래스를 공유하도록 지정해주는 어노테이션
@ControllerAdvice(basePackages = {"com.DongHang_ComeFunny.www"})
public class ExceptionController {
	
	@ExceptionHandler(CustomException.class)
	public ModelAndView ex(CustomException e) {
		ModelAndView mav = new ModelAndView();
		//ErrorCode.valueOf("")
		//매개변수로 넣어주는 이름의 enum 객체를 반환
		//이후 해당 객체의 getMsg()를 호출
		mav.addObject("alertMsg", ErrorCode.valueOf(e.getMessage()).getMsg());
		//매개변수로 넣어주는 이름의 enmu 객체를 반환
		//이후 해당 객체의 getUrl()를 호출
		mav.addObject("url", ErrorCode.valueOf(e.getMessage()).getUrl());
		mav.setViewName("common/result");
		e.printStackTrace();
		return mav;
		
	}
	
	@ExceptionHandler(Exception.class)
	public ModelAndView ex(Exception e
			, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("alertMsg", "지정되지 않은 에러가 발생하였습니다.");
		mav.addObject("url", request.getContextPath());
		mav.setViewName("common/result");
		e.printStackTrace();
		
		return mav;
		
	}
	
	
	
}
