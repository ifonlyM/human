package co.kr.humankdh.mapper;

import org.junit.Test; 
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import co.kr.humankdh.domain.MemberVo;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MemberMapperTests {
	@Autowired @Setter
	private MemberMapper memberMapper;
	
	@Test
	public void testRead() {
		MemberVo vo = memberMapper.read("JAVAMAN");
		log.info(vo);
		vo.getAuths().forEach(log::info);
	}
	
	@Test
	public void testLogin() {
		memberMapper.memberLogin("USER01", "1234");
	}
	
	
}
