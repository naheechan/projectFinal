package com.kh.maison.with.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.maison.common.PageBarFactory;
import com.kh.maison.member.model.vo.Member;
import com.kh.maison.with.model.service.WithBoardService;
import com.kh.maison.with.model.vo.WithBoard;
import com.kh.maison.with.model.vo.WithComment;
import com.kh.maison.with.model.vo.WithReport;

@Controller
public class WithController {
	
	@Autowired
	private WithBoardService service;
	
	@RequestMapping("/with/withList.do")
	public String selectAllWith(Model m,
			@RequestParam(value="cPage",required=false,defaultValue="1") int cPage,
			@RequestParam(value="numPerPage",required=false,defaultValue="10")int numPerPage
			) {
		List<WithBoard> list = service.selectAllWith(cPage,numPerPage);
		int totalContents = service.selectWithCount();
		m.addAttribute("pageBar",PageBarFactory.getPageBar(totalContents, cPage, numPerPage, "withList.do"));
		m.addAttribute("list",list);
		m.addAttribute("totalContents",totalContents);		
		return "with/withList";
	}
	
	@RequestMapping("/with/withEnroll.do")
	public String enrollWith() {
		return "with/withEnroll";
	}
	
	@RequestMapping("/with/imageUpload.do")
	 public void imageUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload)
	    //MultipartFile 타입은 ckedit에서 upload란 이름으로 저장하고 있음. 변경하면 안됨!!
	            throws Exception {
	 	 	//파일이 업로드될 위치        
	        String saveDir = request.getServletContext().getRealPath("/resources/upload/with/");
	        File dir = new File(saveDir);
	        //지정한 경로에 폴더가 없는 경우 폴더를 생성하여 마지막 지정한 폴더까지 생성해줌.
	        if(!dir.exists()) {
	        	dir.mkdirs();
	        }
	        //파일이 제대로 들어오면 즉, 비어있지 않으면
	        if(!upload.isEmpty()) {
	        	//파일의 본래 이름을 불러옴.
	        	String originalFileName =upload.getOriginalFilename();
	        	// 본래 이름에서 . 뒤에 있는 확장자 명을 떼어다가 저장해둠.
	        	String ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
	        	//오늘의 년, 월, 일, 시, 분, 초 까지 불러오고
	        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy_MM_dd_HHmmssSSS");
	        	//1000까지의 숫자를 랜덤으로 가져옴.
	        	int rndNum = (int)(Math.random()*1000);
	        	//오늘의 날짜, 랜덤 넘버, 제일 처음에 떼어놨던 확장자명까지 더해서 새로운 이름을 만들어줌.
	        	String renamedFileName = sdf.format(new Date(System.currentTimeMillis()))+"_"+rndNum+"."+ext;
	        	try {
	        		//위치+이름으로 파일을 업로드 해줌.
	        		upload.transferTo(new File(saveDir+"/"+renamedFileName));
	        	}catch(IOException e) {
	        		e.printStackTrace();
	        	}
	        	//여기 아래부터는 /resources/upload/with 즉, 경로빼고 나머지는 손대지말것. 
	        	//함수, 변수명 등이 ckeditor에 다 지정되어 있음.
		        // 클라이언트에 결과 표시
		        String callback = request.getParameter("CKEditorFuncNum");
		        
		        // 서버=>클라이언트로 텍스트 전송(자바스크립트 실행)
		        PrintWriter printWriter = response.getWriter();
		        String fileUrl = request.getContextPath() + "/resources/upload/with/" + renamedFileName;
		        printWriter.println("<script>window.parent.CKEDITOR.tools.callFunction(" + callback + ",'" + fileUrl
		                + "','successfully uploaded')" + "</script>");
		        printWriter.flush();	
	        }
	        //얘네는 파일을 업로드하고, textarea안에 들어갈 html형태의 데이터에 img태그를 추가해주는 것까지만 해줄뿐,
	        // 이제 이걸가지고 data를 저장하고 불러오는걸 하면됩니당
	        
	    }
	
	@RequestMapping("/with/withEnrollEnd.do")
	public ModelAndView enrollWithEnd(WithBoard wb, ModelAndView mv) {
		
		int result = service.insertWith(wb);
		if(result>0) {
			mv.addObject("msg","함께해요 게시글 등록 성공!");
			mv.addObject("subMsg","함께해요 메인화면으로 전환합니다.");
			mv.addObject("status","success");
			mv.addObject("loc","/with/withList.do");
		}else {
			mv.addObject("msg","함께해요 게시글 등록 실패!");
			mv.addObject("subMsg","게시글 작성 화면으로 돌아갑니다.");
			mv.addObject("status","error");
			mv.addObject("loc","/with/withEnroll.do");
		}
		mv.setViewName("common/sweetMsg");
	
		return mv;
	}
	
	@RequestMapping("/with/withView.do")
	public ModelAndView withView(int no, ModelAndView mv) {
		//조회수 하나 올려주기
		int wbCount = 0;
		service.withBoardCount(no);
		
		WithBoard wb = service.selectOneWith(no);
		//판매자의 데이터를 불러오기
		Member seller = service.selectEmailAndPhone(no);
		mv.addObject("seller",seller);
		mv.addObject("withBoard",wb);
		mv.setViewName("with/withView");
		return mv;
	}
	
	@RequestMapping("/with/withRemove.do")
	public String withRemove(int wbNo) {
		service.removeWith(wbNo);
		return "redirect:/with/withList.do";
	}
	
	@RequestMapping("/with/withUpdate.do")
	public ModelAndView updateWith(int wbNo, ModelAndView mv) {
		mv.addObject("withBoard",service.selectOneWith(wbNo));
		mv.setViewName("with/withUpdate");
		return mv;
	}
	
	@RequestMapping("/with/replyEnroll.do")
	@ResponseBody
	public int withReplyEnroll(@RequestParam String memberId,
											@RequestParam int wbNo,
											@RequestParam String wcContent){
		
		WithComment comment = new WithComment();
		comment.setWbNo(wbNo);
		comment.setMemberId(memberId);
		comment.setWcContent(wcContent);
		
		
		
		return service.insertWithReply(comment);
	}
	
	@RequestMapping("/with/replyList.do")
	@ResponseBody
	public List<WithComment> withReplySelect(@RequestParam int bno){
		
		List<WithComment> list = service.selectAllWithReply(bno);
		return list; 
	}
	
	@RequestMapping("/with/replyEnrollSecond.do")
	@ResponseBody
	public int withReplyEnrollSecond(@RequestParam int wcParent,
									@RequestParam String memberId,
									@RequestParam int wbNo,
									@RequestParam String wcContent
									) {
		WithComment comment = new WithComment();
		comment.setWbNo(wbNo);
		comment.setWcParent(wcParent);
		comment.setWcContent(wcContent);
		comment.setMemberId(memberId);
		return service.insertWithReplySecond(comment);
	}
	
	@RequestMapping("/with/replyRemove.do")
	@ResponseBody
	public int withReplyDelete(@RequestParam int no) {
		return service.deleteWithReply(no);		
	}
	
	@RequestMapping("/with/replyOne.do")
	@ResponseBody
	public WithComment withReplyOneSelect(@RequestParam int wcNo) {
		WithComment wc = service.selectOneWithReply(wcNo);
		return wc;
	}
	
	@RequestMapping("/with/replyUpdate.do")
	@ResponseBody
	public int withReplyUpdate(@RequestParam int cno, @RequestParam String content) {
		WithComment wc = new WithComment();
		wc.setWcNo(cno);
		wc.setWcContent(content);
		return service.updateWithReply(wc);
	}
	
	@RequestMapping("/with/withStatusUpdate.do")
	public ModelAndView withStatusUpdate(WithBoard wb, ModelAndView mv) {
		
		service.withStatusUpdate(wb);
		//판매자의 데이터를 불러오기
		mv.addObject("seller",service.selectEmailAndPhone(wb.getWbNo()));
		mv.addObject("withBoard",service.selectOneWith(wb.getWbNo()));
		mv.setViewName("with/withView");
		return mv;
	}
	
	@RequestMapping("/with/reportEnroll.do")
	public ModelAndView reportEnroll(@RequestParam int bno,ModelAndView mv) {
		
		mv.addObject("withBoard",service.selectOneWith(bno));
		mv.setViewName("with/withReport");		
		return mv;
	}
	
	@RequestMapping("/with/reportEnrollEnd.do")
	@ResponseBody
	public int reportEnrollEnd(@RequestParam int wbNo,
								@RequestParam String memberId,
								@RequestParam String wrContent) {
		WithReport wr = new WithReport();
		wr.setWbNo(wbNo);
		//까먹지 말자! 여기는 글 쓴 사람(신고당하는 사람)이 아니라 신고하는 사람의 memberId가 들어와야 한다.
		wr.setMemberId(memberId);
		wr.setWrContent(wrContent);
		int result = service.insertWithReport(wr);
	
		return result;
	}
	
	@RequestMapping("/with/withUpdateEnd.do")
	public ModelAndView withUpdateEnd(WithBoard wb, ModelAndView mv) {		
		int result = service.updateWith(wb);
		if(result>0) {
			mv.addObject("msg","성공적으로 수정했습니다.");
			mv.addObject("subMsg","함께해요 메인화면으로 전환합니다.");
			mv.addObject("status","success");
			mv.addObject("loc","/with/withList.do");
		}else {
			mv.addObject("msg","게시글 수정 실패!");
			mv.addObject("subMsg","다시 시도하신 후 관리자에게 문의해주세요.");
			mv.addObject("status","error");
			mv.addObject("loc","/with/withList.do");
		}
		mv.setViewName("common/sweetMsg");
		return mv;
	}
	
	@RequestMapping("/with/withChat.do")
	public ModelAndView withChatEnroll(@RequestParam int wbNo, ModelAndView mv) {
		mv.addObject("withBoard",service.selectOneWith(wbNo));
		mv.setViewName("with/withChat");
		return mv;
	}
	
	
}
