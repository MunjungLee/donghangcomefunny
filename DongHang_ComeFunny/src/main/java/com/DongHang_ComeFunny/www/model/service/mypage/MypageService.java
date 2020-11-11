package com.DongHang_ComeFunny.www.model.service.mypage;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.DongHang_ComeFunny.www.model.vo.DoLike;
import com.DongHang_ComeFunny.www.model.vo.GoLike;
import com.DongHang_ComeFunny.www.model.vo.User;
import com.DongHang_ComeFunny.www.model.vo.UserFile;

import common.exception.FileException;

public interface MypageService {
   


//   /**
//    * 비밀번호 일치 확인(암호화x)
//    * @param upw - 사용가자 입력한 비밀번호
//    * @param userid 
//    * @return
//    */
//   public int selectPwCheck(String userId, String uPw);
   /**
    * 비밀번호 일치 확인(암호화)
    * @param upw - 사용가자 입력한 비밀번호
    * @param userid 
    * @return
    */
   public int selectPwCheck(String userId, String uPw);
   
   /**
    * 회원정보 수정
    * @param user - 회원아이디를 가지고 수정
    * @return 
    */
   public int updateUser(User user);

//   /**
//    * 회원정보 조회
//    * @param uno
//    * @return
//    */
//   public User getUserInfo(int uNo);

   /**
    * 회원정보, 프로필 이미지 조회
    * @param uNo
    * @return
    */
   public Map<String, Object> selectUserInfo(int uNo);
   
   /**
    * 프로필 이미지 등록
    * @param uNo
    * @param files
    * @param root
    * @return
    */
   public int insertUserImg(int uNo, List<MultipartFile> files, String root) throws FileException;
   
   /**
    * 프로필 이미지 사진 수정
    * @param uNo
    * @param file
    * @param root
    * @return
    * @throws FileException 
    */
   public int updateUserImg(int uNo, List<MultipartFile> files, String root) throws FileException;

   /**
    * 원본 프로필이미지로 변경(프로필 삭제)
    * @param uNo
    * @return
    */
   public int deleteProfileImg(int uNo);
   
   /**
    * 함꼐해요 찜목록 조회
    * @param uNo
    * @return
    */   
   public List<Object> selectLikelist(int uNo);
   
   /**
    * 함께해요 찜목록 삭제
    * @param uNo
    * @param dbNo
    * @return
    */
   public int deleteDoLike(String uNo, String dbNo);
   
   /**
    * 함께가요 찜목록 조회
    * @param cPage
    * @param cntPerPage
    * @param uNo 
    * @return
    */
   public Map<String, Object> selectGoLikeList(int cPage, int cntPerPage, int uNo);

   /**
    * 함께가요 찜목록 삭제
    * @param chArr
    * @param uNo
    * @return
    */
   public int deleteGoLike(GoLike golike);
   
   /**
    * 수정한 회원 정보 다시 조회
    * @param getuNo
    * @return
    */
   public User newUserInfo(int uNo);
   
   /**
    * 함께해요 찜 수 감소
    * @param dbNo
    */
   public void DBlikeDownCnt(String dbNo);
   
   /**
    * 함께가요 찜 수 감소
    * @param gbNo
    */
   public void GBlikeDownCnt(int gbNo);


   
   
   
   

   
   
   
   
   
   
   
   
   


}