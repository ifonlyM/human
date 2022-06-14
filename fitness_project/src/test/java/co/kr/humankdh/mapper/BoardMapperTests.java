package co.kr.humankdh.mapper;

import java.util.List;

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
public class BoardMapperTests {
	@Setter @Autowired
	private BoardMapper mapper;
	
	@Test
	public void testGetList() {
		mapper.getList().forEach(log::info);
	}
	
	@Test
	public void testInsert() {
		BoardVo board = new BoardVo();
		board.setTitle("새로 작성하는 테스트 제목");
		board.setContent("새로 작성하는 테스트 내용");
		
		mapper.insert(board);
		log.info(board);
	}
	@Test
	public void testInsertSelectKey() {
		BoardVo board = new BoardVo();
		board.setTitle("테스트 제목 - 셀렉트 키");
		board.setContent("테스트 내용 - 셀렉트 키");
		log.info("before :: " + board);
		mapper.insertSelectKey(board);
		log.info("after :: " + board);
		
	}
	
	
	@Test
	public void testRead() {
		BoardVo board = mapper.read(11L);
		log.info(board);
		
	}
	
	@Test
	public void testUpdate() {
		BoardVo board = new BoardVo();
		board.setTitle("수정된 영속 테스트 제목");
		board.setContent("수정된 영속 테스트 내용");
		board.setBno(8L);
		log.info(mapper.update(board));
		log.info(mapper.read(8L));
	}
	
	@Test
	public void testDelete() {
		log.info(mapper.read(9L));
		log.info(mapper.delete(9L));
		log.info(mapper.read(9L));
	}
	@Test
	public void testPaging() {
		Criteria cri = new Criteria();
		cri.setPageNum(3);
		cri.setAmount(10);
		List<BoardVo> list = mapper.getListWithPaging(cri);
		list.forEach(System.out::println);
	}
	@Test
	public void testGetTotalCount() {
		Criteria cri = new Criteria();
		cri.setType("TC");
		cri.setKeyword("dd");
		log.info(mapper.getTotalCount(cri));
	}
}
