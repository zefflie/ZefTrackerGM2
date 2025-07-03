// Палитра
palette = {
    black: c_black,
    red: c_maroon,
    green: c_green,
    yellow: c_olive,
    blue: c_navy,
    magenta: c_purple,
    cyan: c_teal,
    white: c_ltgray,
    
    ltblack: c_gray,
    ltred: c_red,
    ltgreen: c_lime,
    ltyellow: c_yellow,
    ltblue: c_blue,
    ltmagenta: c_fuchsia,
    ltcyan: c_aqua,
    ltwhite: c_white,
};

// Состояние
changes = "";
screenbuffer = buffer_create(window_get_width() * window_get_height() * 4, buffer_fixed, 1);
cursor = {
    x: 0,
    y: 0,
    tab_x: 0,
    fg: c_white,
    bg: c_black,
}

// Размещение
margin = 4;
cell_width = 8;
cell_height = 16;
grid_width = (window_get_width() - margin * 2) div cell_width;
grid_height = (window_get_height() - margin * 2) div cell_height;

// Цветовые коды
colors = {
    reset: "\x1b[m",
    
    fg_black: "\x1b[30m",
    fg_red: "\x1b[31m",
    fg_green: "\x1b[32m",
    fg_yellow: "\x1b[33m",
    fg_blue: "\x1b[34m",
    fg_magenta: "\x1b[35m",
    fg_cyan: "\x1b[36m",
    fg_white: "\x1b[37m",
    
    fg_ltblack: "\x1b[90m",
    fg_ltred: "\x1b[91m",
    fg_ltgreen: "\x1b[92m",
    fg_ltyellow: "\x1b[93m",
    fg_ltblue: "\x1b[94m",
    fg_ltmagenta: "\x1b[95m",
    fg_ltcyan: "\x1b[96m",
    fg_ltwhite: "\x1b[97m",
    
    bg_black: "\x1b[40m",
    bg_red: "\x1b[41m",
    bg_green: "\x1b[42m",
    bg_yellow: "\x1b[43m",
    bg_blue: "\x1b[44m",
    bg_magenta: "\x1b[45m",
    bg_cyan: "\x1b[46m",
    bg_white: "\x1b[47m",
    
    bg_ltblack: "\x1b[100m",
    bg_ltred: "\x1b[101m",
    bg_ltgreen: "\x1b[102m",
    bg_ltyellow: "\x1b[103m",
    bg_ltblue: "\x1b[104m",
    bg_ltmagenta: "\x1b[105m",
    bg_ltcyan: "\x1b[106m",
    bg_ltwhite: "\x1b[107m",
};

write = function(value = "") {
    changes += string(value);
    return self;
}

writeline = function(value = "") {
    changes += string(value) + "\n";
    return self;
}

writevtab = function(value = "") {
    changes += string(value) + "\v";
    return self;
}

move_cursor = function(_x, _y) {
    changes += $"\x1b[{_y};{_x}H";
    return self;
}

clear_rectangle = function(x0, y0, x1, y1) {
    changes += $"\x1b[4;{x0};{y0};{x1};{y1}J";
    return self;
}

__flush_chunk = function(chunk) {
    if (chunk == "") return "";
        
    var _x = margin + cursor.x * cell_width;
    var _y = margin + cursor.y * cell_height;
    // Фон
    draw_set_color(cursor.bg);
    draw_rectangle(
        _x,
        _y,
        _x + string_length(chunk) * cell_width - 1,
        _y + cell_height - 1,
        false
    );
    // Букавы
    draw_set_color(cursor.fg);
    draw_text(
        _x,
        _y,
        chunk
    );
    // Курсор
    cursor.x += string_length(chunk);
    return "";
}

__escape_handler = function(changes, i) {
    if (string_char_at(changes, i++) != "[") return --i;
    var args = [];
    var arg = "0";
    var valid = false;
    
    while (true) {
        if (i > string_length(changes)) break;
            
        var char = string_char_at(changes, i++);
        
        // Перечисление аргументов
        if (char == ";") {
            array_push(args, real(arg));
            arg = "0";
        }
        
        // Конечный символ
        if (string_pos(char, "HJm")) {
            array_push(args, real(arg));
            arg = char;
            valid = true;
            break;
        }
        
        // Числа пишем в аргумент
        if (string_digits(char) != "") {
            arg += char;
        }
    }
    
    if (not valid) return --i;
        
    // Выполнение
    switch (arg) {
        // Установить курсор в позицию
    	case "H":
            if (array_length(args) != 2) break;
                
            cursor.x = args[1];
            cursor.y = args[0];
            cursor.tab_x = cursor.x;
            break;
        
        // Очистка части экрана
        case "J":
            if (array_length(args) < 1) break;
                
            switch(args[0]) {
                case 4:
                    if (array_length(args) != 5) break;
                    draw_set_color(cursor.bg);
                    draw_rectangle(
                        args[1] * cell_width,
                        args[2] * cell_height,
                        args[3] * cell_width + cell_width - 1,
                        args[4] * cell_height + cell_height - 1,
                        false
                    );
                    break;
            }
            break;
        
        // Стилизация
        case "m":
            for (var j = 0; j < array_length(args); j++) {
                switch (args[j]) {
                    case 0: cursor.fg = palette.white; cursor.bg = palette.black; break;
                    
                    case 30: cursor.fg = palette.black; break;
                    case 31: cursor.fg = palette.red; break;
                    case 32: cursor.fg = palette.green; break;
                    case 33: cursor.fg = palette.yellow; break;
                    case 34: cursor.fg = palette.blue; break;
                    case 35: cursor.fg = palette.magenta break;
                    case 36: cursor.fg = palette.cyan; break;
                    case 37: cursor.fg = palette.white; break;
                    
                    case 90: cursor.fg = palette.ltblack; break;
                    case 91: cursor.fg = palette.ltred; break;
                    case 92: cursor.fg = palette.ltgreen; break;
                    case 93: cursor.fg = palette.ltyellow; break;
                    case 94: cursor.fg = palette.ltblue; break;
                    case 95: cursor.fg = palette.ltmagenta break;
                    case 96: cursor.fg = palette.ltcyan; break;
                    case 97: cursor.fg = palette.ltwhite; break;
                    
                    case 40: cursor.bg = palette.black; break;
                    case 41: cursor.bg = palette.red; break;
                    case 42: cursor.bg = palette.green; break;
                    case 43: cursor.bg = palette.yellow; break;
                    case 44: cursor.bg = palette.blue; break;
                    case 45: cursor.bg = palette.magenta break;
                    case 46: cursor.bg = palette.cyan; break;
                    case 47: cursor.bg = palette.white; break;
                    
                    case 100: cursor.bg = palette.ltblack; break;
                    case 101: cursor.bg = palette.ltred; break;
                    case 102: cursor.bg = palette.ltgreen; break;
                    case 103: cursor.bg = palette.ltyellow; break;
                    case 104: cursor.bg = palette.ltblue; break;
                    case 105: cursor.bg = palette.ltmagenta break;
                    case 106: cursor.bg = palette.ltcyan; break;
                    case 107: cursor.bg = palette.ltwhite; break;
                }
            }    
            break;
    }
    
    return --i;
}
