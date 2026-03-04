#macro LOADER global._loader
LOADER = self

//////////////////////////////////////////////////////////////////////////////
//  Временные данные
//

module = new Module();
section = "";
entity = "";
entity_index = 0;
pattern = undefined;
step = 0;

defines = {};

//////////////////////////////////////////////////////////////////////////////
//  Перечисления
//

enum Directives {
    SECTION = 1,
    SEGMENT = 1,
    DF,
    STEP,
    SKIP,
}

enum Instructions {
    SPEED = 1,
    TEMPO,
    ROWS,
    CHANNELS,
    NOTE,
}

enum Entities {
    PATTERN = 1,
}

//////////////////////////////////////////////////////////////////////////////
//  Таблицы
// 

directives = {
    section: Directives.SECTION,
    segment: Directives.SEGMENT,
    df: Directives.DF,
    step: Directives.STEP,
    skip: Directives.SKIP,
};

instructions = {
    speed: Instructions.SPEED,
    tempo: Instructions.TEMPO,
    rows: Instructions.ROWS,
    channels: Instructions.CHANNELS,
    note: Instructions.NOTE,
}

entities = {
    pattern: Entities.PATTERN,
}

directive_parsers = {};
directive_parsers[$ Directives.SECTION] = function(operands) {
    if (array_length(operands) != 1) throw "Directive 'section' accepts only one operand";
    if (not is_string(operands[0])) throw "Directive 'section' operand #1 must be string";
    
    section = string_lower(operands[0]);
}
directive_parsers[$ Directives.DF] = function(operands) {
    var frame = [];
    
    for (var i = 0; i < module.channels; i++) {
        var operand = "..";
        if (i < array_length(operands)) operand = operands[i];

        var state = -is_state(operand);
        operand = state < 0 ? state : operand;
        if (not is_real(operand)) throw $"Directive 'df' operand #{i+1} must be state.continue, state.stop, or number";
        array_push(frame, operand);
    }
    
    array_push(module.order, frame);
}
directive_parsers[$ Directives.STEP] = function(operands) {
    if (section != ".patterns") throw "Directive 'step' can be used only in '.patterns' section";
    if (entity != Entities.PATTERN) throw "Directive 'step' can be usend only in pattern entity";
    if (array_length(operands) != 1) throw "Directive 'step' accepts only one operand";
    var value = operands[0];
    if (not is_real(value)) throw "Directive 'step' operand #1 must be number";
    if (value < 1) throw "Directive 'step' operand #1 must be greater than zero";
    step = value-1;
}
directive_parsers[$ Directives.SKIP] = function(operands) {
    if (section != ".patterns") throw "Directive 'skip' can be used only in '.patterns' section";
    if (entity != Entities.PATTERN) throw "Directive 'skip' can be usend only in pattern entity";
    if (array_length(operands) != 1) throw "Directive 'skip' accepts only one operand";
    var value = operands[0];
    if (not is_real(value)) throw "Directive 'skip' operand #1 must be number";
    if (value < 1) throw "Directive 'skip' operand #1 must be greater than zero";
    for (var i = 0; i < value; i++) pattern.push(new Note(-1, -1, -1));
}

instruction_parsers = {};
instruction_parsers[$ Instructions.SPEED] = function(operands) {
    if (array_length(operands) != 1) throw "Instruction 'speed' accepts only one operand";
    if (section != ".module") throw "Instruction 'speed' can be used only in '.module' section";
    if (not is_real(operands[0])) throw "Instruction 'speed' operand #1 must be number";
    
    module.speed = operands[0];
}
instruction_parsers[$ Instructions.TEMPO] = function(operands) {
    if (array_length(operands) != 1) throw "Instruction 'tempo' accepts only one operand";
    if (section != ".module") throw "Instruction 'tempo' can be used only in '.module' section";
    if (not is_real(operands[0])) throw "Instruction 'tempo' operand #1 must be number";
    
    module.tempo = operands[0];
}
instruction_parsers[$ Instructions.ROWS] = function(operands) {
    if (array_length(operands) != 1) throw "Instruction 'rows' accepts only one operand";
    if (section != ".module") throw "Instruction 'rows' can be used only in '.module' section";
    if (not is_real(operands[0])) throw "Instruction 'rows' operand #1 must be number";
    
    module.rows = operands[0];
}
instruction_parsers[$ Instructions.CHANNELS] = function(operands) {
    if (array_length(operands) != 1) throw "Instruction 'channels' accepts only one operand";
    if (section != ".module") throw "Instruction 'channels' can be used only in '.module' section";
    if (not is_real(operands[0])) throw "Instruction 'channels' operand #1 must be number";
    
    module.channels = operands[0];
}
instruction_parsers[$ Instructions.NOTE] = function(operands) {
    if (section != ".patterns") throw "Instruction 'note' can be used only in '.patterns' section";
    if (entity != Entities.PATTERN) throw "Instruction 'note' can be usend only in pattern entity";
    if (array_length(operands) < 1) throw "Instruction 'note' accepts at least one operand";
    
    var index = NOTE2INDEX[$ string_lower(operands[0])];
    if (index == undefined) throw "Instruction 'note' operand #1 must be state.continue, state.stop, or note";
    if (not is_real(index)) index = -is_state(index);
    
    var instrument = array_default(operands, 1, ".");
    var instrument_state = -is_state(instrument);
    instrument = instrument_state < 0 ? instrument_state : instrument;
    if (not is_real(instrument)) throw "Instruction 'note' operand #2 must be state.continue, state.stop, or number";
    
    var volume = array_default(operands, 2, ".");
    var volume_state = -is_state(volume);
    volume = volume_state < 0 ? volume_state : volume;
    if (not is_real(volume)) throw "Instruction 'note' operand #3 must be state.continue, state.stop, or number";

    pattern.push(new Note(index, instrument, volume));
    for (var i = 0; i < step; i++) pattern.push(new Note(-1, -1, -1));
}

entity_parsers = {};
entity_parsers[$ Entities.PATTERN] = function(index) {
    pattern = new Pattern();
    module.patterns[index] = pattern;
    step = 0;
}

// Методы
load = function(filename) {
    show_debug_message("\n[LOADING FLUFF]\n//////////////////////////////////////////////////");
    var file = file_text_open_read(filename);
    
    while (not file_text_eof(file)) {
        parse_line(file_text_readln(file));
    }
    
    file_text_close(file);
    show_debug_message(json_stringify(module, true));
    
    var null_pattern = new Pattern();
    for (var i = 0; i < module.rows; i++) {
        null_pattern.push(new Note(-1, -1, -1));
        null_pattern.rows[0].index = -2;
    }
    module.patterns[0] = null_pattern;
    
    return module;
}

parse_line = function(line) {
    // Отсечь комментарии
    var comment_pos = string_pos(";", line);
    if (comment_pos) {
        line = string_copy(line, 1, comment_pos - 1);
    }
    
    // Отсечь отступы
    line = string_trim(line);
    
    // Пропустить пустые строки
    if (line == "") return;
    
    // Обработчик макросов
    
    line = parse_macro(line);
    
    // Парсинг метки
    line = parse_label(line);
    
    // Пропустить пустые строки
    if (line == "") return;
    
    // Парсинг команды
    parse_command(line);
}

parse_macro = function(line) {
    if (string_starts_with(line, "%define")) {
        var splitted = string_split(line, " ", true, 2);
        defines[$ splitted[1]] = string_trim(splitted[2]);
        return "";
    }
    
    var names = struct_get_names(defines);
    for (var i = 0; i < array_length(names); i++) {
        var name = names[i];
        line = string_replace(line, name, defines[$ name]);
    }
    
    return line;
}

parse_label = function(line) {
    var splitted = string_split(line, ".", false, 1);
    if (array_length(splitted) != 2) return line;
    var type = splitted[0];
    var right = splitted[1];
    
    if (type != string_letters(type)) return line;
    
    splitted = string_split(right, ":", false, 1);
    if (array_length(splitted) != 2) return line;
    var index_raw = splitted[0];
    right = splitted[1];
    
    var index = undefined;
    // Вернуть 10-ричное
    if (string_starts_with(index_raw, "!")) {
        index_raw = string_copy(index_raw, 2, string_length(index_raw)-1);
        index = real(index_raw);
    }
    
    // Вернуть 16-ричное
    var hex = parse_hex(string_lower(index_raw));
    if (hex != undefined) index = hex;
    
    if (index == undefined) return line;
    
    if (index == 0) throw "Entity label can't be indexed by zero";
    entity = entities[$ string_lower(type)];
    entity_index = index;
    
    if (entity != undefined) {
        entity_parsers[$ entity](entity_index);
    }
    else {
        throw $"Entity label invalid '{type}' type";
    }
    
    return right;
}

parse_command = function(line) {
    var splitted = string_split(line, " ", true);
    var command = string_lower(array_shift(splitted));
    var operands = [];
    
    for (var i = 0; i < array_length(splitted); i++) {
        array_push(operands, parse_operand(splitted[i]));
    }
    
    var directive = directives[$ command];
    if (directive != undefined) {
        directive_parsers[$ directive](operands);
        return;
    }
    
    var instruction = instructions[$ command];
    if (instruction != undefined) {
        instruction_parsers[$ instruction](operands);
        return;
    }
    
    var note = NOTE2INDEX[$ command];
    if (note != undefined) {
        array_insert(operands, 0, command);
        instruction_parsers[$ Instructions.NOTE](operands);
        return;
    }
    
    throw $"Invalid command '{line}'";
}

parse_hex = function(str) {
    static table = {"0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "a": 10, "b": 11, "c": 12, "d": 13, "e": 14, "f": 15};
    var len = string_length(str);
    var value = 0;
    
    for (var i = 1; i <= len; i++) {
        var char = string_char_at(str, i);
        var digit = table[$ char];
        if (digit == undefined) return undefined;
        value += digit << 4 * (len - i);
    }
    
    return value;
}

parse_operand = function(operand) {
    // Вернуть 10-ричное
    if (string_starts_with(operand, "!")) {
        operand = string_copy(operand, 2, string_length(operand)-1);
        return real(operand);
    }
    
    // Вернуть 16-ричное
    var hex = parse_hex(string_lower(operand));
    if (hex != undefined) return hex;
    
    // Вернуть как есть
    return operand;
}

is_state = function(str) {
    if (str == "") return 0;
    
    var first = string_char_at(str, 1);
    for (var i = 1; i <= string_length(str); i++) {
        if (string_char_at(str, i) != first) return 0;
    }
    
    if (first == ".") return 1;
    if (first == "-") return 2;
    return 0;
}

array_default = function(array, index, def = undefined) {
    if (index >= array_length(array)) return def;
    if (array[index] == undefined) return def;
    return array[index];
} 