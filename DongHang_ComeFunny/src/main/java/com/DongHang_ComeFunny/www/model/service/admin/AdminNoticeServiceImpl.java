package com.DongHang_ComeFunny.www.model.service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.DongHang_ComeFunny.www.model.dao.admin.AdminNoticeDao;
import com.DongHang_ComeFunny.www.model.vo.NoticeBoard;
import com.DongHang_ComeFunny.www.model.vo.NoticeFile;

import common.exception.FileException;
import common.util.FileUtil;
import common.util.Paging;

@Service
public class AdminNoticeServiceImpl implements AdminNoticeService{
	
	@Autowired
	AdminNoticeDao adminNoticeDao;

	@Override
	public Map<String, Object> selectNoticeList(int currentPage, int cntPerPage, Map<String, Object> searchNotice) {
		
		Map<String,Object> commandMap = new HashMap<>();
		
		Paging p = new Paging(adminNoticeDao.selectNoticeCnt(searchNotice), currentPage, cntPerPage);
		
		Map<String,Object> searchNoticeMap = new HashMap<>();
		searchNoticeMap.put("paging",p);
		searchNoticeMap.putAll(searchNotice);
		System.out.println(searchNoticeMap);
		
		List<NoticeBoard> noticeList = adminNoticeDao.selectNoticeList(searchNoticeMap);
		
		commandMap.put("paging", p);
		commandMap.put("noticeList", noticeList);
		
		
		return commandMap;
	}

	@Override
	public void deleteNotice(String[] delNbNos) {
		for(int i=0; i<delNbNos.length; i++) {
			adminNoticeDao.deleteNoticeFile(delNbNos[i]);
			adminNoticeDao.deleteNotice(delNbNos[i]);
		}
	}

	@Override
	public void writeNotice(NoticeBoard noticeBoard, List<MultipartFile> noticeFiles, String root) throws FileException {
		
		adminNoticeDao.insertNotice(noticeBoard);
		
		
		long fileSize = 0;
		for(MultipartFile mf : noticeFiles) {
			fileSize = mf.getSize();
		}
		
		if(fileSize != 0){
		if(noticeFiles!= null) {
			FileUtil fileUtil = new FileUtil();
			List<Map<String,Object>> fileData = fileUtil.fileUpload(noticeFiles, root);
			int nbNo = adminNoticeDao.selectWriteNbNo();
			for(Map<String, Object> data : fileData) {
				data.put("nfNbNo", nbNo);
				System.out.println(data);
				adminNoticeDao.InsertNoticeFile(data);
			}
		}
		}
	}
			
				

	@Override
	public Map<String, Object> viewNotice(int nbNo) {
		NoticeBoard viewNotice = adminNoticeDao.selectNoticeByNbNo(nbNo);
		List<NoticeFile> viewNoticeFile = adminNoticeDao.selectNoticeFileByNbNo(nbNo);
		System.out.println(viewNotice);
		System.out.println(viewNoticeFile);
		
		Map<String,Object> viewNoticeMap = new HashMap<>();
		viewNoticeMap.put("viewNotice",viewNotice);
		viewNoticeMap.put("viewNoticeFile",viewNoticeFile);
		return viewNoticeMap;
		
		
	}

	@Override
	public void modifyNotice(NoticeBoard modiNoticeInfo, List<MultipartFile> noticeFiles, String root) throws FileException {
		
		adminNoticeDao.updateNotice(modiNoticeInfo);
		long fileSize = 0;
		for(MultipartFile mf : noticeFiles) {
			fileSize = mf.getSize();
		}
		
		System.out.println("*************************"+fileSize);
		if(fileSize != 0){
		// 수정사항이 변경되지 않았을 경우의 예외 처리 필요
			if(noticeFiles!= null) {
				FileUtil fileUtil = new FileUtil();
				List<Map<String,Object>> fileData = fileUtil.fileUpload(noticeFiles, root);
				for(Map<String, Object> data : fileData) {
					data.put("nfNbNo", modiNoticeInfo.getNbNo());
					System.out.println(data);
					adminNoticeDao.InsertNoticeFile(data);
				}
			}
		}
	}

	@Override
	public int deleteFile(int nfNo) {
		// 1. 파일 번호로 게시글 파일 목록 조회
				Map<String, String> fileData = adminNoticeDao.selectFile(nfNo);
				// 2. 빈 파일유틸 객체 생성
				FileUtil fileUtil = new FileUtil();
				// 3. 파일 저장경로에 있는 파일 삭제 처리
				fileUtil.deleteFile(fileData.get(("NFSAVEPATH")));

				// 4. isdel 컬럼값 0 -> 1로 변경
				int res = adminNoticeDao.deleteFile(nfNo); // 파일완전 삭제
				return res;
	}
	
	
}

		

			
			
		
		

