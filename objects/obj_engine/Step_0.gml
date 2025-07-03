if (keyboard_check_pressed(vk_f1)) export();

if (keyboard_check_pressed(vk_space)) is_playing = not is_playing;
if (not is_playing) return;
while (audio.queued < 2) {
    tick();
    
    if (row_index >= 64) {
        row_index = 0;
        if (is_once) is_playing = false;
    }
}

