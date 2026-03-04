if (async_load[? "queue_id"] != state.audioqueue) return;

var buffer = array_shift(state.audioqueue_raw);
buffer_delete(buffer);
state.audioqueue_size--;

if (async_load[? "queue_shutdown"]) {
    for (var i = 0; i < array_length(state.audioqueue_raw); i++) {
        buffer_delete(state.audioqueue_raw[i]);
    }
}
