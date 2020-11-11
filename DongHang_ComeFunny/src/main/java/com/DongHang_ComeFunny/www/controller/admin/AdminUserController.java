package com.DongHang_ComeFunny.www.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.DongHang_ComeFunny.www.model.service.admin.AdminUserService;
import com.DongHang_ComeFunny.www.model.vo.Admin;
import com.DongHang_ComeFunny.www.model.vo.User;

import common.exception.FileException;

@Controller
@RequestMapping("/admin/user")
public class AdminUserController {
	
	@Autowired
	AdminUserService adminUserService;
	
	@RequestMapping("/list")
	public ModelAndView veiwUserList(
								String searchText,
								String searchKinds,
								HttpSession session,
								@RequestParam(required = false, defaultValue = "1") int cPage) {
		
		ModelAndView mav = new ModelAndView();
		Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
		User sessionUser =(User)session.getAttribute("logInInfo");
		if(sessionAdmin != null) {
			
		int cntPerPage = 10;
		
		System.out.println(searchText);
		System.out.println(searchKinds);
		
		Map<String,Object> searchUser = new HashMap<>();
		
		searchUser.put("searchKinds", searchKinds);
		searchUser.put("searchText", searchText);
		
		System.out.println("******searchUser******" + searchUser);
		
		Map<String,Object> commandMap = adminUserService.viewUserList(cPage, cntPerPage, searchUser);
		System.out.println(commandMap);
		mav.addObject("paging", commandMap.get("paging"));
		mav.addObject("userData" ,commandMap);
		mav.addObject("searchText", searchText);
		mav.addObject("searchKinds", searchKinds);
		mav.setViewName("admin/user/list");
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
	
	@RequestMapping("/delete")
	public ModelAndView deleteUser(
									String[] uNo, 
									HttpSession session)
									{
		ModelAndView mav = new ModelAndView();
		
		Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
		User sessionUser =(User)session.getAttribute("logInInfo");
		if(sessionAdmin != null) {
			
			// delUnos의 값이 null이 아닐경우
			// 퀵 버튼은 배열의 크기가 0일 경우 자동으로 String으로 변환되는 것을 이용
			// 따로 변환해줄 필요가없음
			
			if(uNo != null) {
	//			System.out.println("****************" + uNos);
	//			System.out.println(Arrays.toString(uNos));
				adminUserService.deleteUser(uNo);
				mav.setViewName("redirect:/admin/user/list");
				return mav; 
	//			return new ModelAndView("redirect:/admin/user/list");
			}
			// 아무것도 선택하지 않았을 때 전체 목록으로 redirect 해줌
			else {
				mav.setViewName("redirect:/admin/user/list");
				return mav;
	//			return new ModelAndView("redirect:/admin/user/list");
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
	
	@RequestMapping("/modify")
	public ModelAndView modifyUser(int uNo,
									HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
		User sessionUser =(User)session.getAttribute("logInInfo");
		if(sessionAdmin != null) {
			
			System.out.println(uNo);
			
			Map<String, Object> viewUserMap = adminUserService.viewUser(uNo);
			System.out.println(viewUserMap);
	
			if(viewUserMap.get("viewUser") != null && viewUserMap.get("userImg") != null) {
				mav.addObject("viewUser",viewUserMap.get("viewUser"));
				mav.addObject("userImg",viewUserMap.get("userImg"));
				mav.setViewName("admin/user/modify");
				return mav;
			} else if (viewUserMap.get("viewUser") != null && viewUserMap.get("userImg") == null) {
				mav.addObject("viewUser",viewUserMap.get("viewUser"));
				mav.setViewName("admin/user/modify");
				return mav;
			} else {
				return new ModelAndView("redirect:/admin/user/list");
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
	
	@RequestMapping(value = "/modifyImpl", method = RequestMethod.POST)
	public ModelAndView modifyUserImpl(	User modiUserInfo,
										@RequestParam(required = false) List<MultipartFile> userImg,
										HttpSession session) throws FileException
	{
		ModelAndView mav = new ModelAndView();
		
		Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
		User sessionUser =(User)session.getAttribute("logInInfo");
		if(sessionAdmin != null) {
			String root = session.getServletContext().getRealPath("/");
			
			System.out.println(modiUserInfo);
			System.out.println(userImg);
			System.out.println(root);
			
			if(modiUserInfo != null) {
				adminUserService.modifyUser(modiUserInfo, userImg, root);
				int modiUNo  = modiUserInfo.getuNo();
				return new ModelAndView("redirect:/admin/user/view?uNo="+modiUNo);
			} else {
				return new ModelAndView("redirect:/admin/user/list");
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
	
	@RequestMapping("/view")
	public ModelAndView viewUser(int uNo,
								HttpSession session) {
		ModelAndView mav= new ModelAndView();
		Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
		User sessionUser =(User)session.getAttribute("logInInfo");
		if(sessionAdmin != null) {
			System.out.println(uNo);
			
			Map<String, Object> viewUserMap = adminUserService.viewUser(uNo);
			System.out.println(viewUserMap);
			
	
			if(viewUserMap.get("viewUser") != null && viewUserMap.get("userImg") != null) {
				mav.addObject("viewUser",viewUserMap.get("viewUser"));
				mav.addObject("userImg",viewUserMap.get("userImg"));
				mav.setViewName("admin/user/view");
				return mav;
			} else if (viewUserMap.get("viewUser") != null && viewUserMap.get("userImg") == null) {
				mav.addObject("viewUser",viewUserMap.get("viewUser"));
				mav.setViewName("admin/user/view");
				return mav;
			} else {
				return new ModelAndView("redirect:/admin/user/list");
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
	
	
}
