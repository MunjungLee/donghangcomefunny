package com.DongHang_ComeFunny.www.controller.payment;

import java.util.Date;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.DongHang_ComeFunny.www.model.service.payment.PaymentService;
import com.DongHang_ComeFunny.www.model.vo.Order;

@Controller
public class PaymentController {
   @Autowired
   private PaymentService paymentService;
   @RequestMapping(value = "/payment/paypage", method = RequestMethod.GET)
   public ModelAndView paypage() {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/payment/paypage");
      return mav;
   }

   @RequestMapping(value = "/payment/commitpay", method = RequestMethod.GET)
   public String commitpay(String impuid, String merchantuid, String paidamount, String userno, String count, String date) {
      Order ord = new Order();
      long timestamp = Long.parseLong(date);
      Date date1 = new java.util.Date(timestamp * 1000L);
      ord.setoPrice(Integer.parseInt(paidamount));
      ord.setoUNo(Integer.parseInt(userno));
      ord.setoQunatity(Integer.parseInt(count));
      ord.setoDate(date1);
      ord.setoName("동행복권 "+count+"개");
      ord.setoMerChantUid(merchantuid);
      ord.setoImpUid(impuid);
      int res = paymentService.insertOrder(ord);
      return null;
   }
   
   @RequestMapping(value = "/payment/result", method = RequestMethod.GET)
   public ModelAndView result() {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/payment/result");      
      return mav;
   }
}