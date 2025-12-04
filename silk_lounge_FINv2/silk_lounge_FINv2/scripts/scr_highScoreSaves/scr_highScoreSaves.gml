function load_highscores() {
    var file = "highscores.ini";

    if (!file_exists(file)) return;

    ini_open(file);

    for (var i = 0; i < 10; i++) {
        var section = "Score" + string(i);

        global.highscores[i].name  = ini_read_string(section, "name", "---");
        global.highscores[i].score = ini_read_real(section,  "score", 0);
    }

    ini_close();
}

function save_highscores() {
    ini_open("highscores.ini");

    for (var i = 0; i < 10; i++) {
        var section = "Score" + string(i);
        ini_write_string(section, "name",  global.highscores[i].name);
        ini_write_real(section,  "score", global.highscores[i].score);
    }

    ini_close();
}

function add_highscore(_name, _score) {

    // Insert at correct position
    for (var i = 0; i < 10; i++) {
        if (_score > global.highscores[i].score) {

            // Shift scores down
            for (var j = 9; j > i; j--) {
                global.highscores[j] = global.highscores[j - 1];
            }

            // Insert new score
            global.highscores[i] = {
                name  : _name,
                score : _score
            };

            break;
        }
    }

    save_highscores();
}