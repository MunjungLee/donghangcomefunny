package com.DongHang_ComeFunny.www.controller.board;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.DongHang_ComeFunny.www.model.service.board.ReviewBoardService;
import com.DongHang_ComeFunny.www.model.vo.ReviewBoard;
import com.DongHang_ComeFunny.www.model.vo.ReviewComment;
import com.DongHang_ComeFunny.www.model.vo.ReviewDhTicket;
import com.DongHang_ComeFunny.www.model.vo.ReviewLike;
import com.DongHang_ComeFunny.www.model.vo.ReviewRecommend;
import com.DongHang_ComeFunny.www.model.vo.User;

import common.exception.FileException;

@Controller
//url에 '/context-root/board'를 고정적으로 매핑 셋팅
@RequestMapping("/board")
public class ReviewBoardController {
	// Service 의존성 주입
	@Autowired
	private ReviewBoardService reviewBoardService;
	
	// ⑴ 게시글 작성페이지 이동
	@SuppressWarnings("unused")
	// url : /board/reviewwirte - GET
	// parameter : 
	// HttpSession session - 로그인 세션정보(uno) : 게시글 작성자(fbuno)
	@RequestMapping(value = "/reviewwrite", method = RequestMethod.GET)
	public ModelAndView reviewWrite(HttpSession session) {
		// 1. 모델앤뷰 객체 생성
		ModelAndView mav = new ModelAndView();
		// 2. 세션에 저장된 로그인 정보를 'User' VO에 저장
		User sessionUser = (User)session.getAttribute("logInInfo");
		// 3. 로그인을 했을 경우 
		// 	세션정보가 담긴 회원정보가 Not Null일때 ( User Not Null )
		//	= 빈 세션이 아닐때( HttpSession Not Null )
		int result = reviewBoardService.selectDHApplyList(sessionUser.getuNo());
		
		if( result == 0) {
			mav.addObject("alertMsg", "작성 할 수 있는 후기게시글이 존재하지 않습니다. 먼저 동행 신청을 해주시기 바랍니다.");
			mav.addObject("url", "reviewlist");
			mav.setViewName("common/result");
			return mav;
		}
		
		if(sessionUser != null) {
			// 4. view페이지 : /WEB-INF/views/board 폴더 안에 reviewwrite.jsp
			mav.setViewName("/board/reviewwrite");
			return mav;
		} else {
			// 5-1. view페이지 : /WEB-INF/views/common 폴더 안에 result.jsp
			// 5-2. 경고메세지 출력 후 지정된 url로 페이지 이동
			mav.addObject("alertMsg", "로그인 후에 이용해주시기 바랍니다.");
			mav.addObject("url", "../user/login");
			mav.setViewName("common/result");
			return mav;
		}
		// 6. 데이터 처리가 완료된 모델(VO)값과 보여질 페이지(jsp)를 반환한다. 
	}
	
	@RequestMapping(value="reviewUploadImpl", method = RequestMethod.POST)
	public ModelAndView reviewUpload(
			int gbNo
			, String gbTitle
			, String gbCategory
			, int rbDhStar
			, int rbHostStar
			, ReviewBoard review
			, @RequestParam List<MultipartFile> files
			, HttpSession session
			, HttpServletRequest req
			) throws FileException {
		// ---------------파라미터 값 제대로 불러왔는지 확인----------------
		// 에디터에서 작성한 텍스트 내용 console에 출력
		System.out.println("[controller] reviewUpload 에디터 내용 : " + req.getParameter("rbContent"));
		// ReviewBoard에 form 태그의 파라미터값들 잘 저장되었는지 확인 
		System.out.println("[controller] reviewUpload ReviewBoard에 저장된 내용  : "+ review);
		System.out.println("[controller] reviewUpload 동행정보(gbNo)  : "+ gbNo);
		System.out.println("[controller] reviewUpload 동행정보(gbTitle)  : "+ gbTitle);
		System.out.println("[controller] reviewUpload 동행정보(gbCategory)  : "+ gbCategory);
		System.out.println("[controller] reviewUpload 리뷰정보(rbDhstar)  : "+ rbDhStar);
		System.out.println("[controller] reviewUpload 리뷰정보(rbHoststar)  : "+ rbHostStar);
		// -----------------------------------------------------------------
		
		if(gbCategory.equals("함께가요")) {
			review.setRbGbNo(gbNo);
		} else if(gbCategory.equals("함께해요")) {
			review.setRbDbNo(gbNo);
		}
		
		// 0. 받은 파라미터값 Map으로 넣기
		Map<String,Object> donghangMap = new HashMap<>();
		donghangMap.put("gbNo", gbNo);
		donghangMap.put("gbTitle", gbTitle);
		donghangMap.put("gbCategory", gbCategory);
		donghangMap.put("rbDhStar", rbDhStar);
		donghangMap.put("rbHostStar", rbHostStar);
		
		// -----------------파라미터 맵 출력------------------------------------------------------------
		System.out.println("[controller] reviewUpload 받은 파라미터값 Map(donghangMap)  : "+ donghangMap);
		// ---------------------------------------------------------------------------------------------
		
		// 1. 모델앤뷰 객체 생성
		ModelAndView mav = new ModelAndView();
		// 2. 서버에 업로드할 경로 지정
		String root = session.getServletContext().getRealPath("/");
		// 3. 세션에 저장된 로그인 정보를 'User' VO에 저장
		User sessionUser = (User)session.getAttribute("logInInfo");
		
		// --------------로그인한 세션정보 확인--------------
		System.out.println("[controller] reviewUpload sessionUser 로그인한 세션의 회원정보 : " + sessionUser);
		// --------------------------------------------------
		// 4. 로그인을 했을 경우 
		// 	세션정보가 담긴 회원정보가 Not Null일때 ( User Not Null )
		//	= 빈 세션이 아닐때( HttpSession Not Null )
		if(sessionUser != null) {
			// 5. ReviewBoard 파일업로드한 회원정보(rbuno, 외래키)에 로그인 세션정보(uno, 기본키) 값 넣기
			review.setRbUNo(sessionUser.getuNo());
			// 5-1. 파라미터값 Service에 전달  
			//      - ReviewBoard, List<MultiPart>, root 
			//        (후기게시판, 파일, 업로드 경로)
			reviewBoardService.insertReview(review, files, root);
			// 5-0. 후기에서 받은 별점, 함께가요, 함께해요 별점 평균 및 개수 업데이트
			reviewBoardService.updateDhStar(donghangMap, review);
			// 5-2. Service에서 처리한 후, view 페이지 지정
			//		view페이지 : /WEB-INF/views/board 폴더 안에 reviewlist.jsp
			mav.setViewName("redirect: /board/reviewlist");
		} else {
			// 6. view페이지 : /WEB-INF/views/common 폴더 안에 result.jsp
			// 6-1. 경고메세지 출력 후 지정된 url로 페이지 이동
			mav.addObject("alertMsg", "로그인 후에 이용해주시기 바랍니다.");
			mav.addObject("url", "../user/login");
			mav.setViewName("common/result");
		}
		// 7. 데이터 처리가 완료된 모델(VO)값과 보여질 페이지(jsp)를 반환한다.
		return mav;
		
	}
	
	// ⑶ 게시글 리스트 페이지 이동
	// url : /board/reviewlist - GET
	// parameter : 
	// String searchText - 파라미터(name="searchText") 값(value) 불러오기
	// String searchKinds - 파라미터(name="searchKinds") 값(value) 불러오기
	// cPage : 현재 페이지 값 불러오기
	@RequestMapping(value = "/reviewlist", method = RequestMethod.GET)
	public ModelAndView reviewList(
			String searchText,
			String searchKinds,
			HttpSession session,
			@RequestParam(required=false, defaultValue="1")int cPage) {
		// 1. 모델앤뷰 객체 생성
		ModelAndView mav = new ModelAndView();
		
		// ---------------파라미터 값 제대로 불러왔는지 확인----------------
		// 검색 카테고리 및 검색 키워드 값 불러오기
		System.out.println("[controller] reviewlist - searchText : "+searchText);
		System.out.println("[controller] reviewlist - searchKinds : "+searchKinds);
		System.out.println("[controller] reviewlist - cPage : "+cPage);
		// -----------------------------------------------------------------
		
		// 2. Map 객체 생성 - 검색 카테고리와 키워드를 저장
		Map<String,Object> searchReviewList = new HashMap<>();
		// 3. key-value쌍으로 "serachKinds" = "파라미터로 불러온 검색 카테고리"
		//    , "searchText" = "파라미터로 불러온 검색 키워드" Map에 넣기 
		searchReviewList.put("searchKinds", searchKinds);
		searchReviewList.put("searchText", searchText);
		
		// -----------Map에 검색 카테고리와 키워드 제대로 저장되었는지 확인-----------
		System.out.println("[controller] reviewlist - Map{key=value} : " + searchReviewList);
		// --------------------------------------------------------------------------
		
		// 4. 1페이지당 보여질 게시글 개수 정하기 
		//    -> 1페이지당 10개의 게시글
		int cntPerPage = 10;
		// 5. 파라미터값 Service에 전달 후 Map에 저장
		//    - cPage, cntPerPage, searchReviewList 
		//     (현재페이지, 페이지당 보여줄 게시글 개수, 검색 카테고리와 키워드가 담긴 Map)
		Map<String,Object> commandMap = reviewBoardService.selectReviewSearchList(cPage, cntPerPage, searchReviewList);

		User sessionUser = (User)session.getAttribute("logInInfo");
		if(sessionUser!=null && sessionUser.getuDhtCnt() > 0) {
		// 5-1. 사용한 동행복권 조회
		Map<String,Object> reviewdht = reviewBoardService.selectDhTicket(sessionUser);
		mav.addObject("rticket", reviewdht);
		}
		//--------------------------------------
		// 검색키워드가 없을 시, 리스트 검색
//		ModelAndView mav = new ModelAndView();
//		int cntPerPage = 10;
//		
//		Map<String, Object> commandMap = reviewBoardService.selectReviewList(cPage, cntPerPage);
		//--------------------------------------
		
		//------------------ Service에서 처리한 데이터값 출력-----------------------
		System.out.println("[controller] reviewlist - commandMap : " + commandMap);
		//--------------------------------------------------------------------------
		
		// 6. ModelAndView에 VO 및 View 이름값 넣기 
		mav.addObject("paging", commandMap.get("paging"));
		mav.addObject("reviewData", commandMap);
		mav.addObject("searchKinds", searchKinds);
		mav.addObject("searchText", searchText);
		mav.setViewName("board/reviewlist");
		// 7. 데이터 처리가 완료된 모델(VO)값과 보여질 페이지(jsp)를 반환한다.
		return mav;
	}
	
	// ⑷ 게시글 검색한 후, 검색된 리스트 페이지로 이동
	// url : /board/reviewlistSearch - POST
	// parameter :
	// String searchText - 파라미터(name="searchText") 값(value) 불러오기
	// String searchKinds - 파라미터(name="searchKinds") 값(value) 불러오기
	// cPage : 현재 페이지 값 불러오기
	@RequestMapping(value="/reviewlistSearch", method=RequestMethod.POST)
	public ModelAndView reviewListSearch(
									String searchText,
									String searchKinds,
									HttpSession session,
									@RequestParam(required = false, defaultValue = "1") int cPage) {
		// 1. 모델앤뷰 객체 생성
		ModelAndView mav = new ModelAndView();
		
		// ---------------파라미터 값 제대로 불러왔는지 확인----------------
		// 검색 카테고리 및 검색 키워드 값 불러오기
		System.out.println("[controller] reviewlistSearch - searchText : "+searchText);
		System.out.println("[controller] reviewlistSearch - searchKinds : "+searchKinds);
		System.out.println("[controller] reviewlistSearch - cPage : "+cPage);
		// -----------------------------------------------------------------
		
		// 2. Map 객체 생성 - 검색 카테고리와 키워드를 저장
		Map<String,Object> searchReviewList = new HashMap<>();
		// 3. key-value쌍으로 "serachKinds" = "파라미터로 불러온 검색 카테고리"
		//    , "searchText" = "파라미터로 불러온 검색 키워드" Map에 넣기 
		searchReviewList.put("searchKinds", searchKinds);
		searchReviewList.put("searchText", searchText);
		
		// -----------Map에 검색 카테고리와 키워드 제대로 저장되었는지 확인-----------
		System.out.println("[controller] reviewlistSearch - Map{key=value} : " + searchReviewList);
		// --------------------------------------------------------------------------
		
		// 4. 1페이지당 보여질 게시글 개수 정하기 
		//    -> 1페이지당 10개의 게시글
		int cntPerPage = 10;
		// 5. 파라미터값 Service에 전달 후 Map에 저장
		Map<String,Object> commandMap = reviewBoardService.selectReviewSearchList(cPage, cntPerPage, searchReviewList);
		
		User sessionUser = (User)session.getAttribute("logInInfo");
		if(sessionUser!=null && sessionUser.getuDhtCnt() > 0) {
		// 5-1. 사용한 동행복권 조회
		Map<String,Object> reviewdht = reviewBoardService.selectDhTicket(sessionUser);
		System.out.println(reviewdht);
		mav.addObject("rticket", reviewdht);
		}
		
		//------------------ Service에서 처리한 데이터값 출력-----------------------
		System.out.println("[controller] reviewlistSearch - commandMap : " + commandMap);
		//--------------------------------------------------------------------------
		
		// 6. ModelAndView에 VO 및 View 이름값 넣기 
		mav.addObject("paging", commandMap.get("paging"));
		mav.addObject("reviewData" ,commandMap);
		mav.addObject("searchKinds", searchKinds);
		mav.addObject("searchText", searchText);
		mav.setViewName("redirect: /board/reviewlist");
		// 7. 데이터 처리가 완료된 모델(VO)값과 보여질 페이지(jsp)를 반환한다.
		return mav;
	}
	
	// ⑸ 게시글 상세보기 페이지 이동
	// url : /board/reviewview - GET
	// parameter :
	// int rbNo - 파라미터(name="rbNo") 값(value) 불러오기
	@RequestMapping(value = "/reviewview", method = RequestMethod.GET)
	public ModelAndView reviewView(
			@RequestParam int rbNo
			, HttpSession session
		) {
		// 1. 모델앤뷰 객체 생성
		ModelAndView mav = new ModelAndView();
		// 2. 파라미터값 Service에 전달 후 Map에 저장
		Map<String, Object> commandMap = reviewBoardService.selectReviewView(rbNo);
		
		//---------------- Service에서 처리한 데이터값 출력-------------------------
		System.out.println("[controller] reviewview - commandMap : " + commandMap);
		System.out.println("[ServiceImpl] - fdetail get : " +((Map)commandMap.get("detail")));
		System.out.println("[ServiceImpl] - fdetail get : " +((Map)commandMap.get("detail")).get("RBDBNO"));
		System.out.println("[ServiceImpl] - fdetail get : " +((Map)commandMap.get("detail")).get("RBGBNO"));
		int rbGbNo = Integer.parseInt(((Map)commandMap.get("detail")).get("RBGBNO").toString());
		int rbDbNo = Integer.parseInt(((Map)commandMap.get("detail")).get("RBDBNO").toString());
		System.out.println("rbGbNo : "+rbGbNo);
		System.out.println("rbDbNo : "+rbDbNo);
		//--------------------------------------------------------------------------
		
		// 2-1.동행 게시글 조회하기
		if(rbGbNo != 0) {
//			System.out.println("함께가요 게시판입니다.");
			Map<String, Object> godetail = reviewBoardService.selectGoBoardView(rbGbNo);
			mav.addObject("donghang", godetail);
		} else if(rbDbNo != 0) {
//			System.out.println("함께해요 게시판입니다.");
			Map<String, Object> dodetail = reviewBoardService.selectDoBoardView(rbDbNo);
			mav.addObject("donghang", dodetail);
		}
		
		// 3. DB에 회원, 후기게시판 테이블을 조회한 결과값이 Not Null
		//   ("detail" : 회원, 후기게시판, "filelist" : 후기게시판, 후기파일 )
		if(commandMap.get("detail") != null) {
			// 4. ModelAndView에 VO 및 View 이름값 넣기 
			mav.addObject("rview", commandMap);
			mav.setViewName("board/reviewview");
		} else {
			// 5. view페이지 : /WEB-INF/views/common 폴더 안에 result.jsp
			// 5-1. 경고메세지 출력 후 지정된 url로 페이지 이동
			mav.addObject("alertMsg", "해당 게시물이 존재하지 않습니다.");
			mav.addObject("url", "reviewlist");
			mav.setViewName("common/result");
		}
		
		User sessionUser = (User)session.getAttribute("logInInfo");
		if(sessionUser!=null) {
			// 2-0.세션회원의 동행복권 개수 업데이트
			ReviewDhTicket reviewDhTicket = new ReviewDhTicket();
			reviewDhTicket.setDhtRbNo(rbNo);
			reviewDhTicket.setDhtUNo(sessionUser.getuNo());
			int reviewdht = reviewBoardService.updateDhtCnt(sessionUser, reviewDhTicket);
			System.out.println("[Controller] reviewdht : " + reviewdht);
			if( reviewdht == 0 ) {
				mav.addObject("alertMsg", "사용할 수 있는 동행복권이 없습니다. 마이페이지>결제내역에서 동행복권을 충전해주시기 바랍니다.");
				mav.addObject("url", "reviewlist");
				mav.setViewName("common/result");
				return mav;
			}
			
			ReviewLike reviewlike = new ReviewLike();
			reviewlike.setRlRbNo(rbNo);
			reviewlike.setRlUNo(sessionUser.getuNo());
			int reviewlikecnt = reviewBoardService.getBoardLike(reviewlike);
			System.out.println("[Controller] reviewlikecnt : " + reviewlikecnt);
			mav.addObject("likecnt",reviewlikecnt);
			
			ReviewRecommend reviewrecommend = new ReviewRecommend();
			reviewrecommend.setRrcRbNo(rbNo);
			reviewrecommend.setRrcUNo(sessionUser.getuNo());
			int reviewrecommendcnt = reviewBoardService.getBoardRec(reviewrecommend);
			mav.addObject("reccnt", reviewrecommendcnt);
		} 
		// 6. 데이터 처리가 완료된 모델(VO)값과 보여질 페이지(jsp)를 반환한다.
		return mav;
	}
	
	// ⑹ 게시글 상세보기 페이지에서 파일 다운로드
	// url : /board/reviewdownload
	// parameter :
	// HttpServletResponse response - response header 지정하기
	// HttpSession session - 서버에 저장된 파일경로 받기
	// String ofname - 사용자가 올린 파일 이름
	// String rfname - 서버에 저장된 파일 이름
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
	
	// ⑺ 게시글 수정하기 페이지 이동
	// url : /board/reviewmodify - GET
	// parameter : 
	// int rbNo : 상세보기할 후기게시판 번호값 불러오기
	@RequestMapping(value="/reviewmodify", method = RequestMethod.GET)
	public ModelAndView reviewModify(int rbNo) {
		// 1. 모델앤뷰 객체 생성
		ModelAndView mav = new ModelAndView();
		
		// ---------------파라미터 값 제대로 불러왔는지 확인-------------------------
		System.out.println("[controller] reviewmodify - rbNo : " + rbNo);
		// --------------------------------------------------------------------------
		
		// 2. 파라미터값 Service에 전달 후 Map에 저장
		Map<String,Object> commandMap = reviewBoardService.selectReviewView(rbNo);
		
		//---------------- Service에서 처리한 데이터값 출력-------------------------
		System.out.println("[controller] reviewmodify - commandMap : " + commandMap);
		System.out.println("[ServiceImpl] - fdetail get : " +((Map)commandMap.get("detail")).get("RBDBNO"));
		System.out.println("[ServiceImpl] - fdetail get : " +((Map)commandMap.get("detail")).get("RBGBNO"));
		int rbGbNo = Integer.parseInt(((Map)commandMap.get("detail")).get("RBGBNO").toString());
		int rbDbNo = Integer.parseInt(((Map)commandMap.get("detail")).get("RBDBNO").toString());
		System.out.println("rbGbNo : "+rbGbNo);
		System.out.println("rbDbNo : "+rbDbNo);
		//--------------------------------------------------------------------------
		
		if(rbGbNo != 0) {
//			System.out.println("함께가요 게시판입니다.");
			Map<String, Object> godetail = reviewBoardService.selectGoBoardView(rbGbNo);
			mav.addObject("donghang", godetail);
		} else if(rbDbNo != 0) {
//			System.out.println("함께해요 게시판입니다.");
			Map<String, Object> dodetail = reviewBoardService.selectDoBoardView(rbDbNo);
			mav.addObject("donghang", dodetail);
		}
		
		// 3. DB에 회원, 후기게시판 테이블을 조회한 결과값이 Not Null
		//   ("detail" : 회원, 후기게시판, "filelist" : 후기게시판, 후기파일 )
		if(commandMap.get("detail") != null) {
			// 4. ModelAndView에 VO 및 View 이름값 넣기 
			mav.addObject("rview", commandMap);
			mav.setViewName("board/reviewmodify");
		} else {
			// 5. view페이지 : /WEB-INF/views/common 폴더 안에 result.jsp
			// 5-1. 경고메세지 출력 후 지정된 url로 페이지 이동
			mav.addObject("alertMsg", "해당 게시물이 존재하지 않습니다.");
			mav.addObject("url", "reviewlist");
			mav.setViewName("common/result");
		}
		// 6. 데이터 처리가 완료된 모델(VO)값과 보여질 페이지(jsp)를 반환한다.
		return mav;
		
	}
	
	// ⑻ 게시글 수정 페이지에서, 업로드된 파일 Ajax로 삭제 처리
	// url : /board/reviewdeletefile - POST
	// parameter : 
	// int rbNo - 파라미터(name="rbNo") 값(value) 불러오기
	@RequestMapping(value="/reviewdeletefile", method = RequestMethod.POST)
	@ResponseBody
	public String reviewDeleteFile(int rfNo) {
		// 1. 파라미터값 Service에 전달 후 int 값 반환
		//    ( 성공 : 1, 실패 : 0 )
		int res = reviewBoardService.deleteReviewFile(rfNo);
		
		//---------------- Service에서 처리한 데이터값 출력-------------------------
		System.out.println("[controller] reviewDeleteFile res 반환값 : "+ res);
		//--------------------------------------------------------------------------
		
		// 2. 해당 파일 삭제 성공한다면,
		if( res > 0 ) {
			// 2-1. res = 1 : javascript에 tagSelector로 html 태그의 id값이 "#f+rfno"인 값을 반환
			return "#f"+rfNo;
		} else {
			// 2-2. res = 0 : 실패라고 알림
			return "fail";
		}
		
	}
	
	// ⑼ 게시글 수정한 후, 수정한 상세보기 페이지로 이동
	// url : /board/reviewmodiyImpl - POST
	// parameter : 
	// ReviewBoard reviewboard - form 태그 안의 파라미터(name) 값(value)들을 ReviewBoard 객체에 저장
	// List<MultipartFile> files - 업로드한 파일의 orginalFileName, fileSize 값 불러오기
	// HttpSession session -  로그인 세션정보(uno) : 파일 업로드한 회원정보(rfuno)
	@RequestMapping(value="/reviewmodifyImpl", method = RequestMethod.POST)
	public ModelAndView reviewModifyImpl(
			@RequestParam int gbNo,
			@RequestParam String gbCategory,
			@RequestParam int beforeGbNo,
			@RequestParam String beforeGbCategory,
			@RequestParam int beforeRbDhStar,
			@RequestParam int beforeRbHostStar,
			ReviewBoard reviewboard
			,@RequestParam List<MultipartFile> files
			, HttpSession session
			) throws FileException {

		//---------------- Service에서 처리한 데이터값 출력-------------------------
//		System.out.println("[controller] reviewmodifyImpl - commandMap - detail - USERID : " + ((Map)commandMap.get("detail")).get("USERID"));
		// ReviewBoard에 form 태그의 파라미터값들 잘 저장되었는지 확인 
		System.out.println("[controller] reviewmodifyImpl - reviewboard : " + reviewboard);
		System.out.println("[controller] reviewmodifyImpl 바뀔 동행정보(gbNo)  : "+ gbNo);
		System.out.println("[controller] reviewmodifyImpl 바뀔 동행카테고리(gbCategory)  : "+ gbCategory);
		System.out.println("[controller] reviewmodifyImpl 수정전 동행정보(gbNo)  : "+ beforeGbNo);
		System.out.println("[controller] reviewmodifyImpl 수정전 동행카테고리(beforeGbCategory)  : "+ beforeGbCategory);

		//--------------------------------------------------------------------------

		// 0. 받은 파라미터값 Map으로 넣기
		Map<String, Object> donghangMap = new HashMap<>();
		donghangMap.put("gbNo", gbNo);
		donghangMap.put("gbCategory", gbCategory);
		donghangMap.put("rbDhStar", reviewboard.getRbDhStar());
		donghangMap.put("rbHostStar", reviewboard.getRbHostStar());
		donghangMap.put("beforeGbNo", beforeGbNo);
		donghangMap.put("beforeGbCategory", beforeGbCategory);
		donghangMap.put("beforeRbDhStar", beforeRbDhStar);
		donghangMap.put("beforeRbHostStar", beforeRbHostStar);
		donghangMap.put("rbNo", reviewboard.getRbNo());
		
		System.out.println("reviewboard어떻게 찍히나? " + reviewboard);
		
		// -----------------파라미터 맵 출력------------------------------------------------------------
		System.out.println("[controller] reviewModifyImpl 받은 파라미터값 Map(donghangMap)  : "+ donghangMap);
		// ---------------------------------------------------------------------------------------------
		
		if(donghangMap.get("beforeGbCategory").equals("함께가요")) {
			if(donghangMap.get("gbCategory").equals("함께가요")) {
				reviewboard.setRbGbNo(gbNo);
				reviewboard.setRbDbNo(0);
			} else if(donghangMap.get("gbCategory").equals("함께해요")) {
				reviewboard.setRbGbNo(0);
				reviewboard.setRbDbNo(gbNo);
			}
		} else if(donghangMap.get("beforeGbCategory").equals("함께해요")){
			if(donghangMap.get("gbCategory").equals("함께가요")) {
				reviewboard.setRbGbNo(gbNo);
				reviewboard.setRbDbNo(0);
			} else if(donghangMap.get("gbCategory").equals("함께해요")) {
				reviewboard.setRbGbNo(0);
				reviewboard.setRbDbNo(gbNo);
			}
		}
		
		// 1. 모델앤뷰 객체 생성
		ModelAndView mav = new ModelAndView();
		// 2. 파라미터값 Service에 전달 후 Map에 저장
		//    (후기게시글 작성자와 세션정보가 같은지 파악
		//     , 게시글 수정 후 상세보기 페이지에 수정된 내용 반영)
		Map<String,Object> commandMap = reviewBoardService.selectReviewView(reviewboard.getRbNo());
		
		// 3. 서버에 업로드할 경로 지정
		String root = session.getServletContext().getRealPath("/");
		// 4. 세션에 저장된 로그인 정보를 'User' VO에 저장
		User sessionUser = (User)session.getAttribute("logInInfo");
		
		// 5. 로그인을 안 했을 경우 
		// 	세션정보가 담긴 회원정보가 Null일때 ( User Null )
		//	= 빈 세션 일 때( HttpSession Null )
		if(sessionUser == null) {
			// 6. view페이지 : /WEB-INF/views/common 폴더 안에 result.jsp
			// 6-1. 경고메세지 출력 후 지정된 url로 페이지 이동
			mav.addObject("alertMsg", "로그인 후에 이용해주시기 바랍니다.");
			mav.addObject("url", "../user/login");
			mav.setViewName("common/result");
			// 6-2. 데이터 처리가 완료된 모델(VO)값과 보여질 페이지(jsp)를 반환한다.
			return mav;
		}
		
		// 7. 빈 결과값 생성(성공 여부 파악 / 성공 : 1 , 실패 : 0)
		int res = 0 ;
		// 8. 세션 회원아이디와 후기게시판 글 작성자의 회원아이디 값이 같을 경우
		if(sessionUser.getUserId().equals(((Map)commandMap.get("detail")).get("USERID"))) {
			reviewboard.setRbUNo(sessionUser.getuNo());
			// 9. 파라미터값 Service에 전달 후 int 값 반환
			//    ( 성공 : 1, 실패 : 0 )
			res = reviewBoardService.updateReviewModify(reviewboard, files, root);
		
			reviewBoardService.updateDhStarInModify(donghangMap, reviewboard);
		} 
		
		// 10. 게시글 수정 성공한다면,
		if( res > 0) {
			// 11. ModelAndView에 VO 및 View 이름값 넣기
			mav.addObject("rview",commandMap);
			mav.setViewName("redirect: reviewview?rbNo="+reviewboard.getRbNo());
		} else {
			// 12. view페이지 : /WEB-INF/views/common 폴더 안에 result.jsp
			// 12-1. 경고메세지 출력 후 지정된 url로 페이지 이동
			mav.addObject("alertMsg", "해당 게시물에 접근할 권한이 없습니다.");
			mav.addObject("url", "reviewlist");
			mav.setViewName("common/result");
		}
		// 13. 데이터 처리가 완료된 모델(VO)값과 보여질 페이지(jsp)를 반환한다.
		return mav;
	}
	
	// ⑽ 게시글 삭제하기 
	// url : /board/reviewdelete - GET
	// parameter :
	// int rbNo : 삭제할 후기게시판 번호값 불러오기(url 쿼리)
	// String userId : 삭제할 아이디값 불러오기(url 쿼리)
	// HttpSession session - 로그인 세션정보(uno) : 게시글 작성자(fbuno)
	@RequestMapping(value="/reviewdelete", method = RequestMethod.GET)
	public ModelAndView reviewDelete(
			int rbNo
			, @RequestParam int gbNo
			, @RequestParam String gbCategory
			, String userId
			, HttpSession session) {
		// 0. 받은 파라미터값 Map으로 넣기
		Map<String, Object> donghangMap = new HashMap<>();
		donghangMap.put("gbNo", gbNo);
		donghangMap.put("gbCategory", gbCategory);
		
		
		// 1. 모델앤뷰 객체 생성
		ModelAndView mav = new ModelAndView();
		// 2. 세션에 저장된 로그인 정보를 'User' VO에 저장
		User sessionUser = (User)session.getAttribute("logInInfo");
		// 3. 로그인을 안 했을 경우 
		// 	세션정보가 담긴 회원정보가 Null일때 ( User Null )
		//	= 빈 세션 일 때( HttpSession Null ))
		if(sessionUser == null) {
			// 4. view페이지 : /WEB-INF/views/common 폴더 안에 result.jsp
			// 4-1. 경고메세지 출력 후 지정된 url로 페이지 이동
			mav.addObject("alertMsg", "로그인 후에 이용해주시기 바랍니다.");
			mav.addObject("url", "../user/login");
			mav.setViewName("common/result");
			// 4-2. 데이터 처리가 완료된 모델(VO)값과 보여질 페이지(jsp)를 반환한다.
			return mav;
		}
		// 5. 빈 결과값 생성(성공 여부 파악 / 성공 : 1 , 실패 : 0)
		int res = 0;
		// 6. 파라미터값 Service에 전달 후 Map에 저장
		//    (후기게시글 작성자와 세션정보가 같은지 파악)
		Map<String,Object> review = reviewBoardService.selectReviewView(rbNo);
		
		// 7. 세션 회원아이디와 후기게시판 글 작성자의 회원아이디 값이 같을 경우
		if(sessionUser.getUserId().equals(((Map)review.get("detail")).get("USERID"))) {
			// 8. 파라미터값 Service에 전달 후 int 값 반환
			//    ( 성공 : 1, 실패 : 0 )
			res = reviewBoardService.deleteReviewBoard(rbNo);
			
			res = reviewBoardService.updateDhStarBydelete(donghangMap, rbNo);
		} 
		
		// 9. 게시글 삭제 성공한다면,
//		if(res > 0) {
			// 10. view페이지 : /WEB-INF/views/common 폴더 안에 result.jsp
			// 10-1. 경고메세지 출력 후 지정된 url로 페이지 이동
			mav.addObject("alertMsg", "게시물 삭제에 성공했습니다.");
			mav.addObject("url", "reviewlist");
			mav.setViewName("common/result");
//		} else {
//			// 11. view페이지 : /WEB-INF/views/common 폴더 안에 result.jsp
//			// 11-1. 경고메세지 출력 후 지정된 url로 페이지 이동
//			mav.addObject("alertMsg", "해당 게시물에 접근할 권한이 없습니다.");
//			mav.addObject("url", "reviewlist");
//			mav.setViewName("common/result");
//		}
		// 12. 데이터 처리가 완료된 모델(VO)값과 보여질 페이지(jsp)를 반환한다.
		return mav;
	}
	
	// ⑾ 게시글 상세보기 페이지에서, 댓글 작성 Ajax로 처리
	// url : /board/reviewcommentwirteImpl - POST
	// parameter :
	// ReviewComment reviewComment - Ajax로 처리할 파라미터(name) 값(value)들을 ReviewComment 객체에 저장
	// HttpSession session - 로그인 세션정보(uno) : 댓글 작성한 회원정보(fcuno)
	// int rbNo - 파라미터(name="rbNo") 값(value) 불러오기
	@RequestMapping(value="reviewcommentwriteImpl", method = RequestMethod.POST)
	@ResponseBody
	public int reviewCommentWrite(
			ReviewComment reviewComment
			,HttpSession session
			, @RequestParam(value="rbNo", required = false) int rbNo
			) {
		// 1. 세션에 저장된 로그인 정보를 'User' VO에 저장
		User sessionUser = (User)session.getAttribute("logInInfo");
		// 2. ReviewComment rcRbNo에 request parameter의 rbNo값 불러와서 지정하기
		reviewComment.setRcRbNo(rbNo);
		
		//---------------후기게시판 번호 제대로 저장되었는지, 파라미터값 제대로 불러온지 확인하기 ----------
		System.out.println("[controller] ReviewComment : "+reviewComment);
		//--------------------------------------------------------------------------------------------------
		
		// 3. 로그인을 안 했을 경우 
		// 	세션정보가 담긴 회원정보가 Null일때 ( User Null )
		//	= 빈 세션 일 때( HttpSession Null )
		if(sessionUser != null) {
			// 4. ReviewComment fcuno에 세션의 uno값 불러와서 지정하기
			reviewComment.setRcUNo(sessionUser.getuNo());
			// 4-1. 파라미터값 Service에 전달 후 int 값 반환
			//    ( 성공 : 1, 실패 : 0 )
			return reviewBoardService.insertReviewComment(reviewComment);
		} else {
			// 5. 실패할 경우 0 반환
			return 0;			
		}
	}
	
	// ⑿ 게시글 상세보기 페이지에서, 댓글 리스트 조회 Ajax로 처리
	// url : /board/getReplyList - POST
	// parameter :
	// int rbNo - 파라미터(name="rbNo") 값(value) 불러오기
	@ResponseBody
	@RequestMapping(value = "/getReviewReplyList", method = RequestMethod.POST)
	public List<Map<String,Object>> getReplyList(
			@RequestParam("rbNo") int rbNo) {
		// 1. 파라미터값 Service에 전달 후 int 값 반환
		//    ( 성공 : 1, 실패 : 0 )
		return reviewBoardService.selectReviewCommentList(rbNo);
	}
	
	// ⒀ 게시글 상세보기 페이지에서, 댓글 수정하기 Ajax로 처리
	// url : /board/updateReply - PUT
	// parameter :
	// RequestBody Map replyNo : 댓글번호, 댓글 내용 key-value 요청한 값 받기
	@RequestMapping(value="updateReviewReply", method = RequestMethod.PUT)
	@ResponseBody
	public int updateReply(@RequestBody Map<String,Object> replyNo) {
		
		//-------------------RequestBody에서 요청한 값 제대로 받아왔는지 확인하기----------------------
		System.out.println("[controller] updateReply map : "+replyNo);
		System.out.println("[controller] updateReply fcno int: "+replyNo.get("replyNo"));
		System.out.println("[controller] updateReply fccontent string : "+replyNo.get("replyText"));
		//---------------------------------------------------------------------------------------------
		
		
		// 1. ReviewComment fcNo에 Map에서 갖고온 Value(Object 타입)을 int형태로 바꾸기 
		int fcNo = Integer.parseInt((String) replyNo.get("replyNo"));
		// 2. ReviewComment fcContent에 Map에서 갖고온 Value(Object 타입)을 String형태로 바꾸기
		String fcContent = (String) replyNo.get("replyText");
		// 3. ReviewComment 빈 객체 생성
		ReviewComment reviewComment = new ReviewComment();
		// 4. ReviewComment에 fcNo, fcContent 값 지정
		reviewComment.setRcNo(fcNo);
		reviewComment.setRcContent(fcContent);
		// 5. 파라미터값 Service에 전달 후 int 값 반환
		//    ( 성공 : 1, 실패 : 0 )
		return reviewBoardService.updateReviewContent(reviewComment);
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
		return reviewBoardService.deleteReviewComment(reviewComment);
	}
	
	// ⒂ 게시글 리스트 페이지 이동
	// url : /board/reviewfinddh - GET
	// parameter : 
	// String searchText - 파라미터(name="searchText") 값(value) 불러오기
	// String searchKinds - 파라미터(name="searchKinds") 값(value) 불러오기
	// cPage : 현재 페이지 값 불러오기
	@RequestMapping(value="/reviewfinddh", method = RequestMethod.GET)
	public ModelAndView reviewFindDh(
			String searchDHcategory,
			String searchKeyword,
			HttpSession session,
			@RequestParam(required = false, defaultValue = "1") int cPage) {
		ModelAndView mav = new ModelAndView();
		
		// ---------------파라미터 값 제대로 불러왔는지 확인----------------
		// 검색 카테고리 및 검색 키워드 값 불러오기
		System.out.println("[controller] reviewfinddh - searchDHcategory : "+searchDHcategory);
		System.out.println("[controller] reviewfinddh - searchKeword : "+searchKeyword);
		System.out.println("[controller] reviewfinddh - cPage : "+cPage);
		// -----------------------------------------------------------------
		
		// 0. 세션에 저장된 로그인 정보를 'User' VO에 저장
		User sessionUser = (User)session.getAttribute("logInInfo");
		// 2. Map 객체 생성 - 검색 카테고리와 키워드를 저장
		Map<String,Object> searchDongHangList = new HashMap<>();
		// 3. key-value쌍으로 "serachKinds" = "파라미터로 불러온 검색 카테고리"
		//    , "searchText" = "파라미터로 불러온 검색 키워드" Map에 넣기 
		searchDongHangList.put("searchDHcategory", searchDHcategory);
		searchDongHangList.put("searchKeyword", searchKeyword);
		searchDongHangList.put("uNo", sessionUser.getuNo());
		
		// -----------Map에 검색 카테고리와 키워드 제대로 저장되었는지 확인-----------
		System.out.println("[controller] reviewfinddh - Map{key=value} : " + searchDongHangList);
		// --------------------------------------------------------------------------
		
		// 4. 1페이지당 보여질 게시글 개수 정하기 
		//    -> 1페이지당 10개의 게시글
		int cntPerPage = 10;
		// 5. 파라미터값 Service에 전달 후 Map에 저장
		//    - cPage, cntPerPage, searchReviewList 
		//     (현재페이지, 페이지당 보여줄 게시글 개수, 검색 카테고리와 키워드가 담긴 Map)
		Map<String,Object> commandMap = reviewBoardService.selectDongHangSearchList(cPage, cntPerPage, searchDongHangList, sessionUser);
		
		//--------------------------------------
		// 검색키워드가 없을 시, 리스트 검색
//		ModelAndView mav = new ModelAndView();
//		int cntPerPage = 10;
//		
//		Map<String, Object> commandMap = reviewBoardService.selectReviewList(cPage, cntPerPage);
		//--------------------------------------
		
		//------------------ Service에서 처리한 데이터값 출력-----------------------
		System.out.println("[controller] reviewfinddh - commandMap : " + commandMap);
		//--------------------------------------------------------------------------
		
		// 6. ModelAndView에 VO 및 View 이름값 넣기 
		mav.addObject("paging", commandMap.get("paging"));
		mav.addObject("donghangData", commandMap);
		mav.addObject("searchDHcategory", searchDHcategory);
		mav.addObject("searchKeyword", searchKeyword);
		mav.setViewName("board/reviewfinddh");
		// 7. 데이터 처리가 완료된 모델(VO)값과 보여질 페이지(jsp)를 반환한다.
		return mav;
		
	}
	
	// ⓐ 동행 게시글 검색
	// url : /board/reviewlistSearch - POST
	// parameter :
	// String searchText - 파라미터(name="searchText") 값(value) 불러오기
	// String searchKinds - 파라미터(name="searchKinds") 값(value) 불러오기
	// cPage : 현재 페이지 값 불러오기
	@RequestMapping(value="/reviewfinddhSearch", method=RequestMethod.POST)
	public ModelAndView reviewFinddhSearch(
									String searchDHcategory,
									String searchKeyword,
									HttpSession session,
									@RequestParam(required = false, defaultValue = "1") int cPage) {
		// 1. 모델앤뷰 객체 생성
		ModelAndView mav = new ModelAndView();
		
		// ---------------파라미터 값 제대로 불러왔는지 확인----------------
		// 검색 카테고리 및 검색 키워드 값 불러오기
		System.out.println("[controller] reviewlistSearch - searchDHcategory : "+searchDHcategory);
		System.out.println("[controller] reviewlistSearch - searchKeyword : "+searchKeyword);
		System.out.println("[controller] reviewlistSearch - cPage : "+cPage);
		// -----------------------------------------------------------------
		
		// 0. 세션에 저장된 로그인 정보를 'User' VO에 저장
		User sessionUser = (User)session.getAttribute("logInInfo");
		// 2. Map 객체 생성 - 검색 카테고리와 키워드를 저장
		Map<String,Object> searchDongHangList = new HashMap<>();
		// 3. key-value쌍으로 "serachKinds" = "파라미터로 불러온 검색 카테고리"
		//    , "searchText" = "파라미터로 불러온 검색 키워드" Map에 넣기 
		searchDongHangList.put("searchDHcategory", searchDHcategory);
		searchDongHangList.put("searchKeyword", searchKeyword);
		searchDongHangList.put("uNo", sessionUser.getuNo());
		
		// -----------Map에 검색 카테고리와 키워드 제대로 저장되었는지 확인-----------
		System.out.println("[controller] reviewlistSearch - Map{key=value} : " + searchDongHangList);
		// --------------------------------------------------------------------------
		
		// 4. 1페이지당 보여질 게시글 개수 정하기 
		//    -> 1페이지당 10개의 게시글
		int cntPerPage = 10;
		// 5. 파라미터값 Service에 전달 후 Map에 저장
		Map<String,Object> commandMap = reviewBoardService.selectDongHangSearchList(cPage, cntPerPage, searchDongHangList, sessionUser);
		
		//------------------ Service에서 처리한 데이터값 출력-----------------------
		System.out.println("[controller] reviewlistSearch - commandMap : " + commandMap);
		//--------------------------------------------------------------------------
		
		// 6. ModelAndView에 VO 및 View 이름값 넣기 
		mav.addObject("paging", commandMap.get("paging"));
		mav.addObject("donghangData" ,commandMap);
		mav.addObject("searchDHcategory", searchDHcategory);
		mav.addObject("searchKeyword", searchKeyword);
		mav.setViewName("redirect: /board/reviewfinddh");
		// 7. 데이터 처리가 완료된 모델(VO)값과 보여질 페이지(jsp)를 반환한다.
		return mav;
	}
	
	@RequestMapping(value="/reviewlike", method = RequestMethod.POST)
	@ResponseBody
	public int reviewLike(int like,
			int rlRbNo,
			HttpSession session) {
		User sessionUser = (User)session.getAttribute("logInInfo");
		
		ReviewLike reviewlike = new ReviewLike();
		reviewlike.setRlRbNo(rlRbNo);
		reviewlike.setRlUNo(sessionUser.getuNo());
		
		System.out.println("[controller] like : " + like);
		
		if(like >= 1) {
			reviewBoardService.deleteReviewBoardLike(reviewlike);
			like = 0;
		} else {
			reviewBoardService.insertReviewBoardLike(reviewlike);
			like = 1;
		}
		
		return like;
	}
	
	@RequestMapping(value="/reviewrecommend", method = RequestMethod.POST)
	@ResponseBody
	public int reviewRecommend(int rec,
			int rrcRbNo,
			HttpSession session) {
		User sessionUser = (User)session.getAttribute("logInInfo");
		
		ReviewRecommend reviewrecommend = new ReviewRecommend();
		reviewrecommend.setRrcRbNo(rrcRbNo);
		reviewrecommend.setRrcUNo(sessionUser.getuNo());
		System.out.println("[controller] rec : " + rec);
		
		if(rec >= 1) {
			reviewBoardService.deleteReviewBoardRec(reviewrecommend);
			rec = 0;
		} else {
			reviewBoardService.insertReviewBoardRec(reviewrecommend);
			rec = 1;
		}
		
		return rec;
	}

	



	
	

}
