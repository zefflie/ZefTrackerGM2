function hf_string_pad_left(str, length, filler = " ") {
    str = string(str);
    return string_repeat(filler, length - string_length(str)) + str;
}
