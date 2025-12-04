// 10 entries of name+score
global.highscores = array_create(10);

for (var i = 0; i < 10; i++) {
    global.highscores[i] = {
        name : "---",
        score : 0
    };
}

// Load from file if it exists
load_highscores();