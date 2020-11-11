package com.DongHang_ComeFunny.www.model.service.admin;

import java.util.List;
import java.util.Map;

import com.DongHang_ComeFunny.www.model.vo.Order;

public interface AdminOrderService {

   Map<String, Object> viewOrderList(int cPage, int cntPerPage, Map<String, Object> searchOrder);

   Map<String, Object> viewOrder(int pONo);


}