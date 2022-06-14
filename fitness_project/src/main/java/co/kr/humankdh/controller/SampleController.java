package co.kr.humankdh.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/login/*")
@Controller
public class SampleController {
	
	@GetMapping("/member")
	public void doMember() {
		log.info("사이트 회원");
	}
	
	@GetMapping("/kakao")
	public void doKakao() {
		log.info("카카오회원");
	}
	
	@GetMapping("/admin")
	public void doAdmin() {
		log.info("관리자");
	}
	@GetMapping("doMember")
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	public String doMember2() {
		log.info("member~~~");
		return "sample/member";
	}
}
