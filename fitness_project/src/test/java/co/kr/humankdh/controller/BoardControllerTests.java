package co.kr.humankdh.controller;

import static org.junit.Assert.assertNotNull;

import java.util.List;

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

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
@WebAppConfiguration
public class BoardControllerTests {
	@Setter @Autowired
	private WebApplicationContext ctx;
	private MockMvc mvc;
	
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
	 *  공지사항 게시판 목록 조회 테스트
	 *  @author 김동휘 2021-11-13
	 * @throws Exception 
	 */
	
	@Test
	public void testNoticeList() throws Exception {
		ModelMap map = mvc.perform(MockMvcRequestBuilders.get("/board/notice_list")
				.param("pageNum", "1")
				.param("amount", "5")
				)
			.andReturn()
			.getModelAndView()
			.getModelMap();
		log.info(map.get("board"));
	}
	
	/**
	 * 자유게시판 목록 조회 테스트
	 *  @author 김동휘 2021-11-13
	 * @throws Exception 
	 */
	@Test
	public void testFreeList() throws Exception {
		ModelMap map = mvc.perform(MockMvcRequestBuilders.get("/board/free_list")
				.param("pageNum", "1")
				.param("amount", "5")
				)
			.andReturn()
			.getModelAndView()
			.getModelMap();
		log.info(map.get("board"));
	}
	
	/**
	 *  갤러리 게시판 목록 조회 테스트
	 *  @author 김동휘 2021-11-13
	 * @throws Exception 
	 */
	@Test
	public void testGalleryList() throws Exception {
		ModelMap map = mvc.perform(MockMvcRequestBuilders.get("/board/gallery_list")
				.param("pageNum", "1")
				.param("amount", "5")
				)
			.andReturn()
			.getModelAndView()
			.getModelMap();
		log.info(map.get("board"));
	}
	
	/**
	 *  운동영상 게시판 목록 조회 테스트
	 *  @author 김동휘 2021-11-13
	 * @throws Exception 
	 */
	@Test
	public void testVideoList() throws Exception {
		ModelMap map = mvc.perform(MockMvcRequestBuilders.get("/board/video_list")
				.param("pageNum", "1")
				.param("amount", "5")
				)
			.andReturn()
			.getModelAndView()
			.getModelMap();
		log.info(map.get("board"));
	}
	
	/**
	 *  운동기록 게시판 목록 조회 테스트
	 *  @author 김동휘 2021-11-13
	 * @throws Exception 
	 */
	@Test
	public void testRecordList() throws Exception {
		ModelMap map = mvc.perform(MockMvcRequestBuilders.get("/board/record_list")
				.param("pageNum", "1")
				.param("amount", "5")
				)
			.andReturn()
			.getModelAndView()
			.getModelMap();
		log.info(map.get("board"));
	}
	/**
	 *  게시글 작성 테스트
	 *  @author 김동휘 2021-11-13
	 * @throws Exception 
	 */
	@Test
	public void testRegister() throws Exception {
		ModelAndView mav = mvc.perform(
			MockMvcRequestBuilders.post("/board/register")
			.param("title", "컨트롤러 테스트 글 제목")
			.param("content", "컨트롤러 테스트 글 내용"))
			.andReturn()
			.getModelAndView();
		log.info(mav.getViewName());
		
	}
	
	/**
	 *  게시글 단일 조회 테스트
	 *  @author 김동휘 2021-11-13
	 * @throws Exception 
	 */
	@Test
	public void testGet() throws Exception {
		ModelMap map = mvc.perform(MockMvcRequestBuilders.get("/board/get")
				.param("bno", "1261")
				.param("category", "1"))
				.andReturn()
				.getModelAndView()
				.getModelMap();
		log.info(map.get("board"));
	}
	
	/**
	 *  게시글 수정 테스트
	 *  @author 김동휘 2021-11-13
	 * @throws Exception 
	 */
	@Test
	public void testModify() throws Exception {
		ModelAndView mav = mvc.perform(
				MockMvcRequestBuilders.post("/board/modify")
				.param("title", "컨트롤러 테스트 글 제목 수정")
				.param("content", "컨트롤러 테스트 글 내용 수정")
				.param("bno", "1261"))
				.andReturn()
				.getModelAndView();
		
		log.info(mav.getViewName());
	}
	/**
	 *  게시글 삭제 테스트
	 *  @author 김동휘 2021-11-13
	 * @throws Exception 
	 */
	@Test
	public void testRemove() throws Exception {
		ModelAndView mav = mvc.perform(
				MockMvcRequestBuilders.post("/board/remove")
				.param("bno", "82")
				)
				.andReturn()
				.getModelAndView();
		
		log.info(mav.getViewName());
	}
	
	
}
