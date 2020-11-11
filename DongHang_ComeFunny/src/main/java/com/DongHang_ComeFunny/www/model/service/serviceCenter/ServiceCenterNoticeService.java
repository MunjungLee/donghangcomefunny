package com.DongHang_ComeFunny.www.model.service.serviceCenter;

import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public interface ServiceCenterNoticeService {

	Map<String, Object> viewNoticeBoardList(int cPage, int cntPerPage, Map<String, Object> searchNoticeBoard);

	Map<String, Object> viewNotice(int nbNo);


}
