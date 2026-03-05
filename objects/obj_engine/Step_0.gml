// Не играем на паузе
if (not is_playing) return;

// Пока очередь аудиобуферов меньше 2
while (AUDIO.queue_length < 2) {
    var frame = MAIN.module.order[frame_index];
    
    // Обходим каждый канал
    for (var i = 0; i < MAIN.module.channels; i++) {
        var channel = channels[i];
        
        // Устанавливаем новый паттерн если указан
        if (row_index == 0 and frame[i] != -1) { 
            channel.pattern_index = frame[i];
            if (frame[i] == -2) channel.pattern_index = 0;
            channel.row_index = 0;
        }
        
        // Получаем паттерн и строку из него
        var pattern = MAIN.module.patterns[channel.pattern_index];
        var row = pattern.rows[channel.row_index++];
        
        // Если паттерн закончился - начинаем его заново
        if (channel.row_index >= array_length(pattern.rows)) {
            channel.row_index = 0;
        }
        
        // Обновляем параметры канала
        if (row.index == -2) {
            channel.index = 0;
            channel.phase = 0;
            channel.hz = 0;
        }
        else if (row.index >= 0) {
            channel.index = row.index;
            channel.hz = INDEX2HZ[row.index];
        }
        
        if (row.instrument >= 0) channel.wave = row.instrument;
        
        // Приколы
        if (channel.wave == 3) channel.volume /= 2;
        if (channel.wave == 4) channel.volume /= 1.05;
        
        if (row.volume >= 0) channel.volume = row.volume / 256;
        
        if (buffer_exists(channel.buffer)) buffer_delete(channel.buffer);
        generate(channel);
    }
    
    // Мержим каналы и воспроизводим
    var result = merge(channels);
    AUDIO.play(result);
    
    // Обновляем общий счетчик
    if (++row_index >= MAIN.module.rows) {
        row_index = 0;
        
        // обновляем счетчик фрейма
        if (++frame_index >= array_length(MAIN.module.order)) {
            frame_index = 0;
        }
    }
}