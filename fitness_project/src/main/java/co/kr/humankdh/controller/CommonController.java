package co.kr.humankdh.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;

import co.kr.humankdh.domain.Criteria;
import co.kr.humankdh.domain.MemberVo;
import co.kr.humankdh.domain.TrainerCareerVo;
import co.kr.humankdh.service.MemberService;
import co.kr.humankdh.service.PTreserveService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/common/*")
// @RequestMapping("/common/*")
public class CommonController {
	private MemberService service;
	private PTreserveService ptService;
	
	@Autowired
	BCryptPasswordEncoder passwordencoder;
	
//	@Inject
	
	@RequestMapping("index")
	public void doIndex() {
		log.info("index ...");
	}

	//트레이너 정보를 DB서버에서 가져오기
	@ResponseBody @PostMapping(value="getTrainers")
	public Map<String, List<TrainerCareerVo>> getTrainers(){
		List<MemberVo> trainers = ptService.getTrainerList();
		Map<String, List<TrainerCareerVo>> careers = new HashMap<>();
		trainers.forEach( t -> {
			careers.put( t.getUserName(), ptService.getCareers(t.getUserid())); 
		});
//		log.info(careers);
		return careers;
	}

	// 회원가입 페이지 이동
	@GetMapping("/joinUs")
	public void joinUs() {
		log.info("회원가입 페이지 이동");
	}
	
	// 회원가입
	@PostMapping("/joinUs")
	public String joinUs(MemberVo vo){
		log.info("post joinUs");
		service.register(vo);
		return "redirect:/common/login"; // 로그인 페이지로 가게하기
	}
	
	// 로그인 페이지 이동
	@GetMapping("/login")
	public void login() {
		log.info("로그인페이지");
	}
	
	// 로그인 (security 로그인 사용)
	@ResponseBody @PostMapping("/login")
	public String login(@RequestBody Map<String, Object> param, HttpServletRequest req , Model model) {
		log.info("post login");
		log.info(param);
//		Map loginInfo = map;
		
//		log.info("아이디 비밀번호 맵 : " + map);
		
		if(service.login(param.get("userid").toString(), param.get("pwd").toString()) == 1){
			log.info("로그인 성공");
			HttpSession session = req.getSession();
			session.setMaxInactiveInterval(1800); // 세션 유효시간 
			session.setAttribute("member", param.get("userid").toString());
			
			return "success";
		}
		else {
			log.info("로그인 실패");
			return "failed";
		}
	}
	
	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpServletRequest req) {
		log.info("로그아웃");
		HttpSession session = req.getSession();
		session.invalidate();
		return "redirect:/common/login";
	}
	
	// 세션
//	@ResponseBody
//	@RequestMapping(value="/login", method = RequestMethod.POST)
//	public ModelAndView afLogin(@RequestBody Map<String, Object> param , HttpServletRequest request){
//		
//		HttpSession session = request.getSession();
//		
//		int log = service.login("id", "pwd");
//		
//		session.setAttribute("", log);
//		
//		
//		return null;
//		
//	}
	
	
	// 아이디 중복체크
	@ResponseBody
	@PostMapping("/idChk")
	public int idChk(@RequestBody String id) {
		int result = service.idChk(id);
		log.info("아이디중복체크 결과:" + result);
		return result;
	}

	// 문자보내기
	@PostMapping("/sendSMS")
	@ResponseBody
	public String sendSMS(@RequestBody String phoneNumber) {

		Random rand = new Random();
		String numStr = "";
		for (int i = 0; i < 4; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			numStr += ran;
		}

//		System.out.println("수신자 번호 : " + phoneNumber);
//		System.out.println("인증번호 : " + numStr);
//		service.certifiedPhoneNumber(phoneNumber, numStr);
		log.info(numStr);
		return numStr;
	}
	
	// 에러페이지 이동
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model){
		log.info("access Denied :" + auth);
		
		model.addAttribute("msg", "access Denied");
		
	}
	
	// 아이디 / 비밀번호 찾기 페이지 1
	@GetMapping("checkIn")
	public void checkIn(){
		log.info("아이디 비밀번호 찾기 1 / 2");
	}
	
	// 아이디 / 비밀번호 찾기 페이지 2 (아이디 확인 후) 
	@GetMapping("findInfo")
	public void findInfo(){
		log.info("아이디 비밀번호 찾기 2 / 2");
	}
	
	// 회원정보 수정 페이지 이동
	@PreAuthorize("hasAnyRole('ROLE_USER, ROLE_MEMBER, ROLE_TRAINER, ROLE_ADMIN')")
	@GetMapping("memberModify")
	public void memberMod(Principal principal, Model model) {
		log.info("회원정보 수정 페이지");
		log.info(principal.getName());
		model.addAttribute("member", service.get(principal.getName()));
	}
	
	// 회원정보 수정
	@PostMapping("memberModify")
	public String modMem(MemberVo vo, Principal principal, RedirectAttributes rttr) {
		log.info("Vo ::" + vo);
		vo.setUserid(principal.getName());
		
		service.modify(vo);
		log.info("수정완료::"+ vo);
			
		
		
		return "redirect:/common/index";
		
	}
	
	// CRUD
	@GetMapping("CreateMember")
	public void CreateMember() {
		log.info("CreateMember");
	}
	
	// Create
	@PostMapping("CreateMember")
	public String CreateMember(MemberVo vo, RedirectAttributes rttr) {
		log.info("CreateMember");
		service.register(vo);
		log.info("Create ::" + vo);
		rttr.addAttribute("result ::" + vo.getUserid());
		
		return "redirect:/common/login";
		
	}
	
	// Read
	@GetMapping("ReadMember")
	public void ReadMember(@RequestParam("userid") String userid, Model model, @ModelAttribute("cri") Criteria cri){
		log.info("ReadMember");
		
		model.addAttribute("Member :" + service.get(userid));
		
	}
	
	// Update
	@PostMapping("UpdateMember")
	public String UpdateMember() {
		return "redirect:/common/login";
		
	}
	
	// Delete
	@ResponseBody
	@RequestMapping(value="DeleteMember", method = RequestMethod.POST)
	public String DelMember(String userid[], RedirectAttributes rttr){
		
		for(int i = 0 ; i < userid.length; i++){
			service.remove(userid[i]);
		}
		return "redirect:/common/index";
	}
	
	// 아이디 찾기
	
	
	// 비밀번호 찾기
	
}
