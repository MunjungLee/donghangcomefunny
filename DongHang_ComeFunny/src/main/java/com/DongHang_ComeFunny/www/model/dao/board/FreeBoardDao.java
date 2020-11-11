package com.DongHang_ComeFunny.www.model.dao.board;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.DongHang_ComeFunny.www.model.vo.FreeBoard;
import com.DongHang_ComeFunny.www.model.vo.FreeComment;

import common.util.Paging;

@Repository
public class FreeBoardDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	/**
	 * 게시글 작성하기
	 * @param free - 게시글 제목, 내용, 회원번호가 들어간 자유게시글 객체
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertFree(FreeBoard free) {
		return sqlSession.insert("FREE.insertFree", free);
	}
	
	/**
	 * tb_freefile에 게시글 파일정보 넣기  
	 * @param map
	 * @return
	 */
	public int insertFile(Map<String, Object> map) {
		return sqlSession.insert("FREE.insertFile", map);
	}
	
	/**
	 * 전체 게시글 개수 구하기
	 * @return 성공 : 1, 실패 : 0
	 */
	public int selectContentCnt() {
		return sqlSession.selectOne("FREE.selectContentCnt");
	}

	/**
	 * 페이징을 포함하여 게시글 리스트 조회
	 * @param page - 페이징 객체
	 * @return 리스트로 반환
	 */
	public List<Map<String, Object>> selectFreeList(Paging page) {
		return sqlSession.selectList("FREE.selectFreeList", page);
	}

	/**
	 * 게시글 상세보기 - 회원, 자유게시판 조인
	 * @param fbNo - 자유게시글 번호
	 * @return 맵 형태로 key-value쌍으로 반환
	 */
	public Map<String, Object> selectFreeDetail(int fbNo) {
		return sqlSession.selectOne("FREE.selectFreeDetail", fbNo);
	}

	/**
	 * 게시글 상세보기 - 자유게시판, 자유파일 조인
	 * @param fbNo - 자유게시글 번호
	 * @return 리스트로 반환
	 */
	public List<Map<String, Object>> selectFileWithFree(int fbNo) {
		return sqlSession.selectList("FREE.selectFileWithFree", fbNo);
	}

	/**
	 * 게시글 조회수 올리기
	 * @param fdetail - 게시글 번호가 담긴 맵
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updateHit(Map<String, Object> fdetail) {
		return sqlSession.update("FREE.updateHit",fdetail);
	}

	/**
	 * 게시글 파일정보 조회
	 * @param ffNo - 파일번호
	 * @return 조회된 파일 정보 반환
	 */
	public Map<String, String> selectFreeFile(int ffNo) {
		return sqlSession.selectOne("FREE.selectFreeFile",ffNo);
	}

	/**
	 * 게시글 파일 삭제(isDel = 0 -> 1)
	 * @param ffNo - 파일 번호
	 * @return 성공 : 1, 실패 : 0
	 */
//	public int updateFileIsDel(int ffNo) {
//		return sqlSession.update("FREE.updateFileIsDel", ffNo);
//	}
	/**
	 * 게시글 파일 완전 삭제
	 * @param ffNo - 파일 번호
	 * @return 성공 : 1, 실패 : 0
	 */
	public int deleteFile(int ffNo) {
		return sqlSession.delete("FREE.deleteFile", ffNo);
	}

	/**
	 * 게시글 정보 수정
	 * @param free - 수정할 내용이 저장된 자유게시판
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updateFree(FreeBoard free) {
		return sqlSession.update("FREE.updateFree",free);
	}
	
	/**
	 * 게시판 수정페이지에서 새로운 파일 등록하기
	 * @param data - 파일정보가 단긴 Map
	 * @return 성공 : 1, 실패 : 0
	 */
	public int modifyFreeFile(Map<String, Object> data) {
		return sqlSession.insert("FREE.modifyFreeFile",data);
	}

	/**
	 * 게시판 파일 삭제하기(isDel = 0 -> 1)
	 * @param fbNo - 게시판 번호로 파일 삭제
	 * @return 성공 : 1, 실패 : 0
	 */
//	public int deleteFreeFileByFbno(int fbNo) {
//		return sqlSession.update("FREE.updateFileIsDelByFbno", fbNo);
//	}

	/**
	 * 게시판 게시글 완전 삭제하기
	 * @param fbNo - 게시판 번호로 게시글 삭제
	 * @return 성공 : 1, 실패 : 0
	 */
	public int deleteFreeBoard(int fbNo) {
		return sqlSession.delete("FREE.deleteFreeBoard", fbNo);
	}

	/**
	 * 게시판 댓글 등록
	 * @param freeComment - 등록할 댓글 정보가 담긴 객체
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertFreeComment(FreeComment freeComment) {
		return sqlSession.insert("FREE.insertFreeComment", freeComment);
	}
	
	/**
	 * 게시판 댓글 리스트 조회
	 * @param fbNo - 댓글 리스트를 조회할 게시글 번호
	 * @return 리스트로 반환
	 */
	public List<Map<String, Object>> selectFreeCommentList(int fbNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FREE.selectFreeWithCommentList", fbNo);
	}
	
	/**
	 * 게시판 댓글 내용 수정
	 * @param freeComment - 수정된 댓글 정보가 담긴 객체
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updateFreeContent(FreeComment freeComment) {
		return sqlSession.update("FREE.updateFreeContent",freeComment);
	}

	/**
	 * 게시판 댓글 내용 삭제(isDel = 0 -> 1 )
	 * @param freeComment
	 * @return 성공 : 1, 실패 : 0
	 */
//	public int updateFreeCommentIsDEl(FreeComment freeComment) {
//		return sqlSession.update("FREE.updateFreeCommentIsDEl",freeComment);
//	}
	/**
	 * 게시판 댓글 내용 완전 삭제
	 * @param freeComment
	 * @return 성공 : 1, 실패 : 0
	 */
	public int deleteFreeComment(FreeComment freeComment) {
		return sqlSession.delete("FREE.deleteFreeComment",freeComment);
	}

	/**
	 * 검색된 게시글 전체 개수
	 * @param searchFreeList - 검색 카테고리와 키워드가 담긴 맵
	 * @return 성공 : 1, 실패 : 0
	 */
	public int selectFreeSearchCnt(Map<String, Object> searchFreeList) {
		return sqlSession.selectOne("FREE.selectFreeSearchCnt", searchFreeList);
	}

	/**
	 * 검색된 게시글 전체 리스트 조회
	 * @param searchMap - 검색 카테고리와 키워드, 페이징 객체가 담긴 맵
	 * @return 리스트로 반환
	 */
	public List<Map<String, Object>> selectFreeSearchList(Map<String, Object> searchMap) {
		return sqlSession.selectList("FREE.selectFreeSearchList", searchMap);
	}



	


}
