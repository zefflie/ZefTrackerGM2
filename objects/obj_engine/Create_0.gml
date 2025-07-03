// # Свойства

// Аудио система
audio = instance_create_layer(x, y, layer, obj_audio);
audio.init(new SampleFormat(buffer_s16), 44100, audio_mono);

// Состояние
is_playing = false;
is_once = true;
row_index = 0;
rows_per_second = (60 / (150 * 4)) / 2;
length = 64;

// Структуры
waves = [];

// Проект
project = new ZTProject();
project.waves = [
    { type: "pulse", duty: 0.25 },
    { type: "pulse", duty: 0.25 },
    { type: "triangle" },
];

// 2xx - portamento up. xx - speed
// Sxx - delayed note cut. xx - ticks before cut
// Pxx - fine pitch. x == 80 - default; x > 80 increase; x < 80 decrease
// Vxx - Set square duty
var pt0 = new ZTPattern();
pt0.container = [
    new ZTNote("A-4", "."), // // // //
    new ZTNote("...", "."),
    new ZTNote("D-4", "."),
    new ZTNote("...", "."),
    new ZTNote("G-4", "."), //
    new ZTNote("...", "."),
    new ZTNote("D-4", "."),
    new ZTNote("...", "."),
    new ZTNote("E-4", "."), //
    new ZTNote("---", "."),
    new ZTNote("D-4", "."),
    new ZTNote("---", "."),
    new ZTNote("F-4", "."), //
    new ZTNote("---", "."),
    new ZTNote("D-4", "."),
    new ZTNote("---", "."),
];

var pt1 = new ZTPattern();
pt1.container = [
    new ZTNote("===", "."), // // // //
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."), //
    new ZTNote("D-4", "8"),
    new ZTNote("D#4", "."),
    new ZTNote("E-4", "."),
    new ZTNote("F-4", "F"), //
    new ZTNote("...", "."),
    new ZTNote("...", "8"),
    new ZTNote("...", ".", ["S00"]),
    new ZTNote("F-4", "7"), //
    new ZTNote("...", "5", ["S02"]),
    new ZTNote("...", "."),
    new ZTNote("...", "."),

    new ZTNote("...", "."), // // // //
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("F-4", "F"), //
    new ZTNote("...", "."),
    new ZTNote("...", "8"),
    new ZTNote("...", ".", ["S00"]),
    new ZTNote("F-4", "7"), // 
    new ZTNote("...", "5", ["S02"]),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."), // 
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."),

    new ZTNote("D#4", "F"), // // // //
    new ZTNote("...", "."),
    new ZTNote("...", "8"),
    new ZTNote("...", ".", ["S00"]),
    new ZTNote("D#4", "7"), //
    new ZTNote("...", "5", ["S02"]),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."), // 
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("D#4", "F"), // 
    new ZTNote("...", "."),
    new ZTNote("...", "8"),
    new ZTNote("...", ".", ["S00"]),

    new ZTNote("...", "."), // // // //
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("D#4", "F"), //
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "C"),
    new ZTNote("...", "A"), //
    new ZTNote("...", "8"),
    new ZTNote("...", ".", ["S03"]),
    new ZTNote("...", "."),
    new ZTNote("...", "."), // 
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
];

var pt2 = new ZTPattern();
pt2.container = [
    new ZTNote("...", "."), // // // //
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."), //
    new ZTNote("...", "."),
    new ZTNote("...", ".", ["P7E"]),
    new ZTNote("...", "."),
    new ZTNote("A#3", "C", ["V01"]), // 
    new ZTNote("...", "."),
    new ZTNote("...", "5"),
    new ZTNote("...", ".", ["S01"]),
    new ZTNote("A#3", "4"), // 
    new ZTNote("...", "2", ["S04"]),
    new ZTNote("...", "."),
    new ZTNote("...", "."),

    new ZTNote("...", "."), // // // //
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."), //
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", ".", ["S01"]),
    new ZTNote("A#3", "C"), // 
    new ZTNote("...", ".", ["S04"]),
    new ZTNote("...", "5"),
    new ZTNote("...", "."),
    new ZTNote("A#3", "4"), // 
    new ZTNote("...", "2"),
    new ZTNote("...", "."),
    new ZTNote("...", "."),

    new ZTNote("G-3", "C"), // // // //
    new ZTNote("...", "."),
    new ZTNote("...", "5"),
    new ZTNote("...", ".", ["S00"]),
    new ZTNote("G-3", "A"), //
    new ZTNote("...", "."),
    new ZTNote("...", "4"),
    new ZTNote("...", ".", ["S00"]),
    new ZTNote("G-3", "5"), // 
    new ZTNote("...", "2", ["S04"]),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("G-3", "C"), // 
    new ZTNote("...", "."),
    new ZTNote("...", "5"),
    new ZTNote("...", ".", ["S02"]),

    new ZTNote("...", "."), // // // //
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("G-3", "C"), //
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "9"),
    new ZTNote("...", "7"), //
    new ZTNote("...", "5"),
    new ZTNote("...", ".", ["S05"]),
    new ZTNote("...", "."),
    new ZTNote("...", "."), // 
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
];

var pt3 = new ZTPattern();
pt3.container = [
    new ZTNote("A-3", ".", ["24A"]), // // // //
    new ZTNote("...", ".", ["S00"]),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."), //
    new ZTNote("...", "."),
    new ZTNote("F#4", "0", ["21A"]),
    new ZTNote("...", "."),
    new ZTNote("A-3", "F", ["24A"]), // 
    new ZTNote("...", ".", ["S00"]),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."), // 
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."),

    new ZTNote("A-3", ".", ["24A"]), // // // //
    new ZTNote("...", ".", ["S00"]),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."), //
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("A-3", ".", ["24A"]), // 
    new ZTNote("...", ".", ["S00"]),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."), // 
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."),

    new ZTNote("A-3", ".", ["24A"]), // // // //
    new ZTNote("...", ".", ["S00"]),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."), //
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("A-3", "F", ["24A"]), // 
    new ZTNote("...", ".", ["S00"]),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."), // 
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."),

    new ZTNote("A-3", ".", ["24A"]), // // // //
    new ZTNote("...", ".", ["S00"]),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."), //
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("A-3", ".", ["24A"]), // 
    new ZTNote("...", ".", ["S00"]),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."), // 
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
];

project.patterns[0] = pt1;
project.patterns[1] = pt2;
project.patterns[2] = pt3;

q = [
    new ZTNote("...", "."), // // // //
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."), //
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."), // 
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."), // 
    new ZTNote("...", "."),
    new ZTNote("...", "."),
    new ZTNote("...", "."),
];

export = function() {
    show_debug_message(game_save_id);
    var buffer = buffer_create(12 + 48 + 8, buffer_grow, 1);
    
    // RIFF дескриптор (12)
    // [4 BE] Chunk ID
    buffer_write(buffer, buffer_text, "RIFF");
    // [4 LE] (4 offset) Filesize
    buffer_write(buffer, buffer_u32, 0);
    // [4 BE] Format
    buffer_write(buffer, buffer_text, "WAVE");
    
    // Формат (24)
    // [4 BE] Chunk ID
    buffer_write(buffer, buffer_text, "fmt ");
    // [4 LE] Chunk size
    buffer_write(buffer, buffer_u32, 16);
    // [2 LE] Type of format. 1 - PCM
    buffer_write(buffer, buffer_u16, 1);
    // [2 LE] Channel count
    buffer_write(buffer, buffer_u16, 1);
    // [4 LE] Samplerate
    buffer_write(buffer, buffer_u32, audio.samplerate);
    // [4 LE] Byterate (samplerate * samplesize * channels)
    buffer_write(buffer, buffer_u32, audio.samplerate * audio.sampleformat.size * 1);
    // [2 LE] Block Align (samplesize * channels)
    buffer_write(buffer, buffer_u16, audio.sampleformat.size * 1);
    // [2 LE] Bits per sample
    buffer_write(buffer, buffer_u16, audio.sampleformat.size * 8);
    
    // Данные (8)
    // [4 BE] Chunk ID
    buffer_write(buffer, buffer_text, "data");
    // [4 LE] (40 offset) Chunk size
    buffer_write(buffer, buffer_u32, 0);
    
    var datasize = 0;
    var offset = buffer_tell(buffer);
    
    while (audio.queued < 2) {
        if (row_index >= array_length(pattern)) break;
            
        var note = pattern[row_index++];
        
        if (note == "...") {
            // pass
        }
        else if (note == "---" or note == "===")
            wave.noteindex = 0;
        else
            wave.noteindex = global.notes_index[$ note] + 12;
        
        var chunk = wave.generate(rows_per_second);
        
        buffer_copy(chunk, 0, buffer_get_size(chunk), buffer, offset);
        offset += buffer_get_size(chunk);
        datasize += buffer_get_size(chunk);
    }
    
    buffer_poke(buffer, 40, buffer_u32, datasize);
    buffer_poke(buffer, 4, buffer_u32, 44 + datasize);
    
    // Сохранение
    buffer_save(buffer, game_save_id + "audio.wav");
    buffer_delete(buffer);
    show_debug_message("file saved");
}

true_position = function() {
    return {
        row: hf_math_looprange(row_index - audio.queued, 0, length),
    };
}

init = function() {
    is_playing = false;
    row_index = 0;
    rows_per_second = (60 / (150 * 4)) / 2;
    
    for (var i = 0; i < array_length(project.waves); i++) {
        var wavedata = project.waves[i];
        var wave;
        
        switch (wavedata.type) {
            case "pulse": wave = new WavePulse(audio, wavedata.duty) break;
            case "triangle": wave = new WaveTriangle(audio) break;
            default: throw $"Invalid wave type '{wavedata.type}'";
        }
        
        array_push(waves, wave);
    }
}

tick = function() {
    var buffers = [];
    
    for (var i = 0; i < array_length(waves); i++) {
        var wave = waves[i];
        var pattern = project.patterns[i];
        var note = pattern.read(row_index);
        
        // Определение ноты
        if (note.name == "...") {
            // pass
        }
        else if (note.name == "---" or note.name == "===") {
            wave.noteindex = 0;
            wave.phase = 0;
        }
        else {
            wave.noteindex = global.notes_index[$ note.name];
        }
        
        // Определение громкости
        if (note.volume == ".") {
            // pass
        }
        else {
            wave.volume = (string_pos(note.volume, "0123456789ABCDEF")-1) / 16;
        }
        
        var buffer = wave.generate(rows_per_second);
        array_push(buffers, buffer);
    }
    var buffer = audio.merge(buffers);
    audio.play(buffer);
    row_index++;
}

init();
