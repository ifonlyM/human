package co.kr.humankdh.controller;

import static org.junit.Assert.assertNotNull;
//import static org.springframework.test.web.client.match.MockRestRequestMatchers.content;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultMatcher;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import co.kr.humankdh.domain.MemberVo;
import co.kr.humankdh.domain.TrainerCareerVo;
import co.kr.humankdh.mapper.PTreserveMapperTests;
import co.kr.humankdh.service.PTreserveService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
,"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
@WebAppConfiguration
public class PTreserveControllerTests {
	@Setter @Autowired
	private WebApplicationContext ctx;
	
	private MockMvc mvc;
	
	@Setter @Autowired
	private PTreserveService service;
	
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
	 *  캘린더 페이지 연결 여부 test
	 *  @author 문현석 2021-11-05
	 * @throws Exception 
	 */
	@Test
	public void testCalendar() throws Exception {
		ModelAndView mav =	mvc.perform(get("/PTreserve/calendar"))
								.andExpect(status().is(200))
								.andDo(print())
								.andReturn().getModelAndView();
		log.info(mav.getViewName());
	}
	
	/**
	 *  트레이너선택(소개) 페이지 연결 여부 test
	 *  @author 문현석 2021-11-05
	 *  @throws Exception 
	 */
	@Test
	public void testTrainers() throws Exception{
		ModelAndView mav = mvc.perform(get("/PTreserve/trainers"))
							   .andExpect(status().is(200))
							   .andDo(print())
							   .andReturn().getModelAndView();
		log.info(mav.getViewName());
	}
	
	/**
	 *  트레이너들과 트레이너들의 각 경력들을 제대로 가져오는지 test
	 * @author 문현석 2021-11-05
	 * @throws Exception
	 */
	@Test
	public void testGetTrainers() throws Exception{
		Map<String, List<TrainerCareerVo>> careers = new HashMap<>();
		List<MemberVo> trainers = service.getTrainerList();
		trainers.forEach( t -> {
			careers.put( t.getUserName(), service.getCareers(t.getUserid())); 
		});
		String jsonExpected = new Gson().toJson(careers); // 예상 데이터
		log.info("로그 - jsonStr :: " + jsonExpected);
		
		mvc.perform(post("/PTreserve/getTrainers")
						.accept(MediaType.APPLICATION_JSON_VALUE))
					.andDo(print())
					.andExpect(content().json(jsonExpected)) // 예상 응답 데이터와 실제 응답 데이터를 비교(JSON)
					.andExpect(status().is(200));
	}
	
	/**
	 *  커리어작성 페이지 접속 test
	 *  트레이너리스트 응답
	 *  @author 문현석 2021-11-05
	 * @throws Exception 
	 */
	@Test
	public void testCareerWriteGet() throws Exception{
		ModelMap map = mvc.perform(get("/PTreserve/careerWrite"))
				.andDo(print())
				.andExpect(status().is(200))
				.andReturn()
					.getModelAndView().getModelMap();
		List<?> list = (List<?>) map.get("list");
		list.forEach(log::info);
	}
	
	/**
	 *  웹 화면에서 커리어작성 요청 test
	 *  응답 성공시, 커리어 작성 대상의 id가 넘어오는지 test
	 *  @author 문현석 2021-11-5
	 * @throws Exception 
	 */
	@Test
	public void testCareerWritePost() throws Exception {
		List<TrainerCareerVo> careers = new ArrayList<>();
		TrainerCareerVo career = new TrainerCareerVo();
		career.setCno(null);
		career.setTrainerId("testTrainer");
		career.setCareerName("테스트커리어3");
		career.setStartDate("2021-11-05");
		career.setEndDate("2021-11-06");
		career.setComments("테스트코멘트3");
		careers.add(career);
		
		career = new TrainerCareerVo();
		career.setCno(null);
		career.setTrainerId("testTrainer");
		career.setCareerName("테스트커리어4");
		career.setStartDate("2021-11-05");
		career.setEndDate("2021-11-06");
		career.setComments("테스트코멘트4");
		careers.add(career);
		
		
		String request = new Gson().toJson(careers);
		String strExpected = career.getTrainerId();
		log.info("응답 예상 데이터 :: " + strExpected);
		
		mvc.perform(post("/PTreserve/careerWrite")
					.contentType(MediaType.APPLICATION_JSON_UTF8_VALUE)
					.content(request))
			.andDo(print())
			.andExpect(content().string(strExpected)) // 예상 응답 데이터와 실제 응답 데이터 비교
			.andExpect(status().is(200));
	}
	
	/**
	 * 웹화면에서 트레이너 선택시 해당트레이너의 경력리스트 요청 test
	 * @author 문현석 2021-11-05
	 * @throws Exception 
	 */
	@Test
	public void testGetCareers() throws Exception {
		String request = "testTrainer";
		String jsonExpected = new Gson().toJson(service.getCareers("testTrainer")); // 예상 응답 데이터
		log.info("예상 응답 데이터 :: " + jsonExpected);
		
		mvc.perform(post("/PTreserve/getCareers")
					.contentType(MediaType.APPLICATION_JSON_UTF8_VALUE)
					.content(request)
					.accept(MediaType.APPLICATION_JSON_UTF8_VALUE))
			.andDo(print())
			.andExpect(content().json(jsonExpected)) // 예상 응답 데이터와 실제 응답데이터 비교
			.andExpect(status().is(200));
	}
	
	/**
	 * 웹화면에 트레이너의 저장된 코멘트를 보여주기위한 요청 test
	 * @author 문현석 2021-11-05
	 * @throws Exception 
	 */
	@Test
	public void testGetComments() throws Exception {
		String request = "USER02";
		String strExpected = service.getLastComments("USER02");
		log.info("예상 응답 데이터 :: " + strExpected);
		
		mvc.perform(post("/PTreserve/getComments")
					.contentType("application/text; charset=utf-8")
					.content(request)
					.accept("text/plain; charset=utf-8"))
			.andDo(print())
			.andExpect(content().string(strExpected)) // 예상 응답 데이터와 실제 응답 데이터 비교
			.andExpect(status().is(200));
	}
	
	/**
	 * 웹화면에서 트레이너 경력 수정 요청 test
	 * @author 문현석 2021-11-05
	 * @throws Exception 
	 */
	@Test
	public void testUpdateCareer() throws Exception {
		TrainerCareerVo career = service.getCareers("testTrainer").get(0);
		career.setCareerName("컨트롤러 테스트에서 수정된 커리어");
		career.setStartDate("2021-11-06");
		career.setEndDate("2021-11-07");
		String request = new Gson().toJson(career);
		String strExpected = "수정되었습니다";	// 예상 응답 데이터
		
		mvc.perform(post("/PTreserve/updateCareer")
					.contentType(MediaType.APPLICATION_JSON_UTF8_VALUE)
					.content(request)
					.accept("text/plain; charset=utf-8"))
			.andDo(print())
			.andExpect(content().string(strExpected)) // 예상 응답 데이터와 실제 응답 데이터 비교
			.andExpect(status().is(200));
	}
	
	/**
	 * 웹화면에서 트레이너 경력 삭제 요청 test
	 * @author 문현석 2021-11-05
	 * @throws Exception 
	 */
	@Test
	@Transactional
	public void testDeleteCareer() throws Exception {
		Long cno = 210L;
		String request = new Gson().toJson(cno);
		String strExpected = "삭제되었습니다"; // 예상 응답 데이터
		
		mvc.perform(post("/PTreserve/deleteCareer")
					.contentType(MediaType.APPLICATION_JSON_UTF8_VALUE)
					.content(request)
					.accept("text/plain; charset=utf-8"))
			.andDo(print())
			.andExpect(content().string(strExpected)) // 예상 응답 데이터와 실제 데이터 비교
			.andExpect(status().is(200));
		
	}
	
	/**
	 * LocalDate를 이용한 날짜계산
	 */
	@Test
	public void testDateCalc() {
		LocalDateTime currDateTime = LocalDateTime.now();
		
		log.info("=======LocalDateTime Test========");
		log.info("현재 날짜 및 시간 : "+ currDateTime);
		
		currDateTime = LocalDateTime.of(
				currDateTime.getYear(), 
				currDateTime.getMonthValue(),
				currDateTime.getDayOfMonth(),
				currDateTime.getHour(),
				0);
		LocalDateTime reserveDateTime = LocalDateTime.of(2022, 6, 28, 15, 0, 0);

		Duration duration = Duration.between(currDateTime, reserveDateTime);
		log.info("seconds : " + duration.getSeconds());
		log.info("minutes : " + duration.getSeconds() / 60);
		log.info("hour : " + duration.getSeconds() / 60 / 60);
		
		log.info("=========String Test=======");
		String[] testStr = new String[]{"test1", "test2"};
		log.info(testStr[0]+" "+ testStr[1]);
		
	}
}
