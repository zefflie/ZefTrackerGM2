function hf_audiobuffer_draw(buffer, sampleformat, x0, y0, x1, y1, scale = undefined) {
    var height = y1 - y0;
    var cy = (y0 + y1) / 2;
    var past = 0;
    buffer_seek(buffer, buffer_seek_start, 0);
    if (is_undefined(scale)) scale = (x1 - x0) / (buffer_get_size(buffer) div sampleformat.size);
    
    draw_set_color(c_aqua);
    draw_rectangle(x0, y0, x1, y1, true);
    
    draw_set_color(c_red);
    draw_line(x0, cy, x1, cy);
    
    draw_set_color(c_white);
    for (var i = 0; i < buffer_get_size(buffer) div sampleformat.size; i++) {
        var sample = buffer_read(buffer, sampleformat.type) / sampleformat.maxvalue * (height - 4) / 2;
        var _x = x0 + i * scale;
        
        if (_x >= x1) break;
        if (i != 0) draw_line(x0 + (i-1) * scale, cy + past, _x, cy + sample);
            
        past = sample;
    }
}