package com.DongHang_ComeFunny.www.model.dao.mypage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.DongHang_ComeFunny.www.model.vo.DoApply;
import com.DongHang_ComeFunny.www.model.vo.FreeBoard;
import com.DongHang_ComeFunny.www.model.vo.FreeComment;
import com.DongHang_ComeFunny.www.model.vo.GoApply;
import com.DongHang_ComeFunny.www.model.vo.GoBoard;
import com.DongHang_ComeFunny.www.model.vo.Order;
import com.DongHang_ComeFunny.www.model.vo.ReviewBoard;
import com.DongHang_ComeFunny.www.model.vo.ReviewComment;
import com.DongHang_ComeFunny.www.model.vo.ReviewDhTicket;
import com.DongHang_ComeFunny.www.model.vo.User;

import common.util.Paging;

@Repository
public class FboardListDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	//자유게시판 게시글수 카운트 
	public int selectFbContentCnt(int uno) { 
		
		return sqlSession.selectOne("MYPAGE.selectFbContentCnt", uno);
	}

	//자유게시판 댓글 띄우기
	public int selectFcommentCnt(int uno) {
		
		return sqlSession.selectOne("MYPAGE.selectFcommentCnt", uno);
	}

	//자유게시판 리스트 띄우기
	public List<FreeBoard> selectFboardList(Paging p, int uno) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("p",p);
		param.put("uno", uno);
		return sqlSession.selectList("MYPAGE.selectFboardList", param);
	}


	//자유게시판 게시글 삭제
	public void deleteFboardList(FreeBoard fboard) {
//		System.out.println(fboard);
		sqlSession.delete("MYPAGE.deleteFboardList", fboard);
	}
//	//자유게시판 게시글 삭제(IsDel=1)
//	public void deleteFboardList(FreeBoard fboard) {
////		System.out.println(fboard);
//		sqlSession.update("Fboard.deleteFboardList", fboard);
//	}

	//후기게시판 게시글수 카운트 
	public int selectRbContentCnt(int uno) {
		return sqlSession.selectOne("MYPAGE.selectRbContentCnt", uno);
	}

	//후게시판 댓글 띄우기
	public int selectRbcommentCnt(int uno) {
		return sqlSession.selectOne("MYPAGE.selectRbcommentCnt", uno);
	}

	//후기게시판 리스트 띄우기
	public List<ReviewBoard> selectRboardList(Paging p, int uno) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("p",p);
		param.put("uno", uno);
		return sqlSession.selectList("MYPAGE.selectRboardList", param);
	}

	//후기게시판 리스트 삭제
	public void deleteRboardList(ReviewBoard rboard) {
//		System.out.println(rboard);
		sqlSession.delete("MYPAGE.deleteRboardList", rboard);
		
	}
	
	// ------------------------------------------------------------------
	//동행 평점 개수
	public ReviewBoard selectReviewBoardByDH(ReviewBoard rboard) {
		return sqlSession.selectOne("MYPAGE.selectReviewBoardByDH", rboard);
	}

	public Map<String, Object> selectReviewGbAvg(int rbGbNo) {
		return sqlSession.selectOne("MYPAGE.selectReviewGbAvg", rbGbNo);
	}

	public Map<String, Object> selectReviewDbAvg(int rbDbNo) {
		return sqlSession.selectOne("MYPAGE.selectReviewDbAvg", rbDbNo);
	}

	public int selectReviewBoardByRbGbNo(int rbGbNo) {
		return sqlSession.selectOne("MYPAGE.selectReviewBoardByRbGbNo", rbGbNo);
	}

	public int selectReviewBoardByRbDbNo(int rbDbNo) {
		return sqlSession.selectOne("MYPAGE.selectReviewBoardByRbDbNo", rbDbNo);
	}
	
	public int updateGoAvgByZero(Map<String, Object> reviewStarGo) {
		return sqlSession.update("MYPAGE.updateGoAvgByZero", reviewStarGo);
	}

	public int updateDoAvgByZero(Map<String, Object> reviewStarDo) {
		return sqlSession.update("MYPAGE.updateDoAvgByZero", reviewStarDo);
	}
	
	//--------------------------------------------------------------
//	//후기게시판 리스트 삭제(IsDel=1)
//	public void deleteRboardList(ReviewBoard rboard) {
////		System.out.println(rboard);
//		sqlSession.update("Fboard.deleteRboardList", rboard);
//		
//	}

	//나의댓글수 카운트
	public int selectCbContentCnt(int uno) {
		return sqlSession.selectOne("MYPAGE.selectCbContentCnt", uno);
	}

	//나의 댓글 리스트 띄우기
	public List<FreeComment> selectFcmtList(Paging p, int uno) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("p",p);
		param.put("uno", uno);
		return sqlSession.selectList("MYPAGE.selectFcmtList", param);
	}

	//댓글(자유) 삭제
	public void deletefcmtList(FreeComment fcmt) {
		sqlSession.delete("MYPAGE.deletefcmtList", fcmt);
	}
//	//댓글(자유) 삭제(IsDel=1)
//	public void deletefcmtList(FreeComment fcmt) {
//		sqlSession.update("MYPAGE.deletefcmtList", fcmt);
//	}

	//후기 게시판 댓글 개수
	public int selectRcmtContentCnt(int uno) {
		return sqlSession.selectOne("MYPAGE.selectRcmtContentCnt", uno);
	}

	//후기게시판 댓글 목록 띄우기
	public List<ReviewComment> selectRcmtList(Paging p, int uno) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("p",p);
		param.put("uno", uno);
		return sqlSession.selectList("MYPAGE.selectRcmtList", param);
	}	
	
	
	//댓글(후기) 삭제
	public void deleteRcmtList(ReviewComment rcmt) {
		sqlSession.delete("MYPAGE.deleteRcmtList", rcmt);
		
	}
//	//댓글(후기) 삭제(IsDel=1)
//	public void deleteRcmtList(ReviewComment rcmt) {
//		sqlSession.update("MYPAGE.deleteRcmtList", rcmt);
//		
//	}

	//복권 구매 내역 카운트
	public int selectPmContentCnt(int uno) {
		return sqlSession.selectOne("MYPAGE.selectPmContentCnt", uno);
	}

	//복권 구매 내역 리스트
	public List<Order> selectPmList(Paging p, int uno) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("p",p);
		param.put("uno", uno);
		return sqlSession.selectList("MYPAGE.selectPmList", param);
	}
	
	//보유복권 수량 카운트
	public int selecTkCnt(int uno) {
		return sqlSession.selectOne("MYPAGE.selecTkCnt", uno);
	}

	//복권구매내역 삭제(isdel = 1)
//	public void deletepmList(Order order) {
//		sqlSession.update("MYPAGE.deletepmList", order);
//		
//	}
	//복권구매내역 삭제
	public void deletepmList(Order order) {
		sqlSession.delete("MYPAGE.deletepmList", order);
		
	}

	//(함께가요 ) 신청한 동행 카운트
	public int selectApDhContentCnt(int uno) {
		return sqlSession.selectOne("MYPAGE.selectApDhContentCnt", uno);
	}

	//(함께가요) 신청한 동행 리스트
	public List<GoApply> selectApDhList(Paging p, int uno) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("p",p);
		param.put("uno", uno);
		return sqlSession.selectList("MYPAGE.selectApDhList", param);
	}

	//(함께 가요) 신청한 동행 삭재
	public void deleteAplyDhList(GoApply goapply) {
		sqlSession.delete("MYPAGE.deleteApDhList", goapply);
	}

	//(함께 해요) 신청한 동행 카운트
	public int selectDoApDhContentCnt(int uno) {
		return sqlSession.selectOne("MYPAGE.selectDoApDhContentCnt", uno);
	}

	//(함께 해요) 신청한 동행 리스트
	public List<DoApply> selectDoApDhList(Paging p, int uno) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("p",p);
		param.put("uno", uno);
		return sqlSession.selectList("MYPAGE.selectDoApDhList", param);
	}

	//(함께 해요) 신청한 동행 삭제
	public void deleteDoAplyDhList(DoApply doapply) {
		sqlSession.delete("MYPAGE.deleteDoAplyDhList", doapply);
	}

	//나의 동행 (함께 가요) 카운트
	public int selectMyGoDhContentCnt(int uno) {
		return sqlSession.selectOne("MYPAGE.selectMyGoDhContentCnt", uno);
	}

	//나의 동행 (함께 가요) 리스트
	public List<GoBoard> selectMyGoDhList(Paging p, int uno) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("p",p);
		param.put("uno", uno);
		return sqlSession.selectList("MYPAGE.selectMyGoDhList", param);
	}

	//현재 수락된 인원
	public int selectRecruitNumCnt(int gbno, String gbcategory ) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("gbno", gbno);
		param.put("gbcategory", gbcategory);
		int res = sqlSession.selectOne("MYPAGE.selectRecruitNumCnt", param);
		System.out.println("신청자수  : " + res);
		
		return sqlSession.selectOne("MYPAGE.selectRecruitNumCnt", param);
	}

	

//	//(함께 가요)동행 신청자 리스트 카운트
//	public int selectrecruitContentCnt(int gbno , String gbcategory) {		
//		Map<String, Object> param = new HashMap<String, Object>();
//		param.put("gbno", gbno);
//		param.put("gbcategory", gbcategory);
//		System.out.println( "신청자 리스트 : " + param);
//		return sqlSession.selectOne("MYPAGE.selectrecruitContentCnt",param);
//	}
	
	//신청자 리스트
	public List<User> selectrecruitList(int gbno, String gbcategory) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("gbno", gbno);
		param.put("gbcategory", gbcategory);
		return sqlSession.selectList("MYPAGE.selectrecruitList", param);
	}

	//신청 수락
	public void acceptApply(int aplyuno, int bano, int cate) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("aplyuno", aplyuno);
		param.put("bano", bano);
		param.put("cate", cate);
		sqlSession.update("MYPAGE.acceptApply", param);		
	}

	//신청 거절
	public void acceptRefuse(int aplyuno, int bano, int cate) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("aplyuno", aplyuno);
		param.put("bano", bano);
		param.put("cate", cate);
		sqlSession.update("MYPAGE.acceptRefuse", param);	
		
	}

	//나의 동행리스트 삭제(isdel = 1)
//	public void deleteMyDhList(int bno, String cate) {
//		Map<String, Object> param = new HashMap<String, Object>();
//		param.put("bno", bno);
//		param.put("cate", cate);
//		sqlSession.update("MYPAGE.deleteMyDhList", param);
//	}
	//나의 동행리스트 삭제
	public void deleteMyDhList(int bno, String cate) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("bno", bno);
		param.put("cate", cate);
		sqlSession.delete("MYPAGE.deleteMyDhList", param);
	}

	//동행복권 사용내역 개수
	public int selectUsingContentCnt(int uno) {
		return sqlSession.selectOne("MYPAGE.selectUsingContentCnt", uno);
	}
	
	//동행복권 사용내역 리스트
	public List<ReviewDhTicket> selectUsingdList(Paging p, int uno) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("p",p);
		param.put("uno", uno);
		return sqlSession.selectList("MYPAGE.selectUsingdList", param);
	}










	
}
