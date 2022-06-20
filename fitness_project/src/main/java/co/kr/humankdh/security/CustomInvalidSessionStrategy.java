package co.kr.humankdh.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.session.InvalidSessionStrategy;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class CustomInvalidSessionStrategy implements InvalidSessionStrategy{
	
	// 세션 만료시
	@Override
	public void onInvalidSessionDetected(HttpServletRequest req, HttpServletResponse resp)
			throws IOException, ServletException {
		
		log.info(SecurityContextHolder.getContext().getAuthentication().toString());
		
		// 로그인한 사용자가 아닌경우
		// (사이트 입장시에는 생성된 세션이 없는데, 이때는 index페이지로 포워드 해준다.)
		if(SecurityContextHolder.getContext().getAuthentication().getName().equals("anonymousUser")){
			log.info("anonymousUser!!!");
			
//			resp.sendRedirect("/common/index");
			req.getRequestDispatcher("/common/index").forward(req, resp);
		}
		// 로그인 중이였던 사용자인 경우
		else {
			req.getRequestDispatcher("/common/login").forward(req, resp);
		}
		
	}

}
