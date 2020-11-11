package com.DongHang_ComeFunny.www.model.service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.DongHang_ComeFunny.www.model.dao.admin.AdminQuestionDao;
import com.DongHang_ComeFunny.www.model.vo.AnswerBoard;
import com.DongHang_ComeFunny.www.model.vo.AnswerFile;
import com.DongHang_ComeFunny.www.model.vo.QuestionBoard;
import com.DongHang_ComeFunny.www.model.vo.QuestionFile;

import common.exception.FileException;
import common.util.FileUtil;
import common.util.Paging;

@Service
public class AdminQuestionServiceImpl implements AdminQuestionService {
   
   @Autowired
   AdminQuestionDao adminQuestionDao;

   @Override
   public Map<String, Object> selectQuestionList(int cPage, int cntPerPage, Map<String, Object> searchQuestion) {
      Map<String,Object> commandMap = new HashMap<>();
      
      Paging p = new Paging(adminQuestionDao.selectQuestionCnt(searchQuestion), cPage, cntPerPage);
      
      Map<String,Object> searchQuestionMap = new HashMap<>();
      searchQuestionMap.put("paging",p);
      searchQuestionMap.putAll(searchQuestion);
      System.out.println(searchQuestionMap);
      
      List<QuestionBoard> questionList = adminQuestionDao.selectQuestionList(searchQuestionMap);
      
      commandMap.put("paging", p);
      commandMap.put("questionList", questionList);
      
      
      return commandMap;
   }

   @Override
   public void writeAnswer(AnswerBoard writeAnswerInfo, List<MultipartFile> answerFiles, String root) throws FileException {
      adminQuestionDao.insertAnswer(writeAnswerInfo);
      adminQuestionDao.updateQuestionStatus(writeAnswerInfo.getAbQbNo());
      long fileSize = 0;
      for(MultipartFile mf : answerFiles) {
         fileSize = mf.getSize();
      }
      
      if(fileSize != 0){
      if(answerFiles!= null) {
         FileUtil fileUtil = new FileUtil();
         List<Map<String,Object>> fileData = fileUtil.fileUpload(answerFiles, root);
         for(Map<String, Object> data : fileData) {
            data.put("afAbNo", adminQuestionDao.selectWriteAbNo());
            System.out.println(data);
            adminQuestionDao.insertAnswerFile(data);
         }
      }
      }
   }

   @Override
   public Map<String, Object> viewQuestion(int qbNo) {
      Map<String, Object> viewQuestion = adminQuestionDao.selectQuestionByQbNo(qbNo);
      if(viewQuestion == null) {
         viewQuestion = adminQuestionDao.selectOnlyQuestionByQbNo(qbNo);
         List<QuestionFile> viewQuestionFile = adminQuestionDao.selectQuestionFileByQbNo(qbNo);
         System.out.println(viewQuestionFile);
         
         Map<String,Object> viewQuestionMap = new HashMap<>();
         viewQuestionMap.put("viewQuestion",viewQuestion);
         viewQuestionMap.put("viewQuestionFile",viewQuestionFile);
         System.out.println(viewQuestionMap);
         return viewQuestionMap;
         
      } else {
         List<QuestionFile> viewQuestionFile = adminQuestionDao.selectQuestionFileByQbNo(qbNo);
         List<AnswerFile> viewAnswerFile = adminQuestionDao.selectAnswerFileByAbNo(viewQuestion.get("ABNO"));
         
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
   public void modiAnswer(AnswerBoard modiAnswerInfo, List<MultipartFile> answerFiles, String root) throws FileException {
      adminQuestionDao.updateAnswer(modiAnswerInfo);
      
      long fileSize = 0;
      for(MultipartFile mf : answerFiles) {
         fileSize = mf.getSize();
      }
      
      if(fileSize != 0){
      if(answerFiles!= null) {
         FileUtil fileUtil = new FileUtil();
         List<Map<String,Object>> fileData = fileUtil.fileUpload(answerFiles, root);
         for(Map<String, Object> data : fileData) {
            data.put("afAbNo", modiAnswerInfo.getAbNo());
            System.out.println(data);
            adminQuestionDao.insertAnswerFile(data);
         }
      }
      }
   }

   @Override
   public int deleteFile(int afNo) {
      // 1. 파일 번호로 게시글 파일 목록 조회
      Map<String, String> fileData = adminQuestionDao.selectAnswerFile(afNo);
      // 2. 빈 파일유틸 객체 생성
      FileUtil fileUtil = new FileUtil();
      // 3. 파일 저장경로에 있는 파일 삭제 처리
      fileUtil.deleteFile(fileData.get(("AFSAVEPATH")));

      // 4. isdel 컬럼값 0 -> 1로 변경
      int res = adminQuestionDao.deleteAnswerFile(afNo); // 파일완전 삭제
      return res;
   }

   @Override
   public void deleteAnswer(String abNo) {
      adminQuestionDao.updateQuestionDelStatus(adminQuestionDao.selectQbNoByAbNo(abNo));
      adminQuestionDao.deleteAnswerFileByAbNo(abNo);
      adminQuestionDao.deleteAnswer(abNo);
   }

   @Override
   public void deleteQuestion(String[] qbNo) {
      String abNo = null;
      for(int i=0; i<qbNo.length; i++) {
         abNo = adminQuestionDao.selectAbNoByQbNo(qbNo[i]);
         adminQuestionDao.deleteAnswerFileByAbNo(abNo);
         adminQuestionDao.deleteAnswer(abNo);
         adminQuestionDao.deleteQuestionFileByQbNo(qbNo[i]);
         adminQuestionDao.deleteQuestion(qbNo[i]);
      }
   }

}