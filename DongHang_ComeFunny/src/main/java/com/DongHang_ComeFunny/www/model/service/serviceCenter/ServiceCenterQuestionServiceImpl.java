package com.DongHang_ComeFunny.www.model.service.serviceCenter;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.DongHang_ComeFunny.www.model.dao.serviceCenter.ServiceCenterQuestionDao;
import com.DongHang_ComeFunny.www.model.vo.AnswerFile;
import com.DongHang_ComeFunny.www.model.vo.QuestionBoard;
import com.DongHang_ComeFunny.www.model.vo.QuestionFile;

import common.exception.FileException;
import common.util.FileUtil;
import common.util.Paging;

@Service
public class ServiceCenterQuestionServiceImpl implements ServiceCenterQuestionService {
	
	@Autowired
	ServiceCenterQuestionDao serviceCenterQuestionDao;

	@Override
	public void writeQuestion(QuestionBoard writeQuestionInfo, List<MultipartFile> questionFiles, String root) throws FileException {
	serviceCenterQuestionDao.insertQuestion(writeQuestionInfo);
	
	long fileSize = 0;
	for(MultipartFile mf : questionFiles) {
		fileSize = mf.getSize();
	}
	
	if(fileSize != 0){
	if(questionFiles!= null) {
		FileUtil fileUtil = new FileUtil();
		List<Map<String,Object>> fileData = fileUtil.fileUpload(questionFiles, root);
		for(Map<String, Object> data : fileData) {
			data.put("qfQbNo", serviceCenterQuestionDao.selectWriteQbNo());
			System.out.println(data);
			serviceCenterQuestionDao.insertQuestionFile(data);
		
		}
	}
	}
	}


	@Override
	public Map<String, Object> viewQuestion(int qbNo) {
		Map<String, Object> viewQuestion = serviceCenterQuestionDao.selectQuestionByQbNo(qbNo);
		if(viewQuestion == null) {
			viewQuestion = serviceCenterQuestionDao.selectOnlyQuestionByQbNo(qbNo);
			List<QuestionFile> viewQuestionFile = serviceCenterQuestionDao.selectQuestionFileByQbNo(qbNo);
			System.out.println(viewQuestionFile);
			
			Map<String,Object> viewQuestionMap = new HashMap<>();
			viewQuestionMap.put("viewQuestion",viewQuestion);
			viewQuestionMap.put("viewQuestionFile",viewQuestionFile);
			System.out.println(viewQuestionMap);
			return viewQuestionMap;
			
		} else {
			List<QuestionFile> viewQuestionFile = serviceCenterQuestionDao.selectQuestionFileByQbNo(qbNo);
			List<AnswerFile> viewAnswerFile = serviceCenterQuestionDao.selectAnswerFileByAbNo(viewQuestion.get("ABNO"));
			
			System.out.println(viewQuestion.get("ABNO"));
			System.out.println(viewQuestionFile);
			System.out.println(viewAnswerFile);
			
			Map<String,Object> viewQuestionMap = new HashMap<>();
			viewQuestionMap.put("viewQuestion",viewQuestion);
			viewQuestionMap.put("viewQuestionFile",viewQuestionFile);
			viewQuestionMap.put("viewAnswerFile",viewAnswerFile);
			System.out.println(viewQuestionMap);
			return viewQuestionMap;
		}
		
	}

	@Override
	public int deleteFile(int qfNo) {
		// 1. 파일 번호로 게시글 파일 목록 조회
				Map<String, String> fileData = serviceCenterQuestionDao.selectQuestionFile(qfNo);
				// 2. 빈 파일유틸 객체 생성
				FileUtil fileUtil = new FileUtil();
				// 3. 파일 저장경로에 있는 파일 삭제 처리
				fileUtil.deleteFile(fileData.get(("QFSAVEPATH")));

				// 4. isdel 컬럼값 0 -> 1로 변경
				int res = serviceCenterQuestionDao.deleteQuestionFile(qfNo); // 파일완전 삭제
				return res;
			}

	@Override
	public void modifyQuestion(QuestionBoard modiQuestionInfo, List<MultipartFile> questionFiles, String root)
			throws FileException {
		serviceCenterQuestionDao.updateQuestion(modiQuestionInfo);
		
		long fileSize = 0;
		for(MultipartFile mf : questionFiles) {
			fileSize = mf.getSize();
		}
		
		if(fileSize != 0){
		if(questionFiles!= null) {
			FileUtil fileUtil = new FileUtil();
			List<Map<String,Object>> fileData = fileUtil.fileUpload(questionFiles, root);
			for(Map<String, Object> data : fileData) {
				data.put("qfQbNo", modiQuestionInfo.getQbNo());
				System.out.println(data);
				serviceCenterQuestionDao.insertQuestionFile(data);
			}
		}
		}
	}

	@Override
	public Map<String, Object> selectQuestionList(int cPage, int cntPerPage, Map<String, Object> searchQuestion) {
Map<String,Object> commandMap = new HashMap<>();
		
		Paging p = new Paging(serviceCenterQuestionDao.selectQuestionCnt(searchQuestion), cPage, cntPerPage);
		
		Map<String,Object> searchQuestionMap = new HashMap<>();
		searchQuestionMap.put("paging",p);
		searchQuestionMap.putAll(searchQuestion);
		System.out.println(searchQuestionMap);
		
		List<QuestionBoard> questionList = serviceCenterQuestionDao.selectQuestionList(searchQuestionMap);
		
		commandMap.put("paging", p);
		commandMap.put("questionList", questionList);
		
		
		return commandMap;
	}

	@Override
	public void deleteQuestion(String[] qbNos) {
		String abNos = null;
		for(int i=0; i<qbNos.length; i++) {
			abNos = serviceCenterQuestionDao.selectAbNoByQbNo(qbNos[i]);
			serviceCenterQuestionDao.deleteAnswerFileByAbNo(abNos);
			serviceCenterQuestionDao.deleteAnswer(abNos);
			serviceCenterQuestionDao.deleteQuestionFileByQbNo(qbNos[i]);
			serviceCenterQuestionDao.deleteQuestion(qbNos[i]);
		}
	}

	
}
