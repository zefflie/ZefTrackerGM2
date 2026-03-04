#macro MAIN global._main
MAIN = self

audio_master_gain(0.2);

// Создание экземпляров
instance_create_depth(0, 0, 0, obj_loader);
module = LOADER.load("test.fluff");

instance_create_depth(0, 0, 0, obj_audio).init();

instance_create_depth(0, 0, 0, obj_engine);

instance_create_depth(0, 0, 0, obj_ui);