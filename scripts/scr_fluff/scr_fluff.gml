/// FluffModule inner representation

function Note(index, instrument, volume) constructor {
    self.index = index;
    self.instrument = instrument;
    self.volume = volume;
    
    toString = function() {
        var n = INDEX2NOTE[$ index];
        var i = to_hex(instrument, 2) ?? "..";
        var v = to_hex(volume, 2) ?? "..";
        return $"{n} {i} {v}";
    }
}

function Module() constructor {
    speed = 6;
    tempo = 150;
    rows = 16;
    channels = 4;
    
    order = [];
    patterns = [];
}

function Pattern() constructor {
    rows = [];
    
    push = function(row) {
        array_push(rows, row);
    }
}

function to_hex(num, fill = 0) {
    static table = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"];
    
    if (num < 0) return undefined;
    var str = "";
    var i = 0;
    
    while (num != 0) {
        str = table[num % 16] + str;
        num = num >> 4;
    }
    
    str = string_repeat("0", max(-1, fill - string_length(str))) + str;
    
    return str;
}