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
<link rel="stylesheet" href="css/style.css">
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
							<a href="main_temp.jsp"><img src="img/logo4.png"  width = "100" height="20"  alt=""/></a>
						</div>
					</div>	
            <div class="col-md-9">
            	<div class="menu">
					<nav id="main-menu" class="main-menu">
						<ul>
							<li><a href="logoutAction.jsp">로그아웃</a></li>
																					
							
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
					<h1>Welcome to Exercise scheduling homepage </h1>
					<p>Do you want to be physically fit? It starts now.</p>
			
				</div>
			</div>			
			<div class="single-slide" style="background-image:url(img/운동자극2.jpg);">
				<div class="slider-overlay"></div>
				<div class="slider-text">					
					<h1>Make your own exercise schedule.</h1>
					<p>You are cool to exercise.</p>
				
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
									<li><a href="retrieve.do?num=${dto.num }">스케줄 ${dto.num }</a>
								</c:forEach>
							</ul>
						</div>											
					</div>
				</div>			
				<div class="col-lg-8 col-md-8 col-sm-8 col-xs-12 blog-post" id="scheform">
					<div id="writepg">
						<div>
							<table class="table table-borderd">
								<tr class="success">
									<th></th>
									<th>월</th>
									<th>화</th>
									<th>수</th>
								</tr>
								<tr>
									<th>운동</th>
									<td>${retrieve.mon_athle1_name }/${retrieve.mon_athle1_many }/${retrieve.mon_athle1_set }<br>
										${retrieve.mon_athle2_name }/${retrieve.mon_athle2_many }/${retrieve.mon_athle2_set }</td>
									<td>${retrieve.tue_athle1_name }/${retrieve.tue_athle1_many }/${retrieve.tue_athle1_set }<br>
										${retrieve.tue_athle2_name }/${retrieve.tue_athle2_many }/${retrieve.tue_athle2_set }</td>
									<td>${retrieve.wed_athle1_name }/${retrieve.wed_athle1_many }/${retrieve.wed_athle1_set }<br>
										${retrieve.wed_athle2_name }/${retrieve.wed_athle2_many }/${retrieve.wed_athle2_set }</td>
								</tr>
								<tr>
									<th>식단</th>
									<td>${retrieve.mon_meal }</td>
									<td>${retrieve.tue_meal }</td>
									<td>${retrieve.wed_meal }</td>
								</tr>
								<tr class="success">
									<th></th>
									<th>목</th>
									<th>금</th>
									<th>토</th>
								</tr>
								<tr>
									<th>운동</th>
									<td>${retrieve.thu_athle1_name }/${retrieve.thu_athle1_many }/${retrieve.thu_athle1_set }<br>
										${retrieve.thu_athle2_name }/${retrieve.thu_athle2_many }/${retrieve.thu_athle2_set }</td>
									<td>${retrieve.fri_athle1_name }/${retrieve.fri_athle1_many }/${retrieve.fri_athle1_set }<br>
										${retrieve.fri_athle2_name }/${retrieve.fri_athle2_many }/${retrieve.fri_athle2_set }</td>
									<td>${retrieve.sat_athle1_name }/${retrieve.sat_athle1_many }/${retrieve.sat_athle1_set }<br>
										${retrieve.sat_athle2_name }/${retrieve.sat_athle2_many }/${retrieve.sat_athle2_set }</td>
								</tr>
								<tr>
									<th>식단</th>
									<td>${retrieve.thu_meal }</td>
									<td>${retrieve.fri_meal }</td>
									<td>${retrieve.sat_meal }</td>
								</tr>
								<tr class="success">
									<th></th>
									<th>일</th>
								</tr>
								<tr>
									<th>운동</th>
									<td>${retrieve.sun_athle1_name }/${retrieve.sun_athle1_many }/${retrieve.sun_athle1_set }<br>
										${retrieve.sun_athle2_name }/${retrieve.sun_athle2_many }/${retrieve.sun_athle2_set }</td>
								</tr>
								<tr>
									<th>식단</th>
									<td>${retrieve.sun_meal }</td>
								</tr>
							</table>
						</div>
						<br>
						<div style="text-align: right; letter-spacing: 15px">
							<input type="button" class="btn btn-warning" value="수정" onclick="location.href='updateui.do?num=${retrieve.num }'">
							<input type="button" class="btn btn-danger" value="삭제" onclick="location.href='delete.do?num=${retrieve.num },userID=${retrieve.userID }'">
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
							<p>우리는 사용자에게 사용자가 원하는 운동 유형에 따른 식단정보와 운동방법을 제공해줍니다. 사용자는 자신의 운동 스케줄표를 작성하고 운동, 식단 리스트를 만들어 원할때 볼 수 있습니다. </p>								
							<p>우리 홈페이지를 통해 원하는 운동(다이어트, 체력증진, 벌크업)목표를 이루었으면 좋겠습니다. 자기관리를 하는 사람은 멋있습니다. 이 홈페이지를 들어온 당신은 이미 멋진 사람입니다. 모두 화이팅 하십시오.</p>
							<ul>
							  <li><a href="http://www.facebook.com"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
							  <li><a href="https://www.pinterest.co.kr/"><i class="fa fa-pinterest-p" aria-hidden="true"></i></a></li>
							  <li><a href="https://www.youtube.com/"><i class="fa fa-youtube-play" aria-hidden="true"></i></a></li>
							  <li><a href="https://www.instagram.com/"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
							  <li><a href="https://www.google.co.kr/"><i class="fa fa-google-plus" aria-hidden="true"></i></a></li>
							</ul>
						</div>											
					</div>					
					<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">	
						<div class="flicker-photo">
							<h2>Member Photo</h2>
							<ul>
								<li><img src="img/자극/자극5.jpg" width="80" height="80" alt=""/></li>
								<li><img src="img/자극/자극6.jpg" width="80" height="80" alt=""/></li>
								<li><img src="img/자극/자극3.jpg" width="80" height="80" alt=""/></li>
								<li><img src="img/자극/자극4.jpg" width="80" height="80" alt=""/></li>
								<li><img src="img/자극/자극1.jpg" width="80" height="80" alt=""/></li>
								<li><img src="img/자극/자극2.jpg" width="80" height="80" alt=""/></li>
								<li><img src="img/자극/자극7.jpg" width="80" height="80" alt=""/></li>
								<li><img src="img/자극/자극8.jpg" width="80" height="80" alt=""/></li>
								<li><img src="img/자극/자극12.jpg" width="80" height="80" alt=""/></li>
								<li><img src="img/자극/자극10.jpg" width="80" height="80" alt=""/></li>
								<li><img src="img/자극/자극11.jpg" width="80" height="80" alt=""/></li>
								<li><img src="img/자극/자극9.jpg" width="80" height="80" alt=""/></li>
							</ul>
						</div>											
					</div>						
					<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">	
						<div class="barber-price">
							<h2>A good trainer</h2>
							<ul>
								<li>Jaewoong <span>Rank : 1</span></li>
								<li>Wooseok <span>Rank : 2</span></li>
								<li>Kwangho <span>Rank : 3</span></li>
								<li>Hyunah <span>Rank : 4</span></li>
								<li>Seung Won<span>Rank : 5</span></li>
								<li>Irene <span>Rank : 6</span></li>
								<li>Woobin <span>Rank : 7</span></li>
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
							<p>&copy; 2018 OpenSource Team Project</p>
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
