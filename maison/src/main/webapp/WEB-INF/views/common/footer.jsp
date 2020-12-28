<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<!-- 우리 기준 추천상품 보이는 곳 -->
<!-- Start Instagram Feed  -->
<div class="instagram-box">
    <div class="main-instagram owl-carousel owl-theme">
<%--         <div class="item">
            <div class="ins-inner-box">
                <img src="<%=request.getContextPath() %>/resources/images/instagram-img-01.jpg" alt="" />
          <div class="type-lb">
              <p class="sale">NEW</p><!-- 일주일 지나면 buy now! -->
          </div>
            </div>
        </div> --%>
        <div class="item">
            <div class="ins-inner-box">
                <img src="<%=request.getContextPath() %>/resources/upload/product/2020_12_02_093321816_865.png" alt="" />
                <div class="hov-in">
                    <a href="${path }/shop/shopDetail.do?no=1"><i class="fas fa-check"></i></a>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="ins-inner-box">
                <img src="<%=request.getContextPath() %>/resources/upload/product/2020_12_17_114623855_432.png" alt="" />
                <div class="hov-in">
                    <a href="${path }/shop/shopDetail.do?no=3"><i class="fas fa-check"></i></a>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="ins-inner-box">
                <img src="<%=request.getContextPath() %>/resources/upload/product/2020_12_22_033232305_825.png" alt="" />
                <div class="hov-in">
                    <a href="${path }/shop/shopDetail.do?no=19"><i class="fas fa-check"></i></a>
                </div>
            </div>
        </div>
        <div class="item">
            <div class="ins-inner-box">
                <img src="<%=request.getContextPath() %>/resources/upload/product/2020_12_18_100230583_15.png" alt="" />
                <div class="hov-in">
                    <a href="${path }/shop/shopDetail.do?no=8"><i class="fas fa-check"></i></a>
                </div>
            </div>
        </div>        
        <div class="item">
            <div class="ins-inner-box">
                <img src="<%=request.getContextPath() %>/resources/upload/product/2020_12_08_232902839_101.png" alt="" />
                <div class="hov-in">
                    <a href="${path }/shop/shopDetail.do?no=7"><i class="fas fa-check"></i></a>
                </div>
            </div>
        </div> 
    </div>
</div>
<!-- End Instagram Feed  -->
<!-- Start Footer  -->
    <footer>
        <div class="footer-main">
            <div class="container">
				<div class="row">
					<div class="col-lg-4 col-md-12 col-sm-12">
						<div class="footer-top-box">
							<h3>Business Time</h3>
							<ul class="list-time">
								<li>Monday - Friday: 08.00am to 05.00pm</li> <li>Saturday: 10.00am to 08.00pm</li> <li>Sunday: <span>Closed</span></li>
							</ul>
						</div>
					</div>
					<div class="col-lg-4 col-md-12 col-sm-12">
						<div class="footer-top-box">
							<h3>Newsletter</h3>
							<form class="newsletter-box">
								<div class="form-group">
									<input class="" type="email" name="Email" placeholder="Email Address*" />
									<i class="fa fa-envelope"></i>
								</div>
								<button class="btn hvr-hover" type="submit">Submit</button>
							</form>
						</div>
					</div>
					<div class="col-lg-4 col-md-12 col-sm-12">
						<div class="footer-top-box">
							<h3>Social Media</h3>
							<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
							<ul>
                                <li><a href="#"><i class="fab fa-facebook" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fab fa-twitter" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fab fa-linkedin" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fab fa-google-plus" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fa fa-rss" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fab fa-pinterest-p" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fab fa-whatsapp" aria-hidden="true"></i></a></li>
                            </ul>
						</div>
					</div>
				</div>
				<hr>
                <div class="row">
                    <div class="col-lg-4 col-md-12 col-sm-12">
                        <div class="footer-widget">
                            <h4>About Freshshop</h4>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p> 
							<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. </p> 							
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-12 col-sm-12">
                        <div class="footer-link">
                            <h4>Information</h4>
                            <ul>
                                <li><a href="${path }/firstpage/about.do">About Us</a></li>
                                <li><a href="#">Customer Service</a></li>
                                <li><a href="#">Our Sitemap</a></li>
                                <li><a href="#">Terms &amp; Conditions</a></li>
                                <li><a href="#">Privacy Policy</a></li>
                                <li><a href="#">Delivery Information</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-12 col-sm-12">
                        <div class="footer-link-contact">
                            <h4>Contact Us</h4>
                            <ul>
                                <li>
                                    <p><i class="fas fa-map-marker-alt"></i>Address: Michael I. Days 3756 <br>Preston Street Wichita,<br> KS 67213 </p>
                                </li>
                                <li>
                                    <p><i class="fas fa-phone-square"></i>Phone: <a href="tel:+1-888705770">+1-888 705 770</a></p>
                                </li>
                                <li>
                                    <p><i class="fas fa-envelope"></i>Email: <a href="mailto:contactinfo@gmail.com">contactinfo@gmail.com</a></p>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- End Footer  -->
    <!-- Start copyright  -->
    <div class="footer-copyright">
        <p class="footer-company">All Rights Reserved. &copy; 2020 <a href="#">ThewayShop</a> Design By :
            <a href="https://html.design/">html design</a></p>
    </div>
    <!-- End copyright  -->
    <a href="#" id="back-to-top" title="Back to top" style="display: none;">&uarr;</a>

    <!-- ALL JS FILES -->
	<script
  src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"
  integrity="sha256-0YPKAwZP7Mp3ALMRVB2i8GXeEndvCq3eSl/WsAl1Ryk="
  crossorigin="anonymous"></script>
	<script src="<%=request.getContextPath() %>/resources/js/popper.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/bootstrap.min.js"></script>
    <!-- ALL PLUGINS -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.nicescroll/3.6.8-fix/jquery.nicescroll.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/jquery.superslides.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/bootstrap-select.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/inewsticker.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/bootsnav.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/images-loded.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/isotope.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/owl.carousel.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/baguetteBox.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/form-validator.min.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/contact-form-script.js"></script>
    <script src="<%=request.getContextPath() %>/resources/js/custom.js"></script>
<script>
function recentlyBuy(){
	$.ajax({
		url:'${path }/firstpage/recentlyBuy.do',
		type:'get',
		success:function(data){
			var d='';
			console.log(data);
		}
	})
}
</script>

</body>
</html>