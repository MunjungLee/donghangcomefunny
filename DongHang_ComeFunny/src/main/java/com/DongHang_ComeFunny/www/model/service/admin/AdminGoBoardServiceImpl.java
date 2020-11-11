package com.DongHang_ComeFunny.www.model.service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DongHang_ComeFunny.www.model.dao.admin.AdminGoBoardDao;
import com.DongHang_ComeFunny.www.model.vo.GoBoard;
import com.DongHang_ComeFunny.www.model.vo.GoCheck;

import common.util.Paging;

@Service
public class AdminGoBoardServiceImpl implements AdminGoBoardService {
	
	@Autowired
	AdminGoBoardDao adminGoBoardDao;

	@Override
	public Map<String, Object> viewGoBoardList(int cPage, int cntPerPage, Map<String, Object> searchGoBoard) {
		Map<String,Object> commandMap = new HashMap<>();
		
		Paging p = new Paging(adminGoBoardDao.selectGoBoardCnt(searchGoBoard), cPage, cntPerPage);
		
		Map<String,Object> searchDoBoardMap = new HashMap<>();
		searchDoBoardMap.put("paging",p);
		searchDoBoardMap.putAll(searchGoBoard);
		System.out.println(searchDoBoardMap);
		
		List<GoBoard> doBoardList = adminGoBoardDao.selectGoBoardList(searchDoBoardMap);
		
		commandMap.put("paging", p);
		commandMap.put("doBoardList", doBoardList);
		
		
		return commandMap;
		
		
	}

	@Override
	public void deleteGoBoard(String[] gbNo) {
		for(int i=0; i<gbNo.length; i++) {
			adminGoBoardDao.deleteGoBoard(gbNo[i]);
		}
		
	}

	@Override
	public Map<String, Object> selectGoDetail(int gbNo) {
		 //함께가요 상세 글 정보, 작성자 프로필 이미지
        Map<String, Object> goBoardUserInfo =  adminGoBoardDao.selectGoUserInfo(gbNo);
        
        //함께가요 상세 체크박스
        List<GoCheck> goCheck = adminGoBoardDao.selectGocheck(gbNo);
        
        //함께가요 상세 체크박스(가져오는 방식 변경) - 문정 필요
         Map<String, Object> goChecklist = adminGoBoardDao.selectGochklist(gbNo);
        
        //호스트 평점
        List<Map<String, Object>> hostReview = adminGoBoardDao.selectGoHostReview(gbNo);
        
        //호스트 평점 후기 갯수
        int hostReviewCnt = adminGoBoardDao.selecthostReviewCnt(gbNo);
        
        //함께가요 동행신청 목록
        List<Map<String, Object>> goDhApplylist = adminGoBoardDao.selectgoDhApplylist(gbNo);
        
        
        Map<String,Object> goDetailInfo = new HashMap<String, Object>();
        goDetailInfo.put("goBoardUserInfo", goBoardUserInfo);
        goDetailInfo.put("goCheck", goCheck);
        goDetailInfo.put("hostReview", hostReview);
        goDetailInfo.put("hostReviewCnt", hostReviewCnt);
        goDetailInfo.put("goDhApplylist", goDhApplylist);
        goDetailInfo.put("goChecklist", goChecklist); //문정 필요
        return goDetailInfo;
     }
	
	
	
}
