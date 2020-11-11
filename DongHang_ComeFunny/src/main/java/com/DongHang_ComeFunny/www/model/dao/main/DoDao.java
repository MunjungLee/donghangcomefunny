package com.DongHang_ComeFunny.www.model.dao.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.DongHang_ComeFunny.www.model.vo.DoBoard;
import com.DongHang_ComeFunny.www.model.vo.DoCheck;
import com.DongHang_ComeFunny.www.model.vo.DoImg;

@Repository
public class DoDao {
	
	@Autowired private SqlSessionTemplate sqlSession;

	//doboard에 값 삽입
	public int insertDoBoard(DoBoard doBoard) {
		return sqlSession.insert("DO.insertdoboard", doBoard);
	}

	//gocheck에 값 삽입
	public int insertDoAge(List<String> age) {
		return sqlSession.insert("DO.insertdoage", age);
	}
	
	//docheck에 값 삽입
	public int insertDoTheme(List<String> theme) {
		return sqlSession.insert("DO.insertdotheme", theme);
	}
	
	//fileboard에 삽입
	public int insertDoImg(Map<String, String> fileInfo) {
		return sqlSession.insert("DO.insertfile",fileInfo);
	}

	//기본리스트띄우기 
	public List<Map<String, Object>> selectDolist(Map<String, Object> map) {
		return sqlSession.selectList("DO.selectdolist", map);
	}
	
	//검색
	public List<Map<String, Object>> selectSearchList(Map<String, Object> search) {
		System.out.println("[DODAO]"); 
		return sqlSession.selectList("DO.selectdosearch", search);
	}

	//필터링
	public List<Map<String, Object>> selectFilterList(Map<String, Object> filter) {
		return sqlSession.selectList("DO.selectfilterlist", filter); 
	}

	
	//------------수정
	
	//함께해요 글정보
	public DoBoard selectDoboard(int dbNo){
		return sqlSession.selectOne("DO.selectdoboard",dbNo);
	}

	//함께해요 체크박스
	public Map<String, Object> selectDocheck(int dbNo){
		return sqlSession.selectOne("DO.selectdocheck",dbNo);
	}

	//함께해요 게시글별 이미지 가지고오기
	public List<Map<String, String>> selectDoimg(int dbNo){
		return sqlSession.selectList("DO.selectdoimg",dbNo);
	}

	//함께해요 수정
	public int updateDoboard(DoBoard doBoard) {
		return sqlSession.update("DO.updatedoboard", doBoard);
	}

	//이미지 수정시 업데이트
	public int updateDoImg(Map<String, String> fileInfo) {
		return sqlSession.insert("DO.insertdoimg", fileInfo);
	}
	
	//함께해요 이미지 별 정보
	public DoImg selectDinoimg(int diNo) {
		return sqlSession.selectOne("DO.selectdinoimg", diNo);
	}

	//함께해요 이미지 삭제
	public int deletDoimg(int diNo) {
		return sqlSession.delete("DO.deletedoimg", diNo);
	}

	//----상세보기
	
	//게시글 상세 정보
		public List<Object> selectDoDetail(int dbno) {
			return sqlSession.selectList("DO.selectDoDetail",dbno);
		}

		//후기정보
		public List<Object> selectdoReview(int dbno) {
			return sqlSession.selectList("DO.selectdoReview",dbno);
		}

		//작성자 정보
		public List<Object> selectHostInfo(int dbno) {
			return sqlSession.selectList("DO.selectHostInfo",dbno);
		}

		public List<Object> selectApplyList(int dbno) {
			return sqlSession.selectList("DO.selectApplyList",dbno);
		}

		public List<Object> selectplacePhoto(int dbno) {
			return sqlSession.selectList("DO.selectplacePhoto",dbno);
		}

		//동행수락
		public int acceptdh(int uno, int dbno) {
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("uno", uno);
			param.put("dbno", dbno);
			
			return sqlSession.update("DO.updateApplyStatus", param);
		}

		public int refusedh(int uno, int dbno) {
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("uno", uno);
			param.put("dbno", dbno);
			
			return sqlSession.update("DO.updateApplyRefuseStatus", param);
		}

		//신청하기
		public int applyDh(int uno, int dbno) {
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("uno", uno);
			param.put("dbno", dbno);
			
			return sqlSession.insert("DO.insertapplyDh", param);
		}

		public int applychk(int uno, int dbno) {
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("uno", uno);
			param.put("dbno", dbno);
			
			return sqlSession.selectOne("DO.selectCountApplychk", param);
		}

		public int likeStatus(int uno, int dbno) {
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("uno", uno);
			param.put("dbno", dbno);
			return sqlSession.selectOne("DO.countLikeStatus", param);
		}

		public int insertDoLike(int dbno, int uno) {
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("uno", uno);
			param.put("dbno", dbno);
			return sqlSession.insert("DO.insertDoLike", param);
		}

		public int deleteDoLike(int dbno, int uno) {
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("uno", uno);
			param.put("dbno", dbno);
			return sqlSession.delete("DO.deleteDoLike", param);
		}

		public int deleteDoDetail(int dbno) {
			return sqlSession.update("DO.deleteDoDetail", dbno);
		}

		//찜수 증가
		public int updatelikecnt(int dbno) {
			return sqlSession.update("DO.updatelikecnt", dbno);
		}

		//찜수 감소
		public int deletelikecnt(int dbno) {
			return sqlSession.update("DO.deletelikecnt", dbno);
		}



	

}
