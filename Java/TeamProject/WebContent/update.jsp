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
									<li><a href="retrieve.do?num=${dto.num }">스케줄 ${dto.num }</a>
								</c:forEach>
							</ul>
						</div>											
					</div>
				</div>			
				<div class="col-lg-8 col-md-8 col-sm-8 col-xs-12 blog-post" id="scheform">
					<div id="writepg">
						<form action="update.do" method="post">
							<input type="hidden" name="num" value="${update.num }">
							<div class="form-horizontal">
								<h2>월요일</h2>
								<div class="form-inline form-group" style="padding-left: 30px">
									<div class="form-group">
										<label for="mon_athle1">1.</label>
										&nbsp;&nbsp;
										<input type="text" class="form-control" id="mon_athle1" name="mon_athle1_name" value="${update.mon_athle1_name }">
										&nbsp;&nbsp;
										<select class="form-control" name="mon_athle1_many">
											<option selected>${update.mon_athle1_many }</option>
											<option>5</option>
											<option>10</option>
											<option>15</option>
											<option>20</option>
											<option>25</option>
											<option>30</option>
											<option>35</option>
											<option>40</option>
										</select> 개
										&nbsp;&nbsp;
										<select class="form-control" name="mon_athle1_set">
											<option selected>${update.mon_athle1_set }</option>
											<option>3</option>
											<option>4</option>
											<option>5</option>
											<option>6</option>
											<option>7</option>
											<option>8</option>
											<option>9</option>
											<option>10</option>
										</select> 세트
									</div>
								</div>
								<div class="form-inline form-group" style="padding-left: 30px">
									<div class="form-group">
										<label for="mon_athle2">2.</label>
										&nbsp;&nbsp;
										<input type="text" class="form-control" id="mon_athle2" name="mon_athle2_name" value="${update.mon_athle2_name }">
										&nbsp;&nbsp;
										<select class="form-control" name="mon_athle2_many">
											<option selected>${update.mon_athle2_many }</option>
											<option>5</option>
											<option>10</option>
											<option>15</option>
											<option>20</option>
											<option>25</option>
											<option>30</option>
											<option>35</option>
											<option>40</option>
										</select> 개
										&nbsp;&nbsp;
										<select class="form-control" name="mon_athle2_set">
											<option selected>${update.mon_athle2_set }</option>
											<option>3</option>
											<option>4</option>
											<option>5</option>
											<option>6</option>
											<option>7</option>
											<option>8</option>
											<option>9</option>
											<option>10</option>
										</select> 세트
									</div>
								</div>
								<label for="mon_meal">식단</label>
								<textarea class="form-control" id="mon_meal" name="mon_meal" rows="6">${update.mon_meal }</textarea>
								</div>
							<br>
							<br>
							<div class="form-horizontal">
								<h2>화요일</h2>
								<div class="form-inline form-group" style="padding-left: 30px">
									<div class="form-group">
										<label for="tue_athle1">1.</label>
										&nbsp;&nbsp;
										<input type="text" class="form-control" id="tue_athle1" name="tue_athle1_name" value="${update.tue_athle1_name }">
										&nbsp;&nbsp;
										<select class="form-control" name="tue_athle1_many">
											<option selected>${update.tue_athle1_many }</option>
											<option>5</option>
											<option>10</option>
											<option>15</option>
											<option>20</option>
											<option>25</option>
											<option>30</option>
											<option>35</option>
											<option>40</option>
										</select> 개
										&nbsp;&nbsp;
										<select class="form-control" name="tue_athle1_set">
											<option selected>${update.tue_athle1_set }</option>
											<option>3</option>
											<option>4</option>
											<option>5</option>
											<option>6</option>
											<option>7</option>
											<option>8</option>
											<option>9</option>
											<option>10</option>
										</select> 세트
									</div>
								</div>
								<div class="form-inline form-group" style="padding-left: 30px">
									<div class="form-group">
										<label for="tue_athle2">2.</label>
										&nbsp;&nbsp;
										<input type="text" class="form-control" id="tue_athle2" name="tue_athle2_name" value="${update.tue_athle2_name }">
										&nbsp;&nbsp;
										<select class="form-control" name="tue_athle2_many">
											<option selected>${update.tue_athle2_many }</option>
											<option>5</option>
											<option>10</option>
											<option>15</option>
											<option>20</option>
											<option>25</option>
											<option>30</option>
											<option>35</option>
											<option>40</option>
										</select> 개
										&nbsp;&nbsp;
										<select class="form-control" name="tue_athle2_set">
											<option selected>${update.tue_athle2_set }</option>
											<option>3</option>
											<option>4</option>
											<option>5</option>
											<option>6</option>
											<option>7</option>
											<option>8</option>
											<option>9</option>
											<option>10</option>
										</select> 세트
									</div>
								</div>
								<label for="tue_meal">식단</label>
								<textarea class="form-control" id="tue_meal" name="tue_meal" rows="6">${update.tue_meal }</textarea>
								</div>
							<br>
							<br>
							<div class="form-horizontal">
								<h2>수요일</h2>
								<div class="form-inline form-group" style="padding-left: 30px">
									<div class="form-group">
										<label for="wed_athle1">1.</label>
										&nbsp;&nbsp;
										<input type="text" class="form-control" id="wed_athle1" name="wed_athle1_name" value="${update.wed_athle1_name }">
										&nbsp;&nbsp;
										<select class="form-control" name="wed_athle1_many">
											<option selected>${update.wed_athle1_many }</option>
											<option>5</option>
											<option>10</option>
											<option>15</option>
											<option>20</option>
											<option>25</option>
											<option>30</option>
											<option>35</option>
											<option>40</option>
										</select> 개
										&nbsp;&nbsp;
										<select class="form-control" name="wed_athle1_set">
											<option selected>${update.wed_athle1_set }</option>
											<option>3</option>
											<option>4</option>
											<option>5</option>
											<option>6</option>
											<option>7</option>
											<option>8</option>
											<option>9</option>
											<option>10</option>
										</select> 세트
									</div>
								</div>
								<div class="form-inline form-group" style="padding-left: 30px">
									<div class="form-group">
										<label for="wed_athle2">2.</label>
										&nbsp;&nbsp;
										<input type="text" class="form-control" id="wed_athle2" name="wed_athle2_name" value="${update.wed_athle2_name }">
										&nbsp;&nbsp;
										<select class="form-control" name="wed_athle2_many">
											<option selected>${update.wed_athle2_many }</option>
											<option>5</option>
											<option>10</option>
											<option>15</option>
											<option>20</option>
											<option>25</option>
											<option>30</option>
											<option>35</option>
											<option>40</option>
										</select> 개
										&nbsp;&nbsp;
										<select class="form-control" name="wed_athle2_set">
											<option selected>${update.wed_athle2_set }</option>
											<option>3</option>
											<option>4</option>
											<option>5</option>
											<option>6</option>
											<option>7</option>
											<option>8</option>
											<option>9</option>
											<option>10</option>
										</select> 세트
									</div>
								</div>
								<label for="wed_meal">식단</label>
								<textarea class="form-control" id="wed_meal" name="wed_meal" rows="6">${update.wed_meal }</textarea>
								</div>
							<br>
							<br><div class="form-horizontal">
								<h2>목요일</h2>
								<div class="form-inline form-group" style="padding-left: 30px">
									<div class="form-group">
										<label for="thu_athle1">1.</label>
										&nbsp;&nbsp;
										<input type="text" class="form-control" id="thu_athle1" name="thu_athle1_name" value="${update.thu_athle1_name }">
										&nbsp;&nbsp;
										<select class="form-control" name="thu_athle1_many">
											<option selected>${update.thu_athle1_many }</option>
											<option>5</option>
											<option>10</option>
											<option>15</option>
											<option>20</option>
											<option>25</option>
											<option>30</option>
											<option>35</option>
											<option>40</option>
										</select> 개
										&nbsp;&nbsp;
										<select class="form-control" name="thu_athle1_set">
											<option selected>${update.thu_athle1_set }</option>
											<option>3</option>
											<option>4</option>
											<option>5</option>
											<option>6</option>
											<option>7</option>
											<option>8</option>
											<option>9</option>
											<option>10</option>
										</select> 세트
									</div>
								</div>
								<div class="form-inline form-group" style="padding-left: 30px">
									<div class="form-group">
										<label for="thu_athle2">2.</label>
										&nbsp;&nbsp;
										<input type="text" class="form-control" id="thu_athle2" name="thu_athle2_name" value="${update.thu_athle2_name }">
										&nbsp;&nbsp;
										<select class="form-control" name="thu_athle2_many">
											<option selected>${update.thu_athle2_many }</option>
											<option>5</option>
											<option>10</option>
											<option>15</option>
											<option>20</option>
											<option>25</option>
											<option>30</option>
											<option>35</option>
											<option>40</option>
										</select> 개
										&nbsp;&nbsp;
										<select class="form-control" name="thu_athle2_set">
											<option selected>${update.thu_athle2_set }</option>
											<option>3</option>
											<option>4</option>
											<option>5</option>
											<option>6</option>
											<option>7</option>
											<option>8</option>
											<option>9</option>
											<option>10</option>
										</select> 세트
									</div>
								</div>
								<label for="thu_meal">식단</label>
								<textarea class="form-control" id="thu_meal" name="thu_meal" rows="6">${update.thu_meal }</textarea>
								</div>
							<br>
							<br>
							<div class="form-horizontal">
								<h2>금요일</h2>
								<div class="form-inline form-group" style="padding-left: 30px">
									<div class="form-group">
										<label for="fri_athle1">1.</label>
										&nbsp;&nbsp;
										<input type="text" class="form-control" id="fri_athle1" name="fri_athle1_name" value="${update.fri_athle1_name }">
										&nbsp;&nbsp;
										<select class="form-control" name="fri_athle1_many">
											<option selected>${update.fri_athle1_many }</option>
											<option>5</option>
											<option>10</option>
											<option>15</option>
											<option>20</option>
											<option>25</option>
											<option>30</option>
											<option>35</option>
											<option>40</option>
										</select> 개
										&nbsp;&nbsp;
										<select class="form-control" name="fri_athle1_set">
											<option selected>${update.fri_athle1_set }</option>
											<option>3</option>
											<option>4</option>
											<option>5</option>
											<option>6</option>
											<option>7</option>
											<option>8</option>
											<option>9</option>
											<option>10</option>
										</select> 세트
									</div>
								</div>
								<div class="form-inline form-group" style="padding-left: 30px">
									<div class="form-group">
										<label for="fri_athle2">2.</label>
										&nbsp;&nbsp;
										<input type="text" class="form-control" id="fri_athle2" name="fri_athle2_name" value="${update.fri_athle2_name }">
										&nbsp;&nbsp;
										<select class="form-control" name="fri_athle2_many">
											<option selected>${update.fri_athle2_many }</option>
											<option>5</option>
											<option>10</option>
											<option>15</option>
											<option>20</option>
											<option>25</option>
											<option>30</option>
											<option>35</option>
											<option>40</option>
										</select> 개
										&nbsp;&nbsp;
										<select class="form-control" name="fri_athle2_set">
											<option selected>${update.fri_athle2_set }</option>
											<option>3</option>
											<option>4</option>
											<option>5</option>
											<option>6</option>
											<option>7</option>
											<option>8</option>
											<option>9</option>
											<option>10</option>
										</select> 세트
									</div>
								</div>
								<label for="fri_meal">식단</label>
								<textarea class="form-control" id="fri_meal" name="fri_meal" rows="6">${update.fri_meal }</textarea>
								</div>
							<br>
							<br>
							<div class="form-horizontal">
								<h2>토요일</h2>
								<div class="form-inline form-group" style="padding-left: 30px">
									<div class="form-group">
										<label for="sat_athle1">1.</label>
										&nbsp;&nbsp;
										<input type="text" class="form-control" id="sat_athle1" name="sat_athle1_name" value="${update.sat_athle1_name }">
										&nbsp;&nbsp;
										<select class="form-control" name="sat_athle1_many">
											<option selected>${update.sat_athle1_many }</option>
											<option>5</option>
											<option>10</option>
											<option>15</option>
											<option>20</option>
											<option>25</option>
											<option>30</option>
											<option>35</option>
											<option>40</option>
										</select> 개
										&nbsp;&nbsp;
										<select class="form-control" name="sat_athle1_set">
											<option selected>${update.sat_athle1_set }</option>
											<option>3</option>
											<option>4</option>
											<option>5</option>
											<option>6</option>
											<option>7</option>
											<option>8</option>
											<option>9</option>
											<option>10</option>
										</select> 세트
									</div>
								</div>
								<div class="form-inline form-group" style="padding-left: 30px">
									<div class="form-group">
										<label for="sat_athle2">2.</label>
										&nbsp;&nbsp;
										<input type="text" class="form-control" id="sat_athle2" name="sat_athle2_name" value="${update.sat_athle2_name }">
										&nbsp;&nbsp;
										<select class="form-control" name="sat_athle2_many">
											<option selected>${update.sat_athle2_many }</option>
											<option>5</option>
											<option>10</option>
											<option>15</option>
											<option>20</option>
											<option>25</option>
											<option>30</option>
											<option>35</option>
											<option>40</option>
										</select> 개
										&nbsp;&nbsp;
										<select class="form-control" name="sat_athle2_set">
											<option selected>${update.sat_athle2_set }</option>
											<option>3</option>
											<option>4</option>
											<option>5</option>
											<option>6</option>
											<option>7</option>
											<option>8</option>
											<option>9</option>
											<option>10</option>
										</select> 세트
									</div>
								</div>
								<label for="sat_meal">식단</label>
								<textarea class="form-control" id="sat_meal" name="sat_meal" rows="6">${update.sat_meal }</textarea>
								</div>
							<br>
							<br>
							<div class="form-horizontal">
								<h2>일요일</h2>
								<div class="form-inline form-group" style="padding-left: 30px">
									<div class="form-group">
										<label for="sun_athle1">1.</label>
										&nbsp;&nbsp;
										<input type="text" class="form-control" id="sun_athle1" name="sun_athle1_name" value="${update.sun_athle1_name }">
										&nbsp;&nbsp;
										<select class="form-control" name="sun_athle1_many">
											<option selected>${update.sun_athle1_many }</option>
											<option>5</option>
											<option>10</option>
											<option>15</option>
											<option>20</option>
											<option>25</option>
											<option>30</option>
											<option>35</option>
											<option>40</option>
										</select> 개
										&nbsp;&nbsp;
										<select class="form-control" name="sun_athle1_set">
											<option selected>${update.sun_athle1_set }</option>
											<option>3</option>
											<option>4</option>
											<option>5</option>
											<option>6</option>
											<option>7</option>
											<option>8</option>
											<option>9</option>
											<option>10</option>
										</select> 세트
									</div>
								</div>
								<div class="form-inline form-group" style="padding-left: 30px">
									<div class="form-group">
										<label for="sun_athle2">2.</label>
										&nbsp;&nbsp;
										<input type="text" class="form-control" id="sun_athle2" name="sun_athle2_name" value="${update.sun_athle2_name }">
										&nbsp;&nbsp;
										<select class="form-control" name="sun_athle2_many">
											<option selected>${update.sun_athle2_many }</option>
											<option>5</option>
											<option>10</option>
											<option>15</option>
											<option>20</option>
											<option>25</option>
											<option>30</option>
											<option>35</option>
											<option>40</option>
										</select> 개
										&nbsp;&nbsp;
										<select class="form-control" name="sun_athle2_set">
											<option selected>${update.sun_athle2_set }</option>
											<option>3</option>
											<option>4</option>
											<option>5</option>
											<option>6</option>
											<option>7</option>
											<option>8</option>
											<option>9</option>
											<option>10</option>
										</select> 세트
									</div>
								</div>
								<label for="sun_meal">식단</label>
								<textarea class="form-control" id="sun_meal" name="sun_meal" rows="6">${update.sun_meal }</textarea>
								</div>
							<br>
							<br>
							<div style="text-align: right; letter-spacing: 15px">
								<input type="submit" class="btn btn-success" value="수정">
								<input type="button" class="btn btn-default" value="취소" onclick="location.href='list.do'">
							</div>
						</form>
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
