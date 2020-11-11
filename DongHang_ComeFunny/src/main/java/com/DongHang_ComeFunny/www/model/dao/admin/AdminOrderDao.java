package com.DongHang_ComeFunny.www.model.dao.admin;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.DongHang_ComeFunny.www.model.vo.Order;

@Repository
public class AdminOrderDao {
   
   @Autowired
   SqlSessionTemplate sqlSession;

   public int selectOrderCnt(Map<String, Object> searchOrder) {
      return sqlSession.selectOne("AdminOrder.selectOrderCnt", searchOrder);
   }

   public List<Order> selectOrderList(Map<String, Object> searchOrderMap) {
      return sqlSession.selectList("AdminOrder.selectOrderList", searchOrderMap);
   }

   public Order selectOrderByPoNo(int poNo) {
      return sqlSession.selectOne("AdminOrder.selectOrderByPoNo", poNo);
   }



}