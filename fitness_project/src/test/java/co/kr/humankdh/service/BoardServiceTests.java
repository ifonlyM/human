package co.kr.humankdh.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import co.kr.humankdh.domain.BoardVo;
import co.kr.humankdh.domain.Criteria;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {
	@Setter @Autowired
	private BoardService service;
	
	@Test
	public void testExist() {
		assertNotNull(service);
	}
	
	@Test
	public void testGetList() {
		service.getList(new Criteria()).forEach(log::info);
	}
	
	@Test
	public void testRegister() {
		BoardVo board = new BoardVo();
		board.setTitle("서비스 테스트 제목");
		board.setContent("서비스 테스트 내용");
		service.register(board);
	}
	
	@Test
	public void testGet() {
		log.info(service.get(7L));
	}
	
	@Test
	public void testModify() {
		BoardVo board = new BoardVo();
		board.setTitle("서비스 수정 제목");
		board.setContent("서비스 수정 내용");
		board.setBno(11L);
		service.modify(board);
		log.info(service.get(11L));
	}
	
	@Test
	public void testRemove() {
		log.info(service.get(12L));
		log.info(service.remove(12L));
		log.info(service.get(12L));
	}
}
