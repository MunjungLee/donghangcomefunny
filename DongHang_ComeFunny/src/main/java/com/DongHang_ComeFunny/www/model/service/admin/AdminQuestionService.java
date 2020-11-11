package com.DongHang_ComeFunny.www.model.service.admin;

import java.util.List;
import java.util.Map;

import javax.xml.ws.ServiceMode;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.DongHang_ComeFunny.www.model.vo.AnswerBoard;

import common.exception.FileException;

@Service
public interface AdminQuestionService {

   Map<String, Object> selectQuestionList(int cPage, int cntPerPage, Map<String, Object> searchQuestion);

   void writeAnswer(AnswerBoard writeAnswerInfo, List<MultipartFile> answerFiles, String root) throws FileException;

   Map<String, Object> viewQuestion(int qbNo);

   void modiAnswer(AnswerBoard modiAnswerInfo, List<MultipartFile> answerFiles, String root) throws FileException;

   int deleteFile(int afNo);

   void deleteAnswer(String abNo);

   void deleteQuestion(String[] qbNos);

   


}