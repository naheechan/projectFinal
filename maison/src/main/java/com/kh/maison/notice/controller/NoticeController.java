package com.kh.maison.notice.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.maison.common.PageBarFactory;
import com.kh.maison.member.model.vo.Member;
import com.kh.maison.notice.model.service.NoticeService;
import com.kh.maison.notice.model.vo.Notice;

@Controller
public class NoticeController {

	@Autowired
	private NoticeService service;
	
	@RequestMapping("/notice/noticeList.do")
	public ModelAndView noticeList(ModelAndView mv,
			@RequestParam(value="cPage",required=false,defaultValue="1")int cPage,
			@RequestParam(value="numPerPage",required=false,defaultValue="10")int numPerPage) {
		
		List<Notice> list=service.selectNoticeList(cPage,numPerPage);
		int totalData=service.selectCount();
		
		mv.addObject("pageBar",PageBarFactory.getPageBar(totalData, cPage, numPerPage, "noticeList.do"));
		mv.addObject("totalData",totalData);
		mv.addObject("list",list);
		mv.setViewName("notice/noticeList");
		return mv;
	}
	
	@RequestMapping("/notice/noticeAdd.do")
	public ModelAndView noticeAdd(ModelAndView mv,HttpSession session) {
		
		  Member login=(Member)session.getAttribute("loginMember");
		  
		  if(login!=null) {
			  //로그인되어있음
			  
			  //관리자가 아닐때
			  if(!(login.getMemberId()).equals("admin")) { 
				  mv.addObject("msg","관리자만 접근가능합니다!");
				  mv.addObject("loc","/notice/noticeList.do"); 
				  mv.setViewName("/common/msg");
			  }else { 
				  //관리자가 로그인했을때
				  mv.setViewName("/notice/noticeAdd"); 
				  }
		  }else {
			  mv.addObject("msg","관리자만 접근가능합니다!");
			  mv.addObject("loc","/notice/noticeList.do"); 
			  mv.setViewName("/common/msg");
		  }
		 
		return mv;
	}
	
	@RequestMapping("/notice/imageUpload.do")
	public void imageUpload(HttpServletRequest request,HttpServletResponse response,@RequestParam MultipartFile upload) 
		throws Exception{
			//경로설정
			String saveDir =request.getServletContext().getRealPath("/resources/upload/notice/");
			File dir=new File(saveDir);
			
			if(!dir.exists()) {
				dir.mkdirs();
			}
			
			if(!upload.isEmpty()) {
				//파일명 재설정
				String originalFileName=upload.getOriginalFilename();
				String ext=originalFileName.substring(originalFileName.lastIndexOf(".")+1);
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy_MM-dd_HHmmssSSS");
				int rndNum = (int)(Math.random()*1000);
				
				String renamedFileName=sdf.format(new Date(System.currentTimeMillis()))+"_"+rndNum+"."+ext;
				try {
					//파일저장
					upload.transferTo(new File(saveDir+"/"+renamedFileName));
				}catch(IOException e) {
					e.printStackTrace();
				}
				
				String callback=request.getParameter("CKEditorFuncNum");
				
				PrintWriter printWriter=response.getWriter();
				String fileUrl=request.getContextPath()+"/resources/upload/notice/"+renamedFileName;
				printWriter.println("<script>window.parent.CKEDITOR.tools.callFunction("+callback+",'"+fileUrl
						+"','successfully uploaded')"+"</script>");
				printWriter.flush();
			
				
			}
			
			
		}
	
	
	@RequestMapping("/notice/noticeAddEnd.do")
	public ModelAndView noticaAddEnd(@RequestParam Map<String,String> param,ModelAndView mv) {
		
		
		int result=service.insertNotice(param);
		
		mv.addObject("msg", result>0?"공지가 등록되었습니다.":"공지 등록에 실패하였습니다.");
		mv.addObject("loc", "/notice/noticeList.do");
		
		mv.setViewName("common/msg");
		
		return mv;
	}

	@RequestMapping("/notice/noticeOne.do")
	public ModelAndView noticeOne(int noticeNo,ModelAndView mv,
			@CookieValue(value="noticeView",defaultValue="")String cookie,
			HttpServletResponse response) {
		
		boolean hasRead=false;
		Notice n=service.selectNoticeOne(noticeNo);
		//n을 제대로 불러왔을때
		if(n!=null) {
			
			//noticeView 쿠키에 이미 저장되어있는지 확인하기
			if(cookie.contains("|"+noticeNo+"|")) {
				//이미 본적 있으므로 true
				//hasRead=true;
				
			}else {
				//본적없으면 조회수 올리기
				int result=service.updateCount(noticeNo);
				//조회수 정상적으로 올렸으면 쿠키추가하기
				if(result>0) {
					cookie+="|"+noticeNo+"|";
					Cookie c=new Cookie("noticeView",cookie);
					c.setMaxAge(-1);
					response.addCookie(c);
					n.setNoticeCount(n.getNoticeCount()+1);
					
				}
			}
		}

		
		
		mv.addObject("n",n);
		
		mv.setViewName("/notice/noticeDetail");
		return mv;
	}

	@RequestMapping("/notice/noticeUpdate.do")
	public ModelAndView noticeUpdate(int noticeNo,ModelAndView mv) {
		Notice n=service.selectNoticeOne(noticeNo);
		mv.addObject("n",n);
		mv.setViewName("/notice/noticeUpdate");
		
		return mv;
	}
	
	@RequestMapping("/notice/noticeDelete.do")
	public ModelAndView noticeDelete(int noticeNo,ModelAndView mv,
			@RequestParam(value="admin",required=false)String admin) {
		int result=service.deleteNotice(noticeNo);
		System.out.println("admin: "+admin);
		mv.addObject("msg", result>0?"공지가 삭제되었습니다.":"공지삭제에 실패하였습니다.");
		if(admin.equals("yes")) {
			mv.addObject("loc", "/admin/adminNoticeList.do");
		}else {
			mv.addObject("loc", "/notice/noticeList.do");
			
		}
		
		mv.setViewName("common/msg");
		
		return mv;
		
	}
	
	@RequestMapping("/notice/noticeUpdateEnd.do")
	public ModelAndView noticeUpdateEnd(@RequestParam Map<String,String> param,ModelAndView mv) {
		
		int result=service.updateNotice(param);
		int noticeNo=Integer.parseInt(param.get("noticeNo"));
		mv.addObject("msg", result>0?"공지가 수정되었습니다.":"공지 수정에 실패하였습니다.");
		mv.addObject("loc", "/notice/noticeOne.do?noticeNo="+noticeNo);
		
		mv.setViewName("common/msg");
		
		return mv;
	}
	
	@RequestMapping("/admin/adminNoticeList.do")
	public ModelAndView adminNoticeList(ModelAndView mv,
			@RequestParam(value="cPage",required=false,defaultValue="1")int cPage,
			@RequestParam(value="numPerPage",required=false,defaultValue="10")int numPerPage,
			@RequestParam(value="select", required=false)String select,
			@RequestParam(value="keyword", required=false)String keyword) {
		List<Notice> list=null;
		int totalData=0;
		System.out.println("keyword:"+keyword+"select"+select);
		if(select!=null&&keyword!=null) {
			Map<String,String> param=new HashMap();
			
			param.put("select", select);
			param.put("keyword", keyword);
			list=service.selectNoticeListSearch(cPage, numPerPage,param);
			totalData=service.countSearch(param);
			mv.addObject("select",select);
			mv.addObject("keyword",keyword);
		}else {
			
			list=service.selectNoticeList(cPage, numPerPage);
			totalData=service.selectCount();
			
		}
		
		
		
		mv.addObject("pageBar",PageBarFactory.getPageBar(totalData, cPage, numPerPage, "adminNoticeList.do"));
		mv.addObject("totalData",totalData);
		mv.addObject("list",list);
		mv.setViewName("admin/notice/noticeList");
		return mv;
	}
	
	
	
	
}
