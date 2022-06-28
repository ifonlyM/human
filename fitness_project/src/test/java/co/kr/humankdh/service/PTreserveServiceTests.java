package co.kr.humankdh.service;

import static org.junit.Assert.assertNotNull;

import java.time.LocalDate;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import co.kr.humankdh.domain.TrainerCareerVo;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
,"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
@WebAppConfiguration
public class PTreserveServiceTests {
	@Setter @Autowired
	private PTreserveService service;
	
	@Test
	public void testExist(){
		assertNotNull(service);
	}
	
	@Test
	public void testGetTrainerList() {
		service.getTrainerList().forEach(log::info);
	}
	
	@Test
	public void testGetCareers() {
		service.getCareers("USER02");
	}
	
	@Test
	public void testGetLastComments() {
		log.info(service.getLastComments("USER02"));
	}
	
	@Test
	public void testInsertCareer() {
		TrainerCareerVo vo = new TrainerCareerVo();
		vo.setTrainerId("USER02");
		vo.setCareerName("제1회 근육맨 대회 우승");
		vo.setStartDate("");
		vo.setEndDate("");
		vo.setComments("찐막 코멘트");
		service.insertCareer(vo);
	}
}
