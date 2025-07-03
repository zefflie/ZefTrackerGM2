// Экземпляры
engine = noone;
term = instance_create_depth(0, 0, 0, obj_term);

// Мордаха
smiles = ["OwO", "Ow<", "OwO", "Ow<", "OwO", "Ow<", "OwO", ">w<"];
smile_delay = 4;

// Тема
theme = {
    reset: term.colors.reset,
    
    logo: term.colors.fg_ltmagenta,
    smile: term.colors.fg_ltwhite,
    
    header: term.colors.fg_ltwhite,
    key: term.colors.fg_white,
    value: term.colors.fg_ltred,
    
    sep: term.colors.fg_ltwhite,
    rows: term.colors.fg_white,
    note_empty: term.colors.fg_ltblack,
    note_stop: term.colors.fg_yellow,
    note_name: term.colors.fg_ltgreen,
    note_volume: term.colors.fg_cyan,
    note_cmd: term.colors.fg_ltred,
}

// # Подготовка
term.write($"      {theme.logo}ZefTracker v0.0.3 dev{theme.reset}");
