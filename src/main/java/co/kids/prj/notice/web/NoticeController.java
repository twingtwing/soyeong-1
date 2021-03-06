package co.kids.prj.notice.web;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.kids.prj.notice.service.NoticeService;
import co.kids.prj.notice.service.NoticeVO;

@Controller
public class NoticeController {
	@Autowired
	private NoticeService noticeDao;
	
	/* 공지사항 전체 리스트 */
	@RequestMapping("/noticeList.do")
	public String noticeList(Model model) throws JsonProcessingException {
		ObjectMapper ob = new ObjectMapper();
		String notices = ob.writeValueAsString(noticeDao.noticeSelectList());
		model.addAttribute("notices", notices);
		return "notice/noticeList";
	}
	
	/* 글 조회 */
	@RequestMapping("/noticeRead.do")
	public String noticeRead(Model model, @Param("bno") int bno){
		NoticeVO vo = new NoticeVO();
		vo.setBno(bno);
		vo = noticeDao.noticeSelect(vo);
		model.addAttribute("notice", vo);
		return "notice/noticeRead";
		
	}
	
	/* 공지사항 검색 */
	@RequestMapping("/noticeSearch.do")
	@ResponseBody
	public List<NoticeVO> noticeSearch(NoticeVO vo) {
		if(vo.getBtitle().length() == 0) {vo.setBtitle(null);}
		return noticeDao.noticeSearch(vo);
	}
	
	/* 글 등록 폼 */
	@RequestMapping("noticeForm.do")
	public String noticeForm() { 
		return "notice/noticeForm";
	}
	
	/* 글 등록하기 */
	@RequestMapping(value = "/noticeWrite.do")
	public String noticeWrite(@ModelAttribute("noticeVO") NoticeVO noticeVO, Model model) throws Exception{
		noticeDao.noticeInsert(noticeVO);
		return "redirect:/notice/noticeList";
	}
	
	

}
