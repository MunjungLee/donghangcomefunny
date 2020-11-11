package com.DongHang_ComeFunny.www.model.service.admin;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.DongHang_ComeFunny.www.model.vo.Admin;

@Service
public interface AdminLoginService {

	Admin loginAdmin(Map<String, Object> commandMap);

}
