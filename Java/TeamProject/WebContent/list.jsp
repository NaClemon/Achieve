<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
    <%@ page import="java.io.PrintWriter"%> 
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1.0" >        
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/owl.carousel.min.css">
<link rel="stylesheet" href="css/flaticon.css">
<link rel="stylesheet" href="css/animate.css">
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="css/meanmenu.min.css">
<link rel="stylesheet" href="css/responsive.css">	
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
<header>
     <div class="mnmenu-sec">
			<div class="container">
				<div class="row">
					<div class="col-md-3">
						<div class="logo">
							<a href="main_temp.jsp"><img src="img/logo.png" alt=""/></a>
						</div>
					</div>	
            <div class="col-md-9">
            	<div class="menu">
					<nav id="main-menu" class="main-menu">
						<ul>
							<li><a href="logoutAction.jsp">로그아웃</a></li>
																					
							<li><a href="blog.html">마이페이지<i class="fa fa-caret-down"></i></a>
								<ul>
									<li><a href="blog.html">회원정보</a></li>
									<li><a href="blog-details.html">신체스펙</a></li>
								</ul>								
							</li>
							<li class="active"><a href="list.do">스케줄 관리</a></li>
						</ul>
					</nav>			
				</div>						
			 </div>
			 </div>
			</div>	
		</div>
</header>
<!-- Slider Section Start -->
	<div class="slider">
		<div class="all-slide owl-item">					
			<div class="single-slide" style="background-image:url(img/운동자극.jpg);">
				<div class="slider-overlay"></div>
				<div class="slider-text">					
					<h1>안녕하세요 첫번째 그림입니다.</h1>
					<p>동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라만세</p>
					<ul>
						<li><a href="">Contact Us</a></li>
						<li><a href="">Learn More</a></li>
					</ul>
				</div>
			</div>			
			<div class="single-slide" style="background-image:url(img/운동자극2.jpg);">
				<div class="slider-overlay"></div>
				<div class="slider-text">					
					<h1>안녕하세요 두번째 그림입니다.</h1>
					<p>동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라만세</p>
					<ul>
						<li><a href="">About Us</a></li>
						<li><a href="">Contact Us</a></li>
					</ul>
				</div>
			</div>																
		</div>
	</div>
	<!-- Slider Section End -->	
	
	<!-- Blog Section Start -->
	<div class="blog-sec pt-100 pb-70">
		<div class="container">
			<div class="row">	
				<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12" id="schedulelist">
					<div class="sidebar">
						<div class="widget-archive">
							<h1>개인 스케줄
							<a class="btn btn-default btn-xs" href="writeui.do" style="float: right">Add</a>
                            </h1>
							<ul>
								<c:forEach items="${list }" var="dto">
								<li><a href="retrieve.do?num=${dto.num }">스케줄 ${dto.num }</a></li>
								</c:forEach>
							</ul>
						</div>											
					</div>
				</div>						
			</div>
		</div>
	</div>
	<!-- Blog Section End -->
	<!-- Footer Section Start -->
	<footer>	
		<!-- Footer Top Start-->
		<div class="footer-area">
			<div class="container">
				<div class="row">	
					<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">		
						<div class="about-widget">
							<h2>ABOUT Us</h2>
							<p>Lorem ipsum dolor sit amet, adipiscing elit. Quid vero? Ex eorum enim scriptis et institutis cum omnis,Lorem ipsum dolor sit amet, adipiscing elit. </p>								
							<p>Lorem ipsum dolor sit amet, adipiscing elit. Quid vero? Ex eorum enim scriptis et institutis cum omnis,Lorem ipsum dolor sit amet, adipiscing elit. Quid vero? Ex eorum enim scriptis et institutis cum omnis. Lorem ipsum dolor sit amet </p>
							<ul>
							  <li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
							  <li><a href="#"><i class="fa fa-pinterest-p" aria-hidden="true"></i></a></li>
							  <li><a href="#"><i class="fa fa-youtube-play" aria-hidden="true"></i></a></li>
							  <li><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
							  <li><a href="#"><i class="fa fa-google-plus" aria-hidden="true"></i></a></li>
							</ul>
						</div>											
					</div>					
					<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">	
						<div class="flicker-photo">
							<h2>Flicker Photo</h2>
							<ul>
								<li><img src="img/1.jpg" alt=""/></li>
								<li><img src="img/2.jpg" alt=""/></li>
								<li><img src="img/3.jpg" alt=""/></li>
								<li><img src="img/4.jpg" alt=""/></li>
								<li><img src="img/5.jpg" alt=""/></li>
								<li><img src="img/6.jpg" alt=""/></li>
								<li><img src="img/7.jpg" alt=""/></li>
								<li><img src="img/8.jpg" alt=""/></li>
								<li><img src="img/9.jpg" alt=""/></li>
								<li><img src="img/10.jpg" alt=""/></li>
								<li><img src="img/11.jpg" alt=""/></li>
								<li><img src="img/12.jpg" alt=""/></li>
							</ul>
						</div>											
					</div>						
					<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">	
						<div class="barber-price">
							<h2>Top Prices</h2>
							<ul>
								<li>Trim your Hair <span>from $40</span></li>
								<li>Trim your Beard <span>from $15</span></li>
								<li>Special Beard Treatment<span>from $59</span></li>
								<li>Color your Beard<span>from $69</span></li>
								<li>Wax your Beard <span>from $79</span></li>
								<li>Complete Treatment <span>from $99</span></li>
								<li>Trim your Beard <span>from $44</span></li>
							</ul>
						</div>											
					</div>																				
				</div>					
			</div>
		</div>			
		<!-- Footer Top Area End-->		
		<!-- Footer Bottom Section Start -->
		<div class="footer-bottom-sec">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="copy-right">
							<p>&copy; 2018 All Right Reserved.</p>
						</div>
					</div>					
				</div>
			</div>
		</div>
		<!-- Footer Bottom Section End -->
	</footer>
	<!-- Footer Section End -->
	
	
	
	
	
	

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<script src="js/jquery-2.2.4.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/owl.animate.js"></script>
<script src="js/isotope.pkgd.min.js"></script>
<script src="js/jquery.scrollUp.min.js"></script>
<script src="js/jquery.counterup.min.js"></script>
<script src="js/modernizr.min.js"></script>
<script src="js/waypoints.min.js"></script>
<script src="js/jquery.meanmenu.min.js"></script>
<script src="js/custom.js"></script>
</body>
</html>
