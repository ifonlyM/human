package co.kr.humankdh.service;

import java.util.List;


import org.springframework.stereotype.Service;

import co.kr.humankdh.domain.BlackListVo;
import co.kr.humankdh.domain.Criteria;
import co.kr.humankdh.domain.SalesVo;
import co.kr.humankdh.mapper.BlackListMapper;
import co.kr.humankdh.mapper.SalesMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service @Log4j
@AllArgsConstructor
public class BlackListServiceImpl implements BlackListService {
	private BlackListMapper blackListMapper;

	
	@Override
	public List<BlackListVo> getList(Criteria cri) {
		return blackListMapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return blackListMapper.getTotalCount(cri);
	}

	@Override
	public void register(BlackListVo blackListVo) {
		blackListMapper.insertSelectKey(blackListVo);
		
	}

	@Override
	public boolean remove(Long blackno) {
		// TODO Auto-generated method stub
		return blackListMapper.delete(blackno)>0;
	}


	
	
	
	
	

}
