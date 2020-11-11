package com.DongHang_ComeFunny.www.model.service.board;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.DongHang_ComeFunny.www.model.vo.FreeBoard;
import com.DongHang_ComeFunny.www.model.vo.FreeComment;

import common.exception.FileException;

public interface FreeBoardService {
	
	/**
	 * 게시글 작성(파일업로드 포함)
	 * @param free - 작성할 자유게시판 객체(fbuno, fbtitle, fbcontent, fbwrittendate)
	 * @param files - MultpartFile
	 * @param root - 서버에 업로드한 경로
	 * @return
	 * @throws FileException
	 */
	public int insertFree(
			//Controller가 보내준
			//사용자가 등록한 파일 정보를 가지고 있는 리스트
			FreeBoard free
			, List<MultipartFile> files
			, String root
			) throws FileException;
	
	/**
	 * 게시글 리스트 조회(페이지네이션 포함), 게시글 검색 페이지 구현시 안 쓰임
	 * @param cPage - 현재페이지
	 * @param cntPerPage - 페이지당 게시글 갯수
	 * @return 페이징,자유게시글 테이블 조회
	 */
	public Map<String, Object> selectFreeList(int cPage, int cntPerPage);
	
	/**
	 * 게시글 상세보기 조회
	 * @param fbNo - 자유게시판 번호
	 * @return 회원, 자유게시판 테이블 조회
	 */
	public Map<String, Object> selectFreeView(int fbNo);

	/**
	 * 게시글 업로드된 파일 삭제
	 * @param ffNo - 자유파일 번호
	 * @return 성공 : 1, 실패 : 0
	 */
	public int deleteFreeFile(int ffNo);

	/**
	 * 게시글 수정하기
	 * @param freeboard - 자유게시글 객체
	 * @param files - orginalFileName, fileSize 값이 담긴 MultipartFile
	 * @param root - 업로드할 파일경로
	 * @return 성공 : 1, 실패 : 0
	 * @throws FileException - ExceptionCotroller에 의해 파일업로드 실패시 에러메시지 출력
	 */
	public int updateFreeModify(FreeBoard freeboard, List<MultipartFile> files, String root) throws FileException;

	/**
	 * 게시글 삭제하기
	 * @param fbNo - 삭제할 게시글 번호
	 * @return 성공 : 1, 실패 : 0
	 */
	public int deleteFreeBoard(int fbNo);

	/**
	 * 댓글 작성하기
	 * @param freeComment - 댓글번호(fcno), 댓글내용(fccontent), 댓글 작성자(fcuno)가 담긴 객체 
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertFreeComment(FreeComment freeComment);
	
	/**
	 * 댓글 리스트 조회하기
	 * @param fbNo - 댓글 리스트를 불러올 자유게시글 번호
	 * @return key-value쌍으로 리스트 출력 
	 */
	public List<Map<String, Object>> selectFreeCommentList(int fbNo);

	/**
	 * 댓글 수정하기 
	 * @param freeComment - 수정할 댓글번호, 댓글내용이 담긴 객체
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updateFreeContent(FreeComment freeComment);

	/**
	 * 댓글 삭제하기
	 * @param freeComment - 삭제할 댓글번호, 댓글내용이 담긴 객체
	 * @return 성공 : 1, 실패 : 0
	 */
	public int deleteFreeComment(FreeComment freeComment);

	/**
	 * 검색된 게시글 리스트 페이징 처리
	 * @param cPage - 현재 페이지
	 * @param cntPerPage - 페이지당 조회될 게시글 개수
	 * @param searchFreeList - 검색 카테고리, 키워드가 담긴 객체
	 * @return
	 */
	public Map<String, Object> selectFreeSearchList(int cPage, int cntPerPage, Map<String, Object> searchFreeList);




	
	
}
