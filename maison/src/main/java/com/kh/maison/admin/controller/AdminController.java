package com.kh.maison.admin.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.maison.admin.model.service.AdminService;
import com.kh.maison.admin.model.vo.MemberSearch;
import com.kh.maison.admin.model.vo.ProductStock;
import com.kh.maison.common.crypto.AES256Util;
import com.kh.maison.member.model.vo.Member;
import com.kh.maison.shop.model.vo.Request;
import com.kh.spring.common.PageBarFactory;

@Controller
public class AdminController {

	@Autowired
	private AdminService service;
	
	@Autowired
	private AES256Util aes;
	
	@RequestMapping("/admin/dashBoard.do")
	public String adminMain() {
		return "admin/dashBoard";
	}
	
	//상품재고 관리 페이지 전환 
	@RequestMapping("/admin/productStock.do")
	public ModelAndView adminProductStock(ModelAndView mv,
			@RequestParam(value="cPage",required=false,defaultValue="1") int cPage,
			@RequestParam(value="numPerPage",required=false,defaultValue="10")int numPerPage) {
		
		List<ProductStock> list = service.bringThirdList(cPage,numPerPage);
		int totalContents = service.bringThirdCount();
		String pageBar = PageBarFactory.getPageBar(totalContents, cPage, numPerPage, "productStock.do");
		mv.addObject("list",list);
		mv.addObject("totalContents",totalContents);
		mv.addObject("pageBar",pageBar);
		mv.setViewName("admin/productStock");
		return mv;
	}
	
	//상품재고관리 페이지 첫번째 div데이터 가져오기
	@RequestMapping("/admin/bringFirstDiv.do")
	@ResponseBody
	public Map<String,Object> bringFirstDiv(@RequestParam int numDate){
		//현재 총 재고, 재고변동, 입고량, 출고량 가져와야 함. 
		//가져와서 map에 담아야 함. 
		//그때 numDate를 넘겨줘가지고 계산해야함. 
		int total = service.selectFirstTotal(numDate);
		int change = service.selectFirstChange(numDate);
		int in = service.selectFirstIn(numDate);
		int out = service.selectFirstOut(numDate);
		Map<String,Object> map = new HashMap<String,Object>();
		if(total==0) {
			map.put("total", 0);
		}else {
			map.put("total", total);
		}
		if(change==0) {
			map.put("change", 0);
		}else {
			map.put("change", change);
		}
		if(in==0) {
			map.put("in", 0);
		}else {
			map.put("in", in);
		}
		if(out==0) {
			map.put("out", 0);
		}else {
			if(out<0) {
				map.put("out", out*-1);
			}else {
				map.put("out", out);
			}
		}
		
		return map;
	}
	
	//상품재고관리 페이지 두번째 div데이터 가져오기
	@RequestMapping("/admin/bringSecondDiv.do")
	@ResponseBody
	public Map<String,Object> bringSecondDiv(@RequestParam int sendNum){
		//재고변동, 입고량, 출고량을 가져와야 하는데 sendNum에서 0,1,2,3,4,5,6을 보낼거임
		//얘가 무슨의미냐면, 0이면 오늘, 1이면 어제 즉, 몇일 전의 데이터인지를 sendNum으로 전송
		int change = service.selectSecondChange(sendNum);
		int in = service.selectSecondIn(sendNum);
		int out = service.selectSecondOut(sendNum);
		Map<String,Object> map = new HashMap<String,Object>();
		if(change==0) {
			map.put("change", 0);
		}else {
			map.put("change", change);
		}
		if(in==0) {
			map.put("in",0);
		}else {
			map.put("in",in);
		}
		if(out==0) {
			map.put("out", 0);
		}else {
			if(out<0) {
				map.put("out", out*-1);
			}else {
				map.put("out", out);
			}
		}
		return map;
	}
	
//	@RequestMapping("/admin/bringThirdDiv.do")
//	@ResponseBody
//	public Map<String,Object> bringThirdDiv(
//			@RequestParam(value="cPage",required=false,defaultValue="1") int cPage,
//			@RequestParam(value="numPerPage",required=false,defaultValue="10")int numPerPage){
//		List<ProductStock> list = service.bringThirdList(cPage,numPerPage);
//		int totalContents = service.bringThirdCount();
//		String pageBar = PageBarFactory.getPageBar(totalContents, cPage, numPerPage, "bringThirdDiv.do");
//		Map<String,Object> map = new HashMap<String,Object>();
//		map.put("list", list);
//		map.put("totalContents", totalContents);
//		map.put("pageBar", pageBar);
//		return map;
//	}
	
	//입고요청 페이지 전환
	@RequestMapping("/admin/productRequest.do")
	public ModelAndView adminProductRequest(ModelAndView mv,
			@RequestParam(value="cPage",required=false,defaultValue="1") int cPage,
			@RequestParam(value="numPerPage",required=false,defaultValue="20")int numPerPage,
			@RequestParam(value="requestStatus",required=false,defaultValue="")String requestStatus) {
		List<Request> list = service.selectAllRequest(cPage,numPerPage,requestStatus);
		int totalContents = service.selectAllRequestCount(requestStatus);
		String pageBar = PageBarFactory.getPageBar(totalContents, cPage, numPerPage, "productRequest.do");
		mv.addObject("list",list);
		mv.addObject("totalContents",totalContents);
		mv.addObject("pageBar",pageBar);
		mv.addObject("requestStatus",requestStatus);
		mv.setViewName("admin/productRequest");
		return mv;
	}
	
	@RequestMapping("/admin/requestView")
	public ModelAndView adminRequestView(ModelAndView mv,@RequestParam int no) {
		mv.addObject("request",service.selectOneRequest(no));
		mv.setViewName("admin/productRequestView");		
		return mv;
		
	}
	
	//입고요청 status변경 
	@RequestMapping("/admin/requestStatus.do")
	@ResponseBody
	public int requestStatus(@RequestParam int requestNo,
							@RequestParam String requestStatus) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("requestNo", requestNo);
		map.put("requestStatus", requestStatus);
		int result=service.requestStatusUpdate(map);
		return result;
		
	}
	
	@RequestMapping("/admin/memberList.do")
	public ModelAndView memberList(ModelAndView mv,
			@RequestParam(value="cPage",required=false,defaultValue="1") int cPage,
			@RequestParam(value="numPerPage",required=false,defaultValue="10")int numPerPage,
			@RequestParam(value="type",required=false,defaultValue="")String type,
			@RequestParam(value="keyword",required=false,defaultValue="")String keyword,
			@RequestParam(value="memberSocial",required=false,defaultValue="")String memberSocial,
			@RequestParam(value="emailStatus",required=false,defaultValue="")String emailStatus,
			@RequestParam(value="memberLevel",required=false,defaultValue="")String memberLevel){
		//검색어(target,check), 회원구분, 이메일 수신 여부, 회원등급
			
		//		@RequestParam(value="memberLevel",required=false,defaultValue="")String memberLevel,
		//		@RequestParam(value="emailStatus",required=false,defaultValue="")String emailStatus,
		//		@RequestParam(value = "valueArr[]",required=false,defaultValue="") List<String> valueArr

		MemberSearch ms = new MemberSearch();
		ms.setType(type);
		ms.setKeyword(keyword);
		ms.setMemberSocial(memberSocial);
		ms.setEmailStatus(emailStatus);
		ms.setMemberLevel(memberLevel);
		
		List<Member> list = service.selectAllMember(cPage,numPerPage,ms);
		List<Member> list2 = new ArrayList();
		for(int i=0;i<list.size();i++) {
			try {
				Member mem = new Member();
				mem.setMemberId(list.get(i).getMemberId());
				mem.setMemberName(list.get(i).getMemberName());
				mem.setEmail(aes.decrypt(list.get(i).getEmail()));
				mem.setPhone(aes.decrypt(list.get(i).getPhone()));
				mem.setGradeCode(list.get(i).getGradeCode());
				list2.add(mem);
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (GeneralSecurityException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		int totalContents = service.selectAllMemberCount(ms);
		String pageBar = PageBarFactory.getPageBar(totalContents, cPage, numPerPage, "memberList.do");
		mv.addObject("list",list2);
		mv.addObject("totalContents",totalContents);
		mv.addObject("pageBar",pageBar);
		mv.setViewName("admin/member/memberList");
		return mv;
	}
	
	//버튼 누르면 멤버 탈퇴시키기 
	@RequestMapping("admin/memberDelete.do")
	public ModelAndView memberDelete(ModelAndView mv, @RequestParam String memberId) {
		int result = service.updateMemberStatus(memberId);
		if(result>0) {
			mv.addObject("msg", memberId+"님이 탈퇴되었습니다.");
			mv.addObject("subMsg","관리자 > 멤버 목록 화면을 리로드합니다.");
			mv.addObject("status","success");
			mv.addObject("loc", "/admin/memberList.do");			
		}else {
			mv.addObject("msg", "탈퇴시도가 실패했습니다.");
			mv.addObject("subMsg","다시시도하신 후 관리자에게 문의해주세요.");
			mv.addObject("status","error");
			mv.addObject("loc", "/admin/memberList.do");
		}
		mv.setViewName("common/sweetMsg");
		return mv;
	}
	
}
