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

import com.DongHang_ComeFunny.www.model.service.board.FreeBoardService;
import com.DongHang_ComeFunny.www.model.vo.FreeBoard;
import com.DongHang_ComeFunny.www.model.vo.FreeComment;
import com.DongHang_ComeFunny.www.model.vo.User;

import common.exception.FileException;

@Controller
// url에 '/context-root/board'를 고정적으로 매핑 셋팅
@RequestMapping("/board")
public class FreeBoardController {
	
	// Service 의존성 주입
	@Autowired
	private FreeBoardService freeBoardService;
	// 주석
	// ⑴ 게시글 작성페이지 이동
	// url : /board/freewirte - GET
	// parameter : 
	// HttpSession session - 로그인 세션정보(uno) : 게시글 작성자(fbuno)
	@RequestMapping(value = "/freewrite", method = RequestMethod.GET)
	public ModelAndView freeWrite(HttpSession session) {
		// 1. 모델앤뷰 객체 생성
		ModelAndView mav = new ModelAndView();
		// 2. 세션에 저장된 로그인 정보를 'User' VO에 저장
		User sessionUser = (User)session.getAttribute("logInInfo");
		// 3. 로그인을 했을 경우 
		// 	세션정보가 담긴 회원정보가 Not Null일때 ( User Not Null )
		//	= 빈 세션이 아닐때( HttpSession Not Null )
		if(sessionUser != null) {
			// 4. view페이지 : /WEB-INF/views/board 폴더 안에 freewrite.jsp
			mav.setViewName("/board/freewrite");
		} else {
			// 5-1. view페이지 : /WEB-INF/views/common 폴더 안에 result.jsp
			// 5-2. 경고메세지 출력 후 지정된 url로 페이지 이동
			mav.addObject("alertMsg", "로그인 후에 이용해주시기 바랍니다.");
			mav.addObject("url", "../user/login");
			mav.setViewName("common/result");
		}
		// 6. 데이터 처리가 완료된 모델(VO)값과 보여질 페이지(jsp)를 반환한다. 
		return mav;
		
	}
	
	// ⑵ 게시글 작성한 후, 리스트 페이지로 이동
	// url : /board/freeUploadImpl - POST
	// parameter : 
	// FreeBoard free - form 태그 안의 파라미터(name) 값(value)들을 FreeBoard 객체에 저장
	// List<MultipartFile> files - 업로드한 파일의 orginalFileName, fileSize 값 불러오기
	// HttpSession session - 로그인 세션정보(uno) : 파일 업로드한 회원정보(ffuno)
	// HttpServletRequest req - form 태그 안의 파라미터(name) 값(value) 제대로 불러오는지 확인하기(req.getParameter("name"))
	@SuppressWarnings("unused")
	@RequestMapping(value="freeUploadImpl", method = RequestMethod.POST)
	public ModelAndView freeUpload(
			FreeBoard free
			, @RequestParam List<MultipartFile> files
			, HttpSession session
			, HttpServletRequest req
			) throws FileException {
		// ---------------파라미터 값 제대로 불러왔는지 확인----------------
		// 에디터에서 작성한 텍스트 내용 console에 출력
		System.out.println("[controller] freeUpload 에디터 내용 : " + req.getParameter("fbContent"));
		// FreeBoard에 form 태그의 파라미터값들 잘 저장되었는지 확인 
		System.out.println("[controller] freeUpload FreeBoard에 저장된 정보 : "+free);
		// -----------------------------------------------------------------

		// 1. 모델앤뷰 객체 생성
		ModelAndView mav = new ModelAndView();
		// 2. 서버에 업로드할 경로 지정
		String root = session.getServletContext().getRealPath("/");
		// 3. 세션에 저장된 로그인 정보를 'User' VO에 저장
		User sessionUser = (User)session.getAttribute("logInInfo");
		
		// --------------로그인한 세션정보 확인--------------
		System.out.println("[controller] freeUpload sessionUser 로그인한 세션의 회원정보 : " + sessionUser);
		// --------------------------------------------------
		
		// 4. 로그인을 했을 경우 
		// 	세션정보가 담긴 회원정보가 Not Null일때 ( User Not Null )
		//	= 빈 세션이 아닐때( HttpSession Not Null )
		if(sessionUser != null) {
			// 5. FreeBoard 파일업로드한 회원정보(fbuno, 외래키)에 로그인 세션정보(uno, 기본키) 값 넣기
			free.setFbUNo(sessionUser.getuNo());
			// 5-1. 파라미터값 Service에 전달  
			//      - FreeBoard, List<MultiPart>, root 
			//        (자유게시판, 파일, 업로드 경로)
			freeBoardService.insertFree(free, files, root);
			// 5-2. Service에서 처리한 후, view 페이지 지정
			//		view페이지 : /WEB-INF/views/board 폴더 안에 freelist.jsp
			mav.setViewName("redirect: /board/freelist");
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
	// url : /board/freelist - GET
	// parameter : 
	// String searchText - 파라미터(name="searchText") 값(value) 불러오기
	// String searchKinds - 파라미터(name="searchKinds") 값(value) 불러오기
	// cPage : 현재 페이지 값 불러오기
	@RequestMapping(value = "/freelist", method = RequestMethod.GET)
	public ModelAndView freeList(
			String searchText,
			String searchKinds,
			@RequestParam(required=false, defaultValue="1")int cPage) {
		// 1. 모델앤뷰 객체 생성
		ModelAndView mav = new ModelAndView();
		
		// ---------------파라미터 값 제대로 불러왔는지 확인----------------
		// 검색 카테고리 및 검색 키워드 값 불러오기
		System.out.println("[controller] freelist - searchText : "+searchText);
		System.out.println("[controller] freelist - searchKinds : "+searchKinds);
		System.out.println("[controller] freelist - cPage : "+cPage);
		// -----------------------------------------------------------------
		
		// 2. Map 객체 생성 - 검색 카테고리와 키워드를 저장
		Map<String,Object> searchFreeList = new HashMap<>();
		// 3. key-value쌍으로 "serachKinds" = "파라미터로 불러온 검색 카테고리"
		//    , "searchText" = "파라미터로 불러온 검색 키워드" Map에 넣기 
		searchFreeList.put("searchKinds", searchKinds);
		searchFreeList.put("searchText", searchText);
		
		// -----------Map에 검색 카테고리와 키워드 제대로 저장되었는지 확인-----------
		System.out.println("[controller] freelist - Map{key=value} : " + searchFreeList);
		// --------------------------------------------------------------------------
		
		// 4. 1페이지당 보여질 게시글 개수 정하기 
		//    -> 1페이지당 10개의 게시글
		int cntPerPage = 10;
		// 5. 파라미터값 Service에 전달 후 Map에 저장
		//    - cPage, cntPerPage, searchFreeList 
		//     (현재페이지, 페이지당 보여줄 게시글 개수, 검색 카테고리와 키워드가 담긴 Map)
		Map<String,Object> commandMap = freeBoardService.selectFreeSearchList(cPage, cntPerPage, searchFreeList);
		
		//--------------------------------------
		// 검색키워드가 없을 시, 리스트 검색
//		ModelAndView mav = new ModelAndView();
//		int cntPerPage = 10;
//		
//		Map<String, Object> commandMap = freeBoardService.selectFreeList(cPage, cntPerPage);
		//--------------------------------------
		
		//------------------ Service에서 처리한 데이터값 출력-----------------------
		System.out.println("[controller] freelist - commandMap : " + commandMap);
		//--------------------------------------------------------------------------
		
		// 6. ModelAndView에 VO 및 View 이름값 넣기 
		mav.addObject("paging", commandMap.get("paging"));
		mav.addObject("freeData", commandMap);
		mav.addObject("searchKinds", searchKinds);
		mav.addObject("searchText", searchText);
		mav.setViewName("board/freelist");
		// 7. 데이터 처리가 완료된 모델(VO)값과 보여질 페이지(jsp)를 반환한다.
		return mav;
	}
	
	// ⑷ 게시글 검색한 후, 검색된 리스트 페이지로 이동
	// url : /board/freelistSearch - POST
	// parameter :
	// String searchText - 파라미터(name="searchText") 값(value) 불러오기
	// String searchKinds - 파라미터(name="searchKinds") 값(value) 불러오기
	// cPage : 현재 페이지 값 불러오기
	@RequestMapping(value="/freelistSearch", method=RequestMethod.POST)
	public ModelAndView freeListSearch(
									String searchText,
									String searchKinds,
									@RequestParam(required = false, defaultValue = "1") int cPage) {
		// 1. 모델앤뷰 객체 생성
		ModelAndView mav = new ModelAndView();
		
		// ---------------파라미터 값 제대로 불러왔는지 확인----------------
		// 검색 카테고리 및 검색 키워드 값 불러오기
		System.out.println("[controller] freelistSearch - searchText : "+searchText);
		System.out.println("[controller] freelistSearch - searchKinds : "+searchKinds);
		System.out.println("[controller] freelistSearch - cPage : "+cPage);
		// -----------------------------------------------------------------
		
		// 2. Map 객체 생성 - 검색 카테고리와 키워드를 저장
		Map<String,Object> searchFreeList = new HashMap<>();
		// 3. key-value쌍으로 "serachKinds" = "파라미터로 불러온 검색 카테고리"
		//    , "searchText" = "파라미터로 불러온 검색 키워드" Map에 넣기 
		searchFreeList.put("searchKinds", searchKinds);
		searchFreeList.put("searchText", searchText);
		
		// -----------Map에 검색 카테고리와 키워드 제대로 저장되었는지 확인-----------
		System.out.println("[controller] freelistSearch - Map{key=value} : " + searchFreeList);
		// --------------------------------------------------------------------------
		
		// 4. 1페이지당 보여질 게시글 개수 정하기 
		//    -> 1페이지당 10개의 게시글
		int cntPerPage = 10;
		// 5. 파라미터값 Service에 전달 후 Map에 저장
		Map<String,Object> commandMap = freeBoardService.selectFreeSearchList(cPage, cntPerPage, searchFreeList);
		
		//------------------ Service에서 처리한 데이터값 출력-----------------------
		System.out.println("[controller] freelistSearch - commandMap : " + commandMap);
		//--------------------------------------------------------------------------
		
		// 6. ModelAndView에 VO 및 View 이름값 넣기 
		mav.addObject("paging", commandMap.get("paging"));
		mav.addObject("freeData" ,commandMap);
		mav.addObject("searchKinds", searchKinds);
		mav.addObject("searchText", searchText);
		mav.setViewName("redirect: /board/freelist");
		// 7. 데이터 처리가 완료된 모델(VO)값과 보여질 페이지(jsp)를 반환한다.
		return mav;
	}
	
	// ⑸ 게시글 상세보기 페이지 이동
	// url : /board/freeview - GET
	// parameter :
	// int fbNo - 파라미터(name="fbNo") 값(value) 불러오기
	@RequestMapping(value = "/freeview", method = RequestMethod.GET)
	public ModelAndView freeView(int fbNo
		) {
		// 1. 모델앤뷰 객체 생성
		ModelAndView mav = new ModelAndView();
		// 2. 파라미터값 Service에 전달 후 Map에 저장
		Map<String, Object> commandMap = freeBoardService.selectFreeView(fbNo);
		
		//---------------- Service에서 처리한 데이터값 출력-------------------------
		System.out.println("[controller] freeview - commandMap : " + commandMap);
		//--------------------------------------------------------------------------
		
		// 3. DB에 회원, 자유게시판 테이블을 조회한 결과값이 Not Null
		//   ("detail" : 회원, 자유게시판, "filelist" : 자유게시판, 자유파일 )
		if(commandMap.get("detail") != null) {
			// 4. ModelAndView에 VO 및 View 이름값 넣기 
			mav.addObject("fview", commandMap);
			mav.setViewName("board/freeview");
		} else {
			// 5. view페이지 : /WEB-INF/views/common 폴더 안에 result.jsp
			// 5-1. 경고메세지 출력 후 지정된 url로 페이지 이동
			mav.addObject("alertMsg", "해당 게시물이 존재하지 않습니다.");
			mav.addObject("url", "freelist");
			mav.setViewName("common/result");
		}
		// 6. 데이터 처리가 완료된 모델(VO)값과 보여질 페이지(jsp)를 반환한다.
		return mav;
	}
	
	// ⑹ 게시글 상세보기 페이지에서 파일 다운로드
	// url : /board/freedownload
	// parameter :
	// HttpServletResponse response - response header 지정하기
	// HttpSession session - 서버에 저장된 파일경로 받기
	// String ofname - 사용자가 올린 파일 이름
	// String rfname - 서버에 저장된 파일 이름
	@RequestMapping(value="/freedownload")
	@ResponseBody
	public FileSystemResource freeDownload(
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
	
	// ⑺ 게시글 수정하기 페이지 이동
	// url : /board/freemodify - GET
	// parameter : 
	// int fbNo : 상세보기할 자유게시판 번호값 불러오기
	@RequestMapping(value="/freemodify", method = RequestMethod.GET)
	public ModelAndView freeModify(int fbNo) {
		// 1. 모델앤뷰 객체 생성
		ModelAndView mav = new ModelAndView();
		
		// ---------------파라미터 값 제대로 불러왔는지 확인-------------------------
		System.out.println("[controller] freemodify - fbNo : " + fbNo);
		// --------------------------------------------------------------------------
		
		// 2. 파라미터값 Service에 전달 후 Map에 저장
		Map<String,Object> commandMap = freeBoardService.selectFreeView(fbNo);
		
		//---------------- Service에서 처리한 데이터값 출력-------------------------
		System.out.println("[controller] freemodify - commandMap : " + commandMap);
		//--------------------------------------------------------------------------
		
		// 3. DB에 회원, 자유게시판 테이블을 조회한 결과값이 Not Null
		//   ("detail" : 회원, 자유게시판, "filelist" : 자유게시판, 자유파일 )
		if(commandMap.get("detail") != null) {
			// 4. ModelAndView에 VO 및 View 이름값 넣기 
			mav.addObject("fview", commandMap);
			mav.setViewName("board/freemodify");
		} else {
			// 5. view페이지 : /WEB-INF/views/common 폴더 안에 result.jsp
			// 5-1. 경고메세지 출력 후 지정된 url로 페이지 이동
			mav.addObject("alertMsg", "해당 게시물이 존재하지 않습니다.");
			mav.addObject("url", "freelist");
			mav.setViewName("common/result");
		}
		// 6. 데이터 처리가 완료된 모델(VO)값과 보여질 페이지(jsp)를 반환한다.
		return mav;
		
	}
	
	// ⑻ 게시글 수정 페이지에서, 업로드된 파일 Ajax로 삭제 처리
	// url : /board/freedeletefile - POST
	// parameter : 
	// int fbNo - 파라미터(name="fbNo") 값(value) 불러오기
	@RequestMapping(value="/freedeletefile", method = RequestMethod.POST)
	@ResponseBody
	public String freeDeleteFile(int ffNo) {
		// 1. 파라미터값 Service에 전달 후 int 값 반환
		//    ( 성공 : 1, 실패 : 0 )
		int res = freeBoardService.deleteFreeFile(ffNo);
		
		//---------------- Service에서 처리한 데이터값 출력-------------------------
		System.out.println("[controller] freeDeleteFile res 반환값 : "+ res);
		//--------------------------------------------------------------------------
		
		// 2. 해당 파일 삭제 성공한다면,
		if( res > 0 ) {
			// 2-1. res = 1 : javascript에 tagSelector로 html 태그의 id값이 "#f+ffno"인 값을 반환
			return "#f"+ffNo;
		} else {
			// 2-2. res = 0 : 실패라고 알림
			return "fail";
		}
		
	}
	
	// ⑼ 게시글 수정한 후, 수정한 상세보기 페이지로 이동
	// url : /board/freemodiyImpl - POST
	// parameter : 
	// FreeBoard freeboard - form 태그 안의 파라미터(name) 값(value)들을 FreeBoard 객체에 저장
	// List<MultipartFile> files - 업로드한 파일의 orginalFileName, fileSize 값 불러오기
	// HttpSession session -  로그인 세션정보(uno) : 파일 업로드한 회원정보(ffuno)
	@RequestMapping(value="/freemodifyImpl", method = RequestMethod.POST)
	public ModelAndView freeModifyImpl(
			FreeBoard freeboard
			,@RequestParam List<MultipartFile> files
			, HttpSession session
			) throws FileException {
		// 1. 모델앤뷰 객체 생성
		ModelAndView mav = new ModelAndView();
		// 2. 파라미터값 Service에 전달 후 Map에 저장
		//    (자유게시글 작성자와 세션정보가 같은지 파악
		//     , 게시글 수정 후 상세보기 페이지에 수정된 내용 반영)
		Map<String,Object> commandMap = freeBoardService.selectFreeView(freeboard.getFbNo());
		
		//---------------- Service에서 처리한 데이터값 출력-------------------------
		System.out.println("[controller] freemodifyImpl - commandMap - detail - USERID : " + ((Map)commandMap.get("detail")).get("USERID"));
		System.out.println("[controller] freemodifyImpl - freeboard : " + freeboard);
		//--------------------------------------------------------------------------
		
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
		// 8. 세션 회원아이디와 자유게시판 글 작성자의 회원아이디 값이 같을 경우
		if(sessionUser.getUserId().equals(((Map)commandMap.get("detail")).get("USERID"))) {
			// 9. 파라미터값 Service에 전달 후 int 값 반환
			//    ( 성공 : 1, 실패 : 0 )
			res = freeBoardService.updateFreeModify(freeboard, files, root);
		} 
		
		// 10. 게시글 수정 성공한다면,
		if( res > 0) {
			// 11. ModelAndView에 VO 및 View 이름값 넣기
			mav.addObject("fview",commandMap);
			mav.setViewName("redirect: freeview?fbNo="+freeboard.getFbNo());
		} else {
			// 12. view페이지 : /WEB-INF/views/common 폴더 안에 result.jsp
			// 12-1. 경고메세지 출력 후 지정된 url로 페이지 이동
			mav.addObject("alertMsg", "해당 게시물에 접근할 권한이 없습니다.");
			mav.addObject("url", "freelist");
			mav.setViewName("common/result");
		}
		// 13. 데이터 처리가 완료된 모델(VO)값과 보여질 페이지(jsp)를 반환한다.
		return mav;
	}
	
	// ⑽ 게시글 삭제하기 
	// url : /board/freedelete - GET
	// parameter :
	// int fbNo : 삭제할 자유게시판 번호값 불러오기(url 쿼리)
	// String userId : 삭제할 아이디값 불러오기(url 쿼리)
	// HttpSession session - 로그인 세션정보(uno) : 게시글 작성자(fbuno)
	@RequestMapping(value="/freedelete", method = RequestMethod.GET)
	public ModelAndView freeDelete(
			int fbNo
			, String userId
			, HttpSession session) {
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
		//    (자유게시글 작성자와 세션정보가 같은지 파악)
		Map<String,Object> free = freeBoardService.selectFreeView(fbNo);
		
		// 7. 세션 회원아이디와 자유게시판 글 작성자의 회원아이디 값이 같을 경우
		if(sessionUser.getUserId().equals(((Map)free.get("detail")).get("USERID"))) {
			// 8. 파라미터값 Service에 전달 후 int 값 반환
			//    ( 성공 : 1, 실패 : 0 )
			res = freeBoardService.deleteFreeBoard(fbNo);
		} 
		
		// 9. 게시글 삭제 성공한다면,
		if(res > 0) {
			// 10. view페이지 : /WEB-INF/views/common 폴더 안에 result.jsp
			// 10-1. 경고메세지 출력 후 지정된 url로 페이지 이동
			mav.addObject("alertMsg", "게시물 삭제에 성공했습니다.");
			mav.addObject("url", "freelist");
			mav.setViewName("common/result");
		} else {
			// 11. view페이지 : /WEB-INF/views/common 폴더 안에 result.jsp
			// 11-1. 경고메세지 출력 후 지정된 url로 페이지 이동
			mav.addObject("alertMsg", "해당 게시물에 접근할 권한이 없습니다.");
			mav.addObject("url", "freelist");
			mav.setViewName("common/result");
		}
		// 12. 데이터 처리가 완료된 모델(VO)값과 보여질 페이지(jsp)를 반환한다.
		return mav;
	}
	
	// ⑾ 게시글 상세보기 페이지에서, 댓글 작성 Ajax로 처리
	// url : /board/freecommentwirteImpl - POST
	// parameter :
	// FreeComment freeComment - Ajax로 처리할 파라미터(name) 값(value)들을 FreeComment 객체에 저장
	// HttpSession session - 로그인 세션정보(uno) : 댓글 작성한 회원정보(fcuno)
	// int fbNo - 파라미터(name="fbNo") 값(value) 불러오기
	@RequestMapping(value="freecommentwriteImpl", method = RequestMethod.POST)
	@ResponseBody
	public int freeCommentWrite(
			FreeComment freeComment
			,HttpSession session
			, @RequestParam(value="fbNo", required = false) int fbNo
			) {
		// 1. 세션에 저장된 로그인 정보를 'User' VO에 저장
		User sessionUser = (User)session.getAttribute("logInInfo");
		// 2. FreeComment fcfbno에 request parameter의 fbno값 불러와서 지정하기
		freeComment.setFcFbNo(fbNo);
		
		//---------------자유게시판 번호 제대로 저장되었는지, 파라미터값 제대로 불러온지 확인하기 ----------
		System.out.println("[controller] freeComment : "+freeComment);
		//--------------------------------------------------------------------------------------------------
		
		// 3. 로그인을 안 했을 경우 
		// 	세션정보가 담긴 회원정보가 Null일때 ( User Null )
		//	= 빈 세션 일 때( HttpSession Null )
		if(sessionUser != null) {
			// 4. FreeComment fcuno에 세션의 uno값 불러와서 지정하기
			freeComment.setFcUNo(sessionUser.getuNo());
			// 4-1. 파라미터값 Service에 전달 후 int 값 반환
			//    ( 성공 : 1, 실패 : 0 )
			return freeBoardService.insertFreeComment(freeComment);
		} else {
			// 5. 실패할 경우 0 반환
			return 0;			
		}
	}
	
	// ⑿ 게시글 상세보기 페이지에서, 댓글 리스트 조회 Ajax로 처리
	// url : /board/getReplyList - POST
	// parameter :
	// int fbNo - 파라미터(name="fbNo") 값(value) 불러오기
	@ResponseBody
	@RequestMapping(value = "/getReplyList", method = RequestMethod.POST)
	public List<Map<String,Object>> getReplyList(
			@RequestParam("fbNo") int fbNo) {
		// 1. 파라미터값 Service에 전달 후 int 값 반환
		//    ( 성공 : 1, 실패 : 0 )
		return freeBoardService.selectFreeCommentList(fbNo);
	}
	
	// ⒀ 게시글 상세보기 페이지에서, 댓글 수정하기 Ajax로 처리
	// url : /board/updateReply - PUT
	// parameter :
	// RequestBody Map replyNo : 댓글번호, 댓글 내용 key-value 요청한 값 받기
	@RequestMapping(value="updateReply", method = RequestMethod.PUT)
	@ResponseBody
	public int updateReply(@RequestBody Map<String,Object> replyNo) {
		
		//-------------------RequestBody에서 요청한 값 제대로 받아왔는지 확인하기----------------------
		System.out.println("[controller] updateReply map : "+replyNo);
		System.out.println("[controller] updateReply fcno int: "+replyNo.get("replyNo"));
		System.out.println("[controller] updateReply fccontent string : "+replyNo.get("replyText"));
		//---------------------------------------------------------------------------------------------
		
		
		// 1. FreeComment fcNo에 Map에서 갖고온 Value(Object 타입)을 int형태로 바꾸기 
		int fcNo = Integer.parseInt((String) replyNo.get("replyNo"));
		// 2. FreeComment fcContent에 Map에서 갖고온 Value(Object 타입)을 String형태로 바꾸기
		String fcContent = (String) replyNo.get("replyText");
		// 3. FreeComment 빈 객체 생성
		FreeComment freeComment = new FreeComment();
		// 4. FreeComment에 fcNo, fcContent 값 지정
		freeComment.setFcNo(fcNo);
		freeComment.setFcContent(fcContent);
		// 5. 파라미터값 Service에 전달 후 int 값 반환
		//    ( 성공 : 1, 실패 : 0 )
		return freeBoardService.updateFreeContent(freeComment);
	}
	
	// ⒁ 게시글 상세보기 페이지에서, 댓글 삭제하기 Ajax로 처리
	// url : /board/deleteReply - PUT
	// parameter : 
	// RequestBody Map replyNo : 댓글번호, 댓글 내용 key-value 요청한 값 받기
	@RequestMapping(value="deleteReply", method = RequestMethod.PUT)
	@ResponseBody
	public int deleteReply(@RequestBody Map<String,Object> replyNo) {
		
		//-------------------RequestBody에서 요청한 값 제대로 받아왔는지 확인하기----------------------
		System.out.println("[controller] updateReply map : "+replyNo);
		System.out.println("[controller] updateReply fcno int: "+replyNo.get("replyNo"));
		System.out.println("[controller] updateReply fccontent string : "+replyNo.get("replyText"));
		//---------------------------------------------------------------------------------------------
		
		// 1. FreeComment fcNo에 Map에서 갖고온 Value(Object 타입)을 int형태로 바꾸기 
		int fcNo = Integer.parseInt((String) replyNo.get("replyNo"));
		// 2. FreeComment 빈 객체 생성
		FreeComment freeComment = new FreeComment();
		// 3. FreeComment에 fcNo, fcContent 값 지정
		freeComment.setFcNo(fcNo);
		// 4. 파라미터값 Service에 전달 후 int 값 반환
		//    ( 성공 : 1, 실패 : 0 )
		return freeBoardService.deleteFreeComment(freeComment);
	}





	
	

}
