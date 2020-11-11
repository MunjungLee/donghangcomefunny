package com.DongHang_ComeFunny.www.model.service.admin;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DongHang_ComeFunny.www.model.dao.admin.AdminLoginDao;
import com.DongHang_ComeFunny.www.model.vo.Admin;

@Service
public class AdminLoginServiceImpl implements AdminLoginService {

	@Autowired
	AdminLoginDao adminLoginDao;

	@Override
	public Admin loginAdmin(Map<String, Object> commandMap) {
		
		Admin admin = adminLoginDao.selectAdmin(commandMap);
		
		return admin;
	}
}
