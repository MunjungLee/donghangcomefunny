package com.DongHang_ComeFunny.www.controller.admin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.DongHang_ComeFunny.www.model.service.admin.AdminDoBoardService;
import com.DongHang_ComeFunny.www.model.vo.Admin;
import com.DongHang_ComeFunny.www.model.vo.User;

@Controller
@RequestMapping("/admin/boards/doBoard")
public class AdminDoBoardController {
	
	@Autowired
	AdminDoBoardService adminDoBoardService;
	
	@RequestMapping("/list")
	public ModelAndView viewDoBoardList (	String searchKinds,
											String searchText,
											HttpSession session,
											@RequestParam(required = false, defaultValue = "1")int cPage) {
		
		
				ModelAndView mav = new ModelAndView();
				
				Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
				User sessionUser =(User)session.getAttribute("logInInfo");
				if(sessionAdmin != null) {
					int cntPerPage = 10;
					
					Map<String,Object> searchDoBoard = new HashMap<>();
					
					searchDoBoard.put("searchKinds", searchKinds);
					searchDoBoard.put("searchText", searchText);
					Map<String,Object> doBoardList = adminDoBoardService.viewDoBoardList(cPage, cntPerPage, searchDoBoard);
					
					mav.addObject("paging",doBoardList.get("paging"));
					mav.addObject("doBoardData", doBoardList);
					mav.addObject("searchKinds", searchKinds);
					mav.addObject("searchText", searchText);
					mav.setViewName("admin/boards/doBoard/list");
					return mav;
				} else if (sessionUser != null) {
					mav.addObject("alertMsg", "관리자만 이용 가능합니다.");
					mav.addObject("url", "/main");
					mav.setViewName("common/result");
					return mav;
				} else {
					mav.addObject("alertMsg", "로그인해 주세요.");
					mav.addObject("url", "/admin/login");
					mav.setViewName("common/result");
					return mav;
				}
				
	}
				
		
	
		@RequestMapping("/delete")
		public ModelAndView deleteDoBoard(String[] dbNo,
										HttpSession session
) {
			
			ModelAndView mav = new ModelAndView();
			Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
			User sessionUser =(User)session.getAttribute("logInInfo");
			if(sessionAdmin != null) {
				if(dbNo != null) {
					adminDoBoardService.deleteDoBoard(dbNo);
					mav.setViewName("redirect:/admin/boards/doBoard/list");
					return mav; 
				}else {
					mav.setViewName("redirect:/admin/boards/doBoard/list");
					return mav;
				} 
			
			} else if (sessionUser != null) {
				mav.addObject("alertMsg", "관리자만 이용 가능합니다.");
				mav.addObject("url", "/main");
				mav.setViewName("common/result");
				return mav;
			} else {
				mav.addObject("alertMsg", "로그인해 주세요.");
				mav.addObject("url", "/admin/login");
				mav.setViewName("common/result");
				return mav;
			}
					
		}
		
		
		@RequestMapping(value="/view", method=RequestMethod.GET)
		public ModelAndView dodetail(HttpSession session, HttpServletRequest req ) {
//			User sessionUser = new User();
//			sessionUser.setuNo(26);
//		    //회원정보를 세선에 담기
//		    session.setAttribute("logInInfo", sessionUser);
//			sessionUser= (User) session.getAttribute("loginInfo");
			
			ModelAndView mav = new ModelAndView();
			Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
			User sessionUser =(User)session.getAttribute("logInInfo");
			if(sessionAdmin != null) {
				int dbno = Integer.parseInt( req.getParameter("dbNo"));
				
				
				//함께해요 상세 정보 
				Map<String, Object> commandMap = adminDoBoardService.selectDoDetail(dbno);
						
				mav.addObject("hostInfo",commandMap.get("hostInfo"));
				mav.addObject("applyList",commandMap.get("applyList"));
				mav.addObject("doDetail",commandMap);
				mav.addObject("placePhoto",commandMap.get("placePhoto"));
				mav.setViewName("admin/boards/doBoard/view");
				
				System.out.println("넘어갈 값 mav : " + mav);
				return mav;
			}else if (sessionUser != null) {
				mav.addObject("alertMsg", "관리자만 이용 가능합니다.");
				mav.addObject("url", "/main");
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
