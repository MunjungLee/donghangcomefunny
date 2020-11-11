package com.DongHang_ComeFunny.www.controller.serviceCenter;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.DongHang_ComeFunny.www.model.service.serviceCenter.ServiceCenterNoticeService;
import com.DongHang_ComeFunny.www.model.vo.User;

@Controller
@RequestMapping("/serviceCenter/notice")
public class ServiceCenterNoticeController {
	
	@Autowired
	ServiceCenterNoticeService serviceCenterNoticeService;
	
	@RequestMapping("/list")
	public ModelAndView viewNoticeBoardList (	String searchKinds,
											String searchText,
											HttpSession session,
											@RequestParam(required = false, defaultValue = "1")int cPage) {
		
		ModelAndView mav = new ModelAndView();
		User sessionUser =(User)session.getAttribute("logInInfo");
		if(sessionUser != null) {
			int cntPerPage = 10;
			
			Map<String,Object> searchNoticeBoard = new HashMap<>();
			
			searchNoticeBoard.put("searchKinds", searchKinds);
			searchNoticeBoard.put("searchText", searchText);
			Map<String,Object> noticeBoardList = serviceCenterNoticeService.viewNoticeBoardList(cPage, cntPerPage, searchNoticeBoard);
	
			mav.addObject("paging",noticeBoardList.get("paging"));
			mav.addObject("noticeData", noticeBoardList);
			mav.addObject("searchKinds", searchKinds);
			mav.addObject("searchText", searchText);
			mav.setViewName("serviceCenter/notice/list");
			return mav;
		}else {
			mav.addObject("alertMsg", "로그인해 주세요.");
			mav.addObject("url", "/user/login");
			mav.setViewName("common/result");
			return mav;
		}
	}
	
	@RequestMapping("/view")
	public ModelAndView viewNoticeBoard (int nbNo,
										HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User sessionUser =(User)session.getAttribute("logInInfo");
		if(sessionUser != null) {
			System.out.println(nbNo);
			
			Map<String, Object> viewNoticeMap = serviceCenterNoticeService.viewNotice(nbNo);
			
			System.out.println(viewNoticeMap);
	
			if(viewNoticeMap.get("viewNotice") != null) {
				mav.addObject("viewNotice",viewNoticeMap.get("viewNotice"));
				mav.addObject("viewNoticeFile",viewNoticeMap.get("viewNoticeFile"));
				mav.setViewName("serviceCenter/notice/view");
				return mav;
			} else {
				mav.setViewName("redirect:/serviceCenter/notice/list");
				return mav; 
			}	
		}else {
			mav.addObject("alertMsg", "로그인해 주세요.");
			mav.addObject("url", "/user/login");
			mav.setViewName("common/result");
			return mav;
		}
	}
	
	@RequestMapping("/downloadFile")
	@ResponseBody
	public FileSystemResource downloadFile(
			HttpServletResponse response
			, HttpSession session
			, String ofname
			, String rfname
			) {
		String readFolder = session.getServletContext().getRealPath("/resources/upload");
		
		FileSystemResource downFile = new FileSystemResource(readFolder + "/" + rfname);
		
		try {
			response.setHeader("Content-Disposition"
					  , "attachment; filename="
					  +URLEncoder.encode(ofname, "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return downFile;
	}
	

}
