package com.kh.maison.admin.product.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

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

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.maison.admin.product.model.service.ProductAdminService;
import com.kh.maison.admin.product.model.vo.Category;
import com.kh.maison.admin.product.model.vo.Product;
import com.kh.maison.admin.product.model.vo.ProductCate;

@Controller
@RequestMapping("/admin/product")
public class ProductAdminController {

	@Autowired
	private ProductAdminService service;
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
		
		return "admin/product/productEnroll";
	}
	
	
	//ajax로 카테고리 불러오기
	   @ResponseBody//data만준다고뷰에다가 
	   @RequestMapping("/category.do")
	   public String selectMediumCategory(@RequestParam(value="data", required=true)String data) throws Exception{
		   List<Category> list = null;
		   ObjectMapper mapper = new ObjectMapper();
		   String str = null;
	      
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
		   
		   Category c=null;
		   ObjectMapper mapper = new ObjectMapper();
		   try {
			   c = service.selectOneCategory(param);
			   
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

		/*
		 * System.out.println("파일명: "+imageFile.getOriginalFilename());
		 * System.out.println("파일크기 "+"파일크기: "+imageFile.getSize());
		 * System.out.println("상품이름: "+pd.getProductName());
		 * System.out.println("상품요약: "+pd.getProductSummary());
		 * System.out.println("상품상세: "+pd.getProductContent());
		 * System.out.println("category number:"+pd.getMediumCate());
		 * System.out.println("카테고리: "+pd.getMediumCate().split(",")[1]);
		 */
		String mediumCate = pd.getMediumCate().split(",")[1];
		
		pd.setMediumCate(mediumCate);
		
		//파일업로드처리 (업로드경로불러오기, 리네임처리후 파일저장하기)
//		MultipartFile productImg=pd.getProductImg();
		
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
		mv.addObject("loc","/shop/shopView.do");
		mv.setViewName("/common/msg");
		return mv;
		
	}
	
	@RequestMapping("/moveEnrollCate.do")
	public String moveEnrollCate(Model m) {
		
		return "admin/product/categoryEnroll";
	}
	//카테고리 등록 medicate가지고오기
	@ResponseBody
	@RequestMapping("/selectMedicate.do")
	public String  selectMedicate(ModelAndView mv,@RequestParam(value="large")String largeCate) throws Exception {
		 List<Category> c=null;
		   ObjectMapper mapper = new ObjectMapper();
		   try {
			   c = service.selectMediumCategory(largeCate);
			   
		   }catch(Exception e) {
			   e.printStackTrace();
		   }
		   return mapper.writeValueAsString(c);
	}
	
	//카테고리등록
	@ResponseBody
	@RequestMapping("/enrollCate.do")
	public int enrollCate(@RequestParam(value="largeCate") String largeCate,@RequestParam(value="mcName") String mcName, Model md) {
		
		Category c = new Category();
		c.setLargeCate(largeCate);
		c.setMcName(mcName);
		
		int result = service.enrollCate(c);
		
		
		return result;
	}
	
	//상품등록수정내용불러오기 productAdminController
	@RequestMapping("/productView.do")
	public ModelAndView productView(ModelAndView mv,@RequestParam(value="no") int no) {
		List<ProductCate> list = service.productView(no);
		
		mv.addObject("list",list);
		mv.setViewName("admin/product/productView");
		return mv;
	}
	
	@RequestMapping("/update.do")
	public String productUpdate(Model m, @RequestParam(value="no") int no) {
		List<Category> largeCate = service.selectCategory(null);
		List<ProductCate> list = service.productView(no);
		
		m.addAttribute("largeCate",largeCate);
		m.addAttribute("list",list);
		return "admin/product/productUpdate";
	}
	
	@RequestMapping("/updateEnroll.do")
	public ModelAndView updateEnroll(Product pd, @RequestParam(value="no") int no,ModelAndView mv,MultipartFile imageFile,HttpServletRequest request)
			throws IllegalAccessException,IOException{
				pd.setProductNo(no);
				String mediumCate = pd.getMediumCate().split(",")[1];
				
				pd.setMediumCate(mediumCate);
				
				//파일업로드처리 (업로드경로불러오기, 리네임처리후 파일저장하기)
//				MultipartFile productImg=pd.getProductImg();
				
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
				int result = service.updateEnroll(pd);
				mv.addObject("msg",result>0?"수정성공":"수정실패");
				mv.addObject("loc","/admin/mypage/product/enrollView.do");
				mv.setViewName("/common/msg");
				return mv;
	}
	
}
