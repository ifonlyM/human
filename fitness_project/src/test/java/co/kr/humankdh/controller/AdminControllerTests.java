package co.kr.humankdh.controller;

import static org.junit.Assert.assertNotNull;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
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
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.ui.ModelMap;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import co.kr.humankdh.domain.BlackListVo;
import co.kr.humankdh.domain.BoardVo;
import co.kr.humankdh.domain.TrainerCareerVo;
import co.kr.humankdh.service.BlackListService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
@WebAppConfiguration
public class AdminControllerTests {
	@Setter @Autowired
	private WebApplicationContext ctx;
	private MockMvc mvc;
	
	private BlackListService service;
	
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
	
	

	
//	관리자 게시글 테스트 ============================================================================
	
	/*
	 * 한수빈 
	 * 게시글 리스트 조회 테스트 
	 */
	@Test//성공
	public void testBoardList() throws Exception {
		ModelMap map = mvc.perform(MockMvcRequestBuilders.get("/AdminServe/boardList")
				.param("pageNum", "1")
				.param("amount", "5")
				)
			.andReturn()
			.getModelAndView()
			.getModelMap();
		log.info(map.get("board"));
	}
	
	/*
	 * 한수빈 
	 * 게시글 삭제 테스트
	 */
	@Test//성공
	public void testBoardRemove() throws Exception {
	
		ModelAndView mav = mvc.perform(
	            MockMvcRequestBuilders.post("/AdminServe/boardDelete")
	            .param("bno", "1092")
	            )
	            .andReturn()
	            .getModelAndView();
	      
	   
		
	}
	

	
	
//관리자 회원 테스트======================================================
	
	/*
	 * 한수빈 
	 * 회원 등록 테스트
	 */
	@Test//성공
	public void testMemberRegister() throws Exception {
		ModelAndView mav = mvc.perform(
				MockMvcRequestBuilders.post("/AdminServe/memberRegister")
				.param("userName", "테스트어드민")
				.param("userpw", "1234")
				.param("gender", "M")
				.param("phone", "01012345698")
				.param("email", "test@test12.wd13d")
				.param("address", "컨트롤러테스트")
				.param("height", "154")
				.param("weight", "123")
				.param("category", "1")
				.param("userid", "어드민컨트롤테스트"))
				.andReturn()
				.getModelAndView();
		
		log.info(mav.getViewName());
	}
	
	/*
	 * 한수빈 
	 * 회원 리스트 조회 테스트 
	 */
	@Test //성공
	public void testMemberList() throws Exception {
		ModelAndView mav = mvc.perform(
			MockMvcRequestBuilders.get("/AdminServe/memberInquiry")
			.param("pageNum", "1")
			.param("amount", "10"))
			.andReturn()
			.getModelAndView();
		
		log.info(mav.getViewName());
		
	}
	
	
	
	/*
	 * 한수빈
	 * 회원 단일 조회 테스트
	 */
	@Test //성공
	public void testMemberGet() throws Exception {
		ModelMap map = mvc.perform(MockMvcRequestBuilders.get("/AdminServe/memberDetail").param("userid", "테스트등록"))
				.andReturn()
				.getModelAndView()
				.getModelMap();
		log.info(map.get("userid"));
	}
	
	/*
	 * 한수빈
	 * 회원 수정 테스트  
	 */
	@Test //성공
	public void testMemberModify() throws Exception {
		
		
		ModelAndView mav = mvc.perform(
				MockMvcRequestBuilders.post("/AdminServe/memberDetail")
				.param("userName", "컨트롤러 테스트 수정")
				.param("userpw", "123456")
				.param("gender", "F")
				.param("phone", "01011111111")
				.param("email", "test@test")
				.param("address", "컨트롤러테스트")
				.param("height", "154")
				.param("weight", "123")
				.param("category", "1")
				.param("userid", "테스트등록"))
				.andReturn()
				.getModelAndView();
		
		log.info(mav.getViewName());
	}
	
	/*
	 * 한수빈 
	 * 회원 삭제 테스트
	 */
	@Test//성공
	public void testMemberDelete() throws Exception {
	
		ModelAndView mav = mvc.perform(
				MockMvcRequestBuilders.post("/AdminServe/memberDelete")
				.param("userid", "테스트등록"))
				.andReturn()
				.getModelAndView();
		

		
	}
	
	/*
	 * 한수빈 
	 * 회원  페이지 접속 테스트
	 */
	@Test //성공
	public void testMemberRegisterGet() throws Exception{
		mvc.perform(MockMvcRequestBuilders.get("/AdminServe/memberRegister")
				
				)
		.andReturn()
		.getModelAndView()
		.getModelMap();
	}

	
	
	
	
	
	
// 블랙리스트 테스트==================================================================	
	
	/*
	 * 한수빈 
	 * 블랙리스트 조회
	 */
	@Test //성공
	public void testBlackList() throws Exception {
		ModelAndView mav = mvc.perform(
			MockMvcRequestBuilders.get("/AdminServe/blackList")
			.param("pageNum", "1")
			.param("amount", "10"))
			.andReturn()
			.getModelAndView();
		
		log.info(mav.getViewName());
		
	}	

	/*
	 * 한수빈 
	 * 블랙리스트 등록 테스트
	 */
	@Test//성공
	public void testBlackListRegister() throws Exception {
		BlackListVo blackmember =  new  BlackListVo();
		blackmember.setId("컨트롤러블랙아이디");
		blackmember.setTerm(30);
		blackmember.setResson("컨트롤러블랙이유");
		String request = new Gson().toJson(blackmember);
		
		mvc.perform(post("/AdminServe/blacklistregister")
					.contentType(MediaType.APPLICATION_JSON_UTF8_VALUE)
					.content(request)
					.accept("text/plain; charset=utf-8"))
			.andDo(print());
		
	}
	
	/*
	 * 한수빈 
	 * 블랙리스트 삭제 테스트
	 */
	@Test//성공
	public void testBlackListDelete() throws Exception {
	
		ModelAndView mav = mvc.perform(
				MockMvcRequestBuilders.post("/AdminServe/blackDelete")
				.param("blackno", "141"))
				.andReturn()
				.getModelAndView();
		
	
}



// 관리자 매출 테스트 ================================================
	
	
	/*
	 * 한수빈 
	 * 매출 리스트 조회 테스트
	 */	
	@Test//성공
	public void testSalesList() throws Exception {
		ModelMap map = mvc.perform(MockMvcRequestBuilders.get("/AdminServe/salesInquiry")
				.param("pageNum", "1")
				.param("amount", "10")
				)
			.andReturn()
			.getModelAndView()
			.getModelMap();
		log.info(map.get("sales"));
	}
	
	/*
	 * 한수빈 
	 * 매출 단일 조회 테스트
	 */
	@Test //성공
	public void testSalesrGet() throws Exception {
		ModelMap map = mvc.perform(MockMvcRequestBuilders.get("/AdminServe/salesget").param("sno", "90"))
				.andReturn()
				.getModelAndView()
				.getModelMap();
		log.info(map.get("sales"));
	}
	
	/*
	 * 한수빈 
	 * 매출 등록 테스트
	 */
	@Test//성공
	public void testSalesRegister() throws Exception {
		ModelAndView mav = mvc.perform(
				MockMvcRequestBuilders.post("/AdminServe/salesRegister")
				.param("name", "테스트어드민")
				.param("cost", "123234")
				.param("buydate", "2021-11-11")
				.param("id", "컨트롤러테스트매출")
				.param("trainer", "테스트트레이너")
				.param("buycontent", "테스트")
				.param("payment", "테스트"))
				.andReturn()
				.getModelAndView();
		
		log.info(mav.getViewName());
	}
	
	/*
	 * 한수빈 
	 * 매출 삭제 테스트
	 */
	@Test//성공
	public void testSalesRemove() throws Exception {
	
		ModelAndView mav = mvc.perform(
	            MockMvcRequestBuilders.post("/AdminServe/salesDelete")
	            .param("sno", "261")
	            )
	            .andReturn()
	            .getModelAndView();
	      
		
		
		}
	
	/*
	 * 한수빈 
	 * 매출 월별 조회 그래프 테스트
	 */
	@Test //성공
	public void testSalesrByYear() throws Exception {
		 mvc.perform(MockMvcRequestBuilders.get("/AdminServe/salesInquiry/2021").param("year", "2021"))
				.andReturn()
				.getModelAndView();
				
		
	
		}
	
	/*
	 * 한수빈 
	 * 매출조회 페이지 접속테스트
	 */
	@Test //성공
	public void testSalesResgisterGet() throws Exception{
		mvc.perform(MockMvcRequestBuilders.get("/AdminServe/salesRegister")
				
				)
		.andReturn()
		.getModelAndView()
		.getModelMap();
	}



}
