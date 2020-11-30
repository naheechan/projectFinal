package com.kh.maison.admin.product.controller;

import java.awt.Window;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.maison.admin.product.model.service.ProductService;
import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.Product;

@Controller
@RequestMapping("/admin/product")
public class ProductController {

	@Autowired
	private ProductService service;
	/*
	 * @Autowired private Logger logger;
	 */
	
	//로그출력
	//private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	//productEnroll 페이지이동
	@RequestMapping("/productEnroll.do")
	public String moveEnroll(Model model) {
		List<Category> largeCate = service.selectCategory(null);
		
		model.addAttribute("largeCate",largeCate);
		System.out.println(largeCate.toString());
		return "admin/product/productEnroll";
	}
	
	
	//ajax로 카테고리 불러오기
	   @ResponseBody//data만준다고뷰에다가 
	   @RequestMapping("/category.do")
	   public String selectMediumCategory(@RequestParam(value="data", required=true)String data) throws Exception{
		   List<Category> list = null;
		   ObjectMapper mapper = new ObjectMapper();
		   String str = null;
	      System.err.println("category.do`s Data : " + data);
		   try {
			 list = service.selectMediumCategory(data);  
			 str = mapper.writeValueAsString(list);
			   
	      }catch(Exception e) {
	         e.printStackTrace();
	      }
		 
	      return str;//=success data
	   }
	   
	   //no값가져오기
	   @ResponseBody
	   @RequestMapping("/medicategory.do")
	   public String selectOneCategory(@RequestParam Map<String,Object> param) 
			   											throws JsonMappingException,JsonGenerationException,IOException{
		   System.out.println("in controller"+param);
		   Category c=null;
		   ObjectMapper mapper = new ObjectMapper();
		   try {
			   c = service.selectOneCategory(param);
			   System.out.println("medi in controll"+c);
		   }catch(Exception e) {
			   e.printStackTrace();
		   }
		   return mapper.writeValueAsString(c);
	   }
	
	   
	@RequestMapping("/imageUpload.do")
	public void imageUpload(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam MultipartFile upload)
	throws Exception{
		String saveDir = request.getServletContext().getRealPath("/resources/upload/product/");
        File dir = new File(saveDir);
        if(!dir.exists()) {
        	dir.mkdirs();
        }
        if(!upload.isEmpty()) {
        	String originalFileName =upload.getOriginalFilename();
        	String ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
        	SimpleDateFormat sdf = new SimpleDateFormat("yyyy_MM_dd_HHmmssSSS");
        	int rndNum = (int)(Math.random()*1000);
        	String renamedFileName = sdf.format(new Date(System.currentTimeMillis()))+"_"+rndNum+"."+ext;
        	try {
        		upload.transferTo(new File(saveDir+"/"+renamedFileName));
        	}catch(IOException e) {
        		e.printStackTrace();
        	}
        	
        	//클라이언트에게 결과 표시
	        String callback = request.getParameter("CKEditorFuncNum");
	        //서버->클라이언트 text전송
	        PrintWriter printWriter = response.getWriter();
	        String fileUrl = request.getContextPath() + "/resources/upload/product/" + renamedFileName;
	        printWriter.println("<script>window.parent.CKEDITOR.tools.callFunction(" + callback + ",'" + fileUrl
	                + "','successfully uploaded')" + "</script>");
	        printWriter.flush();	
        }
        
        
	}
	
	@RequestMapping("/enroll.do")
	public ModelAndView insertEnroll(Product pd, ModelAndView mv,MultipartFile imageFile,HttpServletRequest request)
	throws IllegalAccessException,IOException{
		// 파일 업로드 처리
//					String fileName=null;
//					MultipartFile uploadFile = pd.getProductImg();
//					if (!uploadFile.isEmpty()) {
//						String originalFileName = uploadFile.getOriginalFilename();
//						String ext = FilenameUtils.getExtension(originalFileName);	//확장자 구하기
//						UUID uuid = UUID.randomUUID();	//UUID 구하기
//						fileName=uuid+"."+ext;
//						uploadFile.transferTo(new File("D:\\upload\\" + fileName));
//					}
//					pd.setProductImg(fileName);
//					int result = service.insertEnroll(pd); 
//					return "redirect:getBoardList.do";

		System.out.println("파일명: "+imageFile.getOriginalFilename());
		System.out.println("파일크기 "+"파일크기: "+imageFile.getSize());
		System.out.println("상품이름: "+pd.getProductName());
		System.out.println("상품요약: "+pd.getProductSummary());
		System.out.println("상품상세: "+pd.getProductContent());
		System.out.println("category number:"+pd.getMediumCate());
		System.out.println("카테고리: "+pd.getMediumCate().split(",")[1]);
		String mediumCate = pd.getMediumCate().split(",")[1];
		System.out.println(mediumCate);
		pd.setMediumCate(mediumCate);
		
		//파일업로드처리 (업로드경로불러오기, 리네임처리후 파일저장하기)
//		MultipartFile productImg=pd.getProductImg();
		System.out.println("컨트롤러 "+imageFile);
		String saveDir = request.getServletContext().getRealPath("/resources/upload/product");
		File dir = new File(saveDir);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		if(!imageFile.isEmpty()) {
			//중복방지위해 리네임처리
			String originalFileName = imageFile.getOriginalFilename();
			String ext = originalFileName.substring(originalFileName.lastIndexOf(".")+1);
			SimpleDateFormat sdf= new SimpleDateFormat("yyyy_MM_dd_HHmmssSSS");
			int rndNum = (int)(Math.random()*1000);
			String renamedFileName=sdf.format(new Date(System.currentTimeMillis()))+"_"+rndNum+"."+ext;
			try {
				//renamedFileName으로 파일 저장
				imageFile.transferTo(new File(saveDir+"/"+renamedFileName));
			}catch(IOException e) {
				e.printStackTrace();
			}
			pd.setProductImg(renamedFileName);
		}
		int result = service.insertEnroll(pd);
		mv.addObject("msg",result>0?"등록성공":"등록실패");
		mv.addObject("loc","/");
		mv.setViewName("/common/msg");
		return mv;
		
	}
	
	@RequestMapping("/moveEnrollCate.do")
	public String moveEnrollCate(Model m) {
		
		return "admin/product/categoryEnroll";
	}
	
	@RequestMapping("/enrollCate.do")
	public String enrollCate(Category c, Model md) {
		
		int result = service.enrollCate(c);
		
		String msg="";
	
		
		if(result>0) {
			msg="카테고리등록성공";
		
		}else {
			msg="카테고리등록실패";
			
		}
		md.addAttribute("msg",msg);
	
		
		return "common/msg";
	}
	
}
