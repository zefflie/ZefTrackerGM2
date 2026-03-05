
while (state.audioqueue_size < 2) {
    var note = pattern[state.row++];
    
    if (note.index != undefined) state.hz = global.notes_hz[note.index];
    if (note.index == 0) state.phase = 0;
    
    if (note.volume != undefined) state.volume = note.volume;
    
    var buffer = generate(state.hz, state.samples_per_row, state.wave);
    play(buffer);
    
    if (state.row >= array_length(pattern)) state.row = 0;
}
