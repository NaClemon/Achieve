<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
    <%@ page import="java.io.PrintWriter"%>  
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
<title>회원가입</title>
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
									<li class="active"><a href="login.jsp">로그인</a></li> 
														
									<li><a href="join_temp.jsp">회원가입</a></li>															
									
									
								</ul>
							</nav>			
						</div>						
					</div>					
				</div>
			</div>	
		</div>
		</header>
		
		<!-- 여기부분에 회원가입하는 부분 들어와야함 -->

	<div class="appoitment-area pt-100 pb-70">
		<div class="join_images-overlay"></div>
		<div class="container">
			<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="sec-title">
						<h1>회원가입</h1>
						<div class="border-shape"></div>
						<p>회원님의 간단한 개인정보를 입력해주세요.</p>
					</div>
				</div>
			</div>			
			<div class="row">	
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 " style ="padding-left: 10%">
					<div class="appointment-form">		
						<form>
							<fieldset>
								<!-- 아이디  -->
								
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="sngl-field">
										<input placeholder="아이디" name ="userID"  type="text" style="width: 40%">
								</div>
								</div>
								<!-- 비밀 번호 -->
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="sngl-field">
										<input placeholder="비밀 번호" name ="userPassword"  type="password" style="width: 40%">
								</div>
								</div>
								
							
							<!-- 입력된 비밀번호랑 맞는지 확인하는 거 구현해놓기 -->
							
							<!-- 이름 -->
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="sngl-field">
										<input placeholder="이름" name ="userName"  type="text" style="width: 40%">
									</div>
								</div>
							
							
							<!-- 이메일 주소 -->						
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="sngl-field">
										<input placeholder="E-mail" name="userEmail" type="email" style="width: 40%">
									</div>
								</div>	
																							
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="sngl-field">
										<input placeholder="Phone" name="number" type="text" style="width: 40%">
									</div>
								</div>	
								
								<p style="color: white"><b>---------선택적 입력사항입니다.---------</b></p>
								
								<!-- 성별 입력하는 부분 -->
								 <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style ="padding-left: 12%" >
								 <div class="sngl-field">
                    			<div class = "btn-group" data-toggle="buttons" >
                    				<label class = "btn btn-primary active">
                    			<input type = "radio" name= "userGender" autocomplete="off" value="남자" checked>남자</label>
                    				<label class = "btn btn-primary active">
                    				<input type = "radio" name= "userGender" autocomplete="off" value="여자" checked>여자</label>
                    			</div>
                    			</div>
                    			</div>
								
								
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="sngl-field">
										<input placeholder="신장" name="userHeight" type="text" style="width: 40%">
									</div>
								</div>
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="sngl-field">
										<input placeholder="체중" name="userWeight" type="text" style="width: 40%">
									</div>
								</div>
								
					
																
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="filed-submitbtn">
										<input value="회원가입"  type="submit" style ="margin-left: 12%">
									</div>
								</div>	
							</fieldset>	
						</form>	
					</div>
				</div>
				
			</div>	
				
				
			</div>					
		</div>

	<!-- Appointment Area End -->	
		
		
		
		
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


<!-- 쿼리문 -->
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
<!-- --------------------------------------------------------------------->
</body>
</html>


