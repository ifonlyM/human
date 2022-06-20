package co.kr.humankdh.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	@GetMapping(value="calendar")
	public void calendar() {
		log.info("calendar");
	}
	
	@PostMapping(value="calendar", produces="text/plain; charset=utf-8")
	public String calendar(String trainerName, String trainerId){
		if(trainerName == null || trainerId == null ){
			log.info("trainer data null");
			return "redirect:/common/login";
		}
		else {
			log.info(trainerId);
			log.info(trainerName);
			return null;
		}
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
	
	@PostMapping(value="reservePT", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String reservePT(@RequestBody ReserveVo vo){
		log.info(vo);
		if(service.insertPT(vo)){
			return "예약을 완료했습니다.";
		}
		else {
			return "다른사용자가 먼저 예약한 시간입니다.\n죄송하지만 다른 시간을 이용해주세요.";
		}
	}

}
