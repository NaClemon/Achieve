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
