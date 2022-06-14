package co.kr.humankdh.service;

import java.util.List;

import co.kr.humankdh.domain.AttachVo;
import co.kr.humankdh.domain.BoardVo;
import co.kr.humankdh.domain.Criteria;

public interface BoardService {
	void register(BoardVo boardVo);
	BoardVo get(Long bno);
	boolean modify(BoardVo boardVo);
	boolean remove(Long bno);
	List<BoardVo> getList(Criteria cri);
	List<BoardVo> getListAd(Criteria cri);
	int getTotal(Criteria criteria);
	List<AttachVo> getAttachs(Long bno);
}
