package com.DongHang_ComeFunny.www.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.DongHang_ComeFunny.www.model.service.admin.AdminOrderService;
import com.DongHang_ComeFunny.www.model.vo.Order;

@Controller
@RequestMapping("/admin/order")
public class AdminOrderController {

   @Autowired
   AdminOrderService adminOrderService;
   
   @RequestMapping("/list")
   public ModelAndView viewPaymentList (   String searchKinds,
                                 String searchText,
                                 @RequestParam(required = false, defaultValue = "1")int cPage) {
      
      ModelAndView mav = new ModelAndView();
      int cntPerPage = 10;
      
      Map<String,Object> searchOrder = new HashMap<>();
      
      searchOrder.put("searchKinds", searchKinds);
      searchOrder.put("searchText", searchText);
      Map<String,Object> orderList = adminOrderService.viewOrderList(cPage, cntPerPage, searchOrder);

      mav.addObject("paging",orderList.get("paging"));
      mav.addObject("orderList", orderList);
      mav.addObject("searchKinds", searchKinds);
      mav.addObject("searchText", searchText);
      mav.setViewName("admin/order/list");
      return mav;
   }
   
   @RequestMapping("/view")
   public ModelAndView viewPayment(int pONo) {
      
      ModelAndView mav = new ModelAndView();
      
      if(pONo != 0) {
         Map<String, Object> order = adminOrderService.viewOrder(pONo);
         System.out.println(order);
         mav.addObject("Order", order.get("viewOrder"));
         mav.setViewName("admin/order/view");
         return mav;
      } else {
         mav.setViewName("admin/order/list");
         return mav;
      }
   }
   
   

}