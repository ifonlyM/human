package co.kr.humankdh.mapper;

import java.util.List;

import co.kr.humankdh.domain.AttachVo;

public interface AttachMapper {
	void insert(AttachVo vo);
	void delete(String uuid);
	List<AttachVo> findByBno(Long bno);
	AttachVo findBy(String uuid);
	void deleteAll(long bno);
	
	List<AttachVo> getOldFiles();
}
