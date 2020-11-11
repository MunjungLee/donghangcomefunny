package com.DongHang_ComeFunny.www.controller.admin;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.DongHang_ComeFunny.www.model.service.admin.AdminNoticeService;
import com.DongHang_ComeFunny.www.model.vo.Admin;
import com.DongHang_ComeFunny.www.model.vo.NoticeBoard;
import com.DongHang_ComeFunny.www.model.vo.User;

import common.exception.FileException;

@Controller
@RequestMapping("/admin/notice")
public class AdminNoticeController {
	
	@Autowired
	AdminNoticeService adminNoticeService;
	
	@RequestMapping("/list")
	public ModelAndView viewNoticeList (	String searchKinds,
											String searchText,
											HttpSession session,
											@RequestParam(required = false, defaultValue = "1")int cPage) 
										{
		ModelAndView mav = new ModelAndView();
		Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
		User sessionUser =(User)session.getAttribute("logInInfo");
		if(sessionAdmin != null) {
			
		int cntPerPage = 10;
		
		System.out.println(searchText);
		System.out.println(searchKinds);
		
		Map<String,Object> searchNotice = new HashMap<>();
		
		searchNotice.put("searchKinds", searchKinds);
		searchNotice.put("searchText", searchText);
		System.out.println(searchNotice);
		Map<String,Object> noticeList = adminNoticeService.selectNoticeList(cPage, cntPerPage, searchNotice);
		
		mav.addObject("paging", noticeList.get("paging"));
		mav.addObject("NoticeData", noticeList);
		mav.addObject("searchKinds", searchKinds);
		mav.addObject("searchText", searchText);
		mav.setViewName("admin/notice/list");
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
	public ModelAndView deleteNotice(String[] nbNo,
									HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
				
		Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
		User sessionUser =(User)session.getAttribute("logInInfo");
		if(sessionAdmin != null) {
				if(nbNo != null) {
					adminNoticeService.deleteNotice(nbNo);
					mav.setViewName("redirect:/admin/notice/list");
					return mav; 
				}else {
					mav.setViewName("redirect:/admin/notice/list");
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
	
	@RequestMapping("/write")
	public ModelAndView writeNotice(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
		User sessionUser =(User)session.getAttribute("logInInfo");
		if(sessionAdmin != null) {
			mav.addObject("adminLoginInfo",sessionAdmin);
			mav.setViewName("admin/notice/write");
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
	
	@RequestMapping(value = "/writeImpl", method = RequestMethod.POST)
	public ModelAndView writeNoticeImpl(NoticeBoard writeNoticeInfo,
										@RequestParam(required = false) List<MultipartFile> noticeFiles,
										HttpSession session) throws FileException {
		
		ModelAndView mav = new ModelAndView();
		
		Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
		User sessionUser =(User)session.getAttribute("logInInfo");
		if(sessionAdmin != null) {
			
		String root = session.getServletContext().getRealPath("/");
		
		System.out.println(writeNoticeInfo);
		System.out.println(noticeFiles);
		System.out.println(root);
		
		if(writeNoticeInfo != null) {
			adminNoticeService.writeNotice(writeNoticeInfo, noticeFiles, root);
			mav.setViewName("redirect:/admin/notice/list");
			return mav;
		} else {
			mav.setViewName("admin/notice/list");
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
	
	@RequestMapping("/modify")
	public ModelAndView modifyNotice(int nbNo,
									HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
		User sessionUser =(User)session.getAttribute("logInInfo");
		if(sessionAdmin != null) {
			System.out.println(nbNo);
			
			Map<String, Object> viewNoticeMap = adminNoticeService.viewNotice(nbNo);
			
			System.out.println(viewNoticeMap);
	
			if(viewNoticeMap.get("viewNotice") != null) {
				mav.addObject("viewNotice",viewNoticeMap.get("viewNotice"));
				mav.addObject("viewNoticeFile",viewNoticeMap.get("viewNoticeFile"));
				mav.setViewName("admin/notice/modify");
				return mav;
			} else {
				return new ModelAndView("redirect:/admin/notice/list");
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
	
	@RequestMapping(value = "/deleteFile" , method = RequestMethod.POST)
	@ResponseBody
	public String deleteFile(int nfNo) {
		// 1. 파라미터값 Service에 전달 후 int 값 반환
		//    ( 성공 : 1, 실패 : 0 )
		int res = adminNoticeService.deleteFile(nfNo);
		
		//---------------- Service에서 처리한 데이터값 출력-------------------------
		System.out.println("[controller] deleteFile res 반환값 : "+ res);
		//--------------------------------------------------------------------------
		
		// 2. 해당 파일 삭제 성공한다면,
		if( res > 0 ) {
			// 2-1. res = 1 : javascript에 tagSelector로 html 태그의 id값이 "#f+ffno"인 값을 반환
			return "#f"+nfNo;
		} else {
			// 2-2. res = 0 : 실패라고 알림
			return "fail";
		}
		
	}
	
	
	@RequestMapping(value="/modifyImpl", method = RequestMethod.POST)
	public ModelAndView modifyNoticeImpl(NoticeBoard modiNoticeInfo,
										@RequestParam(required = false) List<MultipartFile> noticeFiles,
										HttpSession session) throws FileException {
		
		ModelAndView mav = new ModelAndView();
		Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
		User sessionUser =(User)session.getAttribute("logInInfo");
		if(sessionAdmin != null) {
			
		String root = session.getServletContext().getRealPath("/");
		
		System.out.println(modiNoticeInfo);
		System.out.println(noticeFiles);
		System.out.println(root);
		
		
		
		if(modiNoticeInfo != null) {
			adminNoticeService.modifyNotice(modiNoticeInfo, noticeFiles, root);
			Map<String, Object> viewNoticeMap = adminNoticeService.viewNotice(modiNoticeInfo.getNbNo());
			mav.addObject("viewNotice",viewNoticeMap.get("viewNotice"));
			mav.addObject("viewNoticeFile",viewNoticeMap.get("viewNoticeFile"));
			mav.setViewName("redirect:/admin/notice/list");
			return mav;
		}
		
		return new ModelAndView("redirect:/admin/notice/list");
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
	public ModelAndView viewNotice(int nbNo,
								HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
		User sessionUser =(User)session.getAttribute("logInInfo");
		if(sessionAdmin != null) {
			
			System.out.println(nbNo);
			
			Map<String, Object> viewNoticeMap = adminNoticeService.viewNotice(nbNo);
			
			System.out.println(viewNoticeMap);
	
			if(viewNoticeMap.get("viewNotice") != null) {
				mav.addObject("viewNotice",viewNoticeMap.get("viewNotice"));
				mav.addObject("viewNoticeFile",viewNoticeMap.get("viewNoticeFile"));
				mav.setViewName("admin/notice/view");
				return mav;
			} else {
				return new ModelAndView("redirect:/admin/notice/list");
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
	
	@RequestMapping("/downloadFile")
	@ResponseBody
	public FileSystemResource downloadFile(
			HttpServletResponse response
			, HttpSession session
			, String ofname
			, String rfname
			) {
		// 1. 서버에 저장된 업로드 파일경로
		String readFolder = session.getServletContext().getRealPath("/resources/upload");
		
		// ---------------파라미터 값 제대로 불러왔는지 확인-------------------------
		System.out.println("[controller] freeDowonload - readFolder : " + readFolder);
		System.out.println("[controller] freeDowonload - rfname : " +rfname);
		System.out.println("[controller] freeDowonload - ofname : " +ofname);
		// --------------------------------------------------------------------------
		
		// 2. FileSystemResource 객체 생성
		FileSystemResource downFile = new FileSystemResource(readFolder + "/" + rfname);
		
		try {
			//3. response 헤더 설정 + 파일 이름 인코딩
			response.setHeader("Content-Disposition"
					  , "attachment; filename="
					  +URLEncoder.encode(ofname, "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		// 4. FileSystemResource downFile 값 반환
		return downFile;
	}
	
	
	
	
	
	

}
