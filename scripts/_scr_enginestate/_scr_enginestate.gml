function Enginestate(bpm, samplerate = 44100, sampleformat = buffer_s16, channels = audio_mono) constructor {
    //  Параметры вывода
    self.sample_rate = samplerate;
    self.sample_format = sampleformat;
    self.channels = audio_mono;
    
    //  Аудиобуфер
    self.audioqueue = audio_create_play_queue(sampleformat, samplerate, channels);
    self.audioqueue_size = 0;
    self.audioqueue_raw = [];
    
    //  Параметры семплов
    self.sample_amplitude = sampleformat == buffer_s16 ? 32767 : 127;
    self.sample_size = sampleformat == buffer_s16 ? 2 : 1;
    self.sample_centrize = (sampleformat == buffer_u8) * sample_amplitude;
    
    //  Характеристики трека
    self.bpm = bpm;
    self.rows_per_beat = 4;
    self.samples_per_row = floor(60 / bpm * samplerate / rows_per_beat);
    
    //  Позиции
    self.row = 0;
    self.phase = 0;
    self.hz = 0;
    self.volume = 0.1;
    self.wave = wave_noise;
}