package com.DongHang_ComeFunny.www.model.service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DongHang_ComeFunny.www.model.dao.admin.AdminOrderDao;
import com.DongHang_ComeFunny.www.model.vo.Order;

import common.util.Paging;

@Service
public class AdminOrderServiceImpl implements AdminOrderService{
   
   @Autowired
   AdminOrderDao adminOrderDao;

   @Override
   public Map<String, Object> viewOrderList(int cPage, int cntPerPage, Map<String, Object> searchOrder) {
      Map<String,Object> commandMap = new HashMap<String, Object>();
      Paging p = new Paging(adminOrderDao.selectOrderCnt(searchOrder), cPage, cntPerPage);
      System.out.println("*******페이징*******" + p);
      
      
      
      Map<String, Object> searchOrderMap = new HashMap<>();
         searchOrderMap.put("paging", p);
         searchOrderMap.putAll(searchOrder);
         System.out.println(searchOrderMap);
         
         List<Order> orderList = adminOrderDao.selectOrderList(searchOrderMap); 
         
         System.out.println(orderList);
         commandMap.put("orderList",orderList);
         commandMap.put("paging",p);
         System.out.println("*******데이터베이스조회******" + commandMap);
         
         return commandMap;
      
   }

   @Override
   public Map<String, Object> viewOrder(int poNo) {
      Order orderView = adminOrderDao.selectOrderByPoNo(poNo);
      System.out.println(orderView);
      Map<String, Object> viewOrderMap = new HashMap<>();

      viewOrderMap.put("viewOrder", orderView);
      
      return viewOrderMap;
      
   }

   
}