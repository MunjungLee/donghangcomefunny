package com.DongHang_ComeFunny.www.model.dao.admin;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.DongHang_ComeFunny.www.model.vo.GoBoard;
import com.DongHang_ComeFunny.www.model.vo.GoCheck;

@Repository
public class AdminGoBoardDao {
	
	@Autowired
	SqlSessionTemplate sqlSession;


	public int selectGoBoardCnt(Map<String, Object> searchGoBoard) {
		return sqlSession.selectOne("AdminGoBoard.selectGoBoardCnt", searchGoBoard);
	}

	public List<GoBoard> selectGoBoardList(Map<String, Object> searchDoBoardMap) {
		return sqlSession.selectList("AdminGoBoard.selectGoBoardList", searchDoBoardMap);
	}
	
	public void deleteGoBoard(String gbNo) {
		sqlSession.delete("AdminGoBoard.deleteGoBoard", gbNo);
	}

	public Map<String, Object> selectGoUserInfo(int gbNo) {
        return sqlSession.selectOne("AdminGoBoard.selectGoUserInfo", gbNo);
	}

	public List<GoCheck> selectGocheck(int gbNo) {
        return sqlSession.selectList("AdminGoBoard.selectGocheck", gbNo);
	}

	public Map<String, Object> selectGochklist(int gbNo) {
	      return sqlSession.selectOne("AdminGoBoard.selectGochklist", gbNo);
	}

	public List<Map<String, Object>> selectGoHostReview(int gbNo) {
        return sqlSession.selectList("AdminGoBoard.selectGoHostReview", gbNo);
	}

	public int selecthostReviewCnt(int gbNo) {
        return sqlSession.selectOne("AdminGoBoard.selecthostReviewCnt", gbNo);
	}

	public List<Map<String, Object>> selectgoDhApplylist(int gbNo) {
        return sqlSession.selectList("AdminGoBoard.selectgoDhApplylist", gbNo);
	}
	

}
