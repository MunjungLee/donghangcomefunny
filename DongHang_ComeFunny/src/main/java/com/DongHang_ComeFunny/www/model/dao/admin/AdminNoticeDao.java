package com.DongHang_ComeFunny.www.model.dao.admin;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.DongHang_ComeFunny.www.model.vo.NoticeBoard;
import com.DongHang_ComeFunny.www.model.vo.NoticeFile;
import com.DongHang_ComeFunny.www.model.vo.NoticeImg;

@Repository
public class AdminNoticeDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int selectNoticeCnt(Map<String, Object> searchNotice) {
		return sqlSession.selectOne("AdminNotice.selectNoticeCnt",searchNotice);
	}

	public List<NoticeBoard> selectNoticeList(Map<String, Object> searchNoticeMap) {
		return sqlSession.selectList("AdminNotice.selectNoticeList",searchNoticeMap);
	}

	public void deleteNotice(String nbNo) {
		sqlSession.delete("AdminNotice.deleteNotice", nbNo);
	}

	public void insertNotice(NoticeBoard noticeBoard) {
		sqlSession.insert("AdminNotice.insertNotice", noticeBoard);
		
	}

	public int selectWriteNbNo() {
		return sqlSession.selectOne("AdminNotice.selectWriteNbNo");
	}

	public void InsertNoticeFile(Map<String, Object> data) {
		sqlSession.insert("AdminNotice.insertNoticeFile", data);
	}

	public void InsertNoticeImg(Map<String, Object> data) {
		sqlSession.insert("AdminNoitce.insertNoticeImg", data);
		
	}

	public NoticeBoard selectNoticeByNbNo(int nbNo) {
		return sqlSession.selectOne("AdminNotice.selectNoticeByNbNo", nbNo);
	}
	
	public List<NoticeFile> selectNoticeFileByNbNo(int nbNo) {
		return sqlSession.selectList("AdminNotice.selectNoticeFileByNbNo", nbNo);
	}

	public void updateNotice(NoticeBoard modiNoticeInfo) {
		sqlSession.update("AdminNotice.updateNotice", modiNoticeInfo);
	}

	public void deleteNoticeFile(String nbNo) {
		sqlSession.delete("AdminNotice.deleteNoticeFile", nbNo);
	}

	public void deleteNoticeImg(String nbNo) {
		sqlSession.delete("AdminNotice.deleteNoticeImg", nbNo);
	}

	public Map<String, String> selectFile(int nfNo) {
		return sqlSession.selectOne("AdminNotice.selectFile", nfNo);
	}

	public int deleteFile(int nfNo) {
		return sqlSession.delete("AdminNotice.deleteFile", nfNo);
	}

}
