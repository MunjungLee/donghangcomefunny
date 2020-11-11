package com.DongHang_ComeFunny.www.model.dao.payment;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.DongHang_ComeFunny.www.model.vo.Order;
@Repository
public class PaymentDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int insertOrder(Order ord) {
		return sqlSession.insert("ORDER.insertOrder", ord);
	}
}
