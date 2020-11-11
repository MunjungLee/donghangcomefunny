package com.DongHang_ComeFunny.www.model.service.main;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DongHang_ComeFunny.www.model.dao.main.MainDao;

@Service
public class MainService {
	
	@Autowired MainDao mainDao;
	
	public Map<String, Object> selectMainList(){
		
		//담을 맵 생성
		Map<String, Object> list = new HashMap<String, Object>();
		
		list.put("goreview", mainDao.selectbestgoreview());
		list.put("doreview", mainDao.selectbestdoreview());
		list.put("besthost", mainDao.selectbesthost());
		list.put("bestgo", mainDao.selectgobest());
		list.put("bestdo", mainDao.selectdobest());
		
		System.out.println("[DAO]"+list);
		return list;
		
	}
}
