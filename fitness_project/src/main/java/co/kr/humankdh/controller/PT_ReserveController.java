package co.kr.humankdh.controller;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.eclipse.jdt.internal.compiler.ast.FalseLiteral;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	
	@RequestMapping(value="PTReserveCalendar", produces="text/plain; charset=utf-8", method={RequestMethod.GET, RequestMethod.POST})
	public void calendar(){
	}
	
	@GetMapping(value="memberPTCalendar")
	public void memberPTCalendar(String userId) {
		
	}
	
	@GetMapping(value="trainerPTCalendar")
	public void trinaerPTCalendar() {
		
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
	/*@PostMapping("getTrainerReservedTimeBy")
	@ResponseBody
	public List<String> getTrainerReservedTimeBy(@RequestBody ReserveVo vo){
		log.info(vo);
		return service.getTrainerReservedTimeBy(vo.getTrainerId(), vo.getReserveDate());
	}*/
	
	/**
	 * 지정한 달의 트레이너 한명의 일별 예약 리스트를  가져옴
	 * @param data keys [트레이너 ID, 년-월, 오늘날짜 데이터(null일 경우 과거도 조회가능)]
	 * @return Map<key=예약일, value=예약일에 해당하는 예약시간대 리스트>
	 */
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
	
	@PostMapping("getTrainerReservedTimeBy")
	@ResponseBody
	public List<String> getTrainerReservedTimeBy(@RequestBody Map<String, String> data){
		if(data == null) return null;
		String trainerId = data.get("trainerId");
		String reserveDate = data.get("reserveDate");
		return service.getTrainerReservedTimeBy(trainerId, reserveDate);
	}
	
	@PostMapping("getTrainerReserveDetailBy")
	@ResponseBody
	public ReserveVo getTrainerReserveDetailBy(@RequestBody Map<String, String> data){
		if(data == null) return null;
		return service.getTrainerReserveDetailBy(
				data.get("trainerId"),
				data.get("reserveDate"),
				data.get("reserveTime")
				);
	}
	
	/**
	 * 지정한 달의 유저 한명의 일별 예약 리스트를 가져옴
	 * @param data keys[사용자ID, 년-월]
	 * @return Map<key=예약일, value=예약일에 해당하는 예약시간대 리스트>
	 */
	@PostMapping("getUserReservedListByDay")
	@ResponseBody
	public Map<String, List<String>> getUserReservedListByDay(@RequestBody Map<String, String> data) {
		if(data == null) return null;
		
		String userId = data.get("userId");
		String year_month = data.get("year_month");
		
		log.info("트레이너 id : "+ userId);
		log.info("년-월 : " + year_month);
		
		// 링크드 해쉬맵으로 반환 할것 (DB에서 의도한 순서대로 자료가 반환되면 좋을거 같다)
		Map<String, List<String>> dayListMap = new LinkedHashMap<>();
		List<String> dayList = service.getUserReservedDayBy(userId, year_month);
		dayList.forEach(day -> {
			dayListMap.put(
					day, 
					service.getUserReservedTimeBy(
							userId, 
							year_month+"-"+day
						)
				);
		});
		
		log.info("dayListMap : " + dayListMap);
		
		return dayListMap;
	}
	
	@PostMapping("getUserReservedTimeBy")
	@ResponseBody
	public List<String> getUserReservedTimeBy(@RequestBody Map<String, String> data) {
		if(data == null) return null;
		String userId = data.get("userId");
		String reserveDate = data.get("reserveDate");
		
		return service.getUserReservedTimeBy(userId, reserveDate);
	}
	
	@PostMapping("getUserReserveDetailBy")
	@ResponseBody
	public ReserveVo getUserReserveDetailBy(@RequestBody Map<String, String> data) {
		if(data == null) return null;
		String userId = data.get("userId");
		String reserveDate = data.get("reserveDate");
		String reserveTime = data.get("reserveTime");
		return service.getUserReserveDetailBy(userId, reserveDate, reserveTime);
	}
	
	@PostMapping(value="reserveCancle")
	@ResponseBody
	public Map<String, String> reserveCancle(@RequestBody ReserveVo vo){
		// 현재 날짜,시간
		LocalDateTime currDateTime = LocalDateTime.now(); 
		currDateTime = LocalDateTime.of(
				currDateTime.getYear(), 
				currDateTime.getMonthValue(),
				currDateTime.getDayOfMonth(),
				currDateTime.getHour(),
				0); // 현재시간을 00분으로 고정
		
		// view에서 받아온 예약날짜, 시간
		String date[] = vo.getReserveDate().split("-"); // year, month, day
		String time = vo.getStartTime().split(":")[0]; // hour
		
		// 예약 날짜,시간
		LocalDateTime reserveDateTime = 
				LocalDateTime.of(
				Integer.valueOf(date[0]),
				Integer.valueOf(date[1]),
				Integer.valueOf(date[2]),
				Integer.valueOf(time),
				0); 
		Duration duration = Duration.between(currDateTime, reserveDateTime);
		
		Map<String, String> resultMap = new HashMap<>();
		String resultMsg  = date[0]+"년 "+date[1]+"월 "+date[2]+"일\n";
		
		// 과거 예약 데이터는 취소 불가능
		if(duration.toHours() <= 0){
			resultMsg += "예약은 과거 예약으로 취소가 불가능 합니다.";
			resultMap.put("false", resultMsg);
			return resultMap;
		}
		// 미래의 예약만 취소가능
		else {
			service.reserveCancle(vo.getRno());
			resultMsg += vo.getStartTime()+"시 예약을 취소했습니다.";
			resultMap.put("true", resultMsg);
			return resultMap;
		}
	}

}
