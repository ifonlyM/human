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
	public boolean insertPT(ReserveVo vo) {
		if(!mapper.hasReserve(vo)){
			mapper.insertPT(vo);
			return true;
		}
		else {
			return false;
		}
	}

	@Override
	public List<String> getTrainerReservedTimeBy(String trainerId, String reserveDate) {
		return mapper.selectTrainerReservedTimeBy(trainerId, reserveDate);
	}
	
}
