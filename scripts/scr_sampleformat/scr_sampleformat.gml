/// Параметры семпла по определенному числовому типу
/// @param {Constant.BufferDataType} type `buffer_u8` или `buffer_s16`

function SampleFormat(type) constructor {
    self.type = type;
    
    switch (type) {
    	case buffer_u8:
            self.size = 1;
            self.volume = 255;
            self.maxvalue = 255;
            self.signed = false;
            break;
            
        case buffer_s16:
            self.size = 2;
            self.volume = 65535;
            self.maxvalue = 32767;
            self.signed = true;
            break;
            
        default:
            throw "Sample format can be only buffer_u8 or buffer_s16";
    }
}