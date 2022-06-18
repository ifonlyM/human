package co.kr.humankdh.mapper;

import java.util.List;

import co.kr.humankdh.domain.MemberVo;
import co.kr.humankdh.domain.ReserveVo;
import co.kr.humankdh.domain.TrainerCareerVo;

public interface PTreserveMapper {
	// db의 트레이너 목록 가져오기
	List<MemberVo> getTrainerList();
	
	// 트레이너 id로  트레이너의 최근 comments가져오기
	String readComments(String id);
	
	// 트레이너의 경력사항 DB에 입력
	void insertCareer(TrainerCareerVo vo);
	
	// 트레이너의 id로 경력리스트 가져오기
	List<TrainerCareerVo> getCareers(String id);

	// 트레이너 경력 업데이트
	void updateCareer(TrainerCareerVo vo);

	// 트레이너 경력 삭제
	void deleteCareer(Long cno);

	// 트레이너 경력 모두 삭제
	void deleteAllCareer(String id);
	
	// 트레이너 pt 예약
	void insertPT(ReserveVo vo);
	
	// 이미 예약된 시간인지 조회(트레이너 id, 예약 날짜, 예약 시간)
	boolean hasReserve(ReserveVo vo);
}
