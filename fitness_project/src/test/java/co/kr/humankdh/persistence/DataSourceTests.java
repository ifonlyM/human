package co.kr.humankdh.persistence;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class DataSourceTests {
	
	@Autowired @Setter
	private DataSource dataSource;
	@Autowired @Setter
	private SqlSessionFactory sqlSessionFactory;
	
	
	@Test
	public void testExist() {
		assertNotNull(dataSource);
		log.info(dataSource);
	}
	
	@Test
	public void testConnection() {
		try (Connection conn = dataSource.getConnection()){
			log.info(conn);
		} catch (SQLException e) {
			log.error(e);
			fail(e.getMessage());
		}
	}
	
	@Test
	public void testMybatis() {
		SqlSession session = sqlSessionFactory.openSession();
		Connection conn = session.getConnection();
		log.info(conn);
	}
}
