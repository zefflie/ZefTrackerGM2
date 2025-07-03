channels = audio_mono;
samplerate = 44100;
sampleformat = undefined;
queue = -1;
queued = 0;

phase = 0;

init = function(sampleformat, samplerate, channels) {
    self.sampleformat = sampleformat;
    self.samplerate = samplerate;
    self.channels = channels;
    self.queue = audio_create_play_queue(sampleformat.type, samplerate, channels);
    self.queued = 0;
}

clicking_fix = function(buffer) {
    var temp = buffer_create(100 * sampleformat.size, buffer_fixed, sampleformat.size);
    buffer_seek(buffer, buffer_seek_start, 0);
    
    for (var i = 0; i < 100; i++) {
        buffer_write(temp, sampleformat.type, buffer_read(buffer, sampleformat.type) * (i / 100));
    }
    
    buffer_copy(temp, 0, 100 * sampleformat.size, buffer, 0);
    buffer_delete(temp);
}

clicking_fix_end = function(buffer) {
    var temp = buffer_create(100 * sampleformat.size, buffer_fixed, sampleformat.size);
    buffer_seek(buffer, buffer_seek_start, buffer_get_size(buffer) - 100 * sampleformat.size);
    
    for (var i = 0; i < 100; i++) {
        buffer_write(temp, sampleformat.type, buffer_read(buffer, sampleformat.type) * ((100 - i) / 100));
    }
    
    buffer_copy(temp, 0, 100 * sampleformat.size, buffer, buffer_get_size(buffer) - 100 * sampleformat.size);
    buffer_delete(temp);
}

play = function(buffer) {
    audio_queue_sound(queue, buffer, 0, buffer_get_size(buffer));
    queued++;
    
    if (not audio_is_playing(queue)) audio_play_sound(queue, 50, false, 0.1);
}

merge = function(buffers) {
    var len = buffer_get_size(buffers[0]) div sampleformat.size;
    var buffer = buffer_create(len * sampleformat.size, buffer_fixed, sampleformat.size);
    
    for (var i = 0; i < array_length(buffers); i++) {
        buffer_seek(buffers[i], buffer_seek_start, 0);
    }
    
    for (var i = 0; i < len; i++) {
        var sample = 0;

        for (var j = 0; j < array_length(buffers); j++) {
            sample += buffer_read(buffers[j], sampleformat.type);
        }
        
        buffer_write(buffer, sampleformat.type, sample / array_length(buffers));
    }
    
    for (var i = 0; i < array_length(buffers); i++) {
        buffer_delete(buffers[i]);
    }
    
    return buffer;
}