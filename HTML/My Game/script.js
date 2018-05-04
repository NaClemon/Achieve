var canvas = document.getElementById("mycanvas");
var cnt = canvas.getContext("2d");
var mainscreen = document.getElementById("main");
var choosescreen = document.getElementById("musicchoice");
var gamescreen = document.getElementById("game");
var anim = document.getElementById("anim");

function start(){
    if(choosescreen.style.visibility === "hidden"){
        mainscreen.style.visibility = "hidden";
        choosescreen.style.visibility = "visible";
        anim.style.webkitAnimationPlayState = "paused";
    }
    else{
        choosescreen.style.visibility = "hidden";
    }
}