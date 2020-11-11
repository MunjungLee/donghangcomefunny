package com.DongHang_ComeFunny.www.model.service.admin;

import java.util.Map;

public interface AdminDoBoardService {

	Map<String, Object> viewDoBoardList(int cPage, int cntPerPage, Map<String, Object> searchDoBoard);

	void deleteDoBoard(String[] dbNo);

	Map<String, Object> selectDoDetail(int dbno);


}
