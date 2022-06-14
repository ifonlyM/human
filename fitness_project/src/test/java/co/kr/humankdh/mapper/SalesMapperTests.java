package co.kr.humankdh.mapper;

import static org.junit.Assert.assertNotNull;

import java.util.Date;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import co.kr.humankdh.domain.SalesVo;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class SalesMapperTests {
	@Setter @Autowired
	private SalesMapper mapper;
	
	  @Test
	   public void testExist() {
	      assertNotNull(mapper);
	      log.info(mapper);
	   }

	
	@Test
	public void testInsert() {
		SalesVo sales = new SalesVo();
		sales.setId("테스트 아이디");
		
		mapper.insert(sales);
		log.info(sales);
	}
	
	   @Test
	   public void testGetSalesList() {
	      mapper.getSalesListby("2021").forEach(log::info);
	     
	      
	   }

	
	@Test
	public void testInsertSelectKey() {
		SalesVo sales = new SalesVo();
		sales.setId("테스트 아이디 - 셀렉트 키");
		sales.setName("테스트 이름 - 셀렉트 키");
		sales.setCost(300000l);
//		sales.setBuydate("2021-05-10"); 파라미터 값? 
		sales.setTrainer("테스트 트레이너 -셀렉트 키");
		sales.setBuycontent("테스트 구매내용 -셀렉트 키");
		sales.setPayment("테스트 결제방법 -셀렉트키");
		
		log.info("before :: " + sales);
		mapper.insertSelectKey(sales);
		log.info("after :: " + sales);
		
	}
	@Test
	public void testRead() {
		SalesVo sales = mapper.read(22L);
		log.info(sales);
		
	}
	
	@Test
	public void testUpdate() {
		SalesVo sales = new SalesVo();
		sales.setCost(150000L);
		sales.setPayment("현금");
		sales.setName("김상민");
		sales.setSno(22L);
		log.info(mapper.update(sales));
		log.info(mapper.read(22L));
	}
	
	@Test
	public void testDelete() {
		log.info(mapper.read(22L));
		log.info(mapper.delete(22L));
		log.info(mapper.read(22L));
	}
	@Test
	public  void testSearch(){
//		
//		search.setStartdate("2021-11-01");
//		search.setEnddate("2021-11-30");
		
//		log.info(mapper.search(search));
	}
	
	
	

}
