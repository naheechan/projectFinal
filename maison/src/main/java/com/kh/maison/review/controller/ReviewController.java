package com.kh.maison.review.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.kh.maison.common.PageBarFactory;
import com.kh.maison.member.model.vo.Member;
import com.kh.maison.order.model.service.OrderService;
import com.kh.maison.order.model.vo.OrderDetail;
import com.kh.maison.review.model.service.ReviewService;
import com.kh.maison.review.model.vo.Review;
import com.kh.maison.review.model.vo.ReviewReply;
import com.kh.maison.shop.service.ProductService;
import com.kh.maison.shop.vo.Product;
@Controller
public class ReviewController {

	@Autowired
	ReviewService service;
	
	@Autowired
	ProductService pservice;
	@Autowired
	OrderService oservice;
	
	@RequestMapping("/shop/insertReview.do")
	@ResponseBody
	public ModelAndView insertReview(ModelAndView mv,int productNo,int orderDetailNo) {
		
		Product p=pservice.selectProductOne(productNo);
		OrderDetail od=oservice.selectOdOne(orderDetailNo);
		//전달받은 오더디테일로 쓰여진 리뷰가 있는지 확인하기
		Review r=service.selectReviewOdNo(orderDetailNo);
		
		//r이 null이어야 작성가능
		if(r==null) {
			mv.addObject("p",p);
			mv.addObject("od",od);
			mv.setViewName("/shop/reviewPop");
			
		}else {
			//있으면 작성 불가능
			mv.addObject("msg","이미 작성한 리뷰가 있습니다 !");
			mv.addObject("loc","/member/order/orderList.do");
			mv.setViewName("common/msg");
			return mv;
		}
		return mv ;
	}
	@RequestMapping("/shop/review.do")
	public String review() {
		
	return "shop/productReviewAdd";	
	}
	
	@RequestMapping("/shop/insertReviewEnd.do")
	public ModelAndView insertRevuewEnd(ModelAndView mv,Review r,HttpSession session) {
		
		
		Member m=(Member)session.getAttribute("loginMember");	
		r.setMemberId(m.getMemberId());
		
		int result=service.insertReview(r);
		mv.setViewName("redirect:/shop/shopDetail.do?no="+r.getProductNo());
		return mv;
	}
	
	@RequestMapping("/shop/selectReviewList.do")
	@ResponseBody
	public ModelAndView reviewList(ModelAndView mv,int productNo) 
			throws JsonMappingException, JsonGenerationException, IOException{
		
		List<Review> list=service.selectReviewList(productNo);
		mv.addObject("list", list);
		int count=0;
		float sum=0;
		for(Review r:list) {
			
			sum+=r.getReviewScore();
			count++;
			
		}
		double score=(sum/count);
		score=Math.round(score*100)/100.0;
		float percent= (sum/count)*20;
		
		//페이징처리

		
		
		
		mv.addObject("count", count);
		mv.addObject("score", score);
		mv.addObject("percent", percent);
		mv.setViewName("shop/productReview");
		return mv;
	}
	
	@RequestMapping("/shop/insertReviewReply.do")
	@ResponseBody
	List<ReviewReply> insertReviewReply(@RequestParam Map<String,String> param) 
			throws JsonMappingException, JsonGenerationException, IOException{
		int result=service.insertReviewReply(param);
		int reviewNo=Integer.parseInt(param.get("reviewNo"));
		List<ReviewReply> rlist=service.selectReviewReplyList(reviewNo);
		return rlist;
	}
	
	@RequestMapping("/shop/selectReviewReply.do")
	@ResponseBody
	List<ReviewReply> selectReviewReply(int reviewNo) 
			throws JsonMappingException, JsonGenerationException, IOException{
		List<ReviewReply> rlist=service.selectReviewReplyList(reviewNo);
		//ObjectMapper obm=new ObjectMapper();
		//String str=obm.writeValueAsString(rlist);
		return rlist;
	}

	@RequestMapping("/shop/deleteReply.do")
	@ResponseBody
	List<ReviewReply> deleteReply(int rrNo,int reviewNo) 
			throws JsonMappingException, JsonGenerationException, IOException{
		int result= service.deleteReviewReply(rrNo);
		List<ReviewReply> rlist=service.selectReviewReplyList(reviewNo);
		
		return rlist;
	}

	@RequestMapping("/shop/updateReviewReply.do")
	@ResponseBody
	List<ReviewReply> updateReviewReply(ReviewReply rr){
		int result=service.updateReviewReply(rr);
		List<ReviewReply> rlist=service.selectReviewReplyList(rr.getReviewNo());
		return rlist;
	}

	
	@RequestMapping("/member/updateReview.do")
	@ResponseBody
	ModelAndView updateReview(int reviewNo,ModelAndView mv) {
		Review rev=service.selectReviewOne(reviewNo);
		Product p=pservice.selectProductOne(rev.getProductNo());
		mv.setViewName("shop/reviewUpdatePop");
		mv.addObject("r",rev);
		mv.addObject("p",p);
		return mv;
		
	}
	
	@RequestMapping("/member/updateReviewEnd.do")
	ModelAndView updateReviewEnd(Review r,HttpSession session,ModelAndView mv) {
		System.out.println(r);
		Member m=(Member)session.getAttribute("loginMember");
		if(r.getMemberId().equals(m.getMemberId())){
			int result=service.updateReview(r);
			mv.setViewName("redirect:/member/review/reviewList.do");
			
		}else {
			mv.addObject("msg","수정 권한이 없습니다 !");
			mv.addObject("loc","/shop/shopDetail.do?no="+r.getProductNo());
			mv.setViewName("common/msg");
		}
		return mv;
	}
	
	@RequestMapping("/member/deleteReview.do")
	ModelAndView deleteReview(int reviewNo,ModelAndView mv) {
		int result=service.deleteReview(reviewNo);
		//다시 리뷰페이지로 가기
		mv.setViewName("redirect:/member/review/reviewList.do");
		return mv;
	}
	
	@RequestMapping("/member/review/reviewList.do")
	ModelAndView reviewList(ModelAndView mv,HttpSession session,
			@RequestParam(value="cPage",required=false,defaultValue="1")int cPage,
			@RequestParam(value="numPerPage",required=false,defaultValue="10")int numPerPage) {
		Member m=(Member)session.getAttribute("loginMember");
		if(m==null) {
			mv.addObject("msg","로그인이 필요한 서비스입니다 !");
			mv.addObject("loc","/member/login");
		}else {
			
			List<Review> list=service.selectReviewList(m.getMemberId(),cPage,numPerPage);
			int totalData=service.countReviewId(m.getMemberId());
			
			mv.addObject("pageBar",PageBarFactory.getPageBar(totalData, cPage, numPerPage, "reviewList.do"));
			
			
			mv.addObject("list",list);
			mv.setViewName("/member/review/reviewList");
			
		}
		
		return mv;
	}
	
	@RequestMapping("member/review/selectPeriodReview.do")
	ModelAndView selectPeriodReview(@RequestParam Map param,ModelAndView mv,HttpSession session,
			@RequestParam(value="cPage",required=false,defaultValue="1")int cPage,
			@RequestParam(value="numPerPage",required=false,defaultValue="10")int numPerPage) {
		
		int select=Integer.parseInt((String)param.get("select"));
		
		Member m=(Member)session.getAttribute("loginMember");
		param.put("memberId", m.getMemberId());
		List<Review> list=null;
		int totalData=0;
		if(select==1) {
			//전체보기
			list=service.selectPeriodReview(param,cPage,numPerPage);
			totalData=service.countPeriodReview(param);
		}else if(select==2){
			//답글달린거만 보기
			list=service.selectReviewWithRR(param,cPage,numPerPage);
			totalData=service.countReviewWithRR(param);
		}
		
		
		mv.addObject("pageBar",PageBarFactory.getPageBar2(totalData, cPage, numPerPage, "selectPeriodReview.do?select="+select+"&start="+param.get("start")+"&end="+param.get("end")));
		mv.addObject("list",list);
		mv.addObject("start",param.get("start"));
		mv.addObject("end",param.get("end"));
		mv.addObject("select" ,select);
		mv.setViewName("member/review/reviewList");
		return mv;
	}
	@RequestMapping("admin/review/reviewList.do")
	public ModelAndView adminReviewList(ModelAndView mv) {
		
		
		mv.setViewName("admin/review/reviewList");
		return mv;
	}
	
	@RequestMapping("admin/review/selectPeriodReview.do")
	public ModelAndView adminselectPeriodReview(@RequestParam Map param ,ModelAndView mv,
			@RequestParam(value="cPage",required=false, defaultValue="1") int cPage,
			@RequestParam(value="numPerPage",required=false,defaultValue="10")int numPerPage) {
		
		int select=1;
		if(param.get("select")!=null) {
			select=Integer.parseInt((String)(param.get("select")));
			
		}
		List <Review> list=null;
		int totalData=0;
		if(select==1) {
			//전체보기
			list=service.selectPeriodReviewAdmin(param, cPage, numPerPage);
			totalData=service.countPeriodReviewAdmin(param);
		}else if(select==2) {
			//답변안단 리뷰만 보기
			list=service.selectReviewAdminWithRR(param, cPage, numPerPage);
			totalData=service.countReviewAdminWithRR(param);
		}
		
		mv.addObject("list",list);
		mv.addObject("pageBar",PageBarFactory.getPageBar2(totalData, cPage, numPerPage, "selectPeriodReview.do?select="+select+"&start="+param.get("start")+"&end="+param.get("end")));
		mv.addObject("start",param.get("start"));
		mv.addObject("end",param.get("end"));
		mv.addObject("select",select);
		mv.setViewName("admin/review/reviewList");
		return mv;
	}
	
}
