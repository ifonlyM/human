package co.kr.humankdh.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mchange.v2.cfg.PropertiesConfigSource.Parse;

import co.kr.humankdh.domain.AttachVo;
import co.kr.humankdh.domain.BlackListVo;
import co.kr.humankdh.domain.Criteria;
import co.kr.humankdh.domain.MemberVo;
import co.kr.humankdh.domain.PageDTO;
import co.kr.humankdh.domain.ReplyCriteria;
import co.kr.humankdh.domain.ReplyVo;
import co.kr.humankdh.domain.SalesVo;
import co.kr.humankdh.service.BlackListService;
import co.kr.humankdh.service.BoardService;
import co.kr.humankdh.service.MemberService;
import co.kr.humankdh.service.ReplyService;
import co.kr.humankdh.service.SalesService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import oracle.jdbc.proxy.annotation.Post;


@Controller 
@Log4j
@RequestMapping("/AdminServe/*")
@AllArgsConstructor 
public class AdminServeController {
	private SalesService service;
	private BlackListService blackservice ;
	private MemberService memberservice;
	private BoardService boardservice;
	private UploadController uploadController;
	private ReplyService replyService;
	private ReplyController replyController;
	
	
	
	
	@ResponseBody
    @RequestMapping(value="boardDelete", method=RequestMethod.POST)
	public String boardremove(long bno[], RedirectAttributes rttr ,ReplyCriteria rcri) {
		
		for(int i = 0 ; i < bno.length;i++){
			List<AttachVo> list = boardservice.getAttachs(bno[i]);
			List<ReplyVo> replyList = replyService.getList(rcri, bno[i]);
			replyList.forEach(r -> replyController.remove(r.getRno()));
			log.info(replyList);
			
			if(boardservice.remove(bno[i])) {
				if (list != null) {
					list.forEach(vo-> {
						uploadController.deleteFile(vo.getFullPath(), vo.isImage());
					});
				}
				rttr.addFlashAttribute("result", "success");	
				
			}
			
		}

		return "redirect:/AdminServe/boardList";

	}

	

	


	@GetMapping("boardList")
	public void list(Model model, Criteria cri) {
		log.info("board.list");
		model.addAttribute("list", boardservice.getListAd(cri));
		model.addAttribute("page", new PageDTO(boardservice.getTotal(cri), cri));
	}
	
	
	//==============================회원============================	
	@GetMapping("memberDetail")
	public void get(@RequestParam("userid") String userid, Model model,@ModelAttribute("cri") Criteria cri) {
		log.info("memberGet");
	
	    model.addAttribute("member", memberservice.get(userid));
	}
	
	
	
	@GetMapping("memberInquiry")
	public void memberList(Model model,Criteria cri) {
		log.info("memberList");
		
		
	
		
		model.addAttribute("list",memberservice.getList(cri));
		
		
	
		model.addAttribute("page",new PageDTO(memberservice.getTotal(cri),cri));

	}
	

    @ResponseBody
    @RequestMapping(value="memberDelete", method=RequestMethod.POST)
	public String memberremove(String userid[], RedirectAttributes rttr) {
		
		for(int i = 0 ; i < userid.length;i++){
			memberservice.remove(userid[i]);
		
			
		}

		return "redirect:/AdminServe/memberInquiry";

	}
    
    @PostMapping("memberDetail")
	   public String modify(MemberVo memberVo, RedirectAttributes rttr, Criteria cri) {
	      log.info("modify :: " + memberVo);
	      log.info(memberVo.getGender());
	      log.info(memberVo.getRating());
	      log.info(memberVo.getAuths());
	      if(memberVo.getRating().equals("1")){
	    	  memberVo.setAuth("ROLE_USER");
	      }else if (memberVo.getRating().equals("2")) {
	    	  memberVo.setAuth("ROLE_MEMBER");
	      }else if (memberVo.getRating().equals("3")) {
	    	  memberVo.setAuth("ROLE_TRAINER");
	      }else if (memberVo.getRating().equals("4")) {
	    	  memberVo.setAuth("ROLE_ADMIN");
	      }else {
	    	  memberVo.setAuth("ROLE_USER");
	      }
	   
	      
	      
	      memberservice.modify(memberVo);
	      
	      
//	      rttr.addAttribute(cri.getParams());
	      rttr.addAttribute("pageNum", cri.getPageNum());
	      rttr.addAttribute("amount", cri.getAmount());
	      rttr.addAttribute("type", cri.getType());
	      rttr.addAttribute("keyword", cri.getKeyword());
	      return "redirect:/AdminServe/memberInquiry";
	   }
    
    @GetMapping("memberRegister")
	public void memberRegister() {
		log.info("memberRegister");
		
		
	}
    
    
    
	@PostMapping("memberRegister")
	public String memberRegister(MemberVo member, RedirectAttributes rttr) {
		log.info("memberRegister");
		
	      if(member.getRating().equals("1")){
	    	  member.setAuth("ROLE_USER");
	      }else if (member.getRating().equals("2")) {
	    	  member.setAuth("ROLE_MEMBER");
		}else if (member.getRating().equals("3")) {
			 member.setAuth("ROLE_TRAINER");
		}else if (member.getRating().equals("4")) {
			 member.setAuth("ROLE_ADMIN");
		}else {
			member.setAuth("ROLE_USER");
		}
		
	     System.out.println(member);
	     
		memberservice.registerAdmin(member);
		
		log.info("register:: " + member);
		rttr.addAttribute("result :: " + member.getUserid());
		
		return "redirect:/AdminServe/memberInquiry";
		
	}
	
//==============================블랙리스트============================
	
	@GetMapping("blackList")
	public void blackList(Model model,Criteria cri) {
		log.info("blackList");
		
		log.info("blackList.list");
		model.addAttribute("list",blackservice.getList(cri));
		model.addAttribute("page",new PageDTO(blackservice.getTotal(cri),cri));
		
	}
	
	
    @RequestMapping(value="blacklistregister", method=RequestMethod.POST)
	public String blacklistRegister(@RequestBody BlackListVo blackListVo, RedirectAttributes rttr) {
    	
    int term = blackListVo.getTerm();
    		
    	LocalDate now = LocalDate.now();

    	log.info(now);
    	
    	LocalDate end = now.plusDays(term);
    	log.info(end);
    	
		blackListVo.setStart_date(now);
		blackListVo.setEnd_date(end);
		log.info(blackListVo);
		
		blackservice.register(blackListVo);
		log.info("register:: " + blackListVo);
//		rttr.addAttribute("result :: " + blackListVo.getBlackno());
		
			
		

		return "redirect:/AdminServe/blackList";

	}
    
    @ResponseBody
    @RequestMapping(value="blackDelete", method=RequestMethod.POST)
	public String blackremove(long blackno[], RedirectAttributes rttr) {
		
		for(int i = 0 ; i < blackno.length;i++){
			blackservice.remove(blackno[i]);
			
		}

		return "redirect:/AdminServe/blackList";

	}
	
	
	
//==============================매출============================
	@GetMapping({"salesget", "salesmodify"})
	   public void get(@RequestParam("sno") Long sno, Model model, @ModelAttribute("cri") Criteria cri) {
	      log.info("get");
	      
	      model.addAttribute("sales", service.get(sno));
	   }
	
	@PostMapping("salesget")
	   public String modify(SalesVo salesVo, RedirectAttributes rttr, Criteria cri) {
	      log.info("modify :: " + salesVo);
	      
	      
	      if(service.modify(salesVo)) {
	         rttr.addFlashAttribute("result", "success");   
	      }
	      
	      
//	      rttr.addAttribute(cri.getParams());
	      rttr.addAttribute("pageNum", cri.getPageNum());
	      rttr.addAttribute("amount", cri.getAmount());
	      rttr.addAttribute("type", cri.getType());
	      rttr.addAttribute("keyword", cri.getKeyword());
	      return "redirect:/AdminServe/salesInquiry";
	   }
	
	
	
	
	@GetMapping("salesRegister")
	public void salesRegister() {
		log.info("salesRegister");
		
		
	}
	
	@PostMapping("salesRegister")
	public String register(SalesVo sales, RedirectAttributes rttr){
		service.register(sales);
		log.info("register:: " + sales);
		rttr.addAttribute("result :: " + sales.getSno());
		
		return "redirect:/AdminServe/salesInquiry";
	}

	@ResponseBody
    @RequestMapping(value="salesDelete", method=RequestMethod.POST)
	public String remove(long sno[], RedirectAttributes rttr) {
		
		for(int i = 0 ; i < sno.length;i++){
			service.remove(sno[i]);
			
		}

		return "redirect:/AdminServe/salesInquiry";

	}
	
	@ResponseBody @GetMapping("salesInquiry/{year}")
	public List<Map<String, Object>> getSalesByYear(@PathVariable String year){
//		year="2021";
		log.info(year);
	
		
		return service.getSalesListBy(year);
	}
	@GetMapping("salesInquiry")
	public void salesList(Model model,Criteria cri) {
		
		log.info("sales.list");
		model.addAttribute("list",service.getList(cri));
		model.addAttribute("page",new PageDTO(service.getTotal(cri),cri));
		
		
		
	}
	
	

}
