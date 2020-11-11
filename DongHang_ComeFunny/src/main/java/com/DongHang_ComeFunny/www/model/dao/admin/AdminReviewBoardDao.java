package com.DongHang_ComeFunny.www.model.dao.admin;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.DongHang_ComeFunny.www.model.vo.ReviewBoard;
import com.DongHang_ComeFunny.www.model.vo.ReviewComment;

@Repository
public class AdminReviewBoardDao {
	
	@Autowired
	SqlSessionTemplate sqlSession;

	public List<ReviewBoard> selectReviewBoardList(Map<String, Object> searchReviewBoardMap) {
		return sqlSession.selectList("AdminReviewBoard.selectReviewBoardList", searchReviewBoardMap);
	}

	public int selectReviewBoardCnt(Map<String, Object> searchReviewBoard) {
		return sqlSession.selectOne("AdminReviewBoard.selectReviewBoardCnt", searchReviewBoard);
	}

	public void deleteReviewBoard(String rbNo) {
		sqlSession.delete("AdminReviewBoard.deleteReviewBoard", rbNo);
	}

	public void deleteReviewFileByRbNo(String rfRbNo) {
		sqlSession.delete("AdminReviewBoard.deleteReviewFileByRbNo", rfRbNo);
	}

	public void deleteReviewCommentByRbNo(String rcRbNo) {
		sqlSession.delete("AdminReviewBoard.deleteReviewCommentByRbNo", rcRbNo);
	}

	public Map<String, Object> selectReviewDetail(int rbNo) {
		return sqlSession.selectOne("AdminReviewBoard.selectReviewDetail", rbNo);	
		}

	public List<Map<String, Object>> selectFileWithReview(int rbNo) {
		return sqlSession.selectList("AdminReviewBoard.selectFileWithReview", rbNo);
	}

	public Map<String, Object> selectGoBoardView(int rbGbNo) {
		return sqlSession.selectOne("AdminReviewBoard.selectGoBoardView", rbGbNo);	
		}

	public Map<String, Object> selectDoBoardView(int rbDbNo) {
		return sqlSession.selectOne("AdminReviewBoard.selectGoBoardView", rbDbNo);
		}

	public List<Map<String, Object>> selectReviewCommentList(int rbNo) {
		return sqlSession.selectList("AdminReviewBoard.selectReviewCommentList", rbNo);
	}


	public int deleteReviewComment(ReviewComment reviewComment) {
		return sqlSession.delete("AdminReviewBoard.deleteReviewComment",reviewComment);
	}

}
