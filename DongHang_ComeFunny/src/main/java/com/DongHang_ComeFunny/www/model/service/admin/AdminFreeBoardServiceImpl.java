package com.DongHang_ComeFunny.www.model.service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DongHang_ComeFunny.www.model.dao.admin.AdminFreeBoardDao;
import com.DongHang_ComeFunny.www.model.vo.FreeBoard;
import com.DongHang_ComeFunny.www.model.vo.FreeComment;

import common.util.Paging;

@Service
public class AdminFreeBoardServiceImpl implements AdminFreeBoardService {

	@Autowired
	AdminFreeBoardDao adminFreeBoardDao;

	@Override
	public Map<String, Object> viewFreeBoardList(int cPage, int cntPerPage, Map<String, Object> searchFreeBoard) {
		Map<String,Object> commandMap = new HashMap<>();
		
		Paging p = new Paging(adminFreeBoardDao.selectFreeBoardCnt(searchFreeBoard), cPage, cntPerPage);
		
		Map<String,Object> searchFreeBoardMap = new HashMap<>();
		searchFreeBoardMap.put("paging",p);
		searchFreeBoardMap.putAll(searchFreeBoard);
		System.out.println(searchFreeBoardMap);
		
		List<FreeBoard> freeBoardList = adminFreeBoardDao.selectFreeBoardList(searchFreeBoardMap);
		
		commandMap.put("paging", p);
		commandMap.put("freeBoardList", freeBoardList);
		
		
		return commandMap;
	}

	@Override
	public void deleteFreeBoard(String[] fbNo) {
		for(int i=0; i<fbNo.length; i++) {
		adminFreeBoardDao.deleteFreeCommentByFbNo(fbNo[i]);
		adminFreeBoardDao.deleteFreeFileByFbNo(fbNo[i]);
		adminFreeBoardDao.deleteFreeBoard(fbNo[i]);
		}
	}

	@Override
	public List<Map<String, Object>> viewFreeCommentList(int fbNo) {
		// 1. 게시글 번호로 댓글 리스트 조회
					List<Map<String, Object>> freeComment = adminFreeBoardDao.selectFreeCommentList(fbNo);
					// 2. 조회된 리스트 반환
					return freeComment;
				}

	@Override
	public Map<String, Object> viewFreeBoard(int fbNo) {
		// 1. 게시글 번호로 게시글 상세보기 조회(회원, 자유게시글 테이블)
		Map<String, Object> fdetail = adminFreeBoardDao.selectFreeDetail(fbNo);
		
		// ----------------------DAO에서 제대로 조회되었는지 확인하기-------------------
		System.out.println("[ServiceImpl] - fdetail Map : " + fdetail);
		// -----------------------------------------------------------------------------
		
		// 4. 자유게시글과 업로드된 파일 목록 리스트 조회(자유게시글, 자유파일)
		List<Map<String, Object>> filelist = adminFreeBoardDao.selectFileWithFree(fbNo);
		// 5. 빈 커맨드 객체 생성
		Map<String, Object> commandMap = new HashMap<>();
		// 6. 자유게시글 리스트와 파일리스트를 커맨드맵에 넣기
		commandMap.put("detail", fdetail);
		commandMap.put("filelist", filelist);
		// 7. 커맨드맵 반환
		return commandMap;
	}

	@Override
	public int deleteFreeComment(FreeComment freeComment) {
		// 1. 댓글 삭제 시, isdel=0을 1로 변경
//		return freeBoardDao.updateFreeCommentIsDEl(freeComment);
		// 2. 댓글 완전 삭제
		return adminFreeBoardDao.deleteFreeComment(freeComment);
	}
	
	
}
