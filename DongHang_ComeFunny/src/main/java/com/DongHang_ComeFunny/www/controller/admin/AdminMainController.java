package com.DongHang_ComeFunny.www.controller.admin;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.omg.CORBA.PUBLIC_MEMBER;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.DongHang_ComeFunny.www.model.service.admin.AdminMainService;
import com.DongHang_ComeFunny.www.model.vo.Admin;
import com.DongHang_ComeFunny.www.model.vo.User;

@Controller
@RequestMapping("/admin")
public class AdminMainController {
   
   @Autowired
   AdminMainService adminMainService;
   
   @RequestMapping("/main")
   public ModelAndView adminMain(HttpSession session) {
      ModelAndView mav = new ModelAndView();
      
//      Map<String, Object> todayCnt = adminMainService.countTodayCnt();
      
      Admin sessionAdmin = (Admin)session.getAttribute("adminLoginInfo");
      User sessionUser =(User)session.getAttribute("logInInfo");
      if(sessionAdmin != null) {
         mav.setViewName("admin/main");
         return mav;
      }else if (sessionUser != null) {
         mav.addObject("alertMsg", "관리자만 이용 가능합니다.");
         mav.addObject("url", "admin/main");
         mav.setViewName("common/result");
         return mav;
      } else {
         mav.addObject("alertMsg", "로그인해 주세요.");
         mav.addObject("url", "/admin/login");
         mav.setViewName("common/result");
         return mav;
      }
   }
   
   @RequestMapping("/boards/main")
   public ModelAndView adminBoardsMain(HttpSession session) {
      
      ModelAndView mav = new ModelAndView();
      Admin sessionAdmin = (Admin)session.getAttribute("adminLoginInfo");
      User sessionUser =(User)session.getAttribute("logInInfo");
      if(sessionAdmin != null) {
         mav.setViewName("admin/boards/main");
         return mav;
      }else if (sessionUser != null) {
         mav.addObject("alertMsg", "관리자만 이용 가능합니다.");
         mav.addObject("url", "admin/main");
         mav.setViewName("common/result");
         return mav;
      } else {
         mav.addObject("alertMsg", "로그인해 주세요.");
         mav.addObject("url", "/admin/login");
         mav.setViewName("common/result");
         return mav;
      }
   }
   
}