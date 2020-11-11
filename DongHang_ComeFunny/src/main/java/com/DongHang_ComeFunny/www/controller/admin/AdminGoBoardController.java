package com.DongHang_ComeFunny.www.controller.admin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.DongHang_ComeFunny.www.model.service.admin.AdminGoBoardService;
import com.DongHang_ComeFunny.www.model.vo.Admin;
import com.DongHang_ComeFunny.www.model.vo.User;

@Controller
@RequestMapping("/admin/boards/goBoard")
public class AdminGoBoardController {
	
	@Autowired
	AdminGoBoardService adminGoBoardService;
	
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
		
		Map<String,Object> searchGoBoard = new HashMap<>();
		
		searchGoBoard.put("searchKinds", searchKinds);
		searchGoBoard.put("searchText", searchText);
		Map<String,Object> goBoardList = adminGoBoardService.viewGoBoardList(cPage, cntPerPage, searchGoBoard);

		mav.addObject("paging",goBoardList.get("paging"));
		mav.addObject("goBoardData", goBoardList);
		mav.addObject("searchKinds", searchKinds);
		mav.addObject("searchText", searchText);
		mav.setViewName("admin/boards/goBoard/list");
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
	
	// delete 버튼 추가 예정
		@RequestMapping("/delete")
		public ModelAndView deleteGoBoard(String[] gbNo,
											HttpSession session) {
			
			ModelAndView mav = new ModelAndView();
			
			Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
			User sessionUser =(User)session.getAttribute("logInInfo");
			if(sessionAdmin != null) {
					if(gbNo != null) {
						adminGoBoardService.deleteGoBoard(gbNo);
						mav.setViewName("redirect:/admin/boards/goBoard/list");
						return mav; 
					}else {
						mav.setViewName("redirect:/admin/boards/goBoard/list");
						return mav;
					}
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
		
		 @RequestMapping(value="/view", method=RequestMethod.GET)
	      public void goDetail(int gbNo, Model model, HttpSession session) {

			 
	         //함께가요 상세정보들
	         Map<String, Object> goDetailInfo = adminGoBoardService.selectGoDetail(gbNo);
	         
	         //함께가요 찜목록 클릭 여부
	         
	         model.addAttribute("goDetailInfo", goDetailInfo);
	         
	      }

}
