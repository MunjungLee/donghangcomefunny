package com.DongHang_ComeFunny.www.model.service.payment;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.DongHang_ComeFunny.www.model.dao.payment.PaymentDao;
import com.DongHang_ComeFunny.www.model.dao.user.UserDao;
import com.DongHang_ComeFunny.www.model.vo.Order;
@Service
public class PaymentServiceImpl implements PaymentService{
	@Autowired
	PaymentDao paymentDao;
	@Autowired
	UserDao userDao;
	@Override
	public int insertOrder(Order ord) {
		HashMap<String, Integer> param = new HashMap<String, Integer>(); 
		
		int res=0;
		res += paymentDao.insertOrder(ord);
		if (res ==1){
			param.put("uno",ord.getoUNo() );
			param.put("amount",ord.getoQunatity() );
			res +=userDao.updateDHBG(param);
		}
		return res;
	}

}
