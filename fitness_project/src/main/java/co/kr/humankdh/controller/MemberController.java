package co.kr.humankdh.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import co.kr.humankdh.domain.Criteria;
import co.kr.humankdh.domain.PageDTO;
import co.kr.humankdh.service.MemberService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import oracle.net.aso.m;


@Log4j
@Controller
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {

	
	
	@GetMapping("login")
	public void login() {
		log.info("login");
	}
	
	@GetMapping("joinUs")
	public void joinUs() {
		log.info("joinUS");
	}
	
	@GetMapping("findInfo")
	public void findInfo() {
		log.info("findInfo");
	}


}
