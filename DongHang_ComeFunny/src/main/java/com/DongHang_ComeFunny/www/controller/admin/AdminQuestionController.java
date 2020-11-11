package com.DongHang_ComeFunny.www.controller.admin;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.DongHang_ComeFunny.www.model.service.admin.AdminQuestionService;
import com.DongHang_ComeFunny.www.model.vo.Admin;
import com.DongHang_ComeFunny.www.model.vo.AnswerBoard;
import com.DongHang_ComeFunny.www.model.vo.User;

import common.exception.FileException;

@Controller
@RequestMapping("/admin/question")
public class AdminQuestionController {
   
   
   
   @Autowired
   AdminQuestionService adminQuestionService;
   
   @RequestMapping("/list")
   public ModelAndView viewQuestionList(   String searchKinds,
                                 String searchText,
                                 HttpSession session,
                                 @RequestParam(required = false, defaultValue = "1")int cPage) 
                              {
      ModelAndView mav = new ModelAndView();
      
      Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
      User sessionUser =(User)session.getAttribute("logInInfo");
      if(sessionAdmin != null) {
         int cntPerPage = 10;
         
         System.out.println(searchText);
         System.out.println(searchKinds);
         
         Map<String,Object> searchQuestion = new HashMap<>();
         
         searchQuestion.put("searchKinds", searchKinds);
         searchQuestion.put("searchText", searchText);
         System.out.println(searchQuestion);
         Map<String,Object> questionList = adminQuestionService.selectQuestionList(cPage, cntPerPage, searchQuestion);
         System.out.println(questionList);
         mav.addObject("paging", questionList.get("paging"));
         mav.addObject("questionData", questionList);
         mav.addObject("searchKinds", searchKinds);
         mav.addObject("searchText", searchText);
         mav.setViewName("admin/question/list");
         return mav;
      } else if (sessionUser != null) {
         mav.addObject("alertMsg", "관리자만 이용 가능합니다.");
         mav.addObject("url", "/main");
         mav.setViewName("common/result");
         return mav;
      } else {
         mav.addObject("alertMsg", "로그인해 주세요.");
         mav.addObject("url", "/admin/login");
         mav.setViewName("common/result");
         return mav;
      }
   }
   
   @RequestMapping("/view")
   public ModelAndView viewQuestion(int qbNo,
                           HttpSession session) {
      ModelAndView mav = new ModelAndView();
      
      Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
      User sessionUser =(User)session.getAttribute("logInInfo");
      if(sessionAdmin != null) {
         
      System.out.println(qbNo);
      
      Map<String, Object> viewQuestionMap = adminQuestionService.viewQuestion(qbNo);
      
      System.out.println(viewQuestionMap);

      if(viewQuestionMap.get("viewAnswerFile") != null) {
         mav.addObject("viewQuestion",viewQuestionMap.get("viewQuestion"));
         mav.addObject("viewQuestionFile",viewQuestionMap.get("viewQuestionFile"));
         mav.addObject("viewAnswerFile", viewQuestionMap.get("viewAnswerFile"));
         mav.setViewName("admin/question/view");
         return mav;
      } else {
         mav.addObject("viewQuestion",viewQuestionMap.get("viewQuestion"));
         mav.addObject("viewQuestionFile",viewQuestionMap.get("viewQuestionFile"));
         mav.setViewName("admin/question/view");
         return mav;
      }
      }else if (sessionUser != null) {
         mav.addObject("alertMsg", "관리자만 이용 가능합니다.");
         mav.addObject("url", "/main");
         mav.setViewName("common/result");
         return mav;
      } else {
         mav.addObject("alertMsg", "로그인해 주세요.");
         mav.addObject("url", "/admin/login");
         mav.setViewName("common/result");
         return mav;
      }
   }
   
   @RequestMapping("/writeAnswer")
   public ModelAndView writeAnswer(int qbNo,
                           HttpSession session) {
      ModelAndView mav = new ModelAndView();
      
      Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
      User sessionUser =(User)session.getAttribute("logInInfo");
      if(sessionAdmin != null) {
         
      Map<String, Object> viewQuestionMap = adminQuestionService.viewQuestion(qbNo);
      
      System.out.println(viewQuestionMap);

         mav.addObject("viewQuestion",viewQuestionMap.get("viewQuestion"));
         mav.addObject("viewQuestionFile",viewQuestionMap.get("viewQuestionFile"));
         mav.setViewName("admin/question/writeAnswer");
         return mav;
      }else if (sessionUser != null) {
         mav.addObject("alertMsg", "관리자만 이용 가능합니다.");
         mav.addObject("url", "/main");
         mav.setViewName("common/result");
         return mav;
      } else {
         mav.addObject("alertMsg", "로그인해 주세요.");
         mav.addObject("url", "/admin/login");
         mav.setViewName("common/result");
         return mav;
      }
   }
   
   
   @RequestMapping(value ="/writeAnswerImpl", method=RequestMethod.POST)
   public ModelAndView writeAnswerImpl(AnswerBoard writeAnswerInfo,
                              @RequestParam(required = false) List<MultipartFile> answerFiles,
                              HttpSession session) throws FileException 
                              {
      ModelAndView mav = new ModelAndView();
      
      Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
      User sessionUser =(User)session.getAttribute("logInInfo");
      if(sessionAdmin != null) {
         
      String root = session.getServletContext().getRealPath("/");
      writeAnswerInfo.setAbUno(sessionAdmin.getaNo());
      System.out.println(writeAnswerInfo);
      System.out.println(answerFiles);
      System.out.println(root);
      
         adminQuestionService.writeAnswer(writeAnswerInfo, answerFiles, root);
         mav.setViewName("redirect:/admin/question/list");
         return mav;
         
      }else if (sessionUser != null) {
         mav.addObject("alertMsg", "관리자만 이용 가능합니다.");
         mav.addObject("url", "/main");
         mav.setViewName("common/result");
         return mav;
      } else {
         mav.addObject("alertMsg", "로그인해 주세요.");
         mav.addObject("url", "/admin/login");
         mav.setViewName("common/result");
         return mav;
      }
   }
   
   @RequestMapping("/modifyAnswer")
   public ModelAndView modifyAnswer(int qbNo,
                           HttpSession session) {
      ModelAndView mav = new ModelAndView();
      Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
      User sessionUser =(User)session.getAttribute("logInInfo");
      if(sessionAdmin != null) {
         
         Map<String, Object> viewQuestionMap = adminQuestionService.viewQuestion(qbNo);
         
         System.out.println(viewQuestionMap);
   
         if(viewQuestionMap.get("viewAnswerFile") != null) {
            mav.addObject("viewQuestion",viewQuestionMap.get("viewQuestion"));
            mav.addObject("viewQuestionFile",viewQuestionMap.get("viewQuestionFile"));
            mav.addObject("viewAnswerFile", viewQuestionMap.get("viewAnswerFile"));
            mav.setViewName("admin/question/modifyAnswer");
            return mav;
         } else {
            mav.addObject("viewQuestion",viewQuestionMap.get("viewQuestion"));
            mav.addObject("viewQuestionFile",viewQuestionMap.get("viewQuestionFile"));
            mav.setViewName("admin/question/modifyAnswer");
            return mav;
         }
      }else if (sessionUser != null) {
         mav.addObject("alertMsg", "관리자만 이용 가능합니다.");
         mav.addObject("url", "/main");
         mav.setViewName("common/result");
         return mav;
      } else {
         mav.addObject("alertMsg", "로그인해 주세요.");
         mav.addObject("url", "/admin/login");
         mav.setViewName("common/result");
         return mav;
      }
   }
   
   @RequestMapping(value = "/modifyAnswerImpl", method=RequestMethod.POST)
   public ModelAndView modifyAnswerImpl(AnswerBoard modiAnswerInfo,
                              @RequestParam(required = false) List<MultipartFile> answerFiles,
                              HttpSession session) throws FileException 
         {
         ModelAndView mav = new ModelAndView();
         
         Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
         User sessionUser =(User)session.getAttribute("logInInfo");
         if(sessionAdmin != null) {
            
            String root = session.getServletContext().getRealPath("/");
            
            System.out.println(modiAnswerInfo);
            System.out.println(answerFiles);
            System.out.println(root);
            
            if(modiAnswerInfo != null) {
            adminQuestionService.modiAnswer(modiAnswerInfo, answerFiles, root);
            mav.setViewName("redirect:/admin/question/list");
            return mav;
            } else {
            mav.setViewName("admin/question/list");
            return mav;
            }
         }else if (sessionUser != null) {
            mav.addObject("alertMsg", "관리자만 이용 가능합니다.");
            mav.addObject("url", "/main");
            mav.setViewName("common/result");
            return mav;
         } else {
            mav.addObject("alertMsg", "로그인해 주세요.");
            mav.addObject("url", "/admin/login");
            mav.setViewName("common/result");
            return mav;
         }
   }
   
   
   
   @RequestMapping(value = "/deleteFile" , method = RequestMethod.POST)
   @ResponseBody
   public String deleteFile(int afNo) {
      // 1. 파라미터값 Service에 전달 후 int 값 반환
      //    ( 성공 : 1, 실패 : 0 )
      int res = adminQuestionService.deleteFile(afNo);
      
      //---------------- Service에서 처리한 데이터값 출력-------------------------
      System.out.println("[controller] deleteFile res 반환값 : "+ res);
      //--------------------------------------------------------------------------
      
      // 2. 해당 파일 삭제 성공한다면,
      if( res > 0 ) {
         // 2-1. res = 1 : javascript에 tagSelector로 html 태그의 id값이 "#f+ffno"인 값을 반환
         return "#f"+afNo;
      } else {
         // 2-2. res = 0 : 실패라고 알림
         return "fail";
      }
      
   }
   
   
   @RequestMapping("/downloadFile")
   @ResponseBody
   public FileSystemResource downloadFile(
         HttpServletResponse response
         , HttpSession session
         , String ofname
         , String rfname
         ) {
      // 1. 서버에 저장된 업로드 파일경로
      String readFolder = session.getServletContext().getRealPath("/resources/upload");
      
      // ---------------파라미터 값 제대로 불러왔는지 확인-------------------------
      System.out.println("[controller] freeDowonload - readFolder : " + readFolder);
      System.out.println("[controller] freeDowonload - rfname : " +rfname);
      System.out.println("[controller] freeDowonload - ofname : " +ofname);
      // --------------------------------------------------------------------------
      
      // 2. FileSystemResource 객체 생성
      FileSystemResource downFile = new FileSystemResource(readFolder + "/" + rfname);
      
      try {
         //3. response 헤더 설정 + 파일 이름 인코딩
         response.setHeader("Content-Disposition"
                 , "attachment; filename="
                 +URLEncoder.encode(ofname, "UTF-8"));
      } catch (UnsupportedEncodingException e) {
         e.printStackTrace();
      }
      // 4. FileSystemResource downFile 값 반환
      return downFile;
   }
   
   @RequestMapping("/deleteAnswer")
   public ModelAndView deleteAnswer(    String abNo,
                              HttpSession session
                           ) {
      
      ModelAndView mav = new ModelAndView();
      Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
      User sessionUser =(User)session.getAttribute("logInInfo");
      if(sessionAdmin != null) {
            if(abNo != null) {
               adminQuestionService.deleteAnswer(abNo);
               mav.setViewName("redirect:/admin/question/list");
               return mav; 
            }else {
               mav.setViewName("redirect:/admin/question/list");
               return mav;
            }
      }else if (sessionUser != null) {
         mav.addObject("alertMsg", "관리자만 이용 가능합니다.");
         mav.addObject("url", "/main");
         mav.setViewName("common/result");
         return mav;
      } else {
         mav.addObject("alertMsg", "로그인해 주세요.");
         mav.addObject("url", "/admin/login");
         mav.setViewName("common/result");
         return mav;
      }
      
   }
   
   @RequestMapping("/delete")
   public ModelAndView deleteQuestion(String[] qbNo,
                              HttpSession session
                              ) {
      
      ModelAndView mav = new ModelAndView();
            
      Admin sessionAdmin= (Admin)session.getAttribute("adminLoginInfo");
      User sessionUser =(User)session.getAttribute("logInInfo");
      if(sessionAdmin != null) {
            if(qbNo != null) {
               adminQuestionService.deleteQuestion(qbNo);
               mav.setViewName("redirect:/admin/question/list");
               return mav; 
            }else {
               mav.setViewName("redirect:/admin/question/list");
               return mav;
            } 
      }else if (sessionUser != null) {
         mav.addObject("alertMsg", "관리자만 이용 가능합니다.");
         mav.addObject("url", "/main");
         mav.setViewName("common/result");
         return mav;
      } else {
         mav.addObject("alertMsg", "로그인해 주세요.");
         mav.addObject("url", "/admin/login");
         mav.setViewName("common/result");
         return mav;
      }
   }
}