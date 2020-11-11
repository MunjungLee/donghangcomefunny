package com.DongHang_ComeFunny.www.model.service.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.DongHang_ComeFunny.www.model.dao.board.FreeBoardDao;
import com.DongHang_ComeFunny.www.model.vo.FreeBoard;
import com.DongHang_ComeFunny.www.model.vo.FreeComment;

import common.exception.FileException;
import common.util.FileUtil;
import common.util.Paging;

//bean으로 서비스 등록
@Service
public class FreeBoardServiceImpl implements FreeBoardService {
	// DAO 의존성 주입
	@Autowired
	private FreeBoardDao freeBoardDao;
	
	/**
	 * 게시글 작성(파일업로드 포함)
	 * @param free - 작성할 자유게시판 객체(fbuno, fbtitle, fbcontent, fbwrittendate)
	 * @param files - MultpartFile
	 * @param root - 서버에 업로드한 경로
	 * @return
	 * @throws FileException
	 */
	@Override
	public int insertFree(
			FreeBoard free
			, List<MultipartFile> files
			, String root
			) throws FileException  {
		// 1. 제목없거나 내용이 없이 게시글을 올렸을 경우
		if(free.getFbTitle()==null || "".equals(free.getFbTitle()) ) {
			free.setFbTitle("<제목없음>");
		} 
		if(free.getFbContent()==null || "".equals(free.getFbContent()) ) {
			free.setFbContent("<내용없음>");
		}
		// 2. 파일업로드 없이 게시글 정보만 넣기
		int result = freeBoardDao.insertFree(free);
		// 3. 파일 업로드를 위한 fileUtil 생성
		FileUtil fileUtil = new FileUtil();
		// 4. 파일을 업로드하도록 처리(Map에는 originFileName, storedFileName, savePath, fileSize 등이 저장되어 있음)
		List<Map<String, Object>> filedata = fileUtil.fileUpload(files, root);
		
		//-----------------업로드 된 원본이름---------------------------------
		System.out.println("listmap[1] : "+filedata.get(0).get("originFileName"));
		//--------------------------------------------------------------------
		
		// 5.원본 파일명이 없거나 이름이 없다면 반환
		if( filedata.get(0).get("originFileName") == null || "".equals(filedata.get(0).get("originFileName"))) {
			return result;
		}
		// 6.다중 파일을 처리함
		for(Map<String, Object> data : filedata) {
			//file 테이블에 파일과 관련된 정보를 저장
			freeBoardDao.insertFile(data);
		}
		// 7.결과값 반환
		return result;
		
	}
	
	/**
	 * 게시글 리스트 조회(페이지네이션 포함), 게시글 검색 페이지 구현시 안 쓰임
	 * @param cPage - 현재페이지
	 * @param cntPerPage - 페이지당 게시글 갯수
	 * @return 페이징,자유게시글 테이블 조회
	 */
	@Override
	public Map<String, Object> selectFreeList(
			//현재 페이지
			int cPage 
			//페이지당 노출할 게시글 수
			, int cntPerPage) {
		// 1. 빈 커맨드맵 객체 생성
		Map<String, Object> commandMap = new HashMap<>();
		// 2. 페이징 객체 생성과 동시에 파라미터값(전체 게시글 개수, 현재페이지, 페이지당 게시글 개수) 넣기
		Paging page = new Paging(freeBoardDao.selectContentCnt(), cPage, cntPerPage);
		// 3. 페이징 처리하여 게시글 리스트 조회
		List<Map<String, Object>> flist = freeBoardDao.selectFreeList(page);
		// 4. 페이징 객체와 조회한 게시글 리스트를 커맨드맵에 넣기
		commandMap.put("flist", flist);
		commandMap.put("paging", page);
		// 5. 커맨드맵 반환
		return commandMap;
	}
	
	/**
	 * 게시글 리스트 조회(페이지네이션 포함), 게시글 검색 페이지 구현시 안 쓰임
	 * @param cPage - 현재페이지
	 * @param cntPerPage - 페이지당 게시글 갯수
	 * @return 페이징,자유게시글 테이블 조회
	 */
	@Override
	public Map<String, Object> selectFreeView(int fbNo) {
		// 1. 게시글 번호로 게시글 상세보기 조회(회원, 자유게시글 테이블)
		Map<String, Object> fdetail = freeBoardDao.selectFreeDetail(fbNo);
		
		// ----------------------DAO에서 제대로 조회되었는지 확인하기-------------------
		System.out.println("[ServiceImpl] - fdetail Map : " + fdetail);
		// -----------------------------------------------------------------------------
		
		// 2. 게시글 상세보기 페이지로 이동시, 조회수 증가시키기
		if(fdetail != null) {
			freeBoardDao.updateHit(fdetail);
		}
		// 3. 조회수 증가시킨 상세보기 조회(회원, 자유게시글 테이블)
		fdetail = freeBoardDao.selectFreeDetail(fbNo);
		// 4. 자유게시글과 업로드된 파일 목록 리스트 조회(자유게시글, 자유파일)
		List<Map<String, Object>> filelist = freeBoardDao.selectFileWithFree(fbNo);
		// 5. 빈 커맨드 객체 생성
		Map<String, Object> commandMap = new HashMap<>();
		// 6. 자유게시글 리스트와 파일리스트를 커맨드맵에 넣기
		commandMap.put("detail", fdetail);
		commandMap.put("filelist", filelist);
		// 7. 커맨드맵 반환
		return commandMap;
	}
	
	/**
	 * 게시글 상세보기 조회
	 * @param fbNo - 자유게시판 번호
	 * @return 회원, 자유게시판 테이블 조회
	 */
	@Override
	public int deleteFreeFile(int ffNo) {
		// 1. 파일 번호로 게시글 파일 목록 조회
		Map<String, String> fileData = freeBoardDao.selectFreeFile(ffNo);
		// 2. 빈 파일유틸 객체 생성
		FileUtil fileUtil = new FileUtil();
		// 3. 파일 저장경로에 있는 파일 삭제 처리
		fileUtil.deleteFile(fileData.get(("FFSAVEPATH")));

		// 4. isdel 컬럼값 0 -> 1로 변경
//		int res = freeBoardDao.updateFileIsDel(ffNo); // isdel 0을 1로 변경
		int res = freeBoardDao.deleteFile(ffNo); // 파일완전 삭제
		return res;
	}
	
	/**
	 * 게시글 업로드된 파일 삭제
	 * @param ffNo - 자유파일 번호
	 * @return 성공 : 1, 실패 : 0
	 */
	@Override
	public int updateFreeModify(
		FreeBoard free
		, List<MultipartFile> files
		, String root
		) throws FileException  {
		// 1. 제목없거나 내용이 없이 게시글을 올렸을 경우
		if(free.getFbTitle()==null || "".equals(free.getFbTitle()) ) {
			free.setFbTitle("<제목없음>");
		} 
		if(free.getFbContent()==null || "".equals(free.getFbContent()) ) {
			free.setFbContent("<내용없음>");
		}
		// 2. 파일업로드 없이 게시글 정보만 넣기
		int result = freeBoardDao.updateFree(free);
		// 3. 파일 업로드를 위한 fileUtil 생성
		FileUtil fileUtil = new FileUtil();
		// 4.  파일을 업로드하도록 처리(Map에는 originFileName, storedFileName, savePath, fileSize 등이 저장되어 있음)
		List<Map<String, Object>> filedata = fileUtil.fileUpload(files, root);
		//-----------------업로드 된 원본이름---------------------------------
		System.out.println("listmap[1] : "+filedata.get(0).get("originFileName"));
		System.out.println("listmap 전체 : " + filedata);
		//--------------------------------------------------------------------
		// 5.원본 파일명이 없거나 이름이 없다면 반환
		if( filedata.get(0).get("originFileName") == null || "".equals(filedata.get(0).get("originFileName"))) {
			return result;
		}
		// 6.다중 파일을 처리함
		for(Map<String, Object> data : filedata) {
			//file 테이블에 파일과 관련된 정보를 저장
			//fbno
			data.put("fbNo", free.getFbNo());
			//fbno, fforiginName, ffStroedName, fffileSize, ffsavePath
			System.out.println("data : "+data);
			freeBoardDao.modifyFreeFile(data);
		}
		// 7.결과값 반환
		return result;
	}
	
	/**
	 * 게시글 삭제하기
	 * @param fbNo - 삭제할 게시글 번호
	 * @return 성공 : 1, 실패 : 0
	 */
	@Override
	public int deleteFreeBoard(int fbNo) {
		// 1. 게시글 번호로 해당 게시글에 업로드된 파일 삭제(isDel = 1)
//		freeBoardDao.deleteFreeFileByFbno(fbNo);
		// 2. 게시글 번호로 해당 게시글 삭제
		int res = freeBoardDao.deleteFreeBoard(fbNo);
		// 성공 : 1, 실패 : 0
		return res;
	}

	/**
	 * 댓글 작성하기
	 * @param freeComment - 댓글번호(fcno), 댓글내용(fccontent), 댓글 작성자(fcuno)가 담긴 객체 
	 * @return 성공 : 1, 실패 : 0
	 */
	@Override
	public int insertFreeComment(FreeComment freeComment) {
		// 1. 내용없으면 fcContent에 "<내용없음>" 넣기
		if(freeComment.getFcContent()==null || "".equals(freeComment.getFcContent()) ) {
			freeComment.setFcContent("<내용없음>");
		}
		
		// --------------받아온 파라미터값 확인 : 자유게시판 댓글 제목, 내용--------------------
		System.out.println("[serviceimpl] FreeComment : "+freeComment);
		// -------------------------------------------------------------------------------------
		
		// 2. DB에 댓글 내용 입력하기
		int result = freeBoardDao.insertFreeComment(freeComment);
		
		// 3. 성공 : 1, 실패 : 0
		return result;
	}
	
	/**
	 * 댓글 리스트 조회하기
	 * @param fbNo - 댓글 리스트를 불러올 자유게시글 번호
	 * @return key-value쌍으로 리스트 출력 
	 */
	@Override
	public List<Map<String, Object>> selectFreeCommentList(int fbNo) {
		// 1. 게시글 번호로 댓글 리스트 조회
		List<Map<String, Object>> freeComment = freeBoardDao.selectFreeCommentList(fbNo);
		// 2. 조회된 리스트 반환
		return freeComment;
	}
	
	/**
	 * 댓글 수정하기 
	 * @param freeComment - 수정할 댓글번호, 댓글내용이 담긴 객체
	 * @return 성공 : 1, 실패 : 0
	 */
	@Override
	public int updateFreeContent(FreeComment freeComment) {
		// 1. 수정된 댓글 내용 DB에 반영
		return freeBoardDao.updateFreeContent(freeComment);
	}
	
	/**
	 * 댓글 삭제하기
	 * @param freeComment - 삭제할 댓글번호, 댓글내용이 담긴 객체
	 * @return 성공 : 1, 실패 : 0
	 */
	@Override
	public int deleteFreeComment(FreeComment freeComment) {
		// 1. 댓글 삭제 시, isdel=0을 1로 변경
//		return freeBoardDao.updateFreeCommentIsDEl(freeComment);
		// 2. 댓글 완전 삭제
		return freeBoardDao.deleteFreeComment(freeComment);
	}
	
	/**
	 * 검색된 게시글 리스트 페이징 처리
	 * @param cPage - 현재 페이지
	 * @param cntPerPage - 페이지당 조회될 게시글 개수
	 * @param searchFreeList - 검색 카테고리, 키워드가 담긴 객체
	 * @return
	 */
	@Override
	public Map<String, Object> selectFreeSearchList(int cPage, int cntPerPage, Map<String, Object> searchFreeList) {
		// 1. 빈 커맨드 객체 생성
		Map<String,Object> commandMap = new HashMap<String, Object>();
		// 2. 페이징 객체 생성과 동시에 파라미터값(전체 검색된 게시글 개수, 현재페이지, 페이지당 게시글 개수) 넣기
		Paging page = new Paging(freeBoardDao.selectFreeSearchCnt(searchFreeList), cPage, cntPerPage);
		// 검색된 카테고리 또는 키워드가 null이 아닌 경우,
		if(searchFreeList != null) {
			// 3. 빈 searchMap 객체 생성
			Map<String, Object> searchMap = new HashMap<>();
			// 4. 페이징 넣기
			searchMap.put("paging", page);
			searchMap.putAll(searchFreeList);
			
			// ------검색된 페이징 객체와 검색 카테고리, 키워드가 담긴 Map-------
			System.out.println("[ServiceImpl] selectFreeSearchList searchMap - "+searchMap);
			// ------------------------------------------------------------------
			
			// 5. 키워드로 검색된 게시글 리스트 조회
			List<Map<String,Object>> flist = freeBoardDao.selectFreeSearchList(searchMap) ;
			// ------검색된 카테고리와 키워드로 조회된 게시글 리스트 -------
			System.out.println("[ServiceImpl] selectFreeSearchList flist - "+flist);
			commandMap.put("flist",flist);
			commandMap.put("paging",page);
			
			// ------------- 검색된 페이징 객체와 검색된 게시글 리스트가 담긴 commandMap-----------
			System.out.println("[ServiceImpl] selectFreeSearchList commandMap" + commandMap);
			// ------------------------------------------------------------------------------------
			
		} else {
			// 6. 키워드 없을 경우 전체 게시글 리스트 조회
			Paging searchPage = new Paging(freeBoardDao.selectContentCnt(), cPage, cntPerPage);
			List<Map<String, Object>> flist = freeBoardDao.selectFreeList(page);
			commandMap.put("flist", flist);
			commandMap.put("paging", searchPage);
		}
		// 7. 결과값 반환
		return commandMap;

		
	}

}
