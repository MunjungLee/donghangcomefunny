package com.DongHang_ComeFunny.www.controller.message;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.DongHang_ComeFunny.www.model.service.message.MessageService;
import com.DongHang_ComeFunny.www.model.service.user.UserService;
import com.DongHang_ComeFunny.www.model.vo.Message;
import com.DongHang_ComeFunny.www.model.vo.User;

@Controller
public class MessageController {

   @Autowired
   MessageService messageService;
   @Autowired
   UserService userService;

   @RequestMapping(value = "/message/receivelist", method = RequestMethod.GET)
   public ModelAndView receiveList(@RequestParam(required = false, defaultValue = "1") int cPage,
         HttpSession session) {
      ModelAndView mav = new ModelAndView();
      int cntPerPage = 10;
      User logUser = (User) session.getAttribute("logInInfo");
      logUser = userService.selectMemberByUserId(logUser.getUserId());

      Map<String, Object> commandMap = messageService.selectMessageList(logUser, cPage, cntPerPage);

      mav.addObject("paging", commandMap.get("paging"));
      mav.addObject("ReceiveMsgData", commandMap);
      mav.setViewName("message/receivelist");
      System.out.println(commandMap);
      return mav;
   }

   @RequestMapping(value = "/message/sendlist", method = RequestMethod.GET)
   public ModelAndView sendList(@RequestParam(required = false, defaultValue = "1") int cPage, HttpSession session) {
      ModelAndView mav = new ModelAndView();
      int cntPerPage = 10;
      User logUser = (User) session.getAttribute("logInInfo");
      logUser = userService.selectMemberByUserId(logUser.getUserId());

      Map<String, Object> commandMap = messageService.selectSendList(logUser, cPage, cntPerPage);
      System.out.println("test");
      System.out.println(commandMap);
      mav.addObject("paging", commandMap.get("paging"));
      mav.addObject("SendMsgData", commandMap);
      mav.setViewName("message/sendlist");
      return mav;
   }

   @RequestMapping(value = "/message/mymsglist", method = RequestMethod.GET)
   public ModelAndView myMsgList(@RequestParam(required = false, defaultValue = "1") int cPage, HttpSession session) {
      ModelAndView mav = new ModelAndView();
      int cntPerPage = 10;
      User logUser = (User) session.getAttribute("logInInfo");
      logUser = userService.selectMemberByUserId(logUser.getUserId());
      System.out.println(logUser);
      Map<String, Object> commandMap = messageService.selectMyMsgList(logUser, cPage, cntPerPage);
      System.out.println(commandMap);
      mav.addObject("paging", commandMap.get("paging"));
      mav.addObject("MyMsgData", commandMap);
      mav.setViewName("message/mymsglist");
      return mav;
   }

   @RequestMapping(value = "/message/storelist", method = RequestMethod.GET)
   public ModelAndView storeMsgList(@RequestParam(required = false, defaultValue = "1") int cPage,
         HttpSession session) {
      ModelAndView mav = new ModelAndView();
      int cntPerPage = 10;
      User logUser = (User) session.getAttribute("logInInfo");
      logUser = userService.selectMemberByUserId(logUser.getUserId());

      Map<String, Object> commandMap = messageService.selectStoreMsgList(logUser, cPage, cntPerPage);

      mav.addObject("paging", commandMap.get("paging"));
      mav.addObject("storeData", commandMap);
      mav.setViewName("message/storelist");
      return mav;
   }

   @RequestMapping(value = "/message/delete", method = RequestMethod.GET)
   public ModelAndView Delete(String msno, HttpSession session) {
      String res = msno;
      ModelAndView mav = new ModelAndView();
      String[] arr = null;
      Map<String, Object> ress;
      int val = 0;
      if (res.contains("-")) {
         arr = res.split("-");
         ress = messageService.selectMessage(Integer.parseInt(arr[0]));
         val = messageService.deleteArray(arr);
      } else {
         ress = messageService.selectMessage(Integer.parseInt(msno));
         val = messageService.delete(res);
      }
      if (val <= 0) {
         mav.addObject("alertMsg", "삭제 실패");
         mav.addObject("url", "../message/receivelist");
         mav.setViewName("/message/receivelist");
      }
      int cntPerPage = 10;
      User logUser = (User) session.getAttribute("logInInfo");
      logUser = userService.selectMemberByUserId(logUser.getUserId());
      Map<String, Object> commandMap = messageService.selectMessageList(logUser, 1, cntPerPage);
   
      mav.addObject("paging", commandMap.get("paging"));
      mav.addObject("ReceiveMsgData", commandMap);
      Message resss = (Message) ress.get("message");
      System.out.println("================");
      System.out.println(resss.getMsType());
      if (resss.getMsType() == 0) {
         cntPerPage = 10;
         logUser = (User) session.getAttribute("logInInfo");
         logUser = userService.selectMemberByUserId(logUser.getUserId());

         commandMap = messageService.selectMessageList(logUser, 1, cntPerPage);

         mav.addObject("paging", commandMap.get("paging"));
         mav.addObject("ReceiveMsgData", commandMap);
         mav.setViewName("/message/receivelist");
      } else if (resss.getMsType() == 1) {
         cntPerPage = 10;
         logUser = (User) session.getAttribute("logInInfo");
         logUser = userService.selectMemberByUserId(logUser.getUserId());

         commandMap = messageService.selectSendList(logUser, 1, cntPerPage);

         mav.addObject("paging", commandMap.get("paging"));
         mav.addObject("SendMsgData", commandMap);
         
         mav.setViewName("/message/sendlist");
      } else if (resss.getMsType() == 2) {
         cntPerPage = 10;
         logUser = (User) session.getAttribute("logInInfo");
         logUser = userService.selectMemberByUserId(logUser.getUserId());

         commandMap = messageService.selectStoreMsgList(logUser, 1, cntPerPage);

         mav.addObject("paging", commandMap.get("paging"));
         mav.addObject("storeData", commandMap);
         
         mav.setViewName("/message/storelist");
         
      } else if (resss.getMsType() == 3) {
         cntPerPage = 10;
         logUser = (User) session.getAttribute("logInInfo");
         logUser = userService.selectMemberByUserId(logUser.getUserId());
         System.out.println(logUser);
         commandMap = messageService.selectMyMsgList(logUser, 1, cntPerPage);

         mav.addObject("paging", commandMap.get("paging"));
         mav.addObject("MyMsgData", commandMap);
         mav.setViewName("/message/mymsglist");
      }
      return mav;
   }

   @RequestMapping(value = "/message/store", method = RequestMethod.GET)
   public ModelAndView Store(String msno, HttpSession session) {
      String res = msno;
      ModelAndView mav = new ModelAndView();
      Map<String, Object> ress;
      String[] arr = null;
      int val = 0;
      if (res.contains("-")) {
         arr = res.split("-");
         ress = messageService.selectMessage(Integer.parseInt(arr[0]));
         val = messageService.storeArray(arr);
      } else {
         ress = messageService.selectMessage(Integer.parseInt(msno));
         val = messageService.store(res);
      }
      if (val > 0) {

         mav.addObject("alertMsg", "보관 성공");
         mav.addObject("url", "../message/receivelist");
         mav.setViewName("/message/receivelist");
      } else {
         mav.addObject("alertMsg", "보관 실패");
         mav.addObject("url", "../message/receivelist");
         mav.setViewName("/message/receivelist");
      }
      int cntPerPage = 10;
      User logUser = (User) session.getAttribute("logInInfo");
      logUser = userService.selectMemberByUserId(logUser.getUserId());
      Map<String, Object> commandMap = messageService.selectMessageList(logUser, 1, cntPerPage);
      mav.addObject("paging", commandMap.get("paging"));
      mav.addObject("ReceiveMsgData", commandMap);
      Message resss = (Message) ress.get("message");
      System.out.println("================");
      System.out.println(resss.getMsType());
      if (resss.getMsType() == 0) {
         cntPerPage = 10;
         logUser = (User) session.getAttribute("logInInfo");
         logUser = userService.selectMemberByUserId(logUser.getUserId());

         commandMap = messageService.selectMessageList(logUser, 1, cntPerPage);

         mav.addObject("paging", commandMap.get("paging"));
         mav.addObject("ReceiveMsgData", commandMap);
         mav.setViewName("/message/receivelist");
      } else if (resss.getMsType() == 1) {
         cntPerPage = 10;
         logUser = (User) session.getAttribute("logInInfo");
         logUser = userService.selectMemberByUserId(logUser.getUserId());

         commandMap = messageService.selectSendList(logUser, 1, cntPerPage);

         mav.addObject("paging", commandMap.get("paging"));
         mav.addObject("SendMsgData", commandMap);
         mav.setViewName("/message/sendlist");
      } else if (resss.getMsType() == 2) {
         cntPerPage = 10;
         logUser = (User) session.getAttribute("logInInfo");
         logUser = userService.selectMemberByUserId(logUser.getUserId());

         commandMap = messageService.selectStoreMsgList(logUser, 1, cntPerPage);

         mav.addObject("paging", commandMap.get("paging"));
         mav.addObject("storeData", commandMap);
         
         mav.setViewName("/message/storelist");
         
         mav.setViewName("/message/storelist");
      } else if (resss.getMsType() == 3) {
         cntPerPage = 10;
         logUser = (User) session.getAttribute("logInInfo");
         logUser = userService.selectMemberByUserId(logUser.getUserId());
         System.out.println(logUser);
         commandMap = messageService.selectMyMsgList(logUser, 1, cntPerPage);

         mav.addObject("paging", commandMap.get("paging"));
         mav.addObject("MyMsgData", commandMap);
         mav.setViewName("/message/mymsglist");
      
      }
      return mav;
   }

   @RequestMapping(value = "/message/messagesendview", method = RequestMethod.GET)
   public ModelAndView View(int msno, HttpServletRequest req) {
      ModelAndView mav = new ModelAndView();
      Map<String, Object> message = messageService.selectMessage(msno);
      System.out.println(req.getRequestURI());
      if (message != null) {
         mav.addObject("message", message);
         mav.setViewName("/message/messagesendview");
      } else {
         mav.addObject("alertMsg", "해당 게시물이 존재하지 않습니다.");
         mav.addObject("url", "messagelist");
         mav.setViewName("common/result");
      }
      return mav;
   }

   @RequestMapping(value = "/message/messagereceiveview", method = RequestMethod.GET)
   public ModelAndView receiveView(int msno, HttpServletRequest req) {
      ModelAndView mav = new ModelAndView();
      Map<String, Object> message = messageService.selectMessage(msno);
      System.out.println(req.getRequestURI());
      if (message != null) {
         mav.addObject("message", message);
         mav.setViewName("/message/messagereceiveview");
      } else {
         mav.addObject("alertMsg", "해당 게시물이 존재하지 않습니다.");
         mav.addObject("url", "messagelist");
         mav.setViewName("common/result");
      }
      return mav;
   }

   @RequestMapping(value = "/message/mymsgview", method = RequestMethod.GET)
   public ModelAndView myMsgView(int msno, HttpServletRequest req) {
      ModelAndView mav = new ModelAndView();
      Map<String, Object> message = messageService.selectMessage(msno);
      System.out.println(req.getRequestURI());
      if (message != null) {
         mav.addObject("message", message);
         mav.setViewName("/message/mymsgview");
      } else {
         mav.addObject("alertMsg", "해당 게시물이 존재하지 않습니다.");
         mav.addObject("url", "messagelist");
         mav.setViewName("common/result");
      }
      return mav;
   }

   @RequestMapping(value = "/message/storemsgview", method = RequestMethod.GET)
   public ModelAndView StoreMsgView(int msno, HttpServletRequest req) {
      ModelAndView mav = new ModelAndView();
      Map<String, Object> message = messageService.selectMessage(msno);
      System.out.println(req.getRequestURI());
      if (message != null) {
         mav.addObject("message", message);
         mav.setViewName("/message/storemsgview");
      } else {
         mav.addObject("alertMsg", "해당 게시물이 존재하지 않습니다.");
         mav.addObject("url", "messagelist");
         mav.setViewName("common/result");
      }
      return mav;
   }

   @RequestMapping(value = "/message/send", method = RequestMethod.GET)
   public ModelAndView messageSend(HttpSession session,String msno) {
      Map<String, Object> commandMap;
      ModelAndView mav = new ModelAndView();
      if (msno != null) {
         Map<String, Object> message = messageService.selectMessage(Integer.parseInt(msno));

         User user = (User) message.get("receiver");
         mav.addObject("message", message);
      }
      int cntPerPage = 10;
      User logUser = (User) session.getAttribute("logInInfo");
      logUser = userService.selectMemberByUserId(logUser.getUserId());

      commandMap = messageService.selectMessageList(logUser, 1, cntPerPage);

      mav.addObject("paging", commandMap.get("paging"));
      mav.addObject("ReceiveMsgData", commandMap);
      mav.setViewName("/message/receivelist");
      mav.setViewName("message/messagesend");
      return mav;
   }

   @RequestMapping(value = "/message/send", method = RequestMethod.POST)
   public ModelAndView messageSendMessage(HttpSession session, String receiver, String content, String date,
         String title) {
      Message message = new Message();
      ModelAndView mav = new ModelAndView();
      SimpleDateFormat fm = new SimpleDateFormat("yyyyMMddHHmmss");
      Date sqlDate = new Date(0);

      String res = receiver;
      message.setMsTitle(title);
      message.setMsContent(content);
      // message.set
      int val = 0;
      String arr[] = null;
      // 메일을 보내는 사람의 정보
      User Sender = (User) session.getAttribute("logInInfo");
      try {
         java.util.Date to = fm.parse(date);
         System.out.println(to);
         sqlDate = new Date(to.getTime());
      } catch (ParseException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      message.setMsWrittenTime(sqlDate);
      if (res.contains(",")) {
         arr = res.split(",");
         val = messageService.sendMailList(arr, Sender, message);
      } else {
         val = messageService.SendMail(res, Sender, message);
      }
      mav.setViewName("message/receivelist");
      return mav;
   }

   @RequestMapping(value = "/message/userSearch", method = RequestMethod.GET)
   public ModelAndView messageUserSearch() {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("message/userSearch");
      return mav;
   }

   @RequestMapping(value = "/message/searchUser", method = RequestMethod.GET)
   @ResponseBody
   public Map<String, Object> messageSearchUserId(String userId) {
      String[] arr = null;
      int val = 0;
      User user = new User();
      Map<String, Object> map = new HashMap<String, Object>();
      arr = userId.split("-");

      if (arr[0] == "id" || arr[0].equals("id")) {
         user = messageService.selectUserIdById(arr[1]);
      } else if (arr[0] == "nick" || arr[0].equals("nick")) {
         user = messageService.selectUserIdByNick(arr[1]);
      }

      map.put("user", user);

      return map;
   }

}