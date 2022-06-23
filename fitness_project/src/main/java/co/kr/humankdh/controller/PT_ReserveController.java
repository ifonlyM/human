package co.kr.humankdh.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.kr.humankdh.domain.MemberVo;
import co.kr.humankdh.domain.ReserveVo;
import co.kr.humankdh.domain.TrainerCareerVo;
import co.kr.humankdh.service.PTreserveService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller @Log4j
@RequestMapping("/PTreserve/*")
@AllArgsConstructor  //생성자를 이용해서 autowired자동 주입
public class PT_ReserveController {
	private PTreserveService service;
	
	/*@GetMapping(value="calendar")
	public void calendar() {
		log.info("calendar");
	}*/
	
	@RequestMapping(value="calendar", produces="text/plain; charset=utf-8", method={RequestMethod.GET, RequestMethod.POST})
	public void calendar(){
	}
	
	@GetMapping(value="myCalendar")
	public void myCalendar(String userId) {
		
	}
	
	@GetMapping("trainers")
	public void trainers() {
		log.info("trainers");
	}
	
	
	@PostMapping(value="getTrainers")
	@ResponseBody 
	public Map<String, List<TrainerCareerVo>> getTrainers(){
		List<MemberVo> trainers = service.getTrainerList();
		Map<String, List<TrainerCareerVo>> careers = new HashMap<>(); 	// 트레이너, 커리어리스트
		ObjectMapper mapper = new ObjectMapper();
		
		trainers.forEach( t -> {
			MemberVo trainer = new MemberVo();
			trainer.setUserid(t.getUserid());
			trainer.setUserName(t.getUserName());
			
			String jsonObj = "";
			try {
				jsonObj = mapper.writeValueAsString(trainer);
			} catch (JsonProcessingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			careers.put( jsonObj, service.getCareers(t.getUserid()) );
		});
		
		return careers;
	}
	
	@GetMapping("careerWrite")
	public void careerWrite(Model model) {
		log.info("careerWrite");
		model.addAttribute("list", service.getTrainerList());
	}
	
	@PostMapping("careerWrite")
	@ResponseBody 
	public String careerWrite(@RequestBody List<TrainerCareerVo> list) {
		if(!list.isEmpty()){
			list.forEach(service::insertCareer);
			// 저장완료후 페이지에서 저장한 트레이너가 선택되어 있을것.(작성후 확인차원에서)
			return list.get(0).getTrainerId();
		}
		return "default";
	}
	
	@PostMapping("getCareers")
	@ResponseBody 
	public List<TrainerCareerVo> getCareers(@RequestBody String id) {
		log.info(id);
		return service.getCareers(id);
	}
	
	// 한글이 깨지는 현상 때문에 produces를 설정, 데이터를 보낼때 인코딩해서 보내야함
	@PostMapping(value="getComments", produces="text/plain; charset=utf-8")
	@ResponseBody 
	public String getComments(@RequestBody String id) {
		return service.getLastComments(id);
	}
	
	@PostMapping(value="updateCareer", produces="text/plain; charset=utf-8")
	@ResponseBody 
	public String updateCareer(@RequestBody TrainerCareerVo vo){
		log.info(vo);
		service.updateCareer(vo);
		return "수정되었습니다";
	}
	
	@PostMapping(value="deleteCareer", produces="text/plain; charset=utf-8")
	@ResponseBody 
	public String deleteCareer(@RequestBody Long cno){
		log.info(cno);
		service.deleteCareer(cno);
		return "삭제되었습니다";
	}
	
	@PostMapping(value="deleteAllCareer", produces="text/plain; charset=utf-8")
	@ResponseBody 
	public String deleteAllCareer(@RequestBody String id){
		log.info(id);
		List<TrainerCareerVo> list = service.getCareers(id);
		if(list == null || list.isEmpty()) {
			return "삭제할 데이터가 없습니다!";
		}
		else {
			service.deleteAllCareer(id);
			return "모두 삭제되었습니다";
		}
	}
	
	/**
	 * pt예약하기
	 * @param vo
	 * @return 상황에 맞는 예약 성공여부 String
	 */
	@PostMapping(value="reservePT", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String reservePT(@RequestBody ReserveVo vo){
		log.info(vo);
		return service.insertPT(vo);
	}
	
	/**
	 * 지정된 날짜에 트레이너의 예약정보 가져오기
	 * @param vo
	 * @return 지정된 날짜의 트레이너 예약 시간 list
	 */
	@PostMapping("getTrainerReservedTime")
	@ResponseBody
	public List<String> getTrainerReservedTime(@RequestBody ReserveVo vo){
		log.info(vo);
		return service.getTrainerReservedTimeBy(vo.getTrainerId(), vo.getReserveDate());
	}
	
	@PostMapping("getTrainerReservedListByDay")
	@ResponseBody
	public Map<String, List<String>> getTrainerReservedListByDay(@RequestBody Map<String, String> data){
		if(data == null) return null;
		
		String trainerId = data.get("trainerId");
		String year_month = data.get("year_month");
		String today = data.get("today");
		
		log.info("트레이너 id : "+ trainerId);
		log.info("년-월 : " + year_month);
		log.info("오늘  : " + today);
		
		// 링크드 해쉬맵으로 반환 할것 (DB에서 의도한 순서대로 자료가 반환되면 좋을거 같다)
		Map<String, List<String>> dayListMap = new LinkedHashMap<>();
		List<String> dayList = service.getTrainerReservedDayBy(trainerId, year_month, today);
		dayList.forEach(day -> {
			dayListMap.put(
					day, 
					service.getTrainerReservedTimeBy(
							trainerId, 
							year_month+"-"+day
						)
				);
		});
		
		log.info("dayListMap : " + dayListMap);
		
		return dayListMap;
	}

}
