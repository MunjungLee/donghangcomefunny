package com.DongHang_ComeFunny.www.model.service.admin;

import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public interface AdminGoBoardService {

	Map<String, Object> viewGoBoardList(int cPage, int cntPerPage, Map<String, Object> searchGoBoard);

	void deleteGoBoard(String[] gbNo);

	Map<String, Object> selectGoDetail(int gbNo);

}
