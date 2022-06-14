package co.kr.humankdh.service;

import static org.hamcrest.CoreMatchers.equalTo;
import static org.junit.Assert.assertNotNull; 
import static org.springframework.test.web.client.match.MockRestRequestMatchers.content;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultMatcher;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.thoughtworks.qdox.model.Member;

import co.kr.humankdh.domain.Criteria;
import co.kr.humankdh.domain.MemberVo;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
	,"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
@WebAppConfiguration
public class MemberServiceTests {
	@Setter @Autowired @Qualifier("BCryptPasswordEncoder")
	private PasswordEncoder encoder; 
	
	
	@Setter @Autowired
	private WebApplicationContext ctx;
	private MockMvc mvc;
	
	@Setter @Autowired
	MemberService service;
	
	
	@Test
	public void testExist() {
		assertNotNull(service);
		assertNotNull(encoder);
		log.info(encoder);
	}
	
	
	@Test
	public void testIdChk() {
		log.info(service.idChk("USER01"));
	}
	
	// 회원가입 테스트 성공
	@Test
	public void testInserMember() throws Exception {
		MemberVo vo = new MemberVo();
		vo.setUserid("pwest01");
		vo.setUserpw("1234");
		vo.setUserpw(encoder.encode(vo.getUserpw()));
		vo.setUserName("비번테스트");
		vo.setPhone("01094749874");
		vo.setEmail("pTestz@1test.test");
		vo.setGender("M");
		vo.setEnabled(true);
		
		service.register(vo);
		
		log.info(vo);
	}
	
	// 로그인 테스트
	@Test
	public void testLogin() {
		log.info(service.login("admin01", "qwerqwer12"));
		
	}

	// 회원 정보 수정
	@Test
	public void testModify() {
		MemberVo vo = new MemberVo();
		vo.setUserpw("3210");
		vo.setUserpw(encoder.encode(vo.getUserpw()));
		vo.setUserName("엄엄준식");
		vo.setPhone("11123234123");
		vo.setEmail("uumm@jjuunn.ss");
		vo.setAddress("마포구");
		vo.setHeight(199);
		vo.setWeight(100);
		
		service.modify(vo);
		
		log.info(vo);
		
	}
	
	// 회원 목록
	@Test
	public void testGetList() {
		Criteria cri = new Criteria(1, 40);
		service.getList(cri).forEach(log::info);;
	}
	
	// 비밀번호 암호화 테스트 
	@Test
	public void testConvertNoop2Bcryption() {
		String orgin = "1234";
		log.info(orgin);
		log.info(encoder.encode(orgin));
		
		
		service.getList(new Criteria(1, 40)).forEach((member) -> {
			member.setUserpw(encoder.encode(member.getUserpw()));
			service.modify(member);
		});
	}
	
	// 회원 수정 테스트
	@Test
	public void testMdf() throws Exception {
		MemberVo vo = new MemberVo();
		
		vo.setUserid("zxzx12");
		vo.setUserpw("1111");
		vo.setUserName("야식");
		vo.setGender("M");
		vo.setPhone("12012032993");
		vo.setEmail("e2Cre@a2aaw.cqw");
		vo.setAddress("화성");
		vo.setHeight(190);
		vo.setWeight(100);
		service.modify(vo);
		
		log.info("voㅋ ::" + vo);		
	}
}
