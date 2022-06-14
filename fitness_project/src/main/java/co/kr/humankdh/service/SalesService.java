package co.kr.humankdh.service;


import java.util.List;
import java.util.Map;

import co.kr.humankdh.domain.Criteria;
import co.kr.humankdh.domain.SalesVo;


public interface SalesService {
	void register(SalesVo salesVo);
	SalesVo get(Long sno);
	boolean modify(SalesVo salesVo);
	boolean remove(Long sno);
	List<SalesVo> getList(Criteria cri);
	int getTotal(Criteria criteria);
	List<Map<String, Object>> getSalesListBy(String year);


}
