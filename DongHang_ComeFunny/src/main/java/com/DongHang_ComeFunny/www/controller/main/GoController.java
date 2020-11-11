package com.DongHang_ComeFunny.www.controller.main;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.DongHang_ComeFunny.www.model.service.main.GoService;
import com.DongHang_ComeFunny.www.model.vo.GoBoard;
import com.DongHang_ComeFunny.www.model.vo.GoCheck;
import com.DongHang_ComeFunny.www.model.vo.User;

@Controller
public class GoController {
   
   @Autowired GoService goService;
   
   //필터검색시 검색된 페이지 띄우기
   @RequestMapping(value="/go/goFilter", method=RequestMethod.GET)
   public void gofilter() {
   }
   
   //-------------------------상세보기 ----------------------------------
   
 //함께가요 상세
   @RequestMapping(value="/go/goDetail", method=RequestMethod.GET)
   public void goDetail(int gbNo, Model model, HttpSession session) {
      

      //회원정보를 세선에 담기
     User sessionUser = (User)session.getAttribute("logInInfo");
     int goLikeStatus = 0;
     
      
     //함께가요 상세정보들
      Map<String, Object> goDetailInfo = goService.selectGoDetail(gbNo);
     
     
      if(sessionUser != null) {
         int uNo = sessionUser.getuNo();
         
         //함께가요 찜목록 클릭 여부
         goLikeStatus = goService.selectGoLikeStatus(gbNo, uNo);
           
      }
      
      
//      //함께가요 찜목록 클릭 여부
//      int goLikeStatus = goService.selectGoLikeStatus(gbNo, uNo);
        
      
      model.addAttribute("goDetailInfo", goDetailInfo);
      model.addAttribute("goLikeStatus", goLikeStatus);
      
   }
   
   //함께가요 동행 신청
   @RequestMapping(value="/go/goApply", method=RequestMethod.POST)
   @ResponseBody
   public Map<String, Object> goApply(int gbNo, Model model, HttpSession session) {
      
      //회원정보를 세선에 담기
     User sessionUser = (User)session.getAttribute("logInInfo");
      System.out.println("sessinUser = " + sessionUser);
     
      int res = 0;
      Map<String, Object> newGoApply = null;
     
      //로그인이 되어있는 경우
      if(sessionUser != null) {
          int uNo = sessionUser.getuNo();
                       
         //함께가요 신청
         res = goService.insertGoDhApply(gbNo, uNo);
         
         //방금 함께가요 신청을 누른 사람 꺼 조회
         newGoApply = goService.selectGoNewApply(gbNo, uNo);
         
         if(res > 0) {
            return newGoApply;
         } else {
            return null;
         }
           
      } else { //로그인이 안되어 있는 경우 
         
         return null;
      }
      
   }
   
   //동행 요청 수락
   @RequestMapping(value="/go/goDhOk", method=RequestMethod.POST)
   @ResponseBody
   public String goDhOk(int gbNo, int gaUNo, HttpSession session) {
      
      //함께가요 게시물 인원수 확인
      int gbrecruitnumber = goService.selectGBrecruitnumber(gbNo);
      
      //함께가요 수락 된 인원 확인
      int gbrecruitcnt = goService.selectGrecruitcnt(gbNo);
      
//      System.out.println("인원 제한 gbrecruitnumber = " + gbrecruitnumber);
//      System.out.println("신청한 인원수  gbrecruitcnt = " + gbrecruitcnt);
//      System.out.println("조건 = " + (gbrecruitcnt <= gbrecruitnumber));
      
      int res = 0;
      
      //함께가요 모집인원이랑 동행수락한 인원 비교
      if(gbrecruitcnt < gbrecruitnumber) {
         
         //동행 요청 수락
         res = goService.updateGoApplyOkStatus(gbNo, gaUNo);
         
         //함께가요 모집인원 수 증가
         goService.updateGBrecruitCnt(gbNo);
         
      } else { //함께가요 동행 수락 인원 초과했을 때
         return "fail2";
      }
      
      
      if(res > 0) {
         return ".goDhApplyResult";
      } else { //함께가요 동행 수락이 실패했을 때
         return "fail1";
      }
      
   }
   
   //동행 요청 거절
   @RequestMapping(value="/go/goDhNo", method=RequestMethod.POST)
   @ResponseBody
   public String goDhNo(int gbNo, int gaUNo, HttpSession session) {
      
      //동행 요청 거절
      int res = goService.updateGoApplyNoStatus(gbNo, gaUNo);

      if(res > 0) {
         return ".goDhApplyResult";
      } else {
         return "fail";
      }
      
   }
   
   //함께가요 찜목록 추가
   @RequestMapping(value="/go/goInsertLike", method=RequestMethod.POST)
   @ResponseBody
   public int goInsertLike(int gbNo, int uNo, HttpSession session) {
      

      //함께가요 찜목록 추가
      int res = goService.insertGoLike(gbNo, uNo);

      if(res > 0) {
         
         //찜 수 증가
         goService.GBlikeUpCnt(gbNo);
         
         return 1;
      } else {
         return 0;
      }
      
   }
   
   
   //함께가요 찜목록 삭제
   @RequestMapping(value="/go/goDeleteLike", method=RequestMethod.POST)
   @ResponseBody
   public int goDeleteLike(int gbNo, int uNo, HttpSession session) {
      

      //함께가요 찜목록 삭제
      int res = goService.DeleteGoLike(gbNo, uNo);

      if(res > 0) {
       //함께가요 찜 수 감소 
          goService.GBlikeDownCnt(gbNo); 
         return 1;
      } else {
         return 0;
      }
      
   }
   
   
   //함께가요 삭제
   @RequestMapping(value = "/go/goDelete", method = RequestMethod.GET)
   public String goDelete(int gbNo, Model model, HttpSession session) {

      //함께가요 삭제 -> gbisdel = 1 로 update
      int res = goService.deleteGoboard(gbNo);

      if(res > 0) {
         model.addAttribute("alertMsg", "해당 게시글이 삭제되었습니다.");
         model.addAttribute("url", "/go");
      } else {
         model.addAttribute("alertMsg", "해당 게시글이 삭제 되지 않았습니다.");
         model.addAttribute("url", "/go");
      }

      return "common/result";

   }
   
      //-------------------동행 작성하기 -------------------------
      
    //goform 기본화면 띄우기 
      @RequestMapping(value="/go/goform", method=RequestMethod.GET)
      public ModelAndView gowrite(GoBoard goBoard, HttpSession session) {
    	  
    	 ModelAndView mav = new ModelAndView();
    	 
    	 User sessionUser = (User)session.getAttribute("logInInfo");
    	 
    	 if(sessionUser != null) {
             goBoard.setGbUNo(sessionUser.getuNo());
             mav.setViewName("/go/goForm");
    	 } else {
    		 mav.addObject("alertMsg", "로그인 후에 사용해주시길 바랍니다.");
             mav.addObject("url", "/user/login"); //로그인화면으로
             mav.setViewName("common/result");
    	 }
             
         return mav;
      }
      
   //폼 입력하기
      @RequestMapping(value="/go/gowrite", method=RequestMethod.POST)
      public ModelAndView insertGo(GoBoard goBoard, GoCheck goCheck, HttpSession session) {
         
         ModelAndView mav = new ModelAndView();
         
         User sessionUser = (User)session.getAttribute("logInInfo");
         goBoard.setGbUNo(sessionUser.getuNo());
         
         goService.insertGoForm(goBoard, goCheck);
         
         mav.addObject("alertMsg", "등록 완료!");
         mav.addObject("url","/go");
         mav.setViewName("common/result");
         
         return mav;
         
      }
      
      
      //--------- 리스트 띄우기 ---------------
      
      //기본 최신순 정렬된 리스트 전체 띄우기
      @RequestMapping(value="/go", method=RequestMethod.GET)
      public ModelAndView goList(String searchText, Map<String, Object> commandMap) {
         
         ModelAndView mav = new ModelAndView();
         
         Map<String,Object> search = new HashMap<>();
         search.put("searchText", searchText);
         
         System.out.println("[commandMap]"+ commandMap);
         //검색 전 리스트 출력
//         List<Map<String,Object>> list = goService.selectGoList(commandMap);
         Map<String, Object> list = goService.selectSearchList(search, commandMap);
         
         System.out.println(list);
         mav.addObject("list", list);
         mav.addObject("searchText", searchText );
         mav.setViewName("go/go");
         
         return mav;
         
      }
      
    //메인에서 넘어온 페이지 (기본 리다이렉트)
      @RequestMapping(value="/go/list", method=RequestMethod.POST)
      public ModelAndView goList2(
    		  String gbRecruitArea
    		  ,String gbRecruitDate
    		  ,String gcAgeGroup
    		  ,String gcTheme) {
         
         ModelAndView mav = new ModelAndView();
         Map<String, Object> commandMap = new HashMap<>();
         commandMap.put("area", gbRecruitArea);
         commandMap.put("date", gbRecruitDate);
         commandMap.put("age", gcAgeGroup);
         commandMap.put("theme", gcTheme);
         
         System.out.println("[commandMap]"+commandMap); //파라미터 값  확인
         Map<String, Object> list = goService.selectlist(commandMap);
         
         System.out.println("[list]"+list);
         mav.addObject("list", list);
         mav.setViewName("go/go"); 
         
         return mav;
         
      }
      
      //페이지내에서 검색하기 (기본 리다이렉트)
      @RequestMapping(value="/go/search", method=RequestMethod.POST)
      public ModelAndView goListSearch(String searchText, Map<String, Object> commandMap) {

         ModelAndView mav = new ModelAndView();

         Map<String,Object> search = new HashMap<>();
         search.put("searchText", searchText); //검색키워드 저장

         Map<String,Object> list = goService.selectSearchList(search, commandMap);

         mav.addObject("list", list);
         mav.addObject("searchText", searchText );
         mav.setViewName("go/go"); 

         return mav;
      }

      
      //ajax로 필터링하기
      @RequestMapping(value="/go/filter", method=RequestMethod.GET)
      @ResponseBody
      public ModelAndView goFilter(
            @RequestParam String age, 
            @RequestParam String gender, 
            @RequestParam String theme,
            @RequestParam String area, 
            @RequestParam String state
//               , String searchText, Map<String, Object> commandMap
            ) {
         //필요한 로직 처리
         System.out.println("[controller]");
         System.out.println("[age] " + age.length() + " [gender] " + gender.length() + " [theme] " + theme.length()
         + " [area] " + area.length() + " [state] " + state.length() );
//            System.out.println("[searchText] " + searchText);

         ModelAndView mav = new ModelAndView();

         List<String> agelist = new ArrayList<String>();
         List<String> genderlist = new ArrayList<String>();
         List<String> themelist = new ArrayList<String>();
         List<String> arealist = new ArrayList<String>();
         List<String> statelist = new ArrayList<String>();

         Map<String, Object> filter = new HashMap<>(); //필터 Map 생성

         String[] ageArray = {};
         String[] genderArray = {};
         String[] themeArray = {};
         String[] areaArray = {};
         String[] stateArray = {};

         //받아온 값 쪼개서 각각 넣어주기
         if(age.length() > 0) { //넘어온 값이 공백이 아니면 
            ageArray = age.split("-");  //split 쪼개서 리스트에 넣고 
            for(String str : ageArray) { //반복 돌면서 넣어주기
               System.out.println("[str]"+str);
               agelist.add(str); 
            }
         }

         filter.put("age", agelist); //filter맵에 입력

         if(gender.length() > 0) {
            genderArray = gender.split("-");
            for(String str : genderArray) {
               genderlist.add(str);
            }
         }

         filter.put("gender", genderlist);

         if(theme.length() > 0) {
            themeArray = theme.split("-");
            for(String str : themeArray) {
               themelist.add(str);
            }
         }

         filter.put("theme", themelist);

         if(area.length() > 0) {
            areaArray = area.split("-");
            for(String str : areaArray) {
               arealist.add(str);
            }
         }

         filter.put("area", arealist);

         if(state.length() > 0) {
            stateArray = state.split("-");
            for(String str : stateArray) {
               statelist.add(str);
            }
         }

         filter.put("state", statelist);

         
         Map<String,Object> list = goService.selectFilterList(filter);
//            System.out.println(list);

         mav.addObject("list", list);
//            mav.addObject("searchText", searchText);
         mav.addObject("filter", filter);

         mav.setViewName("/go/goFilter"); 

         System.out.println("****************ajax보자*************");
         System.out.println(mav);
         return mav;
      }

      
      //----------------------------수정-------------------------------
      
      //수정 기본 값 가지고오기
      @RequestMapping(value="/go/modify", method=RequestMethod.GET)
      public ModelAndView goModify(int gbNo, HttpSession session) {
         System.out.println("[Controller] modify");
         System.out.println(gbNo);
         
         ModelAndView mav = new ModelAndView();
         Map<String,Object> goboard = goService.selectGoDetail(gbNo);
         
         mav.addObject("goboard", goboard);
         mav.setViewName("go/goModify");
         return mav;
      }

      //글 수정하기
      @RequestMapping(value="/go/updatemodify", method=RequestMethod.POST)
      public ModelAndView goModifyImpl(
            GoBoard goBoard, HttpSession session) {
         System.out.println("[Controller] /updatemodify");
        
         ModelAndView mav = new ModelAndView();

          //회원정보를 세선에 담기
         User sessionUser = (User)session.getAttribute("logInInfo");

         goBoard.setGbUNo(sessionUser.getuNo());
         goService.updateGoboard(goBoard);
         
         mav.addObject("goBoard", goBoard);
         mav.addObject("alertMsg", "수정완료!");
         mav.addObject("url","/go");
         mav.setViewName("common/result");

         return mav;
      }

}