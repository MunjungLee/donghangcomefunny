package com.DongHang_ComeFunny.www.model.service.admin;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.DongHang_ComeFunny.www.model.vo.ReviewComment;

@Service
public interface AdminReviewBoardService {

	Map<String, Object> viewReviewBoardList(int cPage, int cntPerPage, Map<String, Object> searchReviewBoard);

	void deleteReviewBoard(String[] rbNo);

	Map<String, Object> selectReviewView(int rbNo);

	Map<String, Object> selectGoBoardView(int rbGbNo);

	Map<String, Object> selectDoBoardView(int rbDbNo);

	List<Map<String, Object>> selectReviewCommentList(int rbNo);

	int deleteReviewComment(ReviewComment reviewComment);

}
