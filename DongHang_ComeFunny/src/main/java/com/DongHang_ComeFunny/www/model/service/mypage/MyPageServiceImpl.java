package com.DongHang_ComeFunny.www.model.service.mypage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.DongHang_ComeFunny.www.model.dao.mypage.MypageDao;
import com.DongHang_ComeFunny.www.model.vo.GoLike;
import com.DongHang_ComeFunny.www.model.vo.User;
import com.DongHang_ComeFunny.www.model.vo.UserFile;

import common.exception.FileException;
import common.util.FileUtil;
import common.util.Paging;

@Service
public class MyPageServiceImpl implements MypageService{
   
   @Autowired
   MypageDao mypageDao;
   
   @Autowired
   BCryptPasswordEncoder passwordEncoder;
   //비밀번호 일치 확인
//   @Override
//   public int selectPwCheck(String userId, String uPw) {
//      return mypageDao.selectPwCheck(userId, uPw);
//   }
   
   @Override
   public int selectPwCheck(String userId, String uPw) {
      User user = mypageDao.selectPwCheck(userId, uPw);
      int result = 0;
      if(passwordEncoder.matches(uPw, user.getuPw())) {
         result = 1;
         return result;
      } else {
         result = 0;
         return result;
      }
   }
   
   //회원 정보 수정
   @Override
   public int updateUser(User user) {
      
      //password 암호화
      //매번 다른 방식으로 암호화가 된다.
      String password = user.getuPw();
      password = passwordEncoder.encode(password);
      System.out.println("암호화가 된 password(serviceimpl)" + password);
      
      user.setuPw(password);
      
      return mypageDao.updateUser(user);
   }
   
//   //회원정보 조회
//   @Override
//   public User getUserInfo(int uNo) {
//      return mypageDao.getUserInfo(uNo);
//   }
   
   //회원정보, 프로필 이미지 조회
   @Override
   public Map<String, Object> selectUserInfo(int uNo) {
      
      
      //회원 상세 정보
      User user = mypageDao.getUserInfo(uNo);
      
      //회원 프로필 이미지 정보
      UserFile userImg = mypageDao.selectUserImg(uNo);      
      
      Map<String, Object> userInfo = new HashMap<String, Object>();
      userInfo.put("user", user);
      userInfo.put("userImg", userImg);
      
      return userInfo;
   }
   
   //회원 프로필이미지 등록
   @Override
   public int insertUserImg(int uNo, List<MultipartFile> files, String root) throws FileException {
      int res = 0;
      
      //파일업로드를 위한 객체 생성
      FileUtil fileUtil = new FileUtil();
      List<Map<String, Object>> filedata = fileUtil.fileUpload(files, root);
      
         
      for (Map<String, Object> map : filedata) { //사용자가 업로드 한 파일의 수만큼 돌면서
         map.put("uNo", uNo);
         res = mypageDao.insertUserImg(map); //file테이블에 들어간다   
      }
      
      return res;
   }
   
   //회원 프로필이미지 수정
   @Override
   public int updateUserImg(int uNo, List<MultipartFile> files, String root) throws FileException {
   
      int res = 0;

      FileUtil fileUtil = new FileUtil();
      
      //방법 2-2. 해당 객체의 delete 메소드를 이용해 해당 파일 삭제
      fileUtil.deleteFile(root);
      
      //방법 2-3. db에서도 해당 파일 정보 삭제
      int userfiledelete = mypageDao.deleteUserFile();
      
      //방법 2-4. 파일업로드를 위한 객체 생성
      List<Map<String, Object>> filedata = fileUtil.fileUpload(files, root);
      
         
      for (Map<String, Object> map : filedata) { //사용자가 업로드 한 파일의 수만큼 돌면서
         map.put("uNo", uNo);
         //방법 2-5. 새로 파일을 삽입
         res = mypageDao.insertUserImg(map); 
//         res = mypageDao.updateUserImg(map); //file테이블에 들어간다   
      }
      
      return res;
      
   }
   
   //원본 프로필이미지로 변경(프로필 삭제)
   @Override
   public int deleteProfileImg(int uNo) {
      return mypageDao.deleteProfileImg(uNo);
   }
   
   //함께해요 찜목록 조회
   @Override
   public List<Object> selectLikelist(int uNo) {
      return mypageDao.selectLikelist(uNo);
   }
   
   //함께해요 찜목록 삭제
   @Override
   public int deleteDoLike(String uNo, String dbNo) {
      return mypageDao.deleteDoLike(uNo, dbNo);
   }
   
   //함께가요 찜목록 조회
   @Override
   public Map<String, Object> selectGoLikeList(int cPage, int cntPerPage, int uNo) {
      
      //Map 객체 생성
      Map<String, Object> commandMap = new HashMap<String, Object>();
      
      //Paging 객체 생성
      Paging p = new Paging(mypageDao.selectGbContentCnt(uNo), cPage, cntPerPage);

      //함께가요 찜목록 조회
      List<Object> golist = mypageDao.selectGoLikeList(p,uNo);
      commandMap.put("golist", golist);
      commandMap.put("paging",p);
      


      return commandMap;

   }
   
   //함께가요 찜목록 삭제
   @Override
   public int deleteGoLike(GoLike golike) {
      return mypageDao.deleteGoLike(golike);
   }
   
   //함께해요 찜목록 수 감소
   @Override
   public void DBlikeDownCnt(String dbNo) {
      mypageDao.DBlikeDownCnt(dbNo);
   }
   
   //함께가요 찜목록 수 감소
   @Override
   public void GBlikeDownCnt(int gbNo) {
      mypageDao.GBlikeDownCnt(gbNo);
   }
   
   //수정한 회원 다시 조회
   @Override
   public User newUserInfo(int uNo) {
      return mypageDao.newUserInfo(uNo);
   }
   
   
}













