package co.kr.humankdh.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import co.kr.humankdh.domain.ReplyCriteria;
import co.kr.humankdh.domain.ReplyVo;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyServiceTests {
	@Setter @Autowired
	private ReplyService service;
	
	@Test
	public void testExist() {
		assertNotNull(service);
	}

	@Test
	public void testregister() {
		ReplyVo vo = new ReplyVo();
		vo.setReply("서비스 테스트 댓글");
		vo.setReplyer("서비스 댓글 테스터");
		vo.setBno(941L);
		service.register(vo);
		
	}
	
	@Test
	public void testGet() {
		log.info(service.get(6L)); 
	}
	
	@Test
	public void testModify() {
		ReplyVo vo = new ReplyVo();
		vo.setReply("서비스 테스트 댓글 수정");
		vo.setReplyer("서비스 댓글 테스터 수정");
		vo.setRno(211L);
		service.modify(vo);
		log.info(service.get(211L));
	}
	
	@Test
	public void testRemove() {
		log.info(service.get(244L));
		log.info(service.remove(244L));
		log.info(service.get(244L));
	}
	
	@Test
	public void testGetList() {
		service.getList(new ReplyCriteria(), 941L).forEach(log::info);
	}
}
