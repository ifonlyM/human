package co.kr.humankdh.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.kr.humankdh.domain.ReplyCriteria;
import co.kr.humankdh.domain.ReplyVo;

public interface ReplyMapper {
	int insert(ReplyVo vo);
	ReplyVo read(Long rno);
	int update(ReplyVo vo);
	int delete(Long rno);
	List<ReplyVo> getList(@Param("bno") Long bno, @Param("cri") ReplyCriteria cri);
}
