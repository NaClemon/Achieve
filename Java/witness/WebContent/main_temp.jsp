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
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
<header> 
     <%
     	String userID=null;
     	if(session.getAttribute("userID")!=null){
     		userID = (String)session.getAttribute("userID");
     	}
     %>
    
     <div class="mnmenu-sec">
			<div class="container">
				<div class="row">
					<div class="col-md-3">
						<div class="logo">
							<a href="main_temp.jsp"><img src="img/logo4.png"  width = "100" height="20"  alt=""/></a>
						</div>
					</div>
				
					<%
            	if(userID==null){
            %>
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
				<%
            	} else{
			%>			
			
			
            <div class="col-md-9">		
						<div class="menu">
							<nav id="main-menu" class="main-menu">
								<ul>
									<li class="active"><a href="logoutAction.jsp">로그아웃</a></li>
																					
									<li class="active"><a href="list.do">스케줄 관리</a></li>
									
								</ul>
							</nav>			
						</div>						
					</div>
					
					 <%
            	}
            %>
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
	<!-- Gallery Area Start -->
	<div class="gallery-area pt-100 pb-70">
		<div class="container">
							
			<div class="row">		
				<div class="navbarsort">
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbarfiltr" aria-expanded="false">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>							
					</button>
					<div class="shorttitle">
						<h2>Sort Gallery</h2>
					</div>
				</div>												
				<div class="collapse navbar-collapse" id="navbarfiltr">
					<ul class="simplefilter">
						<li class="active" data-filter="*">All</li>
						<li data-filter=".Shaves">다이어트</li>
						<li data-filter=".Haircut">맨몸운동</li>
						<li data-filter=".Mustashes">벌크업</li>
					</ul>
				</div>
				<div class="gallery-container">					
					<div class="col-xs-6 col-sm-4 col-md-3 inner filtr-item Shaves">
						<div class="single-gallery architecture">
							<img class="img-responsive" src="img/다이어트/다식1.jpg" alt="">
							<div class="gallery-overlay">
								<a href="#"><i class="fa fa-search"></i></a>
							</div>
						</div>				
					</div>		
					<div class="col-xs-6 col-sm-4 col-md-3 inner filtr-item Shaves">
						<div class="single-gallery architecture">
							<img class="img-responsive" src="img/다이어트/다식2.jpg" alt="">
							<div class="gallery-overlay">
								<a href="#"><i class="fa fa-search"></i></a>
							</div>
						</div>				
					</div>		
					<div class="col-xs-6 col-sm-4 col-md-3 inner filtr-item Shaves">
						<div class="single-gallery architecture">
							<img class="img-responsive" src="img/다이어트/다운1.PNG" alt="">
							<div class="gallery-overlay">
								<a href="#"><i class="fa fa-search"></i></a>
							</div>
						</div>				
					</div>		
					<div class="col-xs-6 col-sm-4 col-md-3 inner filtr-item Shaves">
						<div class="single-gallery architecture">
							<img class="img-responsive" src="img/다이어트/다식3.jpg" alt="">
							<div class="gallery-overlay">
								<a href="#"><i class="fa fa-search"></i></a>
							</div>
						</div>				
					</div>	
					<div class="col-xs-6 col-sm-4 col-md-3 inner filtr-item Shaves">
						<div class="single-gallery architecture">
							<img class="img-responsive" src="img/다이어트/다식4.jpg" alt="">
							<div class="gallery-overlay">
								<a href="#"><i class="fa fa-search"></i></a>
							</div>
						</div>				
					</div>		
					<div class="col-xs-6 col-sm-4 col-md-3 inner filtr-item Shaves">
						<div class="single-gallery architecture">
							<img class="img-responsive" src="img/다이어트/다운2.png" alt="">
							<div class="gallery-overlay">
								<a href="#"><i class="fa fa-search"></i></a>
							</div>
						</div>				
					</div>	
					<div class="col-xs-6 col-sm-4 col-md-3 inner filtr-item Shaves">
						<div class="single-gallery architecture">
							<img class="img-responsive" src="img/다이어트/다식5.jpeg" alt="">
							<div class="gallery-overlay">
								<a href="#"><i class="fa fa-search"></i></a>
							</div>
						</div>				
					</div>		
					<div class="col-xs-6 col-sm-4 col-md-3 inner filtr-item Shaves">
						<div class="single-gallery architecture">
							<img class="img-responsive" src="img/다이어트/다식6.jpeg" alt="">
							<div class="gallery-overlay">
								<a href="#"><i class="fa fa-search"></i></a>
							</div>
						</div>				
					</div>	
					<div class="col-xs-6 col-sm-4 col-md-3 inner filtr-item Shaves">
						<div class="single-gallery architecture">
							<img class="img-responsive" src="img/다이어트/다운3.png" alt="">
							<div class="gallery-overlay">
								<a href="#"><i class="fa fa-search"></i></a>
							</div>
						</div>				
					</div>		
							
					
					<div class="col-xs-6 col-sm-4 col-md-3 inner filtr-item Haircut">
						<div class="single-gallery architecture">
							<img class="img-responsive" src="img/맨몸운동/맨운1.jpg" alt="">
							<div class="gallery-overlay">
								<a href="#"><i class="fa fa-search"></i></a>
							</div>
						</div>				
					</div>					
					<div class="col-xs-6 col-sm-4 col-md-3 inner filtr-item Haircut">
						<div class="single-gallery architecture">
							<img class="img-responsive" src="img/맨몸운동/맨식1.PNG" alt="">
							<div class="gallery-overlay">
								<a href="#"><i class="fa fa-search"></i></a>
							</div>
						</div>				
					</div>		
					<div class="col-xs-6 col-sm-4 col-md-3 inner filtr-item Haircut">
						<div class="single-gallery architecture">
							<img class="img-responsive" src="img/맨몸운동/맨운2.PNG" alt="">
							<div class="gallery-overlay">
								<a href="#"><i class="fa fa-search"></i></a>
							</div>
						</div>				
					</div>		
					<div class="col-xs-6 col-sm-4 col-md-3 inner filtr-item Haircut">
						<div class="single-gallery architecture">
							<img class="img-responsive" src="img/맨몸운동/맨식2.PNG" alt="">
							<div class="gallery-overlay">
								<a href="#"><i class="fa fa-search"></i></a>
							</div>
						</div>				
					</div>		
					<div class="col-xs-6 col-sm-4 col-md-3 inner filtr-item Haircut">
						<div class="single-gallery architecture">
							<img class="img-responsive" src="img/맨몸운동/맨운3.jpg" alt="">
							<div class="gallery-overlay">
								<a href="#"><i class="fa fa-search"></i></a>
							</div>
						</div>				
					</div>		
					<div class="col-xs-6 col-sm-4 col-md-3 inner filtr-item Haircut">
						<div class="single-gallery architecture">
							<img class="img-responsive" src="img/맨몸운동/맨식3.PNG" alt="">
							<div class="gallery-overlay">
								<a href="#"><i class="fa fa-search"></i></a>
							</div>
						</div>				
					</div>		
					<div class="col-xs-6 col-sm-4 col-md-3 inner filtr-item Haircut">
						<div class="single-gallery architecture">
							<img class="img-responsive" src="img/맨몸운동/맨운4.PNG" alt="">
							<div class="gallery-overlay">
								<a href="#"><i class="fa fa-search"></i></a>
							</div>
						</div>				
					</div>		
					


					<div class="col-xs-6 col-sm-4 col-md-3 inner filtr-item Mustashes">
						<div class="single-gallery architecture">
							<img class="img-responsive" src="img/벌크업/벌식1.jpg" alt="">
							<div class="gallery-overlay">
								<a href="#"><i class="fa fa-search"></i></a>
							</div>
						</div>				
					</div>		
					<div class="col-xs-6 col-sm-4 col-md-3 inner filtr-item Mustashes">
						<div class="single-gallery architecture">
							<img class="img-responsive" src="img/벌크업/벌운1.PNG" alt="">
							<div class="gallery-overlay">
								<a href="#"><i class="fa fa-search"></i></a>
							</div>
						</div>				
					</div>		
					<div class="col-xs-6 col-sm-4 col-md-3 inner filtr-item Mustashes">
						<div class="single-gallery architecture">
							<img class="img-responsive" src="img/벌크업/벌식2.PNG" alt="">
							<div class="gallery-overlay">
								<a href="#"><i class="fa fa-search"></i></a>
							</div>
						</div>				
					</div>	
					<div class="col-xs-6 col-sm-4 col-md-3 inner filtr-item Mustashes">
						<div class="single-gallery architecture">
							<img class="img-responsive" src="img/벌크업/벌운2.png" alt="">
							<div class="gallery-overlay">
								<a href="#"><i class="fa fa-search"></i></a>
							</div>
						</div>				
					</div>		
					<div class="col-xs-6 col-sm-4 col-md-3 inner filtr-item Mustashes">
						<div class="single-gallery architecture">
							<img class="img-responsive" src="img/벌크업/벌식3.PNG" alt="">
							<div class="gallery-overlay">
								<a href="#"><i class="fa fa-search"></i></a>
							</div>
						</div>				
					</div>			
					<div class="col-xs-6 col-sm-4 col-md-3 inner filtr-item Mustashes">
						<div class="single-gallery architecture">
							<img class="img-responsive" src="img/벌크업/벌운3.gif" alt="">
							<div class="gallery-overlay">
								<a href="#"><i class="fa fa-search"></i></a>
							</div>
						</div>				
					</div>																								
				</div>				
			</div>							
		</div>
	</div>			
	<!-- Gallery Area End -->	
	
	<!-- Team Area Start -->
	<div class="team-area pt-100 pb-70">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="sec-title">
						<h1>Our Team</h1>
						<div class="border-shape"></div>
						<p>Introduce the team members of the Open source Team project.</p>
					</div>
				</div>
			</div>	
		<center>
			<div class="row">	
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<div class="all-team">
						<!-- team 1 Start-->	
						<div class="single-team">
							<img src="img/재웅.jpg" alt=""/>
							<div class="team-overlay">
								<div class="team-info">
									<h2><a href="#">최재웅</a></h2>
									<p>Team leader</p>
									<ul>
										<li><a href=""><i class="fa fa-facebook"></i></a></li>
										<li><a href=""><i class="fa fa-twitter"></i></a></li>
										<li><a href=""><i class="fa fa-pinterest"></i></a></li>
										<li><a href=""><i class="fa fa-linkedin"></i></a></li>
									</ul>
								</div>
							</div>
						</div>	
						<!-- team 1 End-->								
						<!-- team 2 Start-->	
						<div class="single-team">
							<img src="img/광호.jpg" alt=""/>
							<div class="team-overlay">
								<div class="team-info">
									<h2><a href="#">손광호</a></h2>
									<p>Team Member</p>
									<ul>
										<li><a href=""><i class="fa fa-facebook"></i></a></li>
										<li><a href=""><i class="fa fa-twitter"></i></a></li>
										<li><a href=""><i class="fa fa-pinterest"></i></a></li>
										<li><a href=""><i class="fa fa-linkedin"></i></a></li>
									</ul>
								</div>
							</div>
						</div>	
						<!-- team 2 End-->								
						<!-- team 3 Start-->	
						<div class="single-team">
							<img src="img/우석.jpg" alt=""/>
							<div class="team-overlay">
								<div class="team-info">
									<h2><a href="#">조우석</a></h2>
									<p>Team Member</p>
									<ul>
										<li><a href=""><i class="fa fa-facebook"></i></a></li>
										<li><a href=""><i class="fa fa-twitter"></i></a></li>
										<li><a href=""><i class="fa fa-pinterest"></i></a></li>
										<li><a href=""><i class="fa fa-linkedin"></i></a></li>
									</ul>
								</div>
							</div>
						</div>	
																			
					</div>																
				</div>					
			</div>	
	</center>								
		</div>
	</div>			
	<!-- Team Area End -->	
	
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
