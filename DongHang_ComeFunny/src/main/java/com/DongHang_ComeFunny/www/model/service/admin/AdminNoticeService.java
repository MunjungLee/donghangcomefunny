package com.DongHang_ComeFunny.www.model.service.admin;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.DongHang_ComeFunny.www.model.vo.NoticeBoard;

import common.exception.FileException;

@Service
public interface AdminNoticeService {

	public Map<String, Object> selectNoticeList(int currentPage, int cntPerPage, Map<String, Object> searchNotice);

	public void deleteNotice(String[] delNbNos);

	public void writeNotice(NoticeBoard noticeBoard, List<MultipartFile> noticeFiles, String root) throws FileException;

	public Map<String, Object> viewNotice(int nbNo);

	public void modifyNotice(NoticeBoard modiNoticeInfo, List<MultipartFile> noticeFiles, String root) throws FileException;

	public int deleteFile(int nfNo);

}
