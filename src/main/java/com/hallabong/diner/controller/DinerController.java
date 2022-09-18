package com.hallabong.diner.controller;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hallabong.diner.service.DinerService;
import com.hallabong.diner.vo.DinerVO;
import com.webjjang.util.PageObject;
import com.webjjang.util.file.FileUtil;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/diner")
@Log4j
public class DinerController {
	
	@Setter(onMethod_ = {@Autowired})
	@Qualifier("dinerServiceImpl")
	private DinerService service;
	
	// 리스트
	@GetMapping("/list.do")
	public String list(PageObject pageObject, Model model) throws Exception {
		
		log.info("맛집 리스트");
		
		if(pageObject.getPerPageNum() == 10)
			pageObject.setPerPageNum(8);
		
		model.addAttribute("list", service.list(pageObject));
		model.addAttribute("pageObject", pageObject);
		
		return "diner/list";
	}
	
	
	// 보기
	@GetMapping("/view.do")
	public String view(long no, int inc, Model model) throws Exception {
		
	log.info("맛집 게시판 보기");
	
	log.info("no = " + no + ", inc = " + inc);

		model.addAttribute("vo", service.view(no, inc));
		
		return "diner/view";
	}
	
	// 등록 폼
	@GetMapping("/write.do")
	public String writeForm() throws Exception{

		log.info("맛집 게시판 등록폼");

		return "diner/write";
	}
	
	// 등록 처리
	@PostMapping("/write.do")
	public String write(DinerVO vo, HttpServletRequest request, int perPageNum) throws Exception {
		
		log.info("맛집 게시판 글 등록 처리 -------");
		
		log.info(request);
		
		log.info(vo);																								
		
		vo.setId("admin");
		
		vo.setImage(FileUtil.upload("/upload/diner", vo.getImageFile(), request)); 
		
		log.info("파일 등록 처리 ----------");
		
		
		service.write(vo);
				
		return "redirect:list.do?perPageNum=" + perPageNum;

	}
	
	// 수정 폼
	@GetMapping("/update.do")
	public String updateForm(long no, Model model) throws Exception {
		
		log.info("맛집 게시판 수정폼");
		
		model.addAttribute("vo", service.view(no, 0));
		
		return "diner/update";
	}
	
	// 수정 처리
	@PostMapping("/update.do")
	public String update(DinerVO vo, PageObject pageObject, HttpServletRequest request) throws Exception{
		
		log.info("맛집 게시판 수정 처리");
		
		vo.setImage(FileUtil.upload("/upload/diner", vo.getImageFile(), request)); 

		
		service.update(vo);
		
		log.info(pageObject);
		
		return "redirect:view.do?no=" + vo.getNo() + "&inc=0"
		+ "&page=" + pageObject.getPage()
		+ "&perPageNum=" + pageObject.getPerPageNum()
		+ "&key=" + pageObject.getKey()
		+ "&word=" + pageObject.getWord()
		;
	}
	
	// 삭제
	@GetMapping("/delete.do")
	public String delete(long no, int perPageNum) throws Exception{
		
		log.info("맛집 게시판 삭제");
		
		int result = service.delete(no);
		
		if(result == 1) log.info("삭제 완료");
		else log.info("게시판 삭제 실패 - 게시판 글번호를 확인해주세요.");
		
		return "redirect:list.do?perPageNum=" + perPageNum;
	
}
}
