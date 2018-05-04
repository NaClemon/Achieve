var cnt;
var velocity;
var angle;
var ballV;
var ballVx;
var ballVy;
var ballX = 10;
var bally = 250;
var ballRadius = 10;
var score = 0;
var image = new Image();
image.src = "lawn.png";
var backimage = new Image();
backimage.src = "new.png";
var timer;

function drawBall(){
    cnt.beginPath();
    cnt.arc(ballX, bally, ballRadius, 0, 2.0*Math.PI, true);
    cnt.fillStyle = "red";
    cnt.fill();
}
function drawBackground(){
    cnt.drawImage(image, 0, 270);
    cnt.drawImage(backimage, 450, 60);
}
function draw(){
    cnt.clearRect(0, 0, 500, 300);
    drawBall();
    drawBackground();
}
function init(){
    ballX = 10;
    bally = 250;
    ballRadius = 10;
    cnt = document.getElementById("mycanvas").getContext("2d");
    draw();
}
function start(){
    init();
    velocity = Number(document.getElementById("velocity").value);
    angle = Number(document.getElementById("angle").value);
    var angleR = angle*Math.PI/180;
    
    ballVx = velocity*Math.cos(angleR);
    ballVy = -velocity*Math.sin(angleR);
    
    draw();
    timer = setInterval(calculate(), 100);
    return false;
}
function calculate(){
    ballVy = ballVy + 1.98;
    
    ballX = ballX + ballVx;
    bally = bally + ballVy;
    
    if((ballX>=450)&&(ballX<=480) && (bally>=60)&&(bally<=210)){
        score++;
        document.getElementById("score").innerHTML = "점수 = " + score;
        clearInterval(timer);
    }
    if((bally>=300)||(bally<0)){
        clearInterval(timer);
    }
    draw();
}