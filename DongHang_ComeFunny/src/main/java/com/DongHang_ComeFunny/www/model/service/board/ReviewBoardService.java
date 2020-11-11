package com.DongHang_ComeFunny.www.model.service.board;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.DongHang_ComeFunny.www.model.vo.ReviewBoard;
import com.DongHang_ComeFunny.www.model.vo.ReviewComment;
import com.DongHang_ComeFunny.www.model.vo.ReviewDhTicket;
import com.DongHang_ComeFunny.www.model.vo.ReviewLike;
import com.DongHang_ComeFunny.www.model.vo.ReviewRecommend;
import com.DongHang_ComeFunny.www.model.vo.User;

import common.exception.FileException;

public interface ReviewBoardService {
	
	/**
	 * 게시글 작성(파일업로드 포함)
	 * @param review - 작성할 리뷰게시판 객체(rbuno, rbtitle, rbcontent, rbwrittendate)
	 * @param files - MultpartFile
	 * @param root - 서버에 업로드한 경로
	 * @return
	 * @throws FileException
	 */
	public int insertReview(
			//Controller가 보내준
			//사용자가 등록한 파일 정보를 가지고 있는 리스트
			ReviewBoard review
			, List<MultipartFile> files
			, String root
			) throws FileException;
	
	/**
	 * 게시글 리스트 조회(페이지네이션 포함), 게시글 검색 페이지 구현시 안 쓰임
	 * @param cPage - 현재페이지
	 * @param cntPerPage - 페이지당 게시글 갯수
	 * @return 페이징,리뷰게시글 테이블 조회
	 */
	public Map<String, Object> selectReviewList(int cPage, int cntPerPage);
	
	/**
	 * 게시글 상세보기 조회
	 * @param rbNo - 리뷰게시판 번호
	 * @return 회원, 리뷰게시판 테이블 조회
	 */
	public Map<String, Object> selectReviewView(int rbNo);

	/**
	 * 게시글 업로드된 파일 삭제
	 * @param rfNo - 리뷰파일 번호
	 * @return 성공 : 1, 실패 : 0
	 */
	public int deleteReviewFile(int rfNo);

	/**
	 * 게시글 수정하기
	 * @param reviewboard - 리뷰게시글 객체
	 * @param files - orginalFileName, fileSize 값이 담긴 MultipartFile
	 * @param root - 업로드할 파일경로
	 * @return 성공 : 1, 실패 : 0
	 * @throws FileException - ExceptionCotroller에 의해 파일업로드 실패시 에러메시지 출력
	 */
	public int updateReviewModify(ReviewBoard reviewboard, List<MultipartFile> files, String root) throws FileException;

	/**
	 * 게시글 삭제하기
	 * @param rbNo - 삭제할 게시글 번호
	 * @return 성공 : 1, 실패 : 0
	 */
	public int deleteReviewBoard(int rbNo);

	/**
	 * 댓글 작성하기
	 * @param reviewComment - 댓글번호(rcno), 댓글내용(rccontent), 댓글 작성자(rcuno)가 담긴 객체 
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertReviewComment(ReviewComment reviewComment);
	
	/**
	 * 댓글 리스트 조회하기
	 * @param rbNo - 댓글 리스트를 불러올 리뷰게시글 번호
	 * @return key-value쌍으로 리스트 출력 
	 */
	public List<Map<String, Object>> selectReviewCommentList(int rbNo);

	/**
	 * 댓글 수정하기 
	 * @param reviewComment - 수정할 댓글번호, 댓글내용이 담긴 객체
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updateReviewContent(ReviewComment reviewComment);

	/**
	 * 댓글 삭제하기
	 * @param reviewComment - 삭제할 댓글번호, 댓글내용이 담긴 객체
	 * @return 성공 : 1, 실패 : 0
	 */
	public int deleteReviewComment(ReviewComment reviewComment);

	/**
	 * 검색된 게시글 리스트 페이징 처리
	 * @param cPage - 현재 페이지
	 * @param cntPerPage - 페이지당 조회될 게시글 개수
	 * @param searchReviewList - 검색 카테고리, 키워드가 담긴 객체
	 * @return
	 */
	public Map<String, Object> selectReviewSearchList(int cPage, int cntPerPage, Map<String, Object> searchReviewList);

	/**
	 * 검색된 동행 게시글 리스트 페이징 처리
	 * @param cPage - 현재 페이지
	 * @param cntPerPage - 페이지당 조회될 게시글 개수
	 * @param searchDongHangList - 검색 카테고리, 키워드가 담긴 객체
	 * @param sessionUser 
	 * @return
	 */
	public Map<String, Object> selectDongHangSearchList(int cPage, int cntPerPage,
			Map<String, Object> searchDongHangList, User sessionUser);

	/**
	 * 함께가요, 함께해요 게시글에서 별점 평균 및 별점 개수 수정
	 * @param donghangMap - 파라미터로 받아온 기본키가 담긴 함께가요, 함께해요 맵(gbNo, gbTitle, gbCategory, rbDhStar, rbHostStar)
	 * @return - 성공 : 1, 실패 : 0
	 */
	public int updateDhStar(Map<String, Object> donghangMap, ReviewBoard review);
	
	/**
	 * 함께가요 게시글 조회
	 * @param rbGbNo - 조회할 게시글 번호
	 * @return GoBoard - 조회된 게시글
	 */
	public Map<String, Object> selectGoBoardView(int rbGbNo);

	/**
	 * 함께해요 게시글 조회
	 * @param rbGbNo - 조회할 게시글 번호
	 * @return DoBoard - 조회된 게시글
	 */
	public Map<String, Object> selectDoBoardView(int rbDbNo);

	public int updateDhStarInModify(Map<String, Object> donghangMap, ReviewBoard review);

	public int insertReviewBoardLike(ReviewLike reviewlike);

	public int deleteReviewBoardLike(ReviewLike reviewlike);

	public int getBoardLike(ReviewLike reviewlike);

	public int deleteReviewBoardRec(ReviewRecommend reviewrecommend);

	public int insertReviewBoardRec(ReviewRecommend reviewrecommend);
	
	public int getBoardRec(ReviewRecommend reviewrecommend);

	public int selectDHApplyList(int getuNo);

	public int updateDhStarBydelete(Map<String, Object> donghangMap, int rbNo);

	public int updateDhtCnt(User sessionUser, ReviewDhTicket reviewDhTicket);

	public Map<String, Object> selectDhTicket(User sessionUser);






	
	
}
