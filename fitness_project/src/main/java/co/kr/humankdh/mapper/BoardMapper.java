package co.kr.humankdh.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import co.kr.humankdh.domain.BoardVo;
import co.kr.humankdh.domain.Criteria;

public interface BoardMapper {
//	@Select("select * from FITNESS_BOARD where bno > 0")
	public List<BoardVo> getList();
	public List<BoardVo> getListWithPaging(Criteria cri);
	public List<BoardVo> getListWithPagingAd(Criteria cri);
	void insert(BoardVo board);
	void insertSelectKey(BoardVo board);
	BoardVo read(Long bno);
	int delete(Long bno);
	int update(BoardVo boardVo);
	int getTotalCount(Criteria cri);
	void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount); 
}
