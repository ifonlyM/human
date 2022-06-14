package co.kr.humankdh.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import co.kr.humankdh.domain.ReplyCriteria;
import co.kr.humankdh.domain.ReplyVo;
import co.kr.humankdh.mapper.BoardMapper;
import co.kr.humankdh.mapper.ReplyMapper;
import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {
	private ReplyMapper mapper;
	private BoardMapper boardMapper;
	
	
	@Override
	@Transactional
	public void register(ReplyVo vo) {
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		mapper.insert(vo);
		
	}

	@Override
	public ReplyVo get(Long rno) {
		// TODO Auto-generated method stub
		return mapper.read(rno);
	}

	@Override
	public boolean modify(ReplyVo vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo) > 0;
	}

	@Override
	@Transactional
	public boolean remove(Long rno) {
		// TODO Auto-generated method stub
		boardMapper.updateReplyCnt(get(rno).getBno(), -1);
		return mapper.delete(rno) > 0;
	}

	@Override
	public List<ReplyVo> getList(ReplyCriteria cri, Long bno) {
		// TODO Auto-generated method stub
		return mapper.getList(bno, cri);
	}

}
