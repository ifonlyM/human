package co.kr.humankdh.mapper;

import static org.junit.Assert.assertNotNull;

import java.util.Calendar;
import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import co.kr.humankdh.domain.ReserveVo;
import co.kr.humankdh.domain.TrainerCareerVo;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
,"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
@WebAppConfiguration
public class PTreserveMapperTests {
	@Setter @Autowired
	private PTreserveMapper ptMapper;
	
	@Test
	public void testExsist(){
		assertNotNull(ptMapper);
	}
	
	@Test
	public void testGetTrainerList() {
		ptMapper.getTrainerList().forEach(log::info);
	}
	
	@Test
	public void testInsertCareer() {
		TrainerCareerVo vo = new TrainerCareerVo();
		vo.setTrainerId("madu");
		vo.setCareerName("47회 국제 올림피아드 5위");
		vo.setStartDate("2006-10-01");
		vo.setEndDate("2006-10-01");
		vo.setComments("친절하게 근성장의 A to Z 까지 알려드립니다.");
		ptMapper.insertCareer(vo);
	}
	
	@Test
	public void testUpdateCareer() {
		TrainerCareerVo vo = new TrainerCareerVo();
		vo.setCno(65L);
		vo.setCareerName("47회 국제 올림피아드 5위");
		vo.setStartDate("2006-10-01");
		vo.setEndDate("2006-10-01");
		ptMapper.updateCareer(vo);
	}
	
	@Test
	public void testInsertPT() {
		ReserveVo vo = new ReserveVo();
		vo.setTrainerId("hcs");
		vo.setMemeberId("wkqkaos123");
		vo.setReserveDate("2022-06-15");
		vo.setStartTime("10:00");
		vo.setEndTime("11:00");
		ptMapper.insertPT(vo);
	}
	
}
