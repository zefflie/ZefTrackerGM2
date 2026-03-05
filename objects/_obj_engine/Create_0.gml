

//////////////////////////////////////////////////////////////////////////////
/// СВОЙСТВА
/// 

state = new Enginestate(100.157);

pattern = [
    Note.from_row("B-4 4"),
    Note.from_row("B-4 3"),
    Note.from_row("B-4 2"),
    Note.from_row("B-4 1"),
];



//////////////////////////////////////////////////////////////////////////////
/// МЕТОДЫ
/// 

/// Генератор аудиобуфера
generate = function(hz, length, wave_fn) {
    var delta = 2 * pi * hz / state.sample_rate;
    var buffer = buffer_create(length * state.sample_size, buffer_fixed, state.sample_size);

    for (var i = 0; i < length; i++) {
        buffer_write(buffer, state.sample_format, 
            wave_fn(state.phase) * state.volume  * state.sample_amplitude + state.sample_centrize
        );
        state.phase += delta;
        while (state.phase > pi) state.phase -= 2 * pi;
    }
    
    return buffer;
}

/// Воспроизведение
play = function(buffer) {
    audio_queue_sound(state.audioqueue, buffer, 0, buffer_get_size(buffer));
    state.audioqueue_size++;
    array_push(state.audioqueue_raw, buffer);
    if (not audio_is_playing(state.audioqueue)) audio_play_sound(state.audioqueue, 10, false);
}

/// [Отладка] отобразить аудиобуфер
debug_showbuffer = function(buffer, x, y, width, height, samplecount) {
    var middle = height / 2;
    draw_set_color(c_gray); 
    draw_line(x, y + middle, x + width, y + middle);
    draw_rectangle(x, y, x + width, y + height, true);

    var samplesize = state.sample_format == buffer_s16 ? 2 : 1;
    var length = min(samplecount, buffer_get_size(buffer) / samplesize);
    
    var past_value = undefined;
    buffer_seek(buffer, buffer_seek_start, 0);
    draw_set_colour(c_aqua);
    for (var i = 0; i < length; i++) {
        var sample = buffer_read(buffer, state.sample_format);
        var value = 0.5 -(sample + state.sample_centrize) / (state.sample_amplitude * 2);
        var samplewidth = width / length;
        
        if (past_value != undefined)
        draw_line(
            x + (i-1) * samplewidth,
            y + past_value * height,
            x + i * samplewidth,
            y + value * height
        );
        
        past_value = value;
    }
}

draw_oscilloscope = function(buffer, x, y, width, height, count = 500) {
    //  Отрисовка контуров
    var middle = height / 2;
    draw_set_color(c_gray); 
    draw_line(x, y + middle, x + width, y + middle);
    draw_rectangle(x, y, x + width, y + height, true);
    
    //  Централизация сигнала для поиска скачков
    var dc_centrize = 0;
    
    var length = buffer_get_size(buffer) / state.sample_size;
    buffer_seek(buffer, buffer_seek_start, 0);
    for (var i = 0; i < length; i++) {
        dc_centrize += buffer_read(buffer, state.sample_format) - state.sample_centrize;
    }
    
    dc_centrize = dc_centrize div length;
    
    //  Поиск скачков через пересечение нуля
    var zeroes = [];
    var past_sample = 0;
    buffer_seek(buffer, buffer_seek_start, 0);
    
    for (var i = 0; i < length; i++) {
        var sample = buffer_read(buffer, state.sample_format) - state.sample_centrize - dc_centrize;
        
        if ( past_sample > 0 and sample < 0 or past_sample < 0 and sample > 0) {
            array_push(zeroes, i);
        }
        
        past_sample = sample;
    }
    
    //  Поиск стабильной точки
    var stable_point = undefined;
    
    if (array_length(zeroes) > 2) {
        var min_stddev = infinity;  // финальное значение стандартного отклонения
        var stability_range = 3; // диапазон для анализа
   
        for (var z = 0; z < array_length(zeroes); z++) {
            var zero_idx = zeroes[z];
            
            if (zero_idx - count / 2 < 0 or zero_idx - count / 2 >= length) continue;
           
            // Избегаем выхода за рамки буфера
            if (zero_idx >= stability_range && zero_idx + stability_range < length) {
                var samples = [];
                for (var j = -stability_range; j <= stability_range; j++) {
                    buffer_seek(buffer, buffer_seek_start, zero_idx + j);
                    array_push(samples, buffer_read(buffer, state.sample_format) - state.sample_centrize - dc_centrize);
                }
               
                var stddev = calculate_stddev(samples);
                if (stddev < min_stddev) {
                    min_stddev = stddev;
                    stable_point = zero_idx;
                }
            }
        }
    }
        
    stable_point ??= count div 2; // Если точка не нашлась, просто взять начало буфера
        
    // Отрисовка 
    var from = stable_point - count div 2;
    var past_value = undefined;
    var samplewidth = width / count;
    buffer_seek(buffer, buffer_seek_start, from);
    draw_set_colour(c_aqua);
    
    for (var i = from; i < from + count; i++) {
        var sample = buffer_read(buffer, state.sample_format);
        var value = 0.5 -(sample + state.sample_centrize) / (state.sample_amplitude * 2);
        
        
        if (past_value != undefined)
        draw_line(
            x + (i-1) * samplewidth,
            y + past_value * height,
            x + i * samplewidth,
            y + value * height
        );
        
        past_value = value;
    }
}

// Функция для расчета стандартного отклонения
calculate_stddev = function(samples) {
    var _mean = 0;
    var n = array_length(samples);

    for (var i = 0; i < n; i++) {
        _mean += samples[i];
    }
    _mean /= n;

    var variance = 0;
    for (var i = 0; i < n; i++) {
        variance += (samples[i] - _mean) * (samples[i] - _mean);
    }
    variance /= n;

    return sqrt(variance);
}