var cusor = document.getElementById("cursor");

function movecursor(){
    var posx = 0;
    var posy = 0;
    cusor.style.visibility = "visible";
    var id = setInterval(frame, 15);
    function frame(){
        if(posx == 70){
            clearInterval(id);
        }
        else{
            posx += 2;
            posy += 0.5;
            cusor.style.transform = "translate(" + (20 - posx) + "px, " + (80 - posy) + "px)";
        }
    }
}

function outcursor(){
    cusor.style.visibility = "hidden";
    cusor.style.transform = "translate(20px, 80px)";
}