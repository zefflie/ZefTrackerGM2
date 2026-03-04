//var text = "[DEBUG]\n"
//    + $"Audioqueue size: {state.audioqueue_size}\n"
//    + $"Phase: {state.phase}\n"
//    + $"SPR: {state.samples_per_row}\n";

//draw_text(0, 0, text);

var buffer = array_first(state.audioqueue_raw);
if (buffer != undefined) 
    debug_showbuffer(buffer, 16, 128, 512, 128, 500);
//draw_oscilloscope(buffer, 128, 128, 512, 128);