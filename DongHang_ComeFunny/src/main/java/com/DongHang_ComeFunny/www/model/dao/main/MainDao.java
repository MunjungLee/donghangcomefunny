package com.DongHang_ComeFunny.www.model.dao.main;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MainDao {
	
	@Autowired private SqlSessionTemplate sqlSession;
	
	//함께해요 배스트
	public List<Object> selectgobest(){
		return sqlSession.selectList("MAIN.bestgoboard");
	}
	
	//함께가요 베스트
	public List<Object> selectdobest(){
		return sqlSession.selectList("MAIN.bestdoboard");
	}
	
	//베스트동행
	public List<Object> selectbesthost(){
		return sqlSession.selectList("MAIN.besthost");
	}
	
	//베스트함께가요 후기
	public List<Object> selectbestgoreview(){
		return sqlSession.selectList("MAIN.bestgoreview");
	}
	
	//베스트함께해요 후기
	public List<Object> selectbestdoreview(){
		return sqlSession.selectList("MAIN.bestdoreview");
	}
	
}
