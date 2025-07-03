if (async_load[? "queue_id"] == queue) {
    buffer_delete(async_load[? "buffer_id"]);
    queued--;
}
