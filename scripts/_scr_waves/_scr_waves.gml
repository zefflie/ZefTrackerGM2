/// Функция пульса (25% квадрат)
function wave_pulse(phase) {
    return 0 <= phase and phase < pi / 2;
}

/// Функция волны
function wave_sin(phase) {
    return sin(phase);
}

/// Функция пилы
function wave_saw(phase) {
    return phase / pi;
}

/// Функция треугольника
function wave_triangle(phase) {
    return abs(phase / pi);
}

/// Функция шума
function wave_noise(phase) {
    var step = floor((phase + pi) / (2 * pi) * AUDIO.sample_rate / 11025);
    static lfsr = 0x7FFF;
    static last_step = -1;
    
    if (step != last_step) {
        var lsb = lfsr & 1;
        lfsr = lfsr >> 1;
        if (lsb) lfsr ^= 0xB400;
        last_step = step;
    }

    return ((lfsr & 1) * 2 - 1) * 0.7;
}


/// Функция пиано
function wave_piano(phase) {
    return wave_triangle(phase) * 0.7 
        + wave_saw(phase * 1.01) * 0.2 
        + wave_pulse(phase) * 0.1;
}
