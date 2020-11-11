package com.DongHang_ComeFunny.www.model.service.mypage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DongHang_ComeFunny.www.model.dao.mypage.FboardListDao;
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

@Service 
public class FboardListServiceImpl implements FboardListService{
	@Autowired
	FboardListDao fboardlistDao;

	public Map<String, Object> selectFboardList(int cPage, int cntPerPage, int uno) {
		
		Map<String, Object> commandMap = new HashMap<String, Object>();
		Paging p = new Paging(fboardlistDao.selectFbContentCnt(uno), cPage, cntPerPage);
		
		int fcCnt = fboardlistDao.selectFcommentCnt(uno);
		
		List<FreeBoard> flist = fboardlistDao.selectFboardList(p,uno);
		commandMap.put("fclist", fcCnt);
		commandMap.put("flist", flist);
		commandMap.put("paging",p);
		
//		System.out.println(commandMap);
		
		return commandMap;
	}

	@Override
	public void deleteFboardList(FreeBoard fboard) {
		fboardlistDao.deleteFboardList(fboard);
	}

	@Override
	public Map<String, Object> selectRboardList(int cPage, int cntPerPage, int uno) {
		Map<String, Object> commandMap = new HashMap<String, Object>();
		Paging p = new Paging(fboardlistDao.selectRbContentCnt(uno), cPage, cntPerPage);
		
		int rcCnt = fboardlistDao.selectRbcommentCnt(uno);
		
		List<ReviewBoard> rlist = fboardlistDao.selectRboardList(p,uno);
		commandMap.put("rclist", rcCnt);
		commandMap.put("rlist", rlist);
		commandMap.put("paging",p);
		
		System.out.println(commandMap);
		
		return commandMap;
	}

	@Override
	public void deleteRboardList(ReviewBoard rboard) {
		fboardlistDao.deleteRboardList(rboard);
		
	}

	@Override
	public ReviewBoard selectReviewBoardByDH(ReviewBoard rboard) {
		return fboardlistDao.selectReviewBoardByDH(rboard);
	}
	
	@Override
	public int updateDhStarBydelete(ReviewBoard review) {
		// 1. 결과값 넣을 빈 int 값 생성
		int result = 0;
		if(review.getRbGbNo() > 0 ) {
			int cntgb = fboardlistDao.selectReviewBoardByRbGbNo(review.getRbGbNo());
			if( cntgb > 1) {
				Map<String, Object> reviewStarGo = fboardlistDao.selectReviewGbAvg(review.getRbGbNo());
				reviewStarGo.put("gbNo",review.getRbGbNo());
				result = fboardlistDao.updateGoAvgByZero(reviewStarGo);
				return result;
			} else {
				Map<String,Object> reviewZero = new HashMap<>();
				reviewZero.put("RBDHSTARAVG",0);
				reviewZero.put("RBHOSTSTARAVG",0);
				reviewZero.put("gbNo",review.getRbGbNo());
				result = fboardlistDao.updateGoAvgByZero(reviewZero);
				return result;
			}
		} else if(review.getRbDbNo() > 0) {
			int cntdb = fboardlistDao.selectReviewBoardByRbDbNo(review.getRbDbNo());
			if( cntdb > 1 ) {
				Map<String, Object> reviewStarDo = fboardlistDao.selectReviewDbAvg(review.getRbDbNo());
				reviewStarDo.put("gbNo",review.getRbDbNo());
				result = fboardlistDao.updateDoAvgByZero(reviewStarDo);
				return result;
			} else {
				Map<String,Object> reviewZero = new HashMap<>();
				reviewZero.put("RBDHSTARAVG",0);
				reviewZero.put("RBHOSTSTARAVG",0);
				reviewZero.put("gbNo",review.getRbDbNo());
				result = fboardlistDao.updateDoAvgByZero(reviewZero);
				return result;
			}
		}
		return result;
	}

	@Override
	public Map<String, Object> selectFcmtList(int cPage, int cntPerPage, int uno) {
		Map<String, Object> commandMap = new HashMap<String, Object>();
		Paging p = new Paging(fboardlistDao.selectCbContentCnt(uno), cPage, cntPerPage);
		
		List<FreeComment> clist = fboardlistDao.selectFcmtList(p,uno);
		commandMap.put("clist", clist);
		commandMap.put("paging",p);
		
//		System.out.println("CBoard commandMap : " + commandMap);
		
		return commandMap;
	}

	@Override
	public void deleteFcmtList(FreeComment fcmt) {
		fboardlistDao.deletefcmtList(fcmt);
		
	}
	
	@Override
	public void deleteRcmtList(ReviewComment rcmt) {
		fboardlistDao.deleteRcmtList(rcmt);
	}

	@Override
	public Map<String, Object> selectRcmtList(int cPage, int cntPerPage, int uno) {
		Map<String, Object> commandMap = new HashMap<String, Object>();
		Paging p = new Paging(fboardlistDao.selectRcmtContentCnt(uno), cPage, cntPerPage);
		
		List<ReviewComment> rclist = fboardlistDao.selectRcmtList(p,uno);
		commandMap.put("rclist", rclist);
		commandMap.put("paging",p);
		
//		System.out.println("CBoard commandMap : " + commandMap);
		
		return commandMap;
	}

	@Override
	public Map<String, Object> paymentList(int cPage, int cntPerPage, int uno) {
		Map<String, Object> commandMap = new HashMap<String, Object>();
		Paging p = new Paging(fboardlistDao.selectPmContentCnt(uno), cPage, cntPerPage);
		
		int tkCnt = fboardlistDao.selecTkCnt(uno);
		List<Order> pmlist = fboardlistDao.selectPmList(p,uno);
		commandMap.put("tkCnt", tkCnt);
		commandMap.put("pmlist", pmlist);
		commandMap.put("paging",p);
		
//		System.out.println(commandMap);
		
		return commandMap;
	}

	@Override
	public void deletePmList(Order order) {
		fboardlistDao.deletepmList(order);
	}

	@Override
	public Map<String, Object> selectApDhList(int cPage, int cntPerPage, int uno) {
		Map<String, Object> commandMap = new HashMap<String, Object>();
		Paging p = new Paging(fboardlistDao.selectApDhContentCnt(uno), cPage, cntPerPage);
		
		List<GoApply> apdhList = fboardlistDao.selectApDhList(p,uno);
		commandMap.put("apdhList", apdhList);
		commandMap.put("paging",p);
		
//		System.out.println("apdhList commandMap : " + commandMap);
		
		return commandMap;
	}

	@Override
	public void deleteAplyDhList(GoApply goapply) {
		fboardlistDao.deleteAplyDhList(goapply);
		
	}

	@Override
	public Map<String, Object> selectDoApDhList(int cPage, int cntPerPage, int uno) {
		Map<String, Object> commandMap = new HashMap<String, Object>();
		Paging p = new Paging(fboardlistDao.selectDoApDhContentCnt(uno), cPage, cntPerPage);
		
		List<DoApply> doapdhList = fboardlistDao.selectDoApDhList(p,uno);
		commandMap.put("doapdhList", doapdhList);
		commandMap.put("paging",p);
		
//		System.out.println("doapdhList commandMap : " + commandMap);
		
		return commandMap;
	}

	@Override
	public void deleteDoAplyDhList(DoApply doapply) {
		fboardlistDao.deleteDoAplyDhList(doapply);
	}

	@Override
	public Map<String, Object> selectMyGoDhList(int cPage, int cntPerPage, int uno) {
		Map<String, Object> commandMap = new HashMap<String, Object>();
		Paging p = new Paging(fboardlistDao.selectMyGoDhContentCnt(uno), cPage, cntPerPage);

//		Map<String, Object> recruitMap = new LinkedHashMap<String, Object>();
		List<Object> recruitednum = new ArrayList<>();
		List<Object> recruit =  new ArrayList<>();
		List<GoBoard> mygodhList = fboardlistDao.selectMyGoDhList(p,uno);

		
		
		for (int i=0 ; i<mygodhList.size(); i++) {
			int myrecruitnum = fboardlistDao.selectRecruitNumCnt(mygodhList.get(i).getGbNo(), mygodhList.get(i).getGbCategory());
			System.out.println(i+" 수락된 모집인원 : " + myrecruitnum);
			recruitednum.add(i,myrecruitnum);
//			List<Object> recruitList = fboardlistDao.selectrecruitList(p,mygodhList.get(i).getGbNo(),mygodhList.get(i).getGbcategory());
//			System.out.println("recruitList : " + recruitList);
//			commandMap.put("recruitList"+i, recruitList);
//			recruit.add(i,recruitList);
		}
		
		commandMap.put("mygodhList", mygodhList);
		commandMap.put("paging",p);				
		commandMap.put("recruitnum", recruitednum);
//		commandMap.put("recruit", recruit);
		System.out.println("********** mygodhList commandMap : " + commandMap);
		
		return commandMap;
	}

	@Override
	public Map<String, Object> selectrecruitList(String gbcategory, int gbno, int cPage, int cntPerPage) {
		Map<String, Object> commandMap = new HashMap<String, Object>();
		List<User> recruitedList = fboardlistDao.selectrecruitList(gbno,gbcategory);
		
		commandMap.put("recruitedList", recruitedList);
		return commandMap ;
	}

	//신청수락
	@Override
	public void acceptApply(int aplyuno, int bano, int cate) {
		fboardlistDao.acceptApply(aplyuno , bano, cate);
	}

	//신청 거절
	@Override
	public void acceptRefuse(int aplyuno, int bano, int cate) {
		fboardlistDao.acceptRefuse(aplyuno , bano, cate);
		
	}

	//나의 동행 관리
	@Override
	public void deleteMyDhList(String param) {
		String data[] = param.split(",");
		int bno = Integer.parseInt(data[0]);
		String cate = data[1];
		fboardlistDao.deleteMyDhList(bno,cate);
		
	}

	//동행복권 사용내역
	@Override
	public Map<String, Object> selectUsingList(int cPage, int cntPerPage, int uno) {
			
		Map<String, Object> commandMap = new HashMap<String, Object>();
		Paging p = new Paging(fboardlistDao.selectUsingContentCnt(uno), cPage, cntPerPage);
		
		int tkCnt = fboardlistDao.selecTkCnt(uno);
		List<ReviewDhTicket> ulist = fboardlistDao.selectUsingdList(p,uno);
		commandMap.put("tkCnt", tkCnt);
		commandMap.put("ulist", ulist);
		commandMap.put("paging",p);
		
//			System.out.println(commandMap);
		
		return commandMap;
	}


//	@Override
//	public Map<String, Object> selectrecruitList(String gbcategory, int gbno, int cPage, int cntPerPage) {
//		Map<String, Object> commandMap = new HashMap<String, Object>();
//		
//		Paging p = new Paging(fboardlistDao.selectrecruitContentCnt(gbno, gbcategory), cPage, cntPerPage);
//		
//		List<Object> recruitList = fboardlistDao.selectrecruitList(p,gbno, gbcategory);
//		commandMap.put("recruitList", recruitList);
//		commandMap.put("paging",p);
//		
//		System.out.println("recruitList commandMap : " + commandMap);
//		
//		return commandMap;
//	}

//	@Override
//	public Map<String, Object> selectMyGoDhList(int cPage, int cntPerPage, int uno, int gbno) {
//		Map<String, Object> commandMap = new HashMap<String, Object>();
//		Paging p = new Paging(fboardlistDao.selectMyGoDhContentCnt(uno), cPage, cntPerPage);
//
////		Map<String, Object> recruitMap = new LinkedHashMap<String, Object>();
//		List<Object> recruitnum = new ArrayList<>();
//		List<GoBoard> mygodhList = fboardlistDao.selectMyGoDhList(p,uno);
//
//		commandMap.put("mygodhList", mygodhList);
//		commandMap.put("paging",p);
//		
//		for (int i=0 ; i<mygodhList.size(); i++) {
//			int myrecruitnum = fboardlistDao.selectRecruitNumCnt(mygodhList.get(i).getGbNo(), mygodhList.get(i).getGbcategory());
////			System.out.println(i+" 수락된 모집인원 : " + myrecruitnum);
//			recruitnum.add(i,myrecruitnum);
//			
//			List<Object> recruitList = fboardlistDao.selectrecruitList(p,gbno,mygodhList.get(i).getGbcategory());
//			commandMap.put("recruitList", recruitList);		
//		}
//		commandMap.put("recruitnum", recruitnum);
//		System.out.println("********** mygodhList commandMap : " + commandMap);
//		
//		return commandMap;
//	}
	
		
}
