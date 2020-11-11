package com.DongHang_ComeFunny.www.model.service.message;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DongHang_ComeFunny.www.model.dao.message.MessageDao;
import com.DongHang_ComeFunny.www.model.dao.user.UserDao;
import com.DongHang_ComeFunny.www.model.vo.Message;
import com.DongHang_ComeFunny.www.model.vo.User;

import common.util.Paging;


@Service
public class MessageServiceImpl implements MessageService {

   @Autowired
   MessageDao messageDao;
   @Autowired
   UserDao userDao;

   @Override
   public Map<String, Object> selectMessageList(User user, int cPage, int cntPerPage) {
      Map<String, Object> commandMap = new HashMap<>();
      Paging page = new Paging(messageDao.selectContentCnt(user.getuNo()), cPage, cntPerPage);
      List<Map<String, Object>> mList = messageDao.selectMessageList(page, user.getuNo());
      commandMap.put("mList", mList);
      commandMap.put("paging", page);
      return commandMap;
   }

   @Override
   public int deleteArray(String[] arr) {
      int[] nums = Arrays.stream(arr).mapToInt(Integer::parseInt).toArray();

      return messageDao.deleteArr(nums);

   }

   @Override
   public int delete(String res) {

      return messageDao.delete(Integer.parseInt(res));
   }

   @Override
   public int storeArray(String[] arr) {
      int[] nums = Arrays.stream(arr).mapToInt(Integer::parseInt).toArray();

      return messageDao.updateArr(nums);

   }

   @Override
   public int store(String res) {
      return messageDao.update(Integer.parseInt(res));
   }

   @Override
   public Map<String, Object> selectMessage(int msno) {
      Map<String, Object> map = new HashMap<>();
      Message message = messageDao.selectMessageList(msno);
      User receiver = userDao.selectMemberByUno(message.getMsUNo());
      User sender = userDao.selectMemberByUno(message.getMsReceiver());
      
      map.put("message", message);
      map.put("receiver", receiver);
      map.put("sender", sender);
      return map;
   }

   @Override
   public User selectUserIdById(String userid) {
      return userDao.selectMemberByUserId(userid);
   }

   @Override
   public User selectUserIdByNick(String nick) {
      return userDao.selectMemberByUserNick(nick);
   }

   @Override
   public int sendMailList(String[] arr, User sender, Message sendMessage) {
      // 내게 보내는 메시지인 경우
      Message mySendMsg;
      // 메시지 보낸후 발신내역 확인용
      Message mirrorMsg;
      sendMessage.setMsUNo(sender.getuNo());
      sendMessage.setMsOwner(sender.getuNo());
      // 메시지 보내는 수신자의 정보
      int res = 0;
      int returnVal = 0;
      List<Integer> send = new ArrayList<>();
      List<Integer> mirror = new ArrayList<>();
      for (int i = 0; i < arr.length; i++) {
         // 수신자 발신자가 같은 경우 == 내게쓴 메시지인 경우
         if (sender.getUserId() == arr[i] || sender.getUserId().equals(arr[i])) {
            mySendMsg = sendMessage;
            mySendMsg.setMsType(3);
            mySendMsg.setMsUNo(sender.getuNo());
            mySendMsg.setMsReceiver(sender.getuNo());
            mySendMsg.setMsOwner(sender.getuNo());
            returnVal = messageDao.insert(mySendMsg);
            if (returnVal != 1) {
               for (Integer sendNo : send) { // for문을 통한 전체출력
                  messageDao.delete(sendNo);
               }
               for (Integer MyNo : mirror) { // for문을 통한 전체출력
                  messageDao.delete(MyNo);
               }
               return 0;
            }
            // 정상 작동 된경우
            else
               res += returnVal;
            send.add(messageDao.selectSeq());
         }
         // 수신자 발신자가 다른 경우 == 내게쓴 메시지인 경우
         else {
            User receiver = new User();
            receiver = userDao.selectMemberByUserId(arr[i]);
            if(receiver == null) return 0;
            if (receiver.getuNo() <= 0) {
               for (Integer sendNo : send) { // for문을 통한 전체출력
                  messageDao.delete(sendNo);
               }
               for (Integer MyNo : mirror) { // for문을 통한 전체출력
                  messageDao.delete(MyNo);
               }
               return 0;
            } else {
               sendMessage.setMsReceiver(receiver.getuNo());
               sendMessage.setMsOwner(receiver.getuNo());
               mirrorMsg = sendMessage;      
               sendMessage.setMsType(0);
               returnVal = messageDao.insert(sendMessage);
               // 전송 실패경우
               if (returnVal == 0) {
                  for (Integer sendNo : send) { // for문을 통한 전체출력
                     messageDao.delete(sendNo);
                  }
                  for (Integer MyNo : mirror) { // for문을 통한 전체출력
                     messageDao.delete(MyNo);
                  }
                  return 0;
               } else {
                  res += returnVal;
                  send.add(messageDao.selectSeq());
                  mirrorMsg.setMsType(1);
                  mirrorMsg.setMsOwner(mirrorMsg.getMsUNo());
                  returnVal = messageDao.insert(mirrorMsg);
                  if (returnVal == 0) {
                     for (Integer sendNo : send) { // for문을 통한 전체출력
                        messageDao.delete(sendNo);
                     }
                     for (Integer MyNo : mirror) { // for문을 통한 전체출력
                        messageDao.delete(MyNo);
                     }
                     return 0;

                  }else {
                     res += returnVal;
                     send.add(messageDao.selectSeq());                     
                  }
               }
            }
         }
      }

      return res;
   }

   @Override
   public int SendMail(String receiverId, User sender, Message sendMessage) {
      // 내게 보내는 메시지인 경우
      Message mySendMsg;
      // 메시지 보낸후 발신내역 확인용
      Message mirrorMsg;
      sendMessage.setMsUNo(sender.getuNo());
      // 메시지 보내는 수신자의 정보
      int ress = 0;
      int returnVal = 0;
      if (sender.getUserId() == receiverId || sender.getUserId().equals(receiverId)) {
         mySendMsg = sendMessage;
         mySendMsg.setMsType(3);
         mySendMsg.setMsUNo(sender.getuNo());
         mySendMsg.setMsReceiver(sender.getuNo());
         mySendMsg.setMsOwner(sender.getuNo());
         returnVal = messageDao.insert(mySendMsg);
         if (returnVal == 0)
            return 0;
         else
            ress += returnVal;
      } else {
         User receiver = new User();
         receiver = userDao.selectMemberByUserId(receiverId);
         if (receiver == null) return 0;
         if (receiver.getuNo() <= 0)
            return 0;
         else {
            sendMessage.setMsReceiver(receiver.getuNo());
            sendMessage.setMsOwner(receiver.getuNo());
            mirrorMsg = sendMessage;            
            sendMessage.setMsType(0);
            returnVal = messageDao.insert(sendMessage);
            if (returnVal == 0){
               return 0;
            }
            else {
               ress += returnVal;
               mirrorMsg.setMsType(1);
               mirrorMsg.setMsOwner(mirrorMsg.getMsUNo());
               returnVal = messageDao.insert(mirrorMsg);
               if (returnVal == 0) {
                  messageDao.delete(messageDao.selectSeq());

               }
            }
         }
      }
      return ress;
   }

   @Override
   public Map<String, Object> selectMyMsgList(User user, int cPage, int cntPerPage) {
      Map<String, Object> commandMap = new HashMap<>();
      Paging page = new Paging(messageDao.selectMyMsgCnt(user.getuNo()), cPage, cntPerPage);
      List<Map<String, Object>> mList = messageDao.selectMyMsgList(page, user.getuNo());
      commandMap.put("mList", mList);
      commandMap.put("paging", page);
      return commandMap;
   }

   @Override
   public Map<String, Object> selectStoreMsgList(User user, int cPage, int cntPerPage) {
      Map<String, Object> commandMap = new HashMap<>();
      Paging page = new Paging(messageDao.selectStoreMsgCnt(user.getuNo()), cPage, cntPerPage);
      List<Map<String, Object>> mList = messageDao.selectStoreMsgList(page, user.getuNo());
      commandMap.put("mList", mList);
      commandMap.put("paging", page);
      return commandMap;
   }

   @Override
   public Map<String, Object> selectSendList(User user, int cPage, int cntPerPage) {
      Map<String, Object> commandMap = new HashMap<>();
      Paging page = new Paging(messageDao.selectSendMsgCnt(user.getuNo()), cPage, cntPerPage);
      List<Map<String, Object>> mList = messageDao.selectSendList(page, user.getuNo());
      commandMap.put("mList", mList);
      commandMap.put("paging", page);
      return commandMap;
   }
}