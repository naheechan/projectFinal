package com.kh.maison.qnaBoard.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.maison.qnaBoard.model.service.QnaBoardService;
import com.kh.maison.qnaBoard.model.vo.QnaBoardVo;
import com.kh.maison.qnaBoard.model.vo.QnaCommentVo;
import com.kh.spring.common.PageBarFactory;

@Controller
public class QnaBoardController {
	
	@Autowired 
	private QnaBoardService service;
	

	
	@RequestMapping("/qnaboard/qnaboardList.do")
	public ModelAndView qnaBoardList(ModelAndView mv, 
			@RequestParam(value="cPage", required=false, defaultValue="1") int cPage, 
			@RequestParam(value="numPerPage", required=false, defaultValue="10") int numPerPage) {
		
		List<QnaBoardVo> list=service.selectList(cPage,numPerPage);
		int totalData=service.selectCount();
		
		mv.addObject("pageBar",PageBarFactory.getPageBar(totalData, cPage, numPerPage, "qnaboardList.do"));
		mv.addObject("cPage",cPage);
		mv.addObject("totalData",totalData);
		mv.addObject("list",list);
		mv.setViewName("qnaBoard/qnaBoardList");
		
		return mv;
	}
	
	@RequestMapping("/qnaboard/qnaboardEnroll.do")
	public ModelAndView qnaBoardEnroll(ModelAndView mv) {
		
		
		mv.setViewName("/qnaBoard/qnaBoardEnroll");
	
		return mv;
	}
	@RequestMapping("/qnaBoard/imageUpload.do")
	 public void imageUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload)
	    //MultipartFile 타입은 ckedit에서 upload란 이름으로 저장하고 있음. 변경하면 안됨!!
	            throws Exception {
	 	 	//파일이 업로드될 위치        
	        String saveDir = request.getServletContext().getRealPath("/resources/upload/qnaBoard/");
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
		        String fileUrl = request.getContextPath() + "/resources/upload/qnaBoard/" + renamedFileName;
		        printWriter.println("<script>window.parent.CKEDITOR.tools.callFunction(" + callback + ",'" + fileUrl
		                + "','successfully uploaded')" + "</script>");
		        printWriter.flush();	
	        }
	        //얘네는 파일을 업로드하고, textarea안에 들어갈 html형태의 데이터에 img태그를 추가해주는 것까지만 해줄뿐,
	        // 이제 이걸가지고 data를 저장하고 불러오는걸 하면됩니당
	        
	    }
	
	@RequestMapping("/qnaBoard/insertQna.do")
	public ModelAndView qnaBoardInsert(QnaBoardVo QB,ModelAndView mv, 
			@RequestParam(value="cPage", required=false, defaultValue="1") int cPage, 
			@RequestParam(value="numPerPage", required=false, defaultValue="10") int numPerPage) {
		System.out.println(QB);
		int result=service.insertQnaBoard(QB);
		
		List<QnaBoardVo> list=service.selectList(cPage,numPerPage);
		
		mv.addObject("list",list);
		mv.setViewName("redirect:/qnaboard/qnaboardList.do");
		return mv;
		
	}
	@RequestMapping("/qnaBoard/popup.do")
	public ModelAndView qnaBoardInsert(int no,String pw,ModelAndView mv) {
		System.out.println(no);
		mv.addObject("qnaNo",no);
		mv.addObject("qnaPw", pw);
		mv.setViewName("/qnaBoard/popUp");
		return mv;
		
	}
	
	@RequestMapping("/qnaBoard/qnaBoardView")
	public ModelAndView qnaBoardView(int no,ModelAndView mv) {
		mv.addObject("qnaBoard", service.selectQna(no));
		mv.addObject("qnaNo",no);
		mv.setViewName("/qnaBoard/qnaBoardView");
		return mv;
	}
	
	
	@RequestMapping("/qnaBoard/commentEnroll.do")
	@ResponseBody
    public int commentInsert(int bno,String content) {
		QnaCommentVo comment=new QnaCommentVo();
		comment.setQnaNo(bno);
		comment.setQcContent(content);
        	
		int result=service.commentInsertService(comment);
		
		if(result>0) {
			int upresult=service.updateStatus(bno);
		}
    
			return result;
    }
	
	@RequestMapping("/qnaBoard/commentList.do")
	@ResponseBody
    public List<QnaCommentVo> commentInsert(Model model,int bno) {
    
			return service.commentListService(bno);
    }
	
	
	
	@RequestMapping("/qnaboard/myQna.do")
	public ModelAndView myQna(ModelAndView mv, 
			@RequestParam(value="cPage", required=false, defaultValue="1") int cPage, 
			@RequestParam(value="numPerPage", required=false, defaultValue="10") int numPerPage) {
		
		List<QnaBoardVo> list=service.selectList(cPage,numPerPage);
		int totalData=service.selectCount();
		
		mv.addObject("pageBar",PageBarFactory.getPageBar(totalData, cPage, numPerPage, "qnaboardList.do"));
		mv.addObject("cPage",cPage);
		mv.addObject("totalData",totalData);
		mv.addObject("list",list);
		mv.setViewName("qnaBoard/myQna");
		
		return mv;
	}
	
}

	
	












