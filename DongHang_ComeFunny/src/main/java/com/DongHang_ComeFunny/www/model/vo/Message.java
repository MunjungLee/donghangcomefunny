package com.DongHang_ComeFunny.www.model.vo;

import java.util.Date;

public class Message {
   private int msNo;
   private int msUNo;
   private int msReceiver;
   private int msOwner;
   private String msTitle;
   private String msContent;
   private Date msWrittenTime;
   private int msType;
   
   @Override
   public String toString() {
      return "Message [msNo=" + msNo + ", msUNo=" + msUNo + ", msReceiver=" + msReceiver + ", msOwnerl=" + msOwner
            + ", msTitle=" + msTitle + ", msContent=" + msContent + ", msWrittenTime=" + msWrittenTime + ", msType="
            + msType + "]";
   }
   public int getMsNo() {
      return msNo;
   }
   public void setMsNo(int msNo) {
      this.msNo = msNo;
   }
   public int getMsUNo() {
      return msUNo;
   }
   public void setMsUNo(int msUNo) {
      this.msUNo = msUNo;
   }
   public int getMsReceiver() {
      return msReceiver;
   }
   public void setMsReceiver(int msReceiver) {
      this.msReceiver = msReceiver;
   }
   public int getMsOwner() {
      return msOwner;
   }
   public void setMsOwner(int msOwner) {
      this.msOwner = msOwner;
   }
   public String getMsTitle() {
      return msTitle;
   }
   public void setMsTitle(String msTitle) {
      this.msTitle = msTitle;
   }
   public String getMsContent() {
      return msContent;
   }
   public void setMsContent(String msContent) {
      this.msContent = msContent;
   }
   public Date getMsWrittenTime() {
      return msWrittenTime;
   }
   public void setMsWrittenTime(Date msWrittenTime) {
      this.msWrittenTime = msWrittenTime;
   }
   public int getMsType() {
      return msType;
   }
   public void setMsType(int msType) {
      this.msType = msType;
   }

   
   

}