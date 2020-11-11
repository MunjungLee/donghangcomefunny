package com.DongHang_ComeFunny.www.model.dao.admin;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.DongHang_ComeFunny.www.model.vo.Admin;

@Repository
public class AdminLoginDao {
	
	@Autowired
	SqlSessionTemplate sqlSession;

	public Admin selectAdmin(Map<String, Object> commandMap) {
		return sqlSession.selectOne("AdminLogin.selectAdmin", commandMap);
	}
	

}
