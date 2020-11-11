package com.DongHang_ComeFunny.www.model.service.serviceCenter;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.DongHang_ComeFunny.www.model.vo.QuestionBoard;

import common.exception.FileException;

@Service
public interface ServiceCenterQuestionService {

	void writeQuestion(QuestionBoard writeQuestionInfo, List<MultipartFile> questionFiles, String root) throws FileException;

	Map<String, Object> viewQuestion(int qbNo);

	int deleteFile(int qfNo);

	void modifyQuestion(QuestionBoard modiQuestionInfo, List<MultipartFile> questionFiles, String root) throws FileException;

	Map<String, Object> selectQuestionList(int cPage, int cntPerPage, Map<String, Object> searchQuestion);

	void deleteQuestion(String[] qbNos);

}
