package co.kr.humankdh.mapper;

import static org.junit.Assert.assertNotNull;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

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
		vo.setMemberId("wkqkaos123");
		vo.setReserveDate("2022-06-15");
		vo.setStartTime("11:00");
//		vo.setEndTime("11:00");
		ptMapper.insertPT(vo);
	}
	
	@Test
	public void testTrainerHasReserveByTime() {
		ReserveVo vo = new ReserveVo();
		vo.setTrainerId("hcs");
		vo.setMemberId("wkqkaos123");
		vo.setReserveDate("2022-06-15");
		vo.setStartTime("10:01");
		boolean hasReserve = ptMapper.trainerHasReserveByTime(vo);
		log.info(hasReserve);
	}
	
	@Test
	public void testMemberHasReserveByDay() {
		ReserveVo vo = new ReserveVo();
		vo.setTrainerId("hcs");
		vo.setMemberId("wkqkaos123");
		vo.setReserveDate("2022-06-23");
		vo.setStartTime("11:00");
		boolean hasReserve = ptMapper.memberHasReserveByDay(vo);
		log.info(hasReserve);
	}
	
	@Test
	public void testSelecttrainerReservedTime() {
		String trainerId = "hcs";
		String reserveDate = "2022-06-22";
		
		List<String> list = ptMapper.selectTrainerReservedTimeBy(trainerId, reserveDate);
		log.info(list);
	}
	
	@Test
	public void testSelectTrainerReservedDayBy() {
		String trainerId = "hcs";
		String year_month = "2022-06";
		String today = "23";
		
		List<String> list = ptMapper.selectTrainerReservedDayBy(trainerId, year_month, today);
		log.info(list);
	}
	
	@Test
	public void testSelectTrainerReservedAllDayBy() {
		String trainerId = "hcs";
		String year_month = "2022-06";
		
		List<String> list = ptMapper.selectTrainerReservedAllDayBy(trainerId, year_month);
		log.info(list);
	}
	
	@Test
	public void testSelectUserReservedTimeBy(){
		String userId = "wkqkaos123";
		String reserveDate = "2022-06-25";
		
		log.info(ptMapper.selectUserReservedTimeBy(userId, reserveDate));
	}
	
	@Test
	public void testSelectUserReservedDayBy() {
		String userId = "wkqkaos123";
		String year_month = "2022-06";
		
		log.info(ptMapper.selectUserReservedDayBy(userId, year_month));
	}
	
	@Test
	public void testSelectUserReserveDetailBy() {
		String userId = "wkqkaos123";
		String reserveDate = "2022-06-15";
		String reserveTime = "10";
		
		log.info(ptMapper.selectUserReserveDetailBy(userId, reserveDate, reserveTime));
	}
	
	@Test
	public void testDeleteReserveBy(){
		Long rno = 6L;
		ptMapper.deleteReserveBy(rno);
	}
	
	@Test
	public void testSelectTrainerReserveDetailBy() {
		String trainerId = "hcs";
		String reserveDate = "2022-06-27";
		String reserveTime = "10";
		
		log.info(ptMapper.selectUserReserveDetailBy(trainerId, reserveDate, reserveTime));
	}
	
}
