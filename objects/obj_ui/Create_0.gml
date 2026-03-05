#macro UI global._ui
UI = self

cell_width = 8;
cell_height = 16;
border = 4;
width = (window_get_width() - border * 2) div cell_width;
height = (window_get_height() - border * 2) div cell_height;

palette = {
    black:   #000000,
    red:     #BB0000,
    green:   #00BB00,
    yellow:  #BBBB00,
    blue:    #0000BB,
    magenta: #BB00BB,
    cyan:    #00BB00,
    white:   #BBBBBB,
    lt_black:   #555555,
    lt_red:     #FF5555,
    lt_green:   #55FF55,
    lt_yellow:  #FFFF55,
    lt_blue:    #5555FF,
    lt_magenta: #FF55FF,
    lt_cyan:    #55FF55,
    lt_white:   #FFFFFF,
};

paint_rectangle = function(left, top, right, bottom) {
    draw_rectangle(
        border + left * cell_width,
        border + top * cell_height,
        border + (right - 1) * cell_width + cell_width - 1,
        border + (bottom - 1) * cell_height + cell_height - 1,
        false
    );
}

paint_text = function(text, left, top) {
    draw_text_ext(
        border + left * cell_width,
        border + top * cell_height + 2,
        text,
        cell_height,
        width * cell_width
    );
}
