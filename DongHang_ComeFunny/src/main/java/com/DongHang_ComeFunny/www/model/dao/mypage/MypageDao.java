package com.DongHang_ComeFunny.www.model.dao.mypage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.DongHang_ComeFunny.www.model.vo.GoLike;
import com.DongHang_ComeFunny.www.model.vo.User;
import com.DongHang_ComeFunny.www.model.vo.UserFile;

import common.util.Paging;

@Repository
public class MypageDao {

   @Autowired
   SqlSessionTemplate session;

   
   //비밀번호 일치 확인
//   public int selectPwCheck(String userId, String uPw) {
//      
//      Map<String, String> map = new HashMap<String, String>();
//      map.put("userId", userId);
//      map.put("uPw", uPw);
//      
//      int result =  session.selectOne("MYPAGE.selectPwCheck", map);
//      
//      System.out.println("result = " + result);
//      return result;
//   }
   //비밀번호 일치 확인(암호화)
   public User selectPwCheck(String userId, String uPw) {
      
      Map<String, String> map = new HashMap<String, String>();
      map.put("userId", userId);
      map.put("uPw", uPw);
      
      User result =  session.selectOne("MYPAGE.selectPwCheck", map);
      
      System.out.println("result = " + result);
      return result;
   }

   //회원정보 수정
   public int updateUser(User user) {
      return session.update("MYPAGE.updateUser", user);
   }

   //회원정보 조회
   public User getUserInfo(int uNo) {
      return session.selectOne("MYPAGE.getUserInfo", uNo);
   }

   //회원 프로필 이미지 조회
   public UserFile selectUserImg(int uNo) {
      return session.selectOne("MYPAGE.selectUserImg", uNo);
   }
   
   //프로필 이미지 등록
   public int insertUserImg(Map<String, Object> map) {
      return session.insert("MYPAGE.insertUserImg", map);
   }
   
   //방법1. 기존 프로필 사진 삭제 처리
   public int updateUserImgIsDel() {
      return session.update("MYPAGE.updateUserImgIsDel");
   }
   //방법2. 서버 업로드폴더에서 파일 삭제 및 Db에서도 해당 파일정보 삭제
   public int deleteUserFile() {
      return session.delete("MYPAGE.deleteUserFile");
   }
   
   //프로필 이미지 수정
   public int updateUserImg(Map<String, Object> map) {
      return session.update("MYPAGE.updateUserImg", map);
   }
   
   //원본 프로필이미지로 변경(프로필 삭제)
   public int deleteProfileImg(int uNo) {
      return session.delete("MYPAGE.deleteProfileImg", uNo);
   }
   
   
   //함께해요 찜목록 조회
   public List<Object> selectLikelist(int uNo) {
      return session.selectList("MYPAGE.selectLikelist", uNo);
   }
   
   //함께해요 찜목록 삭제
   public int deleteDoLike(String uNo, String dbNo) {

      Map<String, String> map = new HashMap<String, String>();
      map.put("uNo", uNo);
      map.put("dbNo", dbNo);
      
      int result = session.delete("MYPAGE.deleteDoLike", map);
            
      return result;
   }

   //함께가요 찜목록 게시글수 카운트 
   public int selectGbContentCnt(int uNo) { 
        return session.selectOne("MYPAGE.selectGbContentCnt", uNo);
    }

   //함께가요 찜목록 조회
   public List<Object> selectGoLikeList(Paging p, int uNo) {
      
      Map<String, Object> param = new HashMap<String, Object>();
      param.put("p",p);
      param.put("uNo", uNo);
      return session.selectList("MYPAGE.selectGoLikeList", param);

   }

   //함꼐가요 찜목록 삭제
   public int deleteGoLike(GoLike golike) {
      return session.delete("MYPAGE.deleteGoLike", golike);
   }
   
   //수정한 회원 다시 조회
   public User newUserInfo(int uNo) {
      return session.selectOne("MYPAGE.newUserInfo", uNo);

   }
   
   //
   public int DBlikeDownCnt(String dbNo) {
      return session.update("MYPAGE.DBlikeDownCnt", dbNo);
   }

   public int GBlikeDownCnt(int gbNo) {
      return session.update("MYPAGE.GBlikeDownCnt", gbNo);
   }



   
   
   
   
   

   
   
   

   
}