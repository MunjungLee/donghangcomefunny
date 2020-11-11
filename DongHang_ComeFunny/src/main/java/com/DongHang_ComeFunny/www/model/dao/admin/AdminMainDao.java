package com.DongHang_ComeFunny.www.model.dao.admin;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminMainDao {
	
	@Autowired
	SqlSessionTemplate sqlSession;

	public int selectTodayUserCnt() {
		return sqlSession.selectOne("AdminMain.selectTodayUserCnt");
	}

	public int selectTodayPaymentCnt() {
		return sqlSession.selectOne("AdminMain.selectTodayPaymentCnt");
	}

	public int selectTodayPostCnt() {
		return sqlSession.selectOne("AdminMain.selectTodayPostCnt");
	}
	
	
	

}
