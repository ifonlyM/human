package co.kr.humankdh.mapper;

import java.util.stream.IntStream;

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
public class ReplyMapperTests {
	@Setter @Autowired
	private ReplyMapper mapper;
	
	@Test
	public void testMapper() {
		log.info(mapper);
	}
	
	@Test
	public void testInsert() {
		IntStream.range(0, 5).forEach(i-> {
			ReplyVo vo = new ReplyVo();
			vo.setBno(940L);
		    vo.setReply("댓글 테스트" + i);
		    vo.setReplyer("댓글러" + i);
		    mapper.insert(vo);
		});		
	}
	
	@Test
	public void testRead() {
		log.info(mapper.read(1L));
	}
	
	@Test
	public void testUpdate() {
		ReplyVo reply = new ReplyVo();
		reply.setReply("수정된 댓글");
		reply.setReplyer("수정된 사람");
		reply.setRno(2L);
		mapper.update(reply);
		log.info(mapper.read(2L));
	}
	
	@Test
	public void testRemove() {
		log.info(mapper.delete(3L));
		log.info(mapper.read(3L));
	}
	
	@Test
	public void testGetList() {
		ReplyCriteria criteria = new ReplyCriteria();
//		criteria.setLastRno(64L);
		mapper.getList(940L, criteria).forEach(log::info);
	}
}
