package co.kr.humankdh.controller;


import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import co.kr.humankdh.domain.AttachVo;
import co.kr.humankdh.domain.BoardVo;
import co.kr.humankdh.domain.Criteria;
import co.kr.humankdh.domain.PageDTO;
import co.kr.humankdh.domain.ReplyCriteria;
import co.kr.humankdh.domain.ReplyVo;
import co.kr.humankdh.service.BoardService;
import co.kr.humankdh.service.ReplyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller @Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	private BoardService service;
	private ReplyService replyService;
	private UploadController uploadController;
	private ReplyController replyController;
	
	@GetMapping("notice_list")
	public void noticeList(Model model, Criteria cri, BoardVo board) {
		log.info("board.list");
		
		cri.setCategory(1);
		model.addAttribute("category", 1);
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("page", new PageDTO(service.getTotal(cri), cri));
	}
	@GetMapping("free_list")
	public void freeList(Model model, Criteria cri) {
		log.info("board.list");
		cri.setCategory(2);
		model.addAttribute("category", 2);
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("page", new PageDTO(service.getTotal(cri), cri));
	}
	@GetMapping("gallery_list")
	public void galleryList(Model model, Criteria cri, BoardVo board) {
		log.info("board.list");
		cri.setCategory(3);
		model.addAttribute("category", 3);
		List<BoardVo> list = service.getList(cri);
		List<AttachVo> attachs = new ArrayList<>();
		list.forEach((l) -> {
			l.setAttachs(service.getAttachs(l.getBno()));
		});
		
		model.addAttribute("list", list);
//		model.addAttribute("board", list);
		model.addAttribute("page", new PageDTO(service.getTotal(cri), cri));
	}
	
	
	@GetMapping("video_list")
	public void videoList(Model model, Criteria cri) {
		log.info("board.list");
		cri.setCategory(4);
		model.addAttribute("category", 4);
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("page", new PageDTO(service.getTotal(cri), cri));
	}
	@GetMapping("record_list")
	public void recordList(Model model, Criteria cri) {
		log.info("board.list");
		cri.setCategory(5);
		model.addAttribute("category", 5);
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("page", new PageDTO(service.getTotal(cri), cri));
	}
	@GetMapping("register")
	public void register() {
		
	}
	
	@PostMapping("register")
	public String register(BoardVo board, RedirectAttributes rttr, Criteria cri) {
		log.info("register :: " + board);
		log.info("카테고리 값 : "+board.getCategory());
		service.register(board);
		log.info("register :: " + board);
		rttr.addFlashAttribute("result", board.getBno());
		String str = "";
		switch (board.getCategory()) {
		case 1:
			str = "notice_list";
			break;
		case 2:
			str = "free_list";
			break;
		case 3:
			str = "gallery_list";
			break;
		case 4:
			str = "video_list";
			break;
		case 5:
			str = "record_list";
			break;
		default:
			str = "notice_list";
			break;
		}
		return "redirect:/board/" + str;	
	}
	
	@GetMapping({"get", "modify"})
	public void get(@RequestParam("bno") Long bno, Model model, @ModelAttribute("cri") Criteria cri, BoardVo board) {
		log.info("get");
		model.addAttribute("board", service.get(bno));
		model.addAttribute("category", board.getCategory());
	}
	
	@PostMapping("modify")
	public String modify(BoardVo board, RedirectAttributes rttr, Criteria cri) {
		log.info("modify :: " + board);
		if(service.modify(board)) {
			rttr.addFlashAttribute("result", "success");	
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("category", cri.getCategory());
		String str = "";
		switch (board.getCategory()) {
		case 1:
			str = "notice_list";
			break;
		case 2:
			str = "free_list";
			break;
		case 3:
			str = "gallery_list";
			break;
		case 4:
			str = "video_list";
			break;
		case 5:
			str = "record_list";
			break;
		default:
			str = "notice_list";
			break;
		}
		return "redirect:/board/" + str;
	}
	
	@PostMapping("remove")
	public String remove(@RequestParam("bno") Long bno,  RedirectAttributes rttr, Criteria cri, ReplyCriteria rcri, BoardVo board) {
		log.info("remove :: " + bno);
		List<AttachVo> list = service.getAttachs(bno);
		List<ReplyVo> replyList = replyService.getList(rcri, bno);
		replyList.forEach(r -> replyController.remove(r.getRno()));
		log.info(replyList);
		
		if(service.remove(bno)) {
			log.info(list);
			if(list != null) {
				list.forEach(vo->{
					uploadController.deleteFile(vo.getFullPath(), vo.isImage());
				});
			}
			rttr.addFlashAttribute("result", "success");	
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("category", board.getCategory());
		String str = "";
		switch (board.getCategory()) {
		case 1:
			str = "notice_list";
			break;
		case 2:
			str = "free_list";
			break;
		case 3:
			str = "gallery_list";
			break;
		case 4:
			str = "video_list";
			break;
		case 5:
			str = "record_list";
			break;
		default:
			str = "notice_list";
			break;
		}
		return "redirect:/board/" + str;
	}
	@GetMapping("getAttachs/{bno}")
	public @ResponseBody List<AttachVo> getAttachs(@PathVariable Long bno) {
		log.info("첨부파일 :  " +service.getAttachs(bno));
		return service.getAttachs(bno);
	}
}
