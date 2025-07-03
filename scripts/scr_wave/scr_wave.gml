function Wave(audio) constructor {
    self.samplerate = audio.samplerate;
    self.sampleformat = audio.sampleformat;
    
    self.noteindex = 0;
    self.phase = 0;
    self.volume = 1;
    
    generate = function(duration) {
        var hz = global.notes_hz[self.noteindex];
        var length = floor(duration * samplerate);
        var buffer = buffer_create(length * sampleformat.size, buffer_fixed, sampleformat.size);
        var delta = 2 * pi * hz / samplerate;
        
        if (sampleformat.signed) {
            for (var i = 0; i < length; i++) {
                var sample = signal() / 2 * (self.volume * sampleformat.volume);
                phase += delta;
                while (phase >= 2 * pi) phase -= 2 * pi;
                buffer_write(buffer, sampleformat.type, sample);
            }
        }
        else {
            for (var i = 0; i < length; i++) {
                var sample = (0.5 + signal() / 2) * (self.volume * sampleformat.volume);
                phase += delta;
                while (phase >= 2 * pi) phase -= 2 * pi;
                buffer_write(buffer, sampleformat.type, sample);
            }
        }   
        
        return buffer;
    }
    
    signal = function() {
        return sin(phase);
    }
}

function WavePulse(audio, duty) : Wave(audio) constructor {
    self.duty = duty;
    
    signal = function() {
        return ((phase / (2 * pi) > duty) - 0.5) * 2.0;
    }
}

function WaveTriangle(audio) : Wave(audio) constructor {
    signal = function() {
        return abs(phase / pi - 1) * 2 - 1;
    }
}