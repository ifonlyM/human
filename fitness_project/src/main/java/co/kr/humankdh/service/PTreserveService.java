package co.kr.humankdh.service;

import java.util.List;

import co.kr.humankdh.domain.MemberVo;
import co.kr.humankdh.domain.ReserveVo;
import co.kr.humankdh.domain.TrainerCareerVo;

public interface PTreserveService {
	// 트레이너 목록 가져오기
	List<MemberVo> getTrainerList();
	
	// 트레이너 id로 경력목록 가져오기
	List<TrainerCareerVo> getCareers(String id);
	
	// 트레이너 id로 최근 comments 가져오기
	String getLastComments(String id);
	
	// 트레이너 경력입력
	void insertCareer(TrainerCareerVo vo);

	// 트레이너 경력 수정
	void updateCareer(TrainerCareerVo vo);

	// 트레이너 경력 삭제
	void deleteCareer(Long cno);
	
	// 트레이너 경력 모두 삭제
	void deleteAllCareer(String id);
	
	// PT예약 시간 입력
	String insertPT(ReserveVo vo);
	
	// 지정한 날의 해당 트레이너의 예약된 시간대 조회
	List<String> getTrainerReservedTimeBy(String trainerId, String reserveDate);
	
	// 지정한 달의 해당 트레이너의 예약이 있는 날짜 조회 (오늘 이후만 조회)
	List<String> getTrainerReservedDayBy(String trainerId, String year_month, String today);
	
	// 지정한 날의 해당 유저의 예약된 시간대 조회
	List<String> getUserReservedTimeBy(String userId, String reserveDate);
	
	// 지정한 달의 유저의 예약이 있는 날짜 조회 (과거까지 조회 가능)
	List<String> getUserReservedDayBy(String userId, String year_month);

	// 지정한 날, 시간의 유저 PT예약 정보 가져오기
	ReserveVo getUserReserveDetailBy(String userId, String reserveDate, String reserveTime);
	
}
