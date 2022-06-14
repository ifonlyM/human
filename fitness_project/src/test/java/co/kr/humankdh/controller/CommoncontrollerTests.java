package co.kr.humankdh.controller;

import static org.junit.Assert.assertNotNull;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.ui.ModelMap;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import co.kr.humankdh.domain.MemberVo;
import co.kr.humankdh.service.MemberService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@Log4j
@WebAppConfiguration
public class CommoncontrollerTests {
	@Setter
	@Autowired
	private WebApplicationContext ctx;
	private MockMvc mvc;

	@Setter
	@Autowired
	private MemberService service;

	@Before
	public void setup() {
		mvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}

	@Test
	public void testExist() {
		assertNotNull(ctx);
		assertNotNull(mvc);
		log.info(ctx);
		log.info(mvc);

	}

	// 메시지 전송 테스트
//	@Test
//	public void testMessage() {
//		String phoneNumber = "01041511531";
//		Random rand = new Random();
//		String numStr = "";
//		for (int i = 0; i < 4; i++) {
//			String ran = Integer.toString(rand.nextInt(10));
//			numStr += ran;
//		}
//
//		service.certifiedPhoneNumber(phoneNumber, numStr);
//
//		log.info("수신자 번호 : " + phoneNumber);
//		log.info("인증번호 : " + numStr);
//		// 발신번호는 CoolSMS에 등록해서 써야함.
//	}

	// 아이디 중복검사
	@Test
	public void testIdChk() throws Exception {
		
		mvc.perform(post("/common/idChk")
				.contentType("application/json; charset=utf-8")
				.content("JAVAMAN")
				.accept("application/json; charset=utf-8"))
		.andDo(print())
		.andExpect(status().is(200));
	}

	// 로그인 테스트
	@Test
		public void testLogin() throws Exception{ 
		Map<String, Object> map = new HashMap<>();
		map.put("id", "USER01");
		map.put("pwd", "1234");
		
		String json = new Gson().toJson(map);
		
		mvc.perform(post("/common/login")
				.contentType("application/json; charset=utf-8")
				.content(json)
				.accept("application/json; charset=utf-8"))
		.andDo(print())
		.andExpect(status().is(200));
		
	}
	
	// CRUD 테스트 만들기
	
	// CREATE 회원 가입
	@Test // 성공
	public void testCreate() throws Exception {
		ModelAndView mav = mvc.perform(MockMvcRequestBuilders.post("/common/CreateMember")
				.param("userid", "qqqaaaa")
				.param("userpw", "1234")
				.param("userName", "테s스s트용12")
				.param("gender", "F")
				.param("phone", "01091236832")
				.param("email", "aavvaa@gmsail.cosm"))
				.andReturn()
				.getModelAndView();
		
		log.info(mav.getViewName());
				
	}
	// READ 회원 조회
	@Test
	public void testRead() throws Exception {
		ModelMap map = mvc.perform(MockMvcRequestBuilders.get("/common/ReadMember")
				.param("userid", "JAVAMAN"))
				.andReturn()
				.getModelAndView()
				.getModelMap();
		log.info(map.get("userid"));
		
	}
	// UPDATE 회원 정보 수정
	@Test
	public void testUpdate() throws Exception {
		ModelAndView mav = mvc.perform(MockMvcRequestBuilders.post("/common/UpdateMember")
				.param("userid", "asdf1234")
				.param("userpw", "1234")
				.param("userName", "테스트용12수정함")
				.param("gender", "F")
				.param("phone", "01011234332")
				.param("email", "aaaaa@test.com")
				.param("address", "update테스트")
				.param("height", "update테스트")
				.param("weight", "update테스트")
				.param("category", "update테스트")
				)
				.andReturn()
				.getModelAndView();
		
		log.info(mav.getViewName());
	}
	
	// DELETE 회원탈퇴
	@Test
	public void testDelete() throws Exception {
		ModelAndView mav = mvc.perform(MockMvcRequestBuilders.post("/common/delete")
				.param("userid", "asdf1234"))
				.andReturn()
				.getModelAndView();
		
	}
	//dd
}
