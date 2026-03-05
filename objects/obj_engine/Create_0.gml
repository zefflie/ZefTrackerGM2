#macro ENGINE global._engine
ENGINE = self;

//////////////////////////////////////////////////////////////////////////////
//  Состояние
//

is_playing = false;
rows_per_beat = 4;
samples_per_row = floor(60 / MAIN.module.tempo * AUDIO.sample_rate / rows_per_beat);

frame_index = 0;
row_index = 0;

channels = [];

for (var i = 0; i < MAIN.module.channels; i++) {
    array_push(channels, {
        phase: 0,
        hz: 0,
        index: 0,
        volume: 1.0,
        wave: 1,
        buffer: undefined,
        
        pattern_index: 0,
        row_index: 0,
        subframe_index: 0,
    });
}

//////////////////////////////////////////////////////////////////////////////
//  Таблицы
//

waves = [
    function(phase) { return 0.0 },
    wave_pulse,
    wave_triangle,
    wave_noise,
    wave_saw,
    wave_sin,
    wave_piano,
];

//////////////////////////////////////////////////////////////////////////////
//  Методы
//

generate = function(channel) {
    var wave = waves[channel.wave];
    var delta = 2 * pi * channel.hz / AUDIO.sample_rate;
    channel.buffer = buffer_create(samples_per_row * AUDIO.sample_size, buffer_fixed, AUDIO.sample_size);

    for (var i = 0; i < samples_per_row; i++) {
        buffer_write(channel.buffer, AUDIO.sample_format, 
            wave(channel.phase) * channel.volume * AUDIO.sample_amplitude + AUDIO.sample_offset
        );
        channel.phase += delta;
        while (channel.phase > pi) channel.phase -= 2 * pi;
    }
}

merge = function(channels) {
    var len = array_length(channels);
    var result = buffer_create(samples_per_row * AUDIO.sample_size, buffer_fixed, AUDIO.sample_size);
    
    for (var j = 0; j < len; j++) {
        buffer_seek(channels[j].buffer, buffer_seek_start, 0);
    }
    
    for (var i = 0; i < samples_per_row; i++) {
        var sample = 0;
        
        for (var j = 0; j < len; j++) {
            sample += buffer_read(channels[j].buffer, AUDIO.sample_format);
        }
        
        buffer_write(result, AUDIO.sample_format, sample / len);
    }
    
    return result;
}