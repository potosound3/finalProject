package com.ljh.finalProject.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ljh.finalProject.domain.EventDTO;
import com.ljh.finalProject.domain.MemberDTO;
import com.ljh.finalProject.domain.NoticeDTO;
import com.ljh.finalProject.service.BoardService;

@Controller
public class BoardController {
	public String pageNum = "";
	public String sentence = "";
	public String category = "";
	public String remoteId = "";

	public ModelAndView mv = new ModelAndView();
	
	@Autowired
	BoardService boardService;

	
	@ModelAttribute
	public void headProcess(HttpServletRequest request, HttpServletResponse res) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		HttpSession session = request.getSession();
		remoteId = request.getRemoteAddr();
		// pageNum이 넘어와야 pageNum이 바뀜
		if (request.getParameter("pageNum") != null) {
			session.setAttribute("pageNum", request.getParameter("pageNum"));
		}
		
		// category가 넘어와야 세션이 변경됨
		if (request.getParameter("category") != null) {
			session.setAttribute("category", request.getParameter("category"));
			session.setAttribute("sentence", request.getParameter("sentence"));
			session.setAttribute("pageNum", "1");
		}
		category = (String) session.getAttribute("category");
		sentence = (String) session.getAttribute("sentence");
		pageNum = (String) session.getAttribute("pageNum");

		if (pageNum == null)
			pageNum = "1";
	}
	
	@RequestMapping("/notice")
	public ModelAndView list() throws Exception {

		int pageSize = 10;

		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage - 1) * pageSize + 1;
		int endRow = currentPage * pageSize;
		int count = 0;
		int number = 0;
		List articleList = null;

		count = boardService.getArticleCount(category, sentence);
		if (count > 0) {
			articleList = boardService.getArticles(startRow, endRow, category, sentence);
		}
		number = count - (currentPage - 1) * pageSize;

		int bottomLine = 3;
		int pageCount = 0;
		int startPage = 0;
		int endPage = 0;

		if (count > 0) {
			pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			startPage = 1 + (currentPage - 1) / bottomLine * bottomLine;
			endPage = startPage + bottomLine - 1;

			if (endPage > pageCount)
				endPage = pageCount;
		}
		mv.clear();

		mv.addObject("currentPage", currentPage);
		mv.addObject("startRow", startRow);
		mv.addObject("endRow", endRow);
		mv.addObject("count", count);
		mv.addObject("number", number);
		mv.addObject("articleList", articleList);
		mv.addObject("pageSize", pageSize);
		mv.addObject("bottomLine", bottomLine);
		mv.addObject("pageCount", pageCount);
		mv.addObject("startPage", startPage);
		mv.addObject("endPage", endPage);
		mv.setViewName("board/notice");
		
		return mv;
	}
	
	@RequestMapping("/notice/{noticeNo}")
	public String content(@PathVariable("noticeNo") int noticeNo, Model m) throws Exception {
		NoticeDTO article = boardService.getArticle(noticeNo, true);
		m.addAttribute("article", article);
		return "board/noticeDetail";
	}
	
	@GetMapping("/event")
	public String event(Model model) {
		List<EventDTO> event = boardService.eventList();
		model.addAttribute("event", event);
		return "board/event";
	}
	
	@GetMapping("/event/{eventNo}")
	public String eventDetail(@PathVariable("eventNo") int eventNo, Model model) throws Exception {
		EventDTO detail = boardService.eventDetail(eventNo);
		model.addAttribute("detail", detail);
		return "board/eventDetail";
	}
	
	@GetMapping("/event/coupon")
	@ResponseBody
	public int giveCoupon(@RequestParam("couponNo") int couponNo, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		String id = member.getId();
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("couponNo", couponNo);
		map.put("id", id);
		
		return boardService.giveCoupon(map);
	}
	
	@GetMapping("/faq")
	public String faq() {
		return "board/faq";
	}
	
}
