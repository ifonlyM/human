package co.kr.humankdh.controller;

import static org.junit.Assert.assertNotNull;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import com.google.gson.Gson;

import co.kr.humankdh.domain.ReplyCriteria;
import co.kr.humankdh.domain.ReplyVo;
import co.kr.humankdh.service.ReplyService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
@WebAppConfiguration
public class ReplyControllerTests {
	@Autowired @Setter
	private WebApplicationContext ctx;
	private MockMvc mvc;
	
	@Setter @Autowired
	private ReplyService service;
	
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
	
	/**
	 *  댓글 작성 테스트
	 *  @author 김동휘 2021-11-13
	 * @throws Exception 
	 */
	@Test
	public void testCreate() throws Exception {
		ReplyVo vo = new ReplyVo();
		vo.setBno(1261L);
		vo.setReply("컨트롤러 테스트 댓글");
		vo.setReplyer("테스터");
	
		
		String jsonStr = new Gson().toJson(vo);
		
		log.info("jsonStr :: " + jsonStr);
		
		mvc.perform(post("/replies/new")
				.contentType(MediaType.APPLICATION_JSON_VALUE)
				.content(jsonStr))
				.andExpect(status().is(200));
	}
	/**
	 *  댓글 단일 조회 테스트
	 *  jsonAssert 예상 데이터와 실제 데이터를 비교 해봤는데
	 *  update의 값이 json으로 변환되면서 값의 포멧이 변경되어 사용 불가능
	 *  @author 김동휘 2021-11-13
	 * @throws Exception 
	 */
	@Test
	public void testGet() throws Exception {
		ReplyVo vo = service.get(244L);
		String jsonStr = new Gson().toJson(vo);
		log.info("리플 VO : " + vo);
		log.info("replyGet : " + jsonStr);
		
		mvc.perform(get("/replies/244")
				.accept(MediaType.APPLICATION_JSON_VALUE))
		.andDo(print())
		.andExpect(status().is(200));
		
	}
	/**
	 *  댓글 수정 테스트
	 *  @author 김동휘 2021-11-13
	 * @throws Exception 
	 */
	@Test
	public void testModify() throws Exception {
		ReplyVo vo = new ReplyVo();
		vo.setReply("테스트에서 수정된 댓글");
		vo.setReplyer("USER01");
		vo.setRno(211L);
		
		String jsonStr = new Gson().toJson(vo);
		log.info("jsonStr :: " + jsonStr);
		
		mvc.perform(put("/replies/211")
				.contentType("application/json; charset=utf-8")
				.content(jsonStr))
		.andDo(print())
		.andExpect(status().is(200));
	}
	
	/**
	 *  댓글 삭제 테스트
	 *  @author 김동휘 2021-11-13
	 * @throws Exception 
	 */
	@Test @Transactional
	public void testRemove() throws Exception {
		mvc.perform(delete("/replies/244"))
			.andDo(print())
			.andExpect(content().string("success"))
			.andExpect(status().is(200));
	}
	
	/**
	 *  댓글 목록 조회 테스트
	 *  jsonAssert 예상 데이터와 실제 데이터를 비교 해봤는데
	 *  update의 값이 json으로 변환되면서 값의 포멧이 변경되어
	 *  사용 불가능
	 *  @author 김동휘 2021-11-13
	 * @throws Exception 
	 */
	@Test
	public void testGetList() throws Exception {
		List<ReplyVo> vo = service.getList(new ReplyCriteria(244L, 10), 1363L);
		
		String jsonExpected = new Gson().toJson(vo);
		log.info("리플 더보기: replyGet" + vo);
		
		mvc.perform(get("/replies/1261/10/0")
				.accept(MediaType.APPLICATION_JSON_VALUE))
		.andDo(print())
		.andExpect(status().is(200));
		
	}
	
}
