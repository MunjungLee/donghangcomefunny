package com.DongHang_ComeFunny.www.model.dao.board;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

import common.util.Paging;



@Repository
public class ReviewBoardDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	/**
	 * 게시글 작성하기
	 * @param review - 게시글 제목, 내용, 회원번호가 들어간 후기게시글 객체
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertReview(ReviewBoard review) {
		return sqlSession.insert("REVIEW.insertReview", review);
	}
	
	/**
	 * tb_reviewfile에 게시글 파일정보 넣기  
	 * @param map
	 * @return
	 */
	public int insertFile(Map<String, Object> map) {
		return sqlSession.insert("REVIEW.insertFile", map);
	}
	
	/**
	 * 전체 게시글 개수 구하기
	 * @return 성공 : 1, 실패 : 0
	 */
	public int selectContentCnt() {
		return sqlSession.selectOne("REVIEW.selectContentCnt");
	}

	/**
	 * 페이징을 포함하여 게시글 리스트 조회
	 * @param page - 페이징 객체
	 * @return 리스트로 반환
	 */
	public List<Map<String, Object>> selectReviewList(Paging page) {
		return sqlSession.selectList("REVIEW.selectReviewList", page);
	}

	/**
	 * 게시글 상세보기 - 회원, 후기게시판 조인
	 * @param rbNo - 후기게시글 번호
	 * @return 맵 형태로 key-value쌍으로 반환
	 */
	public Map<String, Object> selectReviewDetail(int rbNo) {
		return sqlSession.selectOne("REVIEW.selectReviewDetail", rbNo);
	}

	/**
	 * 게시글 상세보기 - 후기게시판, 후기파일 조인
	 * @param rbNo - 후기게시글 번호
	 * @return 리스트로 반환
	 */
	public List<Map<String, Object>> selectFileWithReview(int rbNo) {
		return sqlSession.selectList("REVIEW.selectFileWithReview", rbNo);
	}

	/**
	 * 게시글 조회수 올리기
	 * @param fdetail - 게시글 번호가 담긴 맵
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updateHit(Map<String, Object> fdetail) {
		return sqlSession.update("REVIEW.updateHit",fdetail);
	}

	/**
	 * 게시글 파일정보 조회
	 * @param rfNo - 파일번호
	 * @return 조회된 파일 정보 반환
	 */
	public Map<String, String> selectReviewFile(int rfNo) {
		return sqlSession.selectOne("REVIEW.selectReviewFile",rfNo);
	}

	/**
//	 * 게시글 파일 삭제(isDel = 0 -> 1)
//	 * @param rfNo - 파일 번호
//	 * @return 성공 : 1, 실패 : 0
//	 */
//	public int updateFileIsDel(int rfNo) {
//		return sqlSession.update("REVIEW.updateFileIsDel", rfNo);
//	}
	/**
	 * 게시글 파일 완전 삭제
	 * @param rfNo - 파일 번호
	 * @return 성공 : 1, 실패 : 0
	 */
	public int deleteFile(int rfNo) {
		return sqlSession.delete("REVIEW.deleteFile", rfNo);
	}

	/**
	 * 게시글 정보 수정
	 * @param review - 수정할 내용이 저장된 후기게시판
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updateReview(ReviewBoard review) {
		return sqlSession.update("REVIEW.updateReview",review);
	}
	
	/**
	 * 게시판 수정페이지에서 새로운 파일 등록하기
	 * @param data - 파일정보가 단긴 Map
	 * @return 성공 : 1, 실패 : 0
	 */
	public int modifyReviewFile(Map<String, Object> data) {
		return sqlSession.insert("REVIEW.modifyReviewFile",data);
	}

	/**
	 * 게시판 파일 삭제하기(isDel = 0 -> 1)
	 * @param rbNo - 게시판 번호로 파일 삭제
	 * @return 성공 : 1, 실패 : 0
	 */
//	public int deleteReviewFileByRbno(int rbNo) {
//		return sqlSession.update("REVIEW.updateFileIsDelByRbno", rbNo);
//	}

	/**
	 * 게시판 게시글 삭제하기(isdel = 1)
	 * @param rbNo - 게시판 번호로 게시글 삭제
	 * @return 성공 : 1, 실패 : 0
	 */
//	public int deleteReviewBoard(int rbNo) {
//		return sqlSession.update("REVIEW.updateReviewBoardIsDel", rbNo);
//	}
//	/**
//	 * 게시판 게시글 삭제하기(완전삭제)
//	 * @param rbNo - 게시판 번호로 게시글 삭제
//	 * @return 성공 : 1, 실패 : 0
//	 */
	public int deleteReviewBoard(int rbNo) {
		return sqlSession.delete("REVIEW.deleteReviewBoard", rbNo);
	}

	/**
	 * 게시판 댓글 등록
	 * @param reviewComment - 등록할 댓글 정보가 담긴 객체
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertReviewComment(ReviewComment reviewComment) {
		return sqlSession.insert("REVIEW.insertReviewComment", reviewComment);
	}
	
	/**
	 * 게시판 댓글 리스트 조회
	 * @param rbNo - 댓글 리스트를 조회할 게시글 번호
	 * @return 리스트로 반환
	 */
	public List<Map<String, Object>> selectReviewCommentList(int rbNo) {
		return sqlSession.selectList("REVIEW.selectReviewWithCommentList", rbNo);
	}
	
	/**
	 * 게시판 댓글 내용 수정
	 * @param ReviewComment - 수정된 댓글 정보가 담긴 객체
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updateReviewContent(ReviewComment reviewComment) {
		return sqlSession.update("REVIEW.updateReviewContent",reviewComment);
	}

	/**
	 * 게시판 댓글 내용 삭제(isDel = 0 -> 1 )
	 * @param reviewComment
	 * @return 성공 : 1, 실패 : 0
	 */
//	public int updateReviewCommentIsDEl(ReviewComment reviewComment) {
//		return sqlSession.update("REVIEW.updateReviewCommentIsDEl",reviewComment);
//	}
	/**
	 * 게시판 댓글 내용 완전 삭제
	 * @param reviewComment
	 * @return 성공 : 1, 실패 : 0
	 */
	public int deleteReviewComment(ReviewComment reviewComment) {
		return sqlSession.delete("REVIEW.deleteReviewComment",reviewComment);
	}

	/**
	 * 검색된 게시글 전체 개수
	 * @param searchReviewList - 검색 카테고리와 키워드가 담긴 맵
	 * @return 성공 : 1, 실패 : 0
	 */
	public int selectReviewSearchCnt(Map<String, Object> searchReviewList) {
		return sqlSession.selectOne("REVIEW.selectReviewSearchCnt", searchReviewList);
	}

	/**
	 * 검색된 게시글 전체 리스트 조회
	 * @param searchMap - 검색 카테고리와 키워드, 페이징 객체가 담긴 맵
	 * @return 리스트로 반환
	 */
	public List<Map<String, Object>> selectReviewSearchList(Map<String, Object> searchMap) {
		return sqlSession.selectList("REVIEW.selectReviewSearchList", searchMap);
	}

	/**
	 * 검색된 동행 게시글 전체 개수
	 * @param searchDongHangList - 검색 카테고리와 키워드가 담긴 맵
	 * @return 성공 : 1, 실패 : 0
	 */
	public int selectDongHangSearchCnt(Map<String, Object> searchDongHangList) {
		return sqlSession.selectOne("REVIEW.selectDongHangSearchCnt", searchDongHangList);
	}

	/**
	 * 검색된 동해 게시글 전체 리스트 조회
	 * @param searchMap - 검색 카테고리와 키워드, 페이징 객체가 담긴 맵
	 * @return 리스트로 반환
	 */
	public List<Map<String, Object>> selectDongHangSearchList(Map<String, Object> searchMap) {
		return sqlSession.selectList("REVIEW.selectDongHangSearchList", searchMap);
	}

	
	/**
	 * 동행 전체 게시글 개수 구하기
	 * @return 성공 : 1, 실패 : 0
	 */
	public int selectDongHangContentCnt() {
		return sqlSession.selectOne("REVIEW.selectDongHangContentCnt");
	}

	/**
	 * 페이징을 포함하여 동행게시글 리스트 조회
	 * @param userno - 페이징 객체
	 * @return 리스트로 반환
	 */
	public List<Map<String, Object>> selectDongHangList(Map<String, Object> userno) {
		return sqlSession.selectList("REVIEW.selectDongHangList", userno);
	}
	public int updateGoBoardStarCnt(Map<String, Object> donghangMap) {
		return sqlSession.update("REVIEW.updateGoBoardStarCnt", donghangMap);
	}

	public int selectGoBoardStarCnt(Map<String, Object> donghangMap) {
		return sqlSession.selectOne("REVIEW.selectGoBoardStarCnt", donghangMap);
	}
	
	public int updateGoBoardStar(Map<String, Object> donghangMap) {
		return sqlSession.update("REVIEW.updateGoBoardStar", donghangMap);
	}

	public int selectDoBoardStarCnt(Map<String, Object> donghangMap) {
		return sqlSession.selectOne("REVIEW.selectDoBoardStarCnt", donghangMap);
	}
	
	public int updateDoBoardStarCnt(Map<String, Object> donghangMap) {
		return sqlSession.update("REVIEW.updateDoBoardStarCnt", donghangMap);
	}

	public int updateDoBoardStar(Map<String, Object> donghangMap) {
		return sqlSession.update("REVIEW.updateDoBoardStar", donghangMap);
	}

	public Map<String, Object> selectGoBoardView(int rbGbNo) {
		return sqlSession.selectOne("REVIEW.selectGoBoardView", rbGbNo);
	}

	public Map<String, Object> selectDoBoardView(int rbDbNo) {
		return sqlSession.selectOne("REVIEW.selectDoBoardView", rbDbNo);
	}
	
	public int selectGoBoardStarCntBefore(Map<String, Object> donghangMap) {
		return sqlSession.selectOne("REVIEW.selectGoBoardStarCntBefore", donghangMap);
	}

	public int updateGoBoardStarBefore(Map<String, Object> donghangMap) {
		return sqlSession.update("REVIEW.updateGoBoardStarBefore", donghangMap);
	}

	public int updateGoBoardStarAfter(Map<String, Object> donghangMap) {
		return sqlSession.update("REVIEW.updateGoBoardStarAfter", donghangMap);
	}

	public int selectDoBoardStarCntBefore(Map<String, Object> donghangMap) {
		return sqlSession.selectOne("REVIEW.selectDoBoardStarCntBefore", donghangMap);
	}

	public int updateDoBoardStarBefore(Map<String, Object> donghangMap) {
		return sqlSession.update("REVIEW.updateDoBoardStarBefore", donghangMap);
	}

	public int updateDoBoardStarAfter(Map<String, Object> donghangMap) {
		return sqlSession.update("REVIEW.updateDoBoardStarAfter", donghangMap);
	}

	public int updateReviewGoBoardNo(Map<String, Object> donghangMap) {
		return sqlSession.update("REVIEW.updateReviewGoBoardNo", donghangMap);
	}

	public int updateReviewDoBoardNo(Map<String, Object> donghangMap) {
		return sqlSession.update("REVIEW.updateReviewDoBoardNo", donghangMap);
	}

	public int insertReviewLike(ReviewLike reviewlike) {
		return sqlSession.insert("REVIEW.insertReviewLike", reviewlike);
	}

	public int updateReviewBoardLikeCnt(int rlRbNo) {
		return sqlSession.update("REVIEW.updateReviewBoardLikeCnt", rlRbNo);
	}

	public int deleteReviewLike(ReviewLike reviewlike) {
		return sqlSession.delete("REVIEW.deleteReviewLike", reviewlike);
	}
	
	public int getBoardLike(ReviewLike reviewlike) {
		return sqlSession.selectOne("REVIEW.getBoardLike", reviewlike);
	}

	public int insertReviewRec(ReviewRecommend reviewrecommand) {
		return sqlSession.insert("REVIEW.insertReviewRec", reviewrecommand);
	}

	public int updateReviewBoardRecCnt(int rrcRbNo) {
		return sqlSession.update("REVIEW.updateReviewBoardRecCnt", rrcRbNo);
	}

	public int deleteReviewRec(ReviewRecommend reviewrecommand) {
		return sqlSession.delete("REVIEW.deleteReviewRec", reviewrecommand);
	}

	public int getBoardRec(ReviewRecommend reviewrecommand) {
		return sqlSession.selectOne("REVIEW.getBoardRec", reviewrecommand);
	}

	public int selectDHApplyList(int getuNo) {
		return sqlSession.selectOne("REVIEW.selectDHApplyList", getuNo);
	}

	public int selectReviewNo(int rbUNo) {
		return sqlSession.selectOne("REVIEW.selectReviewNo", rbUNo);
	}
	
	public Map<String, Object> selectReviewGbAvg(int gbNo) {
		return sqlSession.selectOne("REVIEW.selectReviewGbAvg", gbNo);
	}
	
	public Map<String, Object> selectReviewDbAvg(int gbNo) {
		return sqlSession.selectOne("REVIEW.selectReviewDbAvg", gbNo);
	}

	public int updateGoAvg(Map<String, Object> reviewStar) {
		return sqlSession.update("REVIEW.updateGoAvg", reviewStar);
	}

	public int updateDoAvg(Map<String, Object> reviewStar) {
		return sqlSession.update("REVIEW.updateDoAvg", reviewStar);
	}

	public int selectReviewBoardByRbGbNo(int gbNo) {
		return sqlSession.selectOne("REVIEW.selectReviewBoardByRbGbNo", gbNo);
	}

	public int selectReviewBoardByRbDbNo(int gbNo) {
		return sqlSession.selectOne("REVIEW.selectReviewBoardByRbDbNo", gbNo);
	}

	public int updateGoAvgByZero(Map<String, Object> reviewZero) {
		return sqlSession.update("REVIEW.updateGoAvgByZero", reviewZero);
	}

	public int updateDoAvgByZero(Map<String, Object> reviewZero) {
		return sqlSession.update("REVIEW.updateDoAvgByZero", reviewZero);
	}

	public int updateDhtCnt(User sessionUser) {
		return sqlSession.update("REVIEW.updateDhtCnt", sessionUser);
	}

	public int insertReviewDht(ReviewDhTicket reviewDhTicket) {
		return sqlSession.insert("REVIEW.insertReviewDht", reviewDhTicket);
	}

	public int selectReviewDhtCnt(ReviewDhTicket reviewDhTicket) {
		return sqlSession.selectOne("REVIEW.selectReviewDhtCnt", reviewDhTicket);
	}

	public List<ReviewDhTicket> selectReivewDht(User sessionUser) {
		return sqlSession.selectList("REVIEW.selectReivewDht", sessionUser);
	}

	public int selectGoCnt(GoBoard goBoard) {
		return sqlSession.selectOne("REVIEW.selectGoCnt", goBoard);
	}

	public int selectGaCnt(GoApply goApply) {
		return sqlSession.selectOne("REVIEW.selectGaCnt", goApply);
	}

	public int selectDoCnt(DoBoard doBoard) {
		return sqlSession.selectOne("REVIEW.selectDoCnt", doBoard);
	}

	public int selectDaCnt(DoApply doApply) {
		return sqlSession.selectOne("REVIEW.selectDaCnt", doApply);
	}















	


}
