package co.kr.humankdh.service;

import java.util.List;

import co.kr.humankdh.domain.ReplyCriteria;
import co.kr.humankdh.domain.ReplyVo;

public interface ReplyService {
	void register(ReplyVo vo);
	ReplyVo get(Long rno);
	boolean modify(ReplyVo vo);
	boolean remove(Long rno);
	List<ReplyVo> getList(ReplyCriteria cri, Long bno);
}
