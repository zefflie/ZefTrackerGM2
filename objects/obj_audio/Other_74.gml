if (async_load[? "queue_id"] != queue) return;

if (async_load[? "queue_shutdown"]) {
    queue = undefined;
    queue_length = 0;
}
else {
    buffer_delete(async_load[? "buffer_id"]);
    queue_length--;
}