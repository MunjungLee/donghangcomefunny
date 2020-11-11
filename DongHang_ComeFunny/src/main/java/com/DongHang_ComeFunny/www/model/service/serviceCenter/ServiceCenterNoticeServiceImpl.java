package com.DongHang_ComeFunny.www.model.service.serviceCenter;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DongHang_ComeFunny.www.model.dao.serviceCenter.ServiceCenterNoticeDao;
import com.DongHang_ComeFunny.www.model.vo.NoticeBoard;
import com.DongHang_ComeFunny.www.model.vo.NoticeFile;

import common.util.Paging;

@Service
public class ServiceCenterNoticeServiceImpl implements ServiceCenterNoticeService {
	
	@Autowired
	ServiceCenterNoticeDao serviceCenterNoticeDao;

	@Override
	public Map<String, Object> viewNoticeBoardList(int cPage, int cntPerPage, Map<String, Object> searchNoticeBoard) {
		
		Map<String,Object> commandMap = new HashMap<>();
		
		Paging p = new Paging(serviceCenterNoticeDao.selectNoticeCnt(searchNoticeBoard), cPage, cntPerPage);
		
		Map<String,Object> searchNoticeMap = new HashMap<>();
		searchNoticeMap.put("paging",p);
		searchNoticeMap.putAll(searchNoticeBoard);
		System.out.println(searchNoticeMap);
		
		List<NoticeBoard> noticeList = serviceCenterNoticeDao.selectNoticeList(searchNoticeMap);
		
		commandMap.put("paging", p);
		commandMap.put("noticeList", noticeList);
		
		
		return commandMap;
	}

	@Override
	public Map<String, Object> viewNotice(int nbNo) {
		serviceCenterNoticeDao.updateHits(nbNo);
		
		NoticeBoard viewNotice = serviceCenterNoticeDao.selectNoticeByNbNo(nbNo);
		List<NoticeFile> viewNoticeFile = serviceCenterNoticeDao.selectNoticeFileByNbNo(nbNo);
		System.out.println(viewNotice);
		System.out.println(viewNoticeFile);
		
		Map<String,Object> viewNoticeMap = new HashMap<>();
		viewNoticeMap.put("viewNotice",viewNotice);
		viewNoticeMap.put("viewNoticeFile",viewNoticeFile);
		return viewNoticeMap;
		
	}

}
	
