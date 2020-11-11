package com.DongHang_ComeFunny.www.model.service.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.DongHang_ComeFunny.www.model.dao.board.ReviewBoardDao;
import com.DongHang_ComeFunny.www.model.vo.DoApply;
import com.DongHang_ComeFunny.www.model.vo.DoBoard;
import com.DongHang_ComeFunny.www.model.vo.GoApply;
import com.DongHang_ComeFunny.www.model.vo.GoBoard;
import com.DongHang_ComeFunny.www.model.vo.ReviewBoard;
import com.DongHang_ComeFunny.www.model.vo.ReviewComment;
import com.DongHang_ComeFunny.www.model.vo.ReviewDhTicket;
import com.DongHang_ComeFunny.www.model.vo.ReviewLike;
import com.DongHang_ComeFunny.www.model.vo.ReviewRecommend;
import com.DongHang_ComeFunny.www.model.vo.User;

import common.exception.FileException;
import common.util.FileUtil;
import common.util.Paging;

//bean으로 서비스 등록
@Service
public class ReviewBoardServiceImpl implements ReviewBoardService {
	// DAO 의존성 주입
	@Autowired
	private ReviewBoardDao reviewBoardDao;
	/**
	 * 게시글 작성(파일업로드 포함)
	 * @param review - 작성할 리뷰게시판 객체(rbuno, rbtitle, rbcontent, rbwrittendate)
	 * @param files - MultpartFile
	 * @param root - 서버에 업로드한 경로
	 * @return
	 * @throws FileException
	 */
	@Override
	public int insertReview(
			ReviewBoard review
			, List<MultipartFile> files
			, String root
			) throws FileException  {
		// 1. 제목없거나 내용이 없이 게시글을 올렸을 경우
		if(review.getRbTitle()==null || "".equals(review.getRbTitle()) ) {
			review.setRbTitle("<제목없음>");
		} 
		if(review.getRbContent()==null || "".equals(review.getRbContent()) ) {
			review.setRbContent("<내용없음>");
		}
		// 2. 파일업로드 없이 게시글 정보만 넣기
		int result = reviewBoardDao.insertReview(review);
		// 3. 파일 업로드를 위한 fileUtil 생성
		FileUtil fileUtil = new FileUtil();
		// 4. 파일을 업로드하도록 처리(Map에는 originFileName, storedFileName, savePath, fileSize 등이 저장되어 있음)
		List<Map<String, Object>> filedata = fileUtil.fileUpload(files, root);
		
		//-----------------업로드 된 원본이름---------------------------------
		System.out.println("listmap[1] : "+filedata.get(0).get("originFileName"));
		//--------------------------------------------------------------------
		
		// 5.원본 파일명이 없거나 이름이 없다면 반환
		if( filedata.get(0).get("originFileName") == null || "".equals(filedata.get(0).get("originFileName"))) {
			return result;
		}
		// 6.다중 파일을 처리함
		for(Map<String, Object> data : filedata) {
			//file 테이블에 파일과 관련된 정보를 저장
			reviewBoardDao.insertFile(data);
		}
		// 7.결과값 반환
		return result;
		
	}
	
	/**
	 * 게시글 리스트 조회(페이지네이션 포함), 게시글 검색 페이지 구현시 안 쓰임
	 * @param cPage - 현재페이지
	 * @param cntPerPage - 페이지당 게시글 갯수
	 * @return 페이징,리뷰게시글 테이블 조회
	 */
	@Override
	public Map<String, Object> selectReviewList(
			//현재 페이지
			int cPage 
			//페이지당 노출할 게시글 수
			, int cntPerPage) {
		// 1. 빈 커맨드맵 객체 생성
		Map<String, Object> commandMap = new HashMap<>();
		// 2. 페이징 객체 생성과 동시에 파라미터값(전체 게시글 개수, 현재페이지, 페이지당 게시글 개수) 넣기
		Paging page = new Paging(reviewBoardDao.selectContentCnt(), cPage, cntPerPage);
		// 3. 페이징 처리하여 게시글 리스트 조회
		List<Map<String, Object>> flist = reviewBoardDao.selectReviewList(page);
		// 4. 페이징 객체와 조회한 게시글 리스트를 커맨드맵에 넣기
		commandMap.put("flist", flist);
		commandMap.put("paging", page);
		// 5. 커맨드맵 반환
		return commandMap;
	}
	
	/**
	 * 게시글 리스트 조회(페이지네이션 포함), 게시글 검색 페이지 구현시 안 쓰임
	 * @param cPage - 현재페이지
	 * @param cntPerPage - 페이지당 게시글 갯수
	 * @return 페이징,리뷰게시글 테이블 조회
	 */
	@Override
	public Map<String, Object> selectReviewView(int rbNo) {
		// 1. 게시글 번호로 게시글 상세보기 조회(회원, 리뷰게시글 테이블)
		Map<String, Object> fdetail = reviewBoardDao.selectReviewDetail(rbNo);

		// ----------------------DAO에서 제대로 조회되었는지 확인하기-------------------
		System.out.println("[ServiceImpl] - fdetail Map : " + fdetail);
		// -----------------------------------------------------------------------------
		
		// 2. 게시글 상세보기 페이지로 이동시, 조회수 증가시키기
		if(fdetail != null) {
			reviewBoardDao.updateHit(fdetail);
		}
		// 3. 조회수 증가시킨 상세보기 조회(회원, 리뷰게시글 테이블)
		fdetail = reviewBoardDao.selectReviewDetail(rbNo);
		// 4. 리뷰게시글과 업로드된 파일 목록 리스트 조회(리뷰게시글, 리뷰파일)
		List<Map<String, Object>> filelist = reviewBoardDao.selectFileWithReview(rbNo);
		// 5. 빈 커맨드 객체 생성
		Map<String, Object> commandMap = new HashMap<>();
		// 6. 리뷰게시글 리스트와 파일리스트를 커맨드맵에 넣기
		commandMap.put("detail", fdetail);
		commandMap.put("filelist", filelist);
		// 7. 커맨드맵 반환
		return commandMap;
	}
	
	/**
	 * 게시글 상세보기 조회
	 * @param rbNo - 리뷰게시판 번호
	 * @return 회원, 리뷰게시판 테이블 조회
	 */
	@Override
	public int deleteReviewFile(int rfNo) {
		// 1. 파일 번호로 게시글 파일 목록 조회
		Map<String, String> fileData = reviewBoardDao.selectReviewFile(rfNo);
		// 2. 빈 파일유틸 객체 생성
		FileUtil fileUtil = new FileUtil();
		// 3. 파일 저장경로에 있는 파일 삭제 처리
		fileUtil.deleteFile(fileData.get(("RFSAVEPATH")));
		// 4. isdel 컬럼값 0 -> 1로 변경
//		int res = reviewBoardDao.updateFileIsDel(rfNo); // isdel 0을 1로 변경
		int res = reviewBoardDao.deleteFile(rfNo); // 완전삭제
		return res;
	}
	
	/**
	 * 게시글 업로드된 파일 삭제
	 * @param rfNo - 리뷰파일 번호
	 * @return 성공 : 1, 실패 : 0
	 */
	@Override
	public int updateReviewModify(
		ReviewBoard review
		, List<MultipartFile> files
		, String root
		) throws FileException  {
		// 1. 제목없거나 내용이 없이 게시글을 올렸을 경우
		if(review.getRbTitle()==null || "".equals(review.getRbTitle()) ) {
			review.setRbTitle("<제목없음>");
		} 
		if(review.getRbContent()==null || "".equals(review.getRbContent()) ) {
			review.setRbContent("<내용없음>");
		}
		// 2. 파일업로드 없이 게시글 정보만 넣기
		int result = reviewBoardDao.updateReview(review);
		// 3. 파일 업로드를 위한 fileUtil 생성
		FileUtil fileUtil = new FileUtil();
		// 4.  파일을 업로드하도록 처리(Map에는 originFileName, storedFileName, savePath, fileSize 등이 저장되어 있음)
		List<Map<String, Object>> filedata = fileUtil.fileUpload(files, root);
		//-----------------업로드 된 원본이름---------------------------------
		System.out.println("listmap[1] : "+filedata.get(0).get("originFileName"));
		System.out.println("listmap 전체 : " + filedata);
		//--------------------------------------------------------------------
		// 5.원본 파일명이 없거나 이름이 없다면 반환
		if( filedata.get(0).get("originFileName") == null || "".equals(filedata.get(0).get("originFileName"))) {
			return result;
		}
		// 6.다중 파일을 처리함
		for(Map<String, Object> data : filedata) {
			//file 테이블에 파일과 관련된 정보를 저장
			//rbno
			data.put("rbNo", review.getRbNo());
			//rbno, rforiginName, rfStroedName, rffileSize, rfsavePath
			System.out.println("data : "+data);
			reviewBoardDao.modifyReviewFile(data);
		}
		// 7.결과값 반환
		return result;
	}
	
	/**
	 * 게시글 삭제하기
	 * @param rbNo - 삭제할 게시글 번호
	 * @return 성공 : 1, 실패 : 0
	 */
	@Override
	public int deleteReviewBoard(int rbNo) {
		// 1. 게시글 번호로 해당 게시글에 업로드된 파일 삭제
//		reviewBoardDao.deleteReviewFileByRbno(rbNo);
		// 2. 게시글 번호로 해당 게시글 완전 삭제
		int res = reviewBoardDao.deleteReviewBoard(rbNo);
		// 성공 : 1, 실패 : 0
		return res;
	}

	/**
	 * 댓글 작성하기
	 * @param reviewComment - 댓글번호(rcno), 댓글내용(rccontent), 댓글 작성자(rcuno)가 담긴 객체 
	 * @return 성공 : 1, 실패 : 0
	 */
	@Override
	public int insertReviewComment(ReviewComment reviewComment) {
		// 1. 내용없으면 rcContent에 "<내용없음>" 넣기
		if(reviewComment.getRcContent()==null || "".equals(reviewComment.getRcContent()) ) {
			reviewComment.setRcContent("<내용없음>");
		}
		
		// --------------받아온 파라미터값 확인 : 리뷰게시판 댓글 제목, 내용--------------------
		System.out.println("[serviceimpl] ReviewComment : "+reviewComment);
		// -------------------------------------------------------------------------------------
		
		// 2. DB에 댓글 내용 입력하기
		int result = reviewBoardDao.insertReviewComment(reviewComment);
		
		// 3. 성공 : 1, 실패 : 0
		return result;
	}
	
	/**
	 * 댓글 리스트 조회하기
	 * @param rbNo - 댓글 리스트를 불러올 리뷰게시글 번호
	 * @return key-value쌍으로 리스트 출력 
	 */
	@Override
	public List<Map<String, Object>> selectReviewCommentList(int rbNo) {
		// 1. 게시글 번호로 댓글 리스트 조회
		List<Map<String, Object>> reviewComment = reviewBoardDao.selectReviewCommentList(rbNo);
		// 2. 조회된 리스트 반환
		return reviewComment;
	}
	
	/**
	 * 댓글 수정하기 
	 * @param reviewComment - 수정할 댓글번호, 댓글내용이 담긴 객체
	 * @return 성공 : 1, 실패 : 0
	 */
	@Override
	public int updateReviewContent(ReviewComment reviewComment) {
		// 1. 수정된 댓글 내용 DB에 반영
		return reviewBoardDao.updateReviewContent(reviewComment);
	}
	
	/**
	 * 댓글 삭제하기
	 * @param reviewComment - 삭제할 댓글번호, 댓글내용이 담긴 객체
	 * @return 성공 : 1, 실패 : 0
	 */
	@Override
	public int deleteReviewComment(ReviewComment reviewComment) {
		// 1. 댓글 삭제 시, isdel=0을 1로 변경
//		return reviewBoardDao.updateReviewCommentIsDEl(reviewComment);
		// 2. 댓글 완전 삭제
		return reviewBoardDao.deleteReviewComment(reviewComment);
	}
	
	/**
	 * 검색된 게시글 리스트 페이징 처리
	 * @param cPage - 현재 페이지
	 * @param cntPerPage - 페이지당 조회될 게시글 개수
	 * @param searchReviewList - 검색 카테고리, 키워드가 담긴 객체
	 * @return
	 */
	@Override
	public Map<String, Object> selectReviewSearchList(int cPage, int cntPerPage, Map<String, Object> searchReviewList) {
		// 1. 빈 커맨드 객체 생성
		Map<String,Object> commandMap = new HashMap<String, Object>();
		// 2. 페이징 객체 생성과 동시에 파라미터값(전체 검색된 게시글 개수, 현재페이지, 페이지당 게시글 개수) 넣기
		Paging page = new Paging(reviewBoardDao.selectReviewSearchCnt(searchReviewList), cPage, cntPerPage);
		// 검색된 카테고리 또는 키워드가 null이 아닌 경우,
		if(searchReviewList != null) {
			// 3. 빈 searchMap 객체 생성
			Map<String, Object> searchMap = new HashMap<>();
			// 4. 페이징 넣기
			searchMap.put("paging", page);
			searchMap.putAll(searchReviewList);
			
			// ------검색된 페이징 객체와 검색 카테고리, 키워드가 담긴 Map-------
			System.out.println("[ServiceImpl] selectReviewSearchList searchMap - "+searchMap);
			// ------------------------------------------------------------------
			
			// 5. 키워드로 검색된 게시글 리스트 조회
			List<Map<String,Object>> flist = reviewBoardDao.selectReviewSearchList(searchMap) ;
			// ------검색된 카테고리와 키워드로 조회된 게시글 리스트 -------
			System.out.println("[ServiceImpl] selectReviewSearchList flist - "+flist);
			commandMap.put("flist",flist);
			commandMap.put("paging",page);
			
			// ------------- 검색된 페이징 객체와 검색된 게시글 리스트가 담긴 commandMap-----------
			System.out.println("[ServiceImpl] selectReviewSearchList commandMap" + commandMap);
			// ------------------------------------------------------------------------------------
			
		} else {
			// 6. 키워드 없을 경우 전체 게시글 리스트 조회
			Paging searchPage = new Paging(reviewBoardDao.selectContentCnt(), cPage, cntPerPage);
			List<Map<String, Object>> flist = reviewBoardDao.selectReviewList(page);
			commandMap.put("flist", flist);
			commandMap.put("paging", searchPage);
		}
		// 7. 결과값 반환
		return commandMap;
	}
	
	
	/**
	 * 검색된 동행 게시글 리스트 페이징 처리
	 * @param cPage - 현재 페이지
	 * @param cntPerPage - 페이지당 조회될 게시글 개수
	 * @param searchDongHangList - 검색 카테고리, 키워드가 담긴 객체
	 * @return
	 */
	@Override
	public Map<String, Object> selectDongHangSearchList(int cPage, int cntPerPage,
			Map<String, Object> searchDongHangList, User sessionUser) {
		// 1. 빈 커맨드 객체 생성
		Map<String,Object> commandMap = new HashMap<String, Object>();
		// 2. 페이징 객체 생성과 동시에 파라미터값(전체 검색된 게시글 개수, 현재페이지, 페이지당 게시글 개수) 넣기
		Paging page = new Paging(reviewBoardDao.selectDongHangSearchCnt(searchDongHangList), cPage, cntPerPage);
		// 검색된 카테고리 또는 키워드가 null이 아닌 경우,
		if(searchDongHangList != null) {
			// 3. 빈 searchMap 객체 생성
			Map<String, Object> searchMap = new HashMap<>();
			// 4. 페이징 넣기
			searchMap.put("paging", page);
			searchMap.putAll(searchDongHangList);
			
			// ------검색된 페이징 객체와 검색 카테고리, 키워드가 담긴 Map-------
			System.out.println("[ServiceImpl] selectDongHangSearchList searchMap - "+searchMap);
			// ------------------------------------------------------------------
			
			// 5. 키워드로 검색된 게시글 리스트 조회
			List<Map<String,Object>> flist = reviewBoardDao.selectDongHangSearchList(searchMap) ;
			// ------검색된 카테고리와 키워드로 조회된 게시글 리스트 -------
			System.out.println("[ServiceImpl] selectDongHangSearchList flist - "+flist);
			commandMap.put("flist",flist);
			commandMap.put("paging",page);
			
			// ------------- 검색된 페이징 객체와 검색된 게시글 리스트가 담긴 commandMap-----------
			System.out.println("[ServiceImpl] selectDongHangSearchList commandMap" + commandMap);
			// ------------------------------------------------------------------------------------
			
		} else {
			// 6. 키워드 없을 경우 전체 게시글 리스트 조회
			Paging searchPage = new Paging(reviewBoardDao.selectDongHangContentCnt(), cPage, cntPerPage);
			Map<String, Object> userno = new HashMap<>();
			userno.put("paging", searchPage);
			userno.put("uNo", sessionUser.getuNo());
			List<Map<String, Object>> flist = reviewBoardDao.selectDongHangList(userno);
			commandMap.put("flist", flist);
			commandMap.put("paging", searchPage);
		}
		// 7. 결과값 반환
		return commandMap;
	}
	
	/**
	 * 함께가요, 함께해요 게시글에서 별점 평균 및 별점 개수 수정
	 * @param donghangMap - 파라미터로 받아온 기본키가 담긴 함께가요, 함께해요 맵(gbNo, gbTitle, gbCategory, rbDhStar, rbHostStar)
	 * @return - 성공 : 1, 실패 : 0
	 */
	@Override
	public int updateDhStar(Map<String, Object> donghangMap, ReviewBoard review) {
		// -----------------------파라미터 값 제대로 받아오는지 확인--------------
		System.out.println("[ServiceImpl] updateDhStar donghangMap : " + donghangMap);
		System.out.println("[ServiceImpl] updateDhStar donghangMap(gbNo) : " + donghangMap.get("gbNo"));
		System.out.println("[ServiceImpl] updateDhStar donghangMap(gbCategory) : " + donghangMap.get("gbCategory"));
		System.out.println("[ServiceImpl] updateDhStar donghangMap(rbDhStar) : " + donghangMap.get("rbDhStar"));
		System.out.println("[ServiceImpl] updateDhStar donghangMap(rbHostStar) : " + donghangMap.get("rbHostStar"));
		// -----------------------------------------------------------------------

		// 1. 결과값 넣을 빈 int 값 생성
		int result = 0;
		int gbNo = Integer.parseInt(donghangMap.get("gbNo").toString());
		
//		int rbNo = reviewBoardDao.selectReviewNo(review.getRbUNo());
		
		
		if(donghangMap.get("gbCategory").equals("함께가요")) {
			Map<String,Object> reviewStarGo = reviewBoardDao.selectReviewGbAvg(gbNo);
			reviewStarGo.put("gbNo",gbNo);
			result = reviewBoardDao.updateGoAvg(reviewStarGo);
		} else if(donghangMap.get("gbCategory").equals("함께해요")) {
			Map<String,Object> reviewStarDo = reviewBoardDao.selectReviewDbAvg(gbNo);
			reviewStarDo.put("gbNo",gbNo);
			result = reviewBoardDao.updateDoAvg(reviewStarDo);
		}
		// 성공 : 1, 실패 : 0
		return result;
	}
	
	/**
	 * 함께가요 게시글 조회
	 * @param rbGbNo - 조회할 게시글 번호
	 * @return GoBoard - 조회된 게시글
	 */
	@Override
	public Map<String, Object> selectGoBoardView(int rbGbNo) {
		return reviewBoardDao.selectGoBoardView(rbGbNo);
	}

	/**
	 * 함께해요 게시글 조회
	 * @param rbGbNo - 조회할 게시글 번호
	 * @return DoBoard - 조회된 게시글
	 */
	@Override
	public Map<String, Object> selectDoBoardView(int rbDbNo) {
		return reviewBoardDao.selectDoBoardView(rbDbNo);
	}
	
	@Override
	public int updateDhStarInModify(Map<String, Object> donghangMap, ReviewBoard review) {
		

		// 1. 결과값 넣을 빈 int 값 생성
		int result = 0;
		int gbNo = Integer.parseInt(donghangMap.get("gbNo").toString());
		System.out.println("여기gbno는"+gbNo);
		int beforeGbNo = Integer.parseInt(donghangMap.get("beforeGbNo").toString());
//		
		System.out.println("여기beforeGbNo는"+beforeGbNo);
//		int rbNo = review.getRbNo();
		
//		Map<String,Object> reviewStarAfter = reviewBoardDao.selectReviewAvg(rbNo);
//		reviewStarAfter.put("gbNo", gbNo);
//		
//		Map<String,Object> reviewStarBefore = reviewBoardDao.selectReviewAvg(rbNo);
//		reviewStarBefore.put("gbNo", beforeGbNo);
		
		
		if(donghangMap.get("beforeGbCategory").equals("함께가요")) {
			if(donghangMap.get("gbCategory").equals("함께가요")) {
				Map<String,Object> reviewStarGoBefore = reviewBoardDao.selectReviewGbAvg(beforeGbNo);
				if(reviewStarGoBefore != null) {
					reviewStarGoBefore.put("gbNo",beforeGbNo);
					result = reviewBoardDao.updateGoAvg(reviewStarGoBefore);
				} else {
					Map<String,Object> reviewZero = new HashMap<>();
					reviewZero.put("RBDHSTARAVG",0);
					reviewZero.put("RBHOSTSTARAVG",0);
					reviewZero.put("gbNo",beforeGbNo);
					result = reviewBoardDao.updateGoAvgByZero(reviewZero);
				}
				
				Map<String,Object> reviewStarGo = reviewBoardDao.selectReviewGbAvg(gbNo);
				reviewStarGo.put("gbNo",gbNo);
				result = reviewBoardDao.updateGoAvg(reviewStarGo);
			} else if(donghangMap.get("gbCategory").equals("함께해요")) {
				Map<String,Object> reviewStarGoBefore = reviewBoardDao.selectReviewGbAvg(beforeGbNo);
				if(reviewStarGoBefore != null) {
					reviewStarGoBefore.put("gbNo",beforeGbNo);
					result = reviewBoardDao.updateGoAvgByZero(reviewStarGoBefore);
				} else {
					Map<String,Object> reviewZero = new HashMap<>();
					reviewZero.put("RBDHSTARAVG",0);
					reviewZero.put("RBHOSTSTARAVG",0);
					reviewZero.put("gbNo",beforeGbNo);
					result = reviewBoardDao.updateGoAvgByZero(reviewZero);
				}
				
				Map<String,Object> reviewStarDo = reviewBoardDao.selectReviewDbAvg(gbNo);
				reviewStarDo.put("gbNo",gbNo);
				result = reviewBoardDao.updateDoAvg(reviewStarDo);
			}
		} else if(donghangMap.get("beforeGbCategory").equals("함께해요")){
			if(donghangMap.get("gbCategory").equals("함께가요")) {
				Map<String,Object> reviewStarDoBefore = reviewBoardDao.selectReviewDbAvg(beforeGbNo);
				if(reviewStarDoBefore != null) {
					reviewStarDoBefore.put("gbNo",beforeGbNo);
					result = reviewBoardDao.updateDoAvg(reviewStarDoBefore);
				} else {
					Map<String,Object> reviewZero = new HashMap<>();
					reviewZero.put("RBDHSTARAVG",0);
					reviewZero.put("RBHOSTSTARAVG",0);
					reviewZero.put("gbNo",beforeGbNo);
					result = reviewBoardDao.updateDoAvgByZero(reviewZero);
				}
				
				Map<String,Object> reviewStarGo = reviewBoardDao.selectReviewGbAvg(gbNo);
				reviewStarGo.put("gbNo",gbNo);
				result = reviewBoardDao.updateGoAvg(reviewStarGo);
			} else if(donghangMap.get("gbCategory").equals("함께해요")) {
				Map<String,Object> reviewStarDoBefore = reviewBoardDao.selectReviewDbAvg(beforeGbNo);
				if(reviewStarDoBefore != null) {
					reviewStarDoBefore.put("gbNo",beforeGbNo);
					result = reviewBoardDao.updateDoAvg(reviewStarDoBefore);
				} else {
					Map<String,Object> reviewZero = new HashMap<>();
					reviewZero.put("RBDHSTARAVG",0);
					reviewZero.put("RBHOSTSTARAVG",0);
					reviewZero.put("gbNo",beforeGbNo);
					result = reviewBoardDao.updateDoAvgByZero(reviewZero);
				}
				
				Map<String,Object> reviewStarDoAfter = reviewBoardDao.selectReviewDbAvg(gbNo);
				reviewStarDoAfter.put("gbNo",gbNo);
				result = reviewBoardDao.updateDoAvg(reviewStarDoAfter);
			}
		}
		return result;
	}

	@Override
	public int insertReviewBoardLike(ReviewLike reviewlike) {
		int result = reviewBoardDao.insertReviewLike(reviewlike);
		result = reviewBoardDao.updateReviewBoardLikeCnt(reviewlike.getRlRbNo());
		return result;
	}
	
	@Override
	public int deleteReviewBoardLike(ReviewLike reviewlike) {
		int result = reviewBoardDao.deleteReviewLike(reviewlike);
		result = reviewBoardDao.updateReviewBoardLikeCnt(reviewlike.getRlRbNo());
		return result;
	}
	
	@Override
	public int getBoardLike(ReviewLike reviewlike) {
		return reviewBoardDao.getBoardLike(reviewlike);
	}
	
	@Override
	public int insertReviewBoardRec(ReviewRecommend reviewrecommend) {
		int result = reviewBoardDao.insertReviewRec(reviewrecommend);
		result = reviewBoardDao.updateReviewBoardRecCnt(reviewrecommend.getRrcRbNo());
		return result;
	}
	
	@Override
	public int deleteReviewBoardRec(ReviewRecommend reviewrecommend) {
		int result = reviewBoardDao.deleteReviewRec(reviewrecommend);
		result = reviewBoardDao.updateReviewBoardRecCnt(reviewrecommend.getRrcRbNo());
		return result;
	}
	
	@Override
	public int getBoardRec(ReviewRecommend reviewrecommend) {
		return reviewBoardDao.getBoardRec(reviewrecommend);
	}
	
	@Override
	public int selectDHApplyList(int getuNo) {
		return reviewBoardDao.selectDHApplyList(getuNo);
	}
	
	@Override
	public int updateDhStarBydelete(Map<String, Object> donghangMap, int rbNo) {
		// 1. 결과값 넣을 빈 int 값 생성
		int result = 0;
		int gbNo = Integer.parseInt(donghangMap.get("gbNo").toString());
		
//		int rbNo = reviewBoardDao.selectReviewNo(review.getRbUNo());
		
		
		if(donghangMap.get("gbCategory").equals("함께가요")) {
			int cntgb = reviewBoardDao.selectReviewBoardByRbGbNo(gbNo);
			if( cntgb > 0) {
				Map<String,Object> reviewStarGo = reviewBoardDao.selectReviewGbAvg(gbNo);
				reviewStarGo.put("gbNo",gbNo);
				result = reviewBoardDao.updateGoAvgByZero(reviewStarGo);
				return result;
			} else {
				Map<String,Object> reviewZero = new HashMap<>();
				reviewZero.put("RBDHSTARAVG",0);
				reviewZero.put("RBHOSTSTARAVG",0);
				reviewZero.put("gbNo",gbNo);
				
				result = reviewBoardDao.updateGoAvgByZero(reviewZero);
				return result;
			}
		} else if(donghangMap.get("gbCategory").equals("함께해요")) {
			int cntdb = reviewBoardDao.selectReviewBoardByRbDbNo(gbNo);
			if( cntdb > 0 ) {
				Map<String,Object> reviewStarDo = reviewBoardDao.selectReviewDbAvg(gbNo);
				reviewStarDo.put("gbNo",gbNo);
				result = reviewBoardDao.updateDoAvgByZero(reviewStarDo);
				return result;
			} else {
				Map<String,Object> reviewZero = new HashMap<>();
				reviewZero.put("RBDHSTARAVG",0);
				reviewZero.put("RBHOSTSTARAVG",0);
				reviewZero.put("gbNo",gbNo);
				result = reviewBoardDao.updateDoAvgByZero(reviewZero);
				return result;
			}
		}
		// 성공 : 1, 실패 : 0
		return result;
	}
	
	@Override
	public int updateDhtCnt(User sessionUser, ReviewDhTicket reviewDhTicket) {
		// 빈 int 생성
		int result = 0;
		// 후기 동행복권 사용여부 확인( 0 : 사용x 1: 사용 )
		int selectres = reviewBoardDao.selectReviewDhtCnt(reviewDhTicket);
		// 본인 글 읽는지 확인
		Map<String, Object> fdetail = reviewBoardDao.selectReviewDetail(reviewDhTicket.getDhtRbNo());
		int rbuno = Integer.parseInt(fdetail.get("RBUNO").toString());
		
		// 본인글이 맞다면 동행복권 개수 그대로
		if(sessionUser.getuNo() == rbuno) {
			System.out.println("updateDhtCnt result : " + result);
			result = 2;
			return result;
		}
		int rbGbNo = Integer.parseInt(fdetail.get("RBGBNO").toString());
		int rbDbNo = Integer.parseInt(fdetail.get("RBDBNO").toString());
		//참여한 파티원이 작성한 경우 동행복권 개수 그대로
		if(rbGbNo != 0) {
//			System.out.println("함께가요 게시판입니다.");
			//빈 GoBoard
			GoBoard goBoard = new GoBoard();
			goBoard.setGbUNo(sessionUser.getuNo());
			goBoard.setGbNo(rbGbNo);
			//빈 GoApply
			GoApply goApply = new GoApply();
			goApply.setGaUNo(sessionUser.getuNo());
			goApply.setGaGbNo(rbGbNo);
			//파티장일 경우
			int goCnt = reviewBoardDao.selectGoCnt(goBoard);
			//파티원일 경우
			int gaCnt = reviewBoardDao.selectGaCnt(goApply);
			if(goCnt == 0 || gaCnt == 0 ) {
				result = 3;
				return result;
			}
		} else if(rbDbNo != 0) {
//			System.out.println("함께해요 게시판입니다.");
			// 빈 DoBoard
			DoBoard doBoard = new DoBoard();
			doBoard.setDbUNo(sessionUser.getuNo());
			doBoard.setDbNo(rbDbNo);
			// 빈 DoApply
			DoApply doApply = new DoApply();
			doApply.setDaUNo(sessionUser.getuNo());
			doApply.setDaDbNo(rbDbNo);
			//파티장일 경우
			int doCnt = reviewBoardDao.selectDoCnt(doBoard);
			//파티원일 경우
			int daCnt = reviewBoardDao.selectDaCnt(doApply);
			if(doCnt == 0 || daCnt == 0 ) {
				result = 3;
				return result;
			}
		}
		
		// 회원의 동행복권 개수가 0일때 
		if( sessionUser.getuDhtCnt() == 0) {
			return result;
		}
		
		if( selectres == 0 && sessionUser.getuDhtCnt() > 0) {
			// 동행복권 개수  -1 시키기
			reviewBoardDao.updateDhtCnt(sessionUser);
			
			// 후기 동행복권 테이블에 사용내역 추가하기
			int insertres = reviewBoardDao.insertReviewDht(reviewDhTicket);
			result = insertres;
			return result;
		}
		
		return result;
		
	}
	
	
	@Override
	public Map<String,Object> selectDhTicket(User sessionUser) {
		// 1. 빈 커맨드맵 객체 생성
		Map<String, Object> commandMap = new HashMap<>();
		// 2. 사용한 resultTicket 조회
		List<ReviewDhTicket> tlist = reviewBoardDao.selectReivewDht(sessionUser);
		// 3. 페이징 객체와 조회한 게시글 리스트를 커맨드맵에 넣기
		commandMap.put("tlist", tlist);
		return commandMap;
	}
}
