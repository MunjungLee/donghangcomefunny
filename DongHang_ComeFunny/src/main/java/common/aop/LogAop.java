package common.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Aspect
public class LogAop {
	//Before pointcut 지정
	@Before("execution(* com.DongHang_ComeFunny.www..*.*(..))")
	public void before(JoinPoint join) {
		System.out.println("getTarget 출력 : " + join.getTarget()+"");
		Logger logger = LoggerFactory.getLogger(join.getTarget()+"");
		logger.info("----------log-----------");
		
		//매개변수들을 Object[] 로 받아서
		Object[] args = join.getArgs();
		if(args != null) {
			logger.info("method : " + join.getSignature().getName());
			logger.info("----------------매개변수-------------");
			for(Object arg : args) {
				logger.info(arg+"");
			}
			
		}

	}
}