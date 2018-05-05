var canvas = document.getElementById("mycanvas");
var cnt = canvas.getContext("2d");
var mainscreen = document.getElementById("main");
var choosescreen = document.getElementById("musicchoice");
var gamescreen = document.getElementById("game");
var anim = document.getElementById("anim");

var mus1 = document.getElementById("mus1");
var mus2 = document.getElementById("mus2");
var song1 = new Audio("Shots.mp3");
var song2 = new Audio("Trouble.mp3");
var count = 1;

var imgA = new Image();
var imgS = new Image();
var imgD = new Image();
var imgF = new Image();
imgA.src = "font.png";

var perfect = 0;
var good = 0;
var bad = 0;
var miss = 0;
var combo = 0;

function start(){
    if(choosescreen.style.visibility === "hidden"){
        mainscreen.style.visibility = "hidden";
        choosescreen.style.visibility = "visible";
        anim.style.webkitAnimationPlayState = "paused";
    }
    else{
        choosescreen.style.visibility = "hidden";
    }
    mus2.disabled = true;
    song1.play();
    if(song1.currentTime > 30){
        song1.pause();
        song1.currentTime = 0;
    }
}
function nextsong(){
    song1.currentTime = 0;
    song2.currentTime = 0;
    song1.pause();
    song2.play();
    var pos = 0;
    var scalepos = 0;
    if(count == 1){
        var id = setInterval(frame, 5);
        function frame(){
            if(pos==220)
                clearInterval(id);
            else{
                pos+=4;
                scalepos += 0.0054;
                mus1.style.transform = "translate3d(" + (-120-pos) + "px, 70px, 0px) scale3d(" + (1-scalepos) + ", " +(1-scalepos) + ", " + (1-scalepos) + ")";
                mus2.style.transform = "translate3d(" + (100-pos) + "px, 70px, 0px) scale3d(" + (0.7+scalepos) + ", " +(0.7+scalepos) + ", " + (0.7+scalepos) + ")";
            }
        }
        mus2.disabled = false;
        mus1.disabled = true;
        if(song2.currentTime > 30){
            song2.pause();
            song2.currentTime = 0;
        }
        count = 0;
    }
    else
        return false;
}
function previoussong(){
    song1.currentTime = 0;
    song2.currentTime = 0;
    song2.pause();
    song1.play();
    var pos = 0;
    var scalepos = 0;
    if(count == 0){
        var id = setInterval(frame, 5);
        function frame(){
            if(pos==220)
                clearInterval(id);
            else{
                pos+=4;
                scalepos += 0.0054;
                mus2.style.transform = "translate3d(" + (-120+pos) + "px, 70px, 0px) scale3d(" + (1-scalepos) + ", " +(1-scalepos) + ", " + (1-scalepos) + ")";
                mus1.style.transform = "translate3d(" + (-340+pos) + "px, 70px, 0px) scale3d(" + (0.7+scalepos) + ", " +(0.7+scalepos) + ", " + (0.7+scalepos) + ")";
            }
        }
        mus2.disabled = true;
        mus1.disabled = false;
        if(song1.currentTime > 30){
            song1.pause();
            song1.currentTime = 0;
        }
        count = 1;
    }
    else
        return false;
}

function startgame(num){
    song1.pause();
    song2.pause();
    song1.currentTime = 0;
    song2.currentTime = 0;
    if(gamescreen.style.visibility == "hidden"){
        choosescreen.style.visibility = "hidden";
        gamescreen.style.visibility = "visible";
    }
    else{
        gamescreen.style.visibility = "hidden";
    }
    if(num == 1){
        song1.play();
    }
    else if(num == 2){
        song2.play();
    }
    init();
}

function roundedRect(x, y){
    var gradient = cnt.createRadialGradient((2*x+135)/2, (2*y+16)/2, 0, (2*x+135)/2, (2*y+16)/2, 70);
    gradient.addColorStop(0, "#ffff1a");
    gradient.addColorStop(1, "white");
    cnt.beginPath();
    cnt.moveTo(x, y);
    cnt.lineTo(x+131, y);
    cnt.quadraticCurveTo(x+135, y, x+135, y+4);
    cnt.lineTo(x+135, y+12);
    cnt.quadraticCurveTo(x+135, y+16, x+131, y+16);
    cnt.lineTo(x+4, y+16);
    cnt.quadraticCurveTo(x, y+16, x, y+12);
    cnt.lineTo(x, y+4);
    cnt.quadraticCurveTo(x, y, x+4, y);
    cnt.lineWidth = 3;
    cnt.strokeStyle = "#333333";
    cnt.stroke()
    cnt.closePath();
    cnt.fillStyle = gradient;
    cnt.fill();
}

function init(){
    var gradient = cnt.createLinearGradient(0, 500, 0, 620);
    
    cnt.beginPath();
    gradient.addColorStop(0, "red");
    gradient.addColorStop(1, "white");
    cnt.rect(212, 520, 135, 56);
    cnt.fillStyle = gradient;
    cnt.fill();
    cnt.closePath();
    cnt.font = "bold 50px Courier New";
    cnt.fillStyle = "white";
    cnt.fillText("A", 263, 565);
    cnt.globalAlpha = 0.3;
    cnt.fillStyle = "#e6e6e6";
    cnt.fillRect(212, 0, 135, 520);
    cnt.globalAlpha = 1;
    
    cnt.beginPath();
    gradient.addColorStop(0, "orange");
    cnt.rect(367, 520, 135, 56);
    cnt.fillStyle = gradient;
    cnt.fill();
    cnt.closePath();
    cnt.font = "bold 50px Courier New";
    cnt.fillStyle = "white";
    cnt.fillText("S", 418, 565);
    cnt.globalAlpha = 0.3;
    cnt.fillStyle = "#e6e6e6";
    cnt.fillRect(367, 0, 135, 520);
    cnt.globalAlpha = 1;
    
    cnt.beginPath();
    gradient.addColorStop(0, "blue");
    cnt.rect(522, 520, 135, 56);
    cnt.fillStyle = gradient;
    cnt.fill();
    cnt.closePath();
    cnt.font = "bold 50px Courier New";
    cnt.fillStyle = "white";
    cnt.fillText("D", 573, 565);
    cnt.globalAlpha = 0.3;
    cnt.fillStyle = "#e6e6e6";
    cnt.fillRect(522, 0, 135, 520);
    cnt.globalAlpha = 1;
    
    cnt.beginPath();
    gradient.addColorStop(0, "green");
    cnt.rect(677, 520, 135, 56);
    cnt.fillStyle = gradient;
    cnt.fill();
    cnt.closePath();
    cnt.font = "bold 50px Courier New";
    cnt.fillStyle = "white";
    cnt.fillText("F", 728, 565);
    cnt.globalAlpha = 0.3;
    cnt.fillStyle = "#e6e6e6";
    cnt.fillRect(677, 0, 135, 520);
    cnt.globalAlpha = 1;
    
    cnt.beginPath();
    cnt.globalAlpha = 0.8;
    cnt.fillStyle = "#cccccc"
    cnt.fillRect(0, 485, 1024, 10);
    cnt.fill();
    cnt.closePath();
    cnt.globalAlpha = 1;
}