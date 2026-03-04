#macro AUDIO global._audio
AUDIO = self

init = function(format = buffer_s16, rate = 44100, channels = audio_mono) {
    self.sample_format = format;
    self.sample_rate = rate;
    self.channels = channels;
    self.queue = audio_create_play_queue(sample_format, sample_rate, channels);
    self.queue_length = 0;
    self.sample_amplitude = format == buffer_s16 ? 32767 : 127;
    self.sample_size = format == buffer_s16 ? 2 : 1;
    self.sample_offset = (format == buffer_u8) * sample_amplitude;
}

play = function(buffer) {
    audio_queue_sound(queue, buffer, 0, buffer_get_size(buffer));
    queue_length++;
    if (not audio_is_playing(queue)) audio_play_sound(queue, 10, false);
}