package co.kr.humankdh.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect
@Log4j
@Component
public class LogAdvice {

	public void logAdvice(JoinPoint jp) {
		log.info("++++++++++++++++++++++++++++++++");
	}

	public Object logTime(ProceedingJoinPoint pjp) {
		long start = System.currentTimeMillis();
		Object obj = null; // 비 초기화 지역변수는 사용불가?
		long end = System.currentTimeMillis();
		Object[] args = pjp.getArgs();
		String[] strs = new String[args.length];
		for (int i = 0; i < args.length; i++) {
			strs[i] = args[i].toString();
		}
		String str = String.join(",", strs);
		log.info(String.format("%s.%s(%s) :: %d ms",
				pjp.getTarget().getClass().getSimpleName(),
				pjp.getSignature().getName(),
				strs,
				end - start));
		return obj;
	}
}
