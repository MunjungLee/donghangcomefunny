package com.DongHang_ComeFunny.www.model.service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.DongHang_ComeFunny.www.model.dao.admin.AdminUserDao;
import com.DongHang_ComeFunny.www.model.vo.User;
import com.DongHang_ComeFunny.www.model.vo.UserFile;

import common.exception.FileException;
import common.util.FileUtil;
import common.util.Paging;

@Service
public class AdminUserServiceImpl implements AdminUserService  {

	@Autowired
	AdminUserDao adminUserDao;
	
	@Override
	public Map<String, Object> viewUserList(int currentPage, int cntPerPage, Map<String,Object> searchUser) {
		
		Map<String,Object> commandMap = new HashMap<String, Object>();
		// 전체 회원 수 페이징 처리 및 조회
		Paging p = new Paging(adminUserDao.selectUserCnt(searchUser), currentPage, cntPerPage);
		System.out.println("*******페이징*******" + p);
		
		
		
		Map<String, Object> searchUserMap = new HashMap<>();
			searchUserMap.put("paging", p);
			searchUserMap.putAll(searchUser);
			System.out.println(searchUserMap);
			
			// Map에 담을 페이징된 회원의 리스트 조회
			List<User> userList = adminUserDao.selectUserList(searchUserMap); 
			
			System.out.println(userList);
			commandMap.put("userList",userList);
			commandMap.put("paging",p);
			System.out.println("*******데이터베이스조회******" + commandMap);
			
			// adminUserController로 반환
			return commandMap;
		
	}

	@Override
	public void deleteUser(String[] uNos) {
		for(int i=0; i<uNos.length; i++) {
			adminUserDao.deleteUserFile(uNos[i]);
			adminUserDao.deleteUser(uNos[i]);
		}
	}

	@Override
	public Map<String,Object> viewUser(int uno) {
		User viewUser = adminUserDao.selectUserByUNo(uno);
		UserFile userImg = adminUserDao.selectUserFileByUNo(uno);
		System.out.println(viewUser);
		System.out.println(userImg);
		Map<String,Object> viewUserMap = new HashMap<>();
		viewUserMap.put("viewUser",viewUser);
		viewUserMap.put("userImg", userImg);
		return viewUserMap;
	}
	
	

	@Override
	public void modifyUser(User modiUserInfo, List<MultipartFile> userImg, String root) throws FileException {
		adminUserDao.updateUser(modiUserInfo);
		FileUtil fileUtil = new FileUtil();
		long fileSize = 0;
		
		for(MultipartFile mf : userImg) {
			fileSize = mf.getSize();
		}
		
		System.out.println("*************************"+fileSize);
		if(fileSize != 0){
			
		List<Map<String,Object>> fileData = fileUtil.fileUpload(userImg, root);
			int fileCheck = adminUserDao.selectUserFileCount(modiUserInfo.getuNo());
			
				if(fileCheck != 1) {
					for(Map<String, Object> data : fileData) {
						data.put("ufUNo", modiUserInfo.getuNo());
						adminUserDao.insertUserFile(data);
					}
				} else {
					for(Map<String, Object> data : fileData) {
						data.put("ufUNo", modiUserInfo.getuNo());
						adminUserDao.updateUserFile(data);
					}
				}
				
		}
	}
	
	}

	

