package com.DongHang_ComeFunny.www.model.service.admin;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.DongHang_ComeFunny.www.model.vo.User;

import common.exception.FileException;

@Service
public interface AdminUserService {
	/**
	 * 전체 회원 조회
	 * @param currentPage - 현재 페이지
	 * @param cntPerPage - 페이지당 노출할 게시글 수
	 * @return - 현재 가입중인 회원의 Map
	 */
	public Map<String,Object> viewUserList(int currentPage, int cntPerPage, Map<String,Object> searchUser);

	/**
	 * 회원 삭제
	 * @param selUnos - 삭제 할 회원의 배열 및 삭제할 회원의 번호
	 */
	public void deleteUser(String[] uNos);

	/**
	 * 회원 정보 상세보기
	 * @param uNo - 상세보기 할 회원의 번호
	 * @return Map - 조회한 회원의 정보를 담은 리스트
	 */
	public Map<String,Object> viewUser(int uNo);

	public void modifyUser(User modiUserInfo, List<MultipartFile> userImg, String root) throws FileException; 
	
	
	

}
