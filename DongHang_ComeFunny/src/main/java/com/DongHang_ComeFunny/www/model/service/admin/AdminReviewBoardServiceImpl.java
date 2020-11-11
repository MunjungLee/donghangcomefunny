package com.DongHang_ComeFunny.www.model.service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DongHang_ComeFunny.www.model.dao.admin.AdminReviewBoardDao;
import com.DongHang_ComeFunny.www.model.vo.ReviewBoard;
import com.DongHang_ComeFunny.www.model.vo.ReviewComment;

import common.util.Paging;

@Service
public class AdminReviewBoardServiceImpl implements AdminReviewBoardService {

	@Autowired
	AdminReviewBoardDao adminReviewBoardDao;

	@Override
	public Map<String, Object> viewReviewBoardList(int cPage, int cntPerPage, Map<String, Object> searchReviewBoard) {
		
		Map<String,Object> commandMap = new HashMap<>();
		
		Paging p = new Paging(adminReviewBoardDao.selectReviewBoardCnt(searchReviewBoard), cPage, cntPerPage);
		
		Map<String,Object> searchReviewBoardMap = new HashMap<>();
		searchReviewBoardMap.put("paging",p);
		searchReviewBoardMap.putAll(searchReviewBoard);
		System.out.println(searchReviewBoardMap);
		
		List<ReviewBoard> reviewBoardList = adminReviewBoardDao.selectReviewBoardList(searchReviewBoardMap);
		
		commandMap.put("paging", p);
		commandMap.put("reviewBoardList", reviewBoardList);
		
		
		return commandMap;
	}

	@Override
	public void deleteReviewBoard(String[] rbNo) {
		for(int i=0; i<rbNo.length; i++) {
			adminReviewBoardDao.deleteReviewFileByRbNo(rbNo[i]);
			adminReviewBoardDao.deleteReviewCommentByRbNo(rbNo[i]);
			adminReviewBoardDao.deleteReviewBoard(rbNo[i]);
		}
	}

	@Override
	public Map<String, Object> selectReviewView(int rbNo) {
		// 1. 게시글 번호로 게시글 상세보기 조회(회원, 리뷰게시글 테이블)
				Map<String, Object> fdetail = adminReviewBoardDao.selectReviewDetail(rbNo);

				// ----------------------DAO에서 제대로 조회되었는지 확인하기-------------------
				System.out.println("[ServiceImpl] - fdetail Map : " + fdetail);
				// -----------------------------------------------------------------------------
				
				// 4. 리뷰게시글과 업로드된 파일 목록 리스트 조회(리뷰게시글, 리뷰파일)
				List<Map<String, Object>> filelist = adminReviewBoardDao.selectFileWithReview(rbNo);
				// 5. 빈 커맨드 객체 생성
				Map<String, Object> commandMap = new HashMap<>();
				// 6. 리뷰게시글 리스트와 파일리스트를 커맨드맵에 넣기
				commandMap.put("detail", fdetail);
				commandMap.put("filelist", filelist);
				// 7. 커맨드맵 반환
				return commandMap;
			}

	@Override
	public Map<String, Object> selectGoBoardView(int rbGbNo) {
		return adminReviewBoardDao.selectGoBoardView(rbGbNo);
	}

	@Override
	public Map<String, Object> selectDoBoardView(int rbDbNo) {
		return adminReviewBoardDao.selectDoBoardView(rbDbNo);
	}
	
	@Override
	public List<Map<String, Object>> selectReviewCommentList(int rbNo) {
		// 1. 게시글 번호로 댓글 리스트 조회
				List<Map<String, Object>> reviewComment = adminReviewBoardDao.selectReviewCommentList(rbNo);
				// 2. 조회된 리스트 반환
				return reviewComment;
			}

	@Override
	public int deleteReviewComment(ReviewComment reviewComment) {
		// 1. 댓글 삭제 시, isdel=0을 1로 변경
//		return reviewBoardDao.updateReviewCommentIsDEl(reviewComment);
		// 2. 댓글 완전 삭제
		return adminReviewBoardDao.deleteReviewComment(reviewComment);
	}
}
