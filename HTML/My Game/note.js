var note1 = $("#note1");
var note2 = $("#note2");
var note3 = $("#note3");
var note4 = $("#note4");
var line1 = $("#line1");
var line2 = $("#line2");
var line3 = $("#line3");
var line4 = $("#line4");
var current_note = 0;
var noteV = 2;
var perfect = 0;
var good = 0;
var bad = 0;
var miss = 0;
var combo = 0;
var noteanim;
var game;

var n=$("#nowjudge");

function note_down(note){
    current_note = parseInt(note.css("top"));
    if(current_note > 500)
        current_note = 0;
    note.css("top", current_note + noteV);
}

function game_start(){
    note_down(note1);
    game = requestAnimationFrame(game_start);
}

$(document).on('keydown', function(e){
    var key = e.keyCode;
    if(key == 65){
        line1.css("opacity", 0.5);
        n.css("color", "red");
    }
});

$(document).on('keyup', function(e){
    var key = e.keyCode;
    if(key == 65){
        line1.css("opacity", 0.3);
        n.css("color", "black");
    }
})
