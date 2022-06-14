package co.kr.humankdh.mapper;






import java.util.List;
import java.util.Map;

import co.kr.humankdh.domain.Criteria;
import co.kr.humankdh.domain.SalesVo;


public interface SalesMapper {

	public List<SalesVo> getList();
	public List<SalesVo> getListWithPaging(Criteria cri);
	int getTotalCount(Criteria cri);
	
	void insert(SalesVo sales);
	void insertSelectKey(SalesVo sales);
	SalesVo read(Long sno);
	int delete(Long sno);
	int update(SalesVo salesVo);
	List<Map<String, Object>> getSalesListby(String year);
	

}
