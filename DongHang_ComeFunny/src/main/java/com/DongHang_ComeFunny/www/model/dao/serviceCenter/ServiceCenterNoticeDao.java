package com.DongHang_ComeFunny.www.model.dao.serviceCenter;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.DongHang_ComeFunny.www.model.vo.NoticeBoard;
import com.DongHang_ComeFunny.www.model.vo.NoticeFile;

@Repository
public class ServiceCenterNoticeDao {
	
	@Autowired
	SqlSessionTemplate sqlSession;

	public int selectNoticeCnt(Map<String, Object> searchNoticeBoard) {
		return sqlSession.selectOne("ServiceCenterNotice.selectNoticeCnt", searchNoticeBoard);
	}

	public List<NoticeBoard> selectNoticeList(Map<String, Object> searchNoticeMap) {
		return sqlSession.selectList("ServiceCenterNotice.selectNoticeList", searchNoticeMap);
	}

	public NoticeBoard selectNoticeByNbNo(int nbNo) {
		return sqlSession.selectOne("ServiceCenterNotice.selectNoticeByNbNo", nbNo);
	}
	
	public List<NoticeFile> selectNoticeFileByNbNo(int nbNo) {
		return sqlSession.selectList("ServiceCenterNotice.selectNoticeFileByNbNo", nbNo);
	}

	public void updateHits(int nbNo) {
		sqlSession.update("ServiceCenterNotice.updateHits", nbNo);
	}

}
