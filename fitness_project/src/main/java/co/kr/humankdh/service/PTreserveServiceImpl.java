package co.kr.humankdh.service;

import java.util.List;

import org.springframework.stereotype.Service;

import co.kr.humankdh.domain.MemberVo;
import co.kr.humankdh.domain.ReserveVo;
import co.kr.humankdh.domain.TrainerCareerVo;
import co.kr.humankdh.mapper.PTreserveMapper;
import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class PTreserveServiceImpl implements PTreserveService{
	private PTreserveMapper mapper;

	@Override
	public List<MemberVo> getTrainerList() {
		return mapper.getTrainerList();
	}

	@Override
	public void insertCareer(TrainerCareerVo vo) {
		mapper.insertCareer(vo);
	}
	
	@Override
	public String getLastComments(String id) {
		return mapper.readComments(id);
	}

	@Override
	public List<TrainerCareerVo> getCareers(String id) {
		return mapper.getCareers(id);
	}

	@Override
	public void updateCareer(TrainerCareerVo vo) {
		mapper.updateCareer(vo);
	}

	@Override
	public void deleteCareer(Long cno) {
		mapper.deleteCareer(cno);
	}

	@Override
	public void deleteAllCareer(String id) {
		mapper.deleteAllCareer(id);
	}

	@Override
	public String insertPT(ReserveVo vo) {
		if(mapper.trainerHasReserveByTime(vo)){
			return "***예약실패***\n다른 회원이 이미 예약한 시간입니다.\n다른 시간을 이용해주세요.";
		}
		/*else if(mapper.memberHasReserveByDay(vo)){
			return "***예약실패***\n같은날 예약된 PT일정이 존재합니다.\n기존 일정을 취소하거나 다른 날을 이용해주세요. ";
		}*/
		else {
			mapper.insertPT(vo);
			return "예약을 완료했습니다.";
		}
	}

	@Override
	public List<String> getTrainerReservedTimeBy(String trainerId, String reserveDate) {
		return mapper.selectTrainerReservedTimeBy(trainerId, reserveDate);
	}

	@Override
	public List<String> getTrainerReservedDayBy(String trainerId, String year_month, String today) {
		if(today == null){
			return mapper.selectTrainerReservedAllDayBy(trainerId, year_month);
		}
		else {
			return mapper.selectTrainerReservedDayBy(trainerId, year_month, today);
		}
	}

	@Override
	public List<String> getUserReservedDayBy(String userId, String year_month) {
		return mapper.selectUserReservedDayBy(userId, year_month);
	}

	@Override
	public List<String> getUserReservedTimeBy(String userId, String reserveDate) {
		return mapper.selectUserReservedTimeBy(userId, reserveDate);
	}

	@Override
	public ReserveVo getUserReserveDetailBy(String userId, String reserveDate, String reserveTime) {
		return mapper.selectUserReserveDetailBy(userId, reserveDate, reserveTime);
	}

	@Override
	public void reserveCancle(Long rno) {
		mapper.deleteReserveBy(rno);
	}

	@Override
	public ReserveVo getTrainerReserveDetailBy(String trainerId, String reserveDate, String reserveTime) {
		return mapper.selectTrainerReserveDetailBy(trainerId, reserveDate, reserveTime);
	}
	
}
