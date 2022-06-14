package co.kr.humankdh.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import co.kr.humankdh.domain.Criteria;
import co.kr.humankdh.domain.SalesVo;
import co.kr.humankdh.mapper.SalesMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service @Log4j
@AllArgsConstructor
public class SalesServiceImpl implements SalesService {
	private SalesMapper salesMapper;

	@Override
	public void register(SalesVo salesVo) {
		
		salesMapper.insertSelectKey(salesVo);
	}

	@Override
	public SalesVo get(Long sno) {
		// TODO Auto-generated method stub
		return salesMapper.read(sno);
	}

	@Override
	public boolean modify(SalesVo salesVo) {
		boolean result = salesMapper.update(salesVo)>0;
		
		return result;
	}

	@Override
	public boolean remove(Long sno) {
		
		return  salesMapper.delete(sno)>0;
	}

	@Override
	public List<SalesVo> getList(Criteria cri) {
		return salesMapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return salesMapper.getTotalCount(cri);
	}

	@Override
	public List<Map<String, Object>> getSalesListBy(String year) {
		// TODO Auto-generated method stub
		return salesMapper.getSalesListby(year);
	}


	
	
	
	
	

}
