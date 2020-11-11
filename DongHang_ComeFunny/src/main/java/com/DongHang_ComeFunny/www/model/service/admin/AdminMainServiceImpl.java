package com.DongHang_ComeFunny.www.model.service.admin;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.client.OkHttp3ClientHttpRequestFactory;
import org.springframework.stereotype.Service;

import com.DongHang_ComeFunny.www.model.dao.admin.AdminMainDao;

@Service
public class AdminMainServiceImpl implements AdminMainService {

	@Autowired
	AdminMainDao adminMainDao;
	@Override
	public Map<String, Object> countTodayCnt() {
		
		int user = adminMainDao.selectTodayUserCnt();
		int payment = adminMainDao.selectTodayPaymentCnt();
		int post = adminMainDao.selectTodayPostCnt();
		
		Map<String, Object> todayCount = new HashMap<>();
		todayCount.put("user", user);
		todayCount.put("payment", payment);
		todayCount.put("post", post);
		return todayCount;
	}

}
