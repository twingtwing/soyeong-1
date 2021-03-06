package co.kids.prj.reservation.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import co.kids.prj.reservation.service.ReservLodVO;
import co.kids.prj.reservation.service.ReservationImpl;

import co.kids.prj.lodging.service.LodgingServiceImpl;
import co.kids.prj.lodging.service.LodgingVO;

import co.kids.prj.reservation.service.ReservationVO;
import co.kids.prj.review.service.ReviewServiceImpl;
import co.kids.prj.review.service.ReviewVO;
import co.kids.prj.sales.service.SalesServiceImpl;
import co.kids.prj.sales.service.SalesVO;

@Controller
public class ReservationController {
	@Autowired 
	private LodgingServiceImpl lodgingDao;
	@Autowired
	private ReservationImpl rDao;
	@Autowired SalesServiceImpl salesDao;
	
	@RequestMapping("myReserv.do")
	public String myReserv(HttpServletRequest request, HttpSession session, ReservLodVO vo) {
		session = request.getSession();
		vo.setId((String) session.getAttribute("id"));
		if(vo.getIspaid()==null) {
			vo.setIspaid("A");
		}
		request.setAttribute("cards", rDao.reservSortList(vo));	
		return "reservation/myReservation";
	}

	
	@RequestMapping("simpleInfo.do")
	public void simpleInfo(HttpServletRequest request, ReservationVO vo) {
		System.out.println("----");
		vo.setBookno(Integer.parseInt(request.getParameter("bookno")));
		request.setAttribute("thisBook", rDao.reservSelect(vo));
	}
	

	@GetMapping("/bookingForm.do")
	public String booking(HttpServletRequest request,Model model) {
		LodgingVO lodgingVO = new LodgingVO();
		int day = Integer.parseInt(request.getParameter("day"));
		int rno = Integer.parseInt(request.getParameter("rno"));
		lodgingVO.setRno(rno);
		lodgingVO = lodgingDao.LodgingSelect(lodgingVO);
		model.addAttribute("hotel", lodgingVO);
		int fee = lodgingVO.getFee();
		model.addAttribute("price",fee*day);
		model.addAttribute("serviceFee", (int)(fee*day*0.1));
		model.addAttribute("serviceTax",(int)(fee*day*0.01));
		model.addAttribute("total", (int)(fee*day+fee*day*0.1+fee*day*0.01));
		model.addAttribute("rcheckin",request.getParameter("rcheckin"));
		model.addAttribute("rcheckout",request.getParameter("rcheckout"));
		model.addAttribute("bookkid",request.getParameter("bookkid"));
		model.addAttribute("bookadult",request.getParameter("bookadult"));
		return "reservation/bookingForm";
	}

	@RequestMapping("booking.do")
	public String booking(ReservationVO vo, SalesVO svo, HttpServletRequest request) {
		System.out.println("============");
		rDao.reservInsert(vo);
		LodgingVO lodgingVO = new LodgingVO();
		lodgingVO.setRno(vo.getRno());
		lodgingVO.setRuse("N");
		lodgingDao.LodgingUpdateState(lodgingVO);
		System.out.println(request.getParameter("servicesale"));
		svo.setSid(request.getParameter("sid"));
		svo.setSales(Integer.parseInt(request.getParameter("servicesale")));
		salesDao.insertSales(svo);
		return "redirect:myReserv.do";
	}

	
	@PostMapping("/myReservDetail.do")
	public String myReservDetail(ReservLodVO vo, Model model,HttpServletRequest request) {
		vo.setId((String) request.getSession().getAttribute("id"));
		model.addAttribute("reservInfo", rDao.reservLodgSelect(vo));
		return "reservation/myReservationDetail";
	}

	@PostMapping("/cancelReserv.do")
	@ResponseBody
	public String cancelReserv(ReservationVO vo) {
		if(rDao.reservDelete(vo)!=0) {
			return "ok";
		} else {
			return "ng";
		}
		
	}
	
	
	
}
