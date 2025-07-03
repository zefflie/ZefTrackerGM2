buffer_set_surface(screenbuffer, application_surface, 0);

changes += "\x1C";
var chunk = "";
draw_set_font(fnt_unscii);

for (var i = 1; i <= string_length(changes); i++) {
    var char = string_char_at(changes, i);
    
    if (char == "\x1b") {
        chunk = __flush_chunk(chunk);
        i = __escape_handler(changes, ++i);
        continue;
    }
    
    if (char == "\n") {
        chunk = __flush_chunk(chunk);
        cursor.x = 0;
        cursor.y++;
        continue;
    }
    
    if (char == "\v") {
        chunk = __flush_chunk(chunk);
        cursor.x = cursor.tab_x;
        cursor.y++;
        continue;
    }
    
    if (char == "\x1C") {
        chunk = __flush_chunk(chunk);
        continue;
    }
    
    chunk += char;
}

changes = "";

buffer_get_surface(screenbuffer, application_surface, 0);