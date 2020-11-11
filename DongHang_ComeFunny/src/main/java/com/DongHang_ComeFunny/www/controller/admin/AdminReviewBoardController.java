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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.DongHang_ComeFunny.www.model.service.admin.AdminReviewBoardService;
import com.DongHang_ComeFunny.www.model.vo.Admin;
import com.DongHang_ComeFunny.www.model.vo.ReviewComment;
import com.DongHang_ComeFunny.www.model.vo.ReviewDhTicket;
import com.DongHang_ComeFunny.www.model.vo.ReviewLike;
import com.DongHang_ComeFunny.www.model.vo.ReviewRecommend;
import com.DongHang_ComeFunny.www.model.vo.User;

@Controller
@RequestMapping("/admin/boards/reviewBoard")
public class AdminReviewBoardController {
	
	@Autowired
	AdminReviewBoardService adminReviewBoardService;
	
	@RequestMapping("/list")
	public ModelAndView viewReviewBoardList (	String searchKinds,
											String searchText,
											HttpSession session,
											@RequestParam(required = false, defaultValue = "1")int cPage) {
		
		ModelAndView mav = new ModelAndView();
		
		Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
		User sessionUser =(User)session.getAttribute("logInInfo");
		if(sessionAdmin != null) {
			
		int cntPerPage = 10;
		
		Map<String,Object> searchReviewBoard = new HashMap<>();
		
		searchReviewBoard.put("searchKinds", searchKinds);
		searchReviewBoard.put("searchText", searchText);
		Map<String,Object> reviewBoardList = adminReviewBoardService.viewReviewBoardList(cPage, cntPerPage, searchReviewBoard);

		mav.addObject("paging",reviewBoardList.get("paging"));
		mav.addObject("reviewBoardData", reviewBoardList);
		mav.addObject("searchKinds", searchKinds);
		mav.addObject("searchText", searchText);
		mav.setViewName("admin/boards/reviewBoard/list");
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
		public ModelAndView deleteReivewBoard(String[] rbNo,
												HttpSession session) {
			
			ModelAndView mav = new ModelAndView();
			Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
			User sessionUser =(User)session.getAttribute("logInInfo");
			if(sessionAdmin != null) {
					if(rbNo != null) {
						adminReviewBoardService.deleteReviewBoard(rbNo);
						mav.setViewName("redirect:/admin/boards/reviewBoard/list");
						return mav; 
					}else {
						mav.setViewName("redirect:/admin/boards/reviewBoard/list");
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
		
		@RequestMapping(value = "/view", method = RequestMethod.GET)
		public ModelAndView reviewView(
				@RequestParam int rbNo
				, HttpSession session
			) {
			// 1. 모델앤뷰 객체 생성
			ModelAndView mav = new ModelAndView();
			
			Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
			User sessionUser =(User)session.getAttribute("logInInfo");
			if(sessionAdmin != null) {
				
			// 2. 파라미터값 Service에 전달 후 Map에 저장
			Map<String, Object> commandMap = adminReviewBoardService.selectReviewView(rbNo);
			
			//---------------- Service에서 처리한 데이터값 출력-------------------------
			System.out.println("[controller] reviewview - commandMap : " + commandMap);
			System.out.println("[ServiceImpl] - fdetail get : " +((Map)commandMap.get("detail")).get("RBDBNO"));
			System.out.println("[ServiceImpl] - fdetail get : " +((Map)commandMap.get("detail")).get("RBGBNO"));
			int rbGbNo = Integer.parseInt(((Map)commandMap.get("detail")).get("RBGBNO").toString());
			int rbDbNo = Integer.parseInt(((Map)commandMap.get("detail")).get("RBDBNO").toString());
			System.out.println("rbGbNo : "+rbGbNo);
			System.out.println("rbDbNo : "+rbDbNo);
			//--------------------------------------------------------------------------
			
			// 2-1.동행 게시글 조회하기
			if(rbGbNo != 0) {
//				System.out.println("함께가요 게시판입니다.");
				Map<String, Object> godetail = adminReviewBoardService.selectGoBoardView(rbGbNo);
				mav.addObject("donghang", godetail);
			} else if(rbDbNo != 0) {
//				System.out.println("함께해요 게시판입니다.");
				Map<String, Object> dodetail = adminReviewBoardService.selectDoBoardView(rbDbNo);
				mav.addObject("donghang", dodetail);
			}
			
			// 3. DB에 회원, 후기게시판 테이블을 조회한 결과값이 Not Null
			//   ("detail" : 회원, 후기게시판, "filelist" : 후기게시판, 후기파일 )
			if(commandMap.get("detail") != null) {
				// 4. ModelAndView에 VO 및 View 이름값 넣기 
				mav.addObject("rview", commandMap);
				mav.setViewName("admin/boards/reviewBoard/view");
			} else {
				// 5. view페이지 : /WEB-INF/views/common 폴더 안에 result.jsp
				// 5-1. 경고메세지 출력 후 지정된 url로 페이지 이동
				mav.addObject("alertMsg", "해당 게시물이 존재하지 않습니다.");
				mav.addObject("url", "list");
				mav.setViewName("common/result");
			}
				
			// 6. 데이터 처리가 완료된 모델(VO)값과 보여질 페이지(jsp)를 반환한다.
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
		
		@RequestMapping(value="/reviewdownload")
		@ResponseBody
		public FileSystemResource reviewDownload(
				HttpServletResponse response
				, HttpSession session
				, String ofname
				, String rfname
				) {
			// 1. 서버에 저장된 업로드 파일경로
			String readFolder = session.getServletContext().getRealPath("/resources/upload");
			
			// ---------------파라미터 값 제대로 불러왔는지 확인-------------------------
			System.out.println("[controller] reviewDowonload - readFolder : " + readFolder);
			System.out.println("[controller] reviewDowonload - rfname : " +rfname);
			System.out.println("[controller] reviewDowonload - ofname : " +ofname);
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
		
		@ResponseBody
		@RequestMapping(value = "/getReviewReplyList", method = RequestMethod.POST)
		public List<Map<String,Object>> getReplyList(
				@RequestParam("rbNo") int rbNo) {
			// 1. 파라미터값 Service에 전달 후 int 값 반환
			//    ( 성공 : 1, 실패 : 0 )
			return adminReviewBoardService.selectReviewCommentList(rbNo);
		}
		
		// ⒁ 게시글 상세보기 페이지에서, 댓글 삭제하기 Ajax로 처리
		// url : /board/deleteReply - PUT
		// parameter : 
		// RequestBody Map replyNo : 댓글번호, 댓글 내용 key-value 요청한 값 받기
		@RequestMapping(value="deleteReviewReply", method = RequestMethod.PUT)
		@ResponseBody
		public int deleteReply(@RequestBody Map<String,Object> replyNo) {
			
			//-------------------RequestBody에서 요청한 값 제대로 받아왔는지 확인하기----------------------
			System.out.println("[controller] updateReply map : "+replyNo);
			System.out.println("[controller] updateReply fcno int: "+replyNo.get("replyNo"));
			System.out.println("[controller] updateReply fccontent string : "+replyNo.get("replyText"));
			//---------------------------------------------------------------------------------------------
			
			// 1. ReviewComment fcNo에 Map에서 갖고온 Value(Object 타입)을 int형태로 바꾸기 
			int fcNo = Integer.parseInt((String) replyNo.get("replyNo"));
			// 2. ReviewComment 빈 객체 생성
			ReviewComment reviewComment = new ReviewComment();
			// 3. ReviewComment에 fcNo, fcContent 값 지정
			reviewComment.setRcNo(fcNo);
			// 4. 파라미터값 Service에 전달 후 int 값 반환
			//    ( 성공 : 1, 실패 : 0 )
			return adminReviewBoardService.deleteReviewComment(reviewComment);
		}
		
		
		

}
