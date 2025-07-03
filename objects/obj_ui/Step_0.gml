var position = engine.true_position();

// Мордаха
term.move_cursor(1, 0)
    .write(theme.smile + smiles[position.row div smile_delay % array_length(smiles)] + theme.reset);

// Движок
var str_mode = "invalid";

if (engine.is_playing) str_mode = "play";
else str_mode = "idle";

term.move_cursor(1, 2)
    .writevtab($"{theme.header}# ENGINE{theme.reset}")
    .writevtab($"{theme.key}Row: {theme.value}{position.row}{theme.reset}")
    .writevtab($"{theme.key}RPS: {theme.value}{1 / engine.rows_per_second}{theme.reset}")
    .writevtab($"{theme.key}Mode: {theme.value}{str_mode}{theme.reset}");

// Проект
term.move_cursor(17, 2)
    .writevtab($"{theme.header}# MODULE{theme.reset}")
    .writevtab($"{theme.key}Length: {theme.value}{engine.length}{theme.reset}");

// Аудио
var str_channels = "invalid";

switch (engine.audio.channels) {
    case audio_mono: str_channels = "mono"; break;
    case audio_stereo: str_channels = "stereo"; break;
    case audio_3d: str_channels = "3D"; break;
}

var str_sampletype = "invalid";

switch (engine.audio.sampleformat.type) {
    case buffer_u8: str_sampletype = "u8"; break;
    case buffer_s16: str_sampletype = "s16"; break;
}

term.move_cursor(33, 2)
    .writevtab($"{theme.header}# AUDIO{theme.reset}")
    .writevtab($"{theme.key}Channels: {theme.value}{str_channels}{theme.reset}")
    .writevtab($"{theme.key}Sample rate: {theme.value}{engine.audio.samplerate}{theme.reset}")
    .writevtab($"{theme.key}Sample type: {theme.value}{str_sampletype}{theme.reset}")
    .writevtab($"{theme.key}Buffer queue: {theme.value}{engine.audio.queued}{theme.reset}");

// # Паттерны
term.clear_rectangle(1, 8, 3 + array_length(engine.waves) * 12, 8 + engine.length);
term.move_cursor(1, 8);

for (var i = position.row; i < engine.length; i++) {
    term.write($"{theme.rows}{hf_string_pad_left(i, 2, " ")}");
    
    for (var j = 0; j < array_length(engine.waves); j++) {
        var pattern = engine.project.patterns[j];
        var note = pattern.read(i);
        var cmd = "...";
        if (array_length(note.commands)) cmd = note.commands[0];
            
        var c_name = theme.note_name;
        if (note.name == "...") c_name = theme.note_empty;
        if (note.name == "---" or note.name == "===")     c_name = theme.note_stop;
        var c_volume = note.volume == "." ? theme.note_empty : theme.note_volume;
        var c_cmd = cmd == "..." ? theme.note_empty : theme.note_cmd;
        
        term.write($" {theme.sep}| {c_name}{note.name} {c_volume}{note.volume} {c_cmd}{cmd}");
    }
    
    term.writevtab();
} 
