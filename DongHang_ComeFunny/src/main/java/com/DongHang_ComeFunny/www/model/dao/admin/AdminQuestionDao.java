package com.DongHang_ComeFunny.www.model.dao.admin;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.DongHang_ComeFunny.www.model.vo.AnswerBoard;
import com.DongHang_ComeFunny.www.model.vo.AnswerFile;
import com.DongHang_ComeFunny.www.model.vo.AnswerImg;
import com.DongHang_ComeFunny.www.model.vo.NoticeBoard;
import com.DongHang_ComeFunny.www.model.vo.QuestionBoard;
import com.DongHang_ComeFunny.www.model.vo.QuestionFile;
import com.DongHang_ComeFunny.www.model.vo.QuestionImg;

@Repository
public class AdminQuestionDao {
   
   @Autowired
   private SqlSessionTemplate sqlSession;

   public int selectQuestionCnt(Map<String, Object> searchQuestion) {
      return sqlSession.selectOne("AdminQuestion.selectQuestionCnt", searchQuestion);
   }

   public List<QuestionBoard> selectQuestionList(Map<String, Object> searchQuestionMap) {
      return sqlSession.selectList("AdminQuestion.selectQuestionList", searchQuestionMap);
   }

   public void insertAnswer(AnswerBoard writeAnswerInfo) {
      sqlSession.insert("AdminQuestion.insertAnswer", writeAnswerInfo);
   }

   public int selectWriteAbNo() {
      return sqlSession.selectOne("AdminQuestion.selectWriteAbNo");
   }

   public void insertAnswerFile(Map<String, Object> data) {
      sqlSession.insert("AdminQuestion.insertAnswerFile", data);
   }


   public List<QuestionFile> selectQuestionFileByQbNo(int qbNo) {
      return sqlSession.selectList("AdminQuestion.selectQuestionFileByQbNo", qbNo);
   }

   public Map<String, Object> selectQuestionByQbNo(int qbNo) {
      return sqlSession.selectOne("AdminQuestion.selectQuestionByQbNo", qbNo);
   }

   public void updateQuestionStatus(int abQbNo) {
      sqlSession.update("AdminQuestion.updateQuestionStatus", abQbNo);
   }

   public void updateAnswer(AnswerBoard modiAnswerInfo) {
      sqlSession.update("AdminQuestion.updateAnswer", modiAnswerInfo);
   }

   public Map<String, String> selectAnswerFile(int afNo) {
      return sqlSession.selectOne("AdminQuestion.selectAnswerFile", afNo);
   }

   public int deleteAnswerFile(int afNo) {
      return sqlSession.delete("AdminQuestion.deleteAnswerFile", afNo);
   }

   public void deleteAnswerFileByAbNo(String abNo) {
      sqlSession.delete("AdminQuestion.deleteAnswerFileByAbNo", abNo);
      
   }

   public void deleteAnswer(String abNo) {
      sqlSession.delete("AdminQuestion.deleteAnswer", abNo);
      
   }

   public void deleteQuestionFileByQbNo(String qbNo) {
      sqlSession.delete("AdminQuestion.deleteQuestionFileByQbNo", qbNo);
   }

   public void deleteQuestion(String qbNo) {
      sqlSession.delete("AdminQuestion.deleteQuestion", qbNo);
   }

   public List<AnswerFile> selectAnswerFileByAbNo(Object abNo) {
      return sqlSession.selectList("AdminQuestion.selectAnswerFileByAbNo", abNo);
   }

   public Map<String, Object> selectOnlyQuestionByQbNo(int qbNo) {
      return sqlSession.selectOne("AdminQuestion.selectOnlyQuestionByQbNo", qbNo);
   }

   public void updateQuestionDelStatus(int qbNo) {
      sqlSession.update("AdminQuestion.updateQuestionDelStatus", qbNo);
   }

   public String selectAbNoByQbNo(String qbNo) {
      return sqlSession.selectOne("AdminQuestion.selectAbNoByQbNo", qbNo);
   }

   public int selectQbNoByAbNo(String abNo) {
      return sqlSession.selectOne("AdminQuestion.selectQbNoByAbNo", abNo);
   }



}