package com.DongHang_ComeFunny.www.chat;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Component

public class WebSocketHandler extends TextWebSocketHandler {
   private List<WebSocketSession> sessions = new ArrayList<>();
   Logger log = LoggerFactory.getLogger(WebSocketHandler.class);
   HashMap<String, String> users = new HashMap<String, String>();

   @Override
   public void afterConnectionEstablished(WebSocketSession session) throws Exception {
      sessions.add(session);
      log.info("접속 : {}", session);
   }

   @Override
   protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
      String userId;
      if (!message.getPayload().contains("<div")) {
         String res = message.getPayload().substring(0, message.getPayload().indexOf("_"));
         users.put(session.getId(), res);
         String sndMsg ="<br><br><div style='text-align:center;'>"+ res + " 님이 입장 하셨습니다.</div>";
         userId = "userId_";
         for (String key : users.keySet()) {

            String value = users.get(key);

            userId += value + ",";

         }
         userId = userId.substring(0, userId.length() - 1);
         for (WebSocketSession sess : sessions) {
            sess.sendMessage(new TextMessage(userId));
            sess.sendMessage(new TextMessage(sndMsg));
         }

      } else {
         TextMessage msg = new TextMessage("id-" + users.get(session.getId()) + "_" + message.getPayload());
         
         for (WebSocketSession sess : sessions) {
            if (sess.getId() == session.getId()) {
               continue;

            } else {
               
               
               sess.sendMessage(msg);
            }
         }
      }
   }

   @Override
   public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
      // TextMessage msg = session.set
      sessions.remove(session);
      String userId;
      if (users.get(session.getId()) != null) {
         String sndMsg ="<br><br><div style='text-align:center;'>"+ users.get(session.getId()) + " 님이 퇴장 하셧습니다.</div>";
         users.remove(session.getId());
         userId = "userId_";
         for (String key : users.keySet()) {

            String value = users.get(key);

            userId += value + ",";

         }
         userId = userId.substring(0, userId.length() - 1);
         for (WebSocketSession sess : sessions) {
            sess.sendMessage(new TextMessage(userId));
            sess.sendMessage(new TextMessage(sndMsg));
         }
      } else {
         return;
      }

      log.info("퇴장 : {}", session);
   }
}