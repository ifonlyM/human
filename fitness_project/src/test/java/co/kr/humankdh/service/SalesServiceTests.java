package co.kr.humankdh.service;

import static org.junit.Assert.assertNotNull;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import co.kr.humankdh.domain.BoardVo;
import co.kr.humankdh.domain.SalesVo;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class SalesServiceTests {
	@Setter @Autowired
	private SalesService service;
	
	@Test
	public void testExist() {
		assertNotNull(service);
	}
	

	
	@Test
	public void testRegister() {
		SalesVo sales  = new SalesVo();
		sales.setId("테스트 아이디 - 셀렉트 키");
		sales.setName("테스트 이름 - 셀렉트 키");
		sales.setCost(300000l);
//		sales.setBuydate("2021-05-10"); 파라미터 값? 
		sales.setTrainer("테스트 트레이너 -셀렉트 키");
		sales.setBuycontent("테스트 구매내용 -셀렉트 키");
		sales.setPayment("테스트 결제방법 -셀렉트키");
		
		service.register(sales);
	}
	
	@Test
	public void testGet() {
		log.info(service.get(23L));
	}
	
	@Test
	public void testModify() {
		SalesVo sales = new SalesVo();
		sales.setId("테스트 아이디 ");
		sales.setName("테스트 이름 ");
		sales.setCost(300000l);
//		sales.setBuydate();
		sales.setTrainer("테스트 트레이너 ");
		sales.setBuycontent("테스트 구매내용");
		sales.setPayment("테스트 결제방법");
		sales.setSno(25L);
		service.modify(sales);
		log.info(service.get(25L));
	}
	
	@Test
	public void testRemove() {
		log.info(service.get(22L));
		log.info(service.remove(22L));
		log.info(service.get(22L));
	}
	@Test
	public void testGetSum() throws ParseException{

		
		String sDate = "2021-11-01";
	    String eDate = "2021-11-30";
	    String startDate = "";
	    String endDate = "";
	    
		SimpleDateFormat beforeFormat = new SimpleDateFormat("yyyy-MM-dd");
		//Date로 변경하기 위해 날짜 형식을 yyyy-mm-dd로 변경
		SimpleDateFormat afterFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date tempDate = null;
		Date tempDate2 = null;
			    
		//yyyymmdd로된 날짜 형식으로 java.util.Date객체를 만듬
		tempDate = beforeFormat.parse(sDate);
		tempDate2 = beforeFormat.parse(eDate);
			   
		//Date를 yyyy-mm-dd 형식으로 변경하여 String으로 반환
		startDate = afterFormat.format(tempDate);
		endDate = afterFormat.format(tempDate2);

		
		
//		search.setStartdate(tempDate);
//		search.setEnddate(tempDate2);
//		log.info(service.getSum(search));
	}
	


}
