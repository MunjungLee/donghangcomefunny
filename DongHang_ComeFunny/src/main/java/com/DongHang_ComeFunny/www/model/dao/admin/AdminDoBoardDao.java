package com.DongHang_ComeFunny.www.model.dao.admin;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.DongHang_ComeFunny.www.model.vo.DoBoard;
import com.DongHang_ComeFunny.www.model.vo.NoticeBoard;

@Repository
public class AdminDoBoardDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int selectDoBoardCnt(Map<String, Object> searchDoBoard) {
		return sqlSession.selectOne("AdminDoBoard.selectDoBoardCnt", searchDoBoard);
	}

	public  List<DoBoard> selectDoBoardList(Map<String, Object> searchDoBoardMap) {
		return sqlSession.selectList("AdminDoBoard.selectDoBoardList", searchDoBoardMap);
	}

	public void deleteDoBoard(String dbNo) {
		sqlSession.delete("AdminDoBoard.deleteDoBoard", dbNo);
		
	}

			public List<Object> selectDoDetail(int dbno) {
				return sqlSession.selectList("AdminDoBoard.selectDoDetail",dbno);
			}

			//후기정보
			public List<Object> selectdoReview(int dbno) {
				return sqlSession.selectList("AdminDoBoard.selectdoReview",dbno);
			}

			//작성자 정보
			public List<Object> selectHostInfo(int dbno) {
				return sqlSession.selectList("AdminDoBoard.selectHostInfo",dbno);
			}

			public List<Object> selectApplyList(int dbno) {
				return sqlSession.selectList("AdminDoBoard.selectApplyList",dbno);
			}

			public List<Object> selectplacePhoto(int dbno) {
				return sqlSession.selectList("AdminDoBoard.selectplacePhoto",dbno);
			}
}
