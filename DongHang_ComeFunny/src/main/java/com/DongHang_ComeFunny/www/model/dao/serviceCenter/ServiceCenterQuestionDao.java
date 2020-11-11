package com.DongHang_ComeFunny.www.model.dao.serviceCenter;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.DongHang_ComeFunny.www.model.vo.AnswerFile;
import com.DongHang_ComeFunny.www.model.vo.QuestionBoard;
import com.DongHang_ComeFunny.www.model.vo.QuestionFile;

@Repository
public class ServiceCenterQuestionDao {
	
	@Autowired
	SqlSessionTemplate sqlSession;

	public void insertQuestion(QuestionBoard writeQuestionInfo) {
		sqlSession.insert("ServiceCenterQuestion.insertQuestion", writeQuestionInfo);		
	}

	public int selectWriteQbNo() {
		return sqlSession.selectOne("ServiceCenterQuestion.selectWriteQbNo");
	}

	public void insertQuestionFile(Map<String, Object> data) {
		sqlSession.insert("ServiceCenterQuestion.insertQuestionFile", data);
		
	}

	public Map<String, Object> selectQuestionByQbNo(int qbNo) {
		return sqlSession.selectOne("ServiceCenterQuestion.selectQuestionByQbNo", qbNo);
	}

	public Map<String, Object> selectOnlyQuestionByQbNo(int qbNo) {
		return sqlSession.selectOne("ServiceCenterQuestion.selectOnlyQuestionByQbNo", qbNo);
	}

	public List<QuestionFile> selectQuestionFileByQbNo(int qbNo) {
		return sqlSession.selectList("ServiceCenterQuestion.selectQuestionFileByQbNo", qbNo);
	}

	public List<AnswerFile> selectAnswerFileByAbNo(Object abNo) {
		return sqlSession.selectList("ServiceCenterQuestion.selectAnswerFileByAbNo", abNo);
	}

	public Map<String, String> selectQuestionFile(int qfNo) {
		return sqlSession.selectOne("ServiceCenterQuestion.selectQuestionFile", qfNo);
	}

	public int deleteQuestionFile(int qfNo) {
		return sqlSession.delete("ServiceCenterQuestion.deleteQuestionFile", qfNo);
	}

	public void updateQuestion(QuestionBoard modiQuestionInfo) {
		sqlSession.update("ServiceCenterQuestion.updateQuestion", modiQuestionInfo);
	}

	public int selectQuestionCnt(Map<String, Object> searchQuestion) {
		return sqlSession.selectOne("ServiceCenterQuestion.selectQuestionCnt", searchQuestion);
	}

	public List<QuestionBoard> selectQuestionList(Map<String, Object> searchQuestionMap) {
		return sqlSession.selectList("ServiceCenterQuestion.selectQuestionList", searchQuestionMap);
	}

	public String selectAbNoByQbNo(String qbNo) {
		return sqlSession.selectOne("ServiceCenterQuestion.selectAbNoByQbNo", qbNo);
	}

	public void deleteAnswerFileByAbNo(String abNo) {
		sqlSession.delete("ServiceCenterQuestion.deleteAnswerFileByAbNo", abNo);
	}

	public void deleteAnswer(String abNo) {
		sqlSession.delete("ServiceCenterQuestion.deleteAnswer", abNo);
	}

	public void deleteQuestionFileByQbNo(String qbNo) {
		sqlSession.delete("ServiceCenterQuestion.deleteQuestionFileByQbNo", qbNo);
	}

	public void deleteQuestion(String qbNo) {
		sqlSession.delete("ServiceCenterQuestion.deleteQuestion", qbNo);
	}

	
}
