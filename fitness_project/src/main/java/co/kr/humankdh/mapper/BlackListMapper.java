package co.kr.humankdh.mapper;






import java.util.List;


import co.kr.humankdh.domain.BlackListVo;
import co.kr.humankdh.domain.Criteria;




public interface BlackListMapper {

	public List<BlackListVo> getList();
	public List<BlackListVo> getListWithPaging(Criteria cri);
	int getTotalCount(Criteria cri);
	
	void insert(BlackListVo blacklist);
	void insertSelectKey(BlackListVo blacklist);
	
	int delete(Long blackno);
	

	

}
