// Подготовка
var text;
draw_set_font(fnt_unscii);



// Реальная позиция
var frame_index = ENGINE.frame_index;

var row_index = ENGINE.row_index - AUDIO.queue_length;
if (row_index < 0) {
    row_index += MAIN.module.rows;
    frame_index--;
    
    if (frame_index < 0) frame_index += array_length(MAIN.module.order);
}



// Шапка
draw_set_colour(palette.lt_white);
paint_rectangle(0, 0, width, 1);

text = $"FluffTracker v{GM_version}\n";
draw_set_colour(palette.black);
paint_text(text, 1, 0);

// Модуль
text = $"[module]\nspeed\ntempo\nrows\nchannels";
draw_set_colour(palette.lt_white);
paint_text(text, 1, 2);

text = $"{MAIN.module.speed}\n{MAIN.module.tempo}\n{MAIN.module.rows}\n{MAIN.module.channels}";
draw_set_colour(palette.lt_yellow);
paint_text(text, 10, 3);

// Состояние
text = $"[state]\nmode\nrow\nframe";
draw_set_colour(palette.lt_white);
paint_text(text, 24, 2);
var state = ENGINE.is_playing ? "play" : "pause";
text = $"{state}\n{row_index}\n{frame_index}";
draw_set_colour(palette.lt_yellow);
paint_text(text, 32, 3);

// Порядок
text = "[order]";
draw_set_colour(palette.lt_white);
paint_text(text, 48, 2);

text = "";

for (var i = 0; i < 4; i++) {
    var pos = frame_index + i;
    if (pos >= array_length(MAIN.module.order)) continue;
    var frame = MAIN.module.order[pos];
    
    text += $"{to_hex(pos, 2)} | ";
    for (var j = 0; j < MAIN.module.channels; j++) {
        var ptn = to_hex(frame[j], 2);
        if (frame[j] == -1) ptn = "..";
        if (frame[j] == -2) ptn = "--";
        text += $"{ptn} ";
    }
    
    text += "\n";
}

draw_set_colour(palette.lt_yellow);
paint_text(text, 48, 3);

/////// Паттерны
// Плашка
draw_set_colour(palette.white);
paint_rectangle(0, 8, width, 9);

text = "row   ";
for (var i = 0; i < MAIN.module.channels; i++) {
    text += $"channel {i+1}   ";
}

draw_set_colour(palette.black);
paint_text(text, 1, 8);

// Строка
draw_set_colour(palette.lt_black);
paint_rectangle(1, 10 + row_index, width - 1, 11 + row_index);

// Нумерация
text = "";

for (var i = 0; i < MAIN.module.rows; i++) {
    text += $"{to_hex(i, 3)}\n";
}

draw_set_colour(palette.lt_white);
paint_text(text, 1, 10);

// Паттерны

text = "";

for (var j = 0; j < MAIN.module.rows; j++) {
    for (var i = 0; i < MAIN.module.channels; i++) {
        var channel = ENGINE.channels[i];
        var pattern = MAIN.module.patterns[channel.pattern_index];
        text += $"{pattern.rows[j]}   ";
    }
    text += "\n";
}

draw_set_colour(palette.lt_yellow);
paint_text(text, 7, 10);