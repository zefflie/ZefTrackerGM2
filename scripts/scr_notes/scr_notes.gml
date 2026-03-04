#macro NOTE2INDEX global._note2index
NOTE2INDEX = { 
  "...": "...",
  "---": "---",
    
  "c-1": 1,
  "c#1": 2,
  "d-1": 3,
  "d#1": 4,
  "e-1": 5,
  "f-1": 6,
  "f#1": 7,
  "g-1": 8,
  "g#1": 9,
  "a-1": 10,
  "a#1": 11,
  "b-1": 12,

  "c-2": 13,
  "c#2": 14,
  "d-2": 15,
  "d#2": 16,
  "e-2": 17,
  "f-2": 18,
  "f#2": 19,
  "g-2": 20,
  "g#2": 21,
  "a-2": 22,
  "a#2": 23,
  "b-2": 24,

  "c-3": 25,
  "c#3": 26,
  "d-3": 27,
  "d#3": 28,
  "e-3": 29,
  "f-3": 30,
  "f#3": 31,
  "g-3": 32,
  "g#3": 33,
  "a-3": 34,
  "a#3": 35,
  "b-3": 36,

  "c-4": 37,
  "c#4": 38,
  "d-4": 39,
  "d#4": 40,
  "e-4": 41,
  "f-4": 42,
  "f#4": 43,
  "g-4": 44,
  "g#4": 45,
  "a-4": 46,
  "a#4": 47,
  "b-4": 48,

  "c-5": 49,
  "c#5": 50,
  "d-5": 51,
  "d#5": 52,
  "e-5": 53,
  "f-5": 54,
  "f#5": 55,
  "g-5": 56,
  "g#5": 57,
  "a-5": 58,
  "a#5": 59,
  "b-5": 60,

  "c-6": 61,
  "c#6": 62,
  "d-6": 63,
  "d#6": 64,
  "e-6": 65,
  "f-6": 66,
  "f#6": 67,
  "g-6": 68,
  "g#6": 69,
  "a-6": 70,
  "a#6": 71,
  "b-6": 72,

  "c-7": 73,
  "c#7": 74,
  "d-7": 75,
  "d#7": 76,
  "e-7": 77,
  "f-7": 78,
  "f#7": 79,
  "g-7": 80,
  "g#7": 81,
  "a-7": 82,
  "a#7": 83,
  "b-7": 84,

  "c-8": 85,
  "c#8": 86,
  "d-8": 87,
  "d#8": 88,
  "e-8": 89,
  "f-8": 90,
  "f#8": 91,
  "g-8": 92,
  "g#8": 93,
  "a-8": 94,
  "a#8": 95,
  "b-8": 96,
};

#macro INDEX2HZ global._index2hz
INDEX2HZ = [
  0,

  33.0,
  34.96,
  37.04,
  39.25,
  41.58,
  44.05,
  46.67,
  49.45,
  52.39,
  55.50,
  58.80,
  62.30,

  66.00,
  69.93,
  74.08,
  78.49,
  83.16,
  88.10,
  93.34,
  98.89,
  104.77,
  111.00,
  117.60,
  124.59,

  132.00,
  139.85,
  148.17,
  156.98,
  166.31,
  176.20,
  186.68,
  197.78,
  209.54,
  222.00,
  235.20,
  249.19,

  264.01,
  279.70,
  296.33,
  313.96,
  332.62,
  352.40,
  373.36,
  395.56,
  419.08,
  444.00,
  470.40,
  498.37,

  528.01,
  559.40,
  592.66,
  627.92,
  665.24,
  704.80,
  746.72,
  791.12,
  838.16,
  888.00,
  940.80,
  996.74,

  1056.02,
  1118.80,
  1185.32,
  1255.84,
  1330.48,
  1409.60,
  1493.44,
  1582.24,
  1676.32,
  1776.00,
  1881.60,
  1993.48,

  2112.04,
  2237.60,
  2370.64,
  2511.68,
  2660.96,
  2819.20,
  2986.88,
  3164.48,
  3352.64,
  3552.00,
  3763.20,
  3986.96,

  4224.08,
  4475.00,
  4741.28,
  5023.36,
  5321.92,
  5638.40,
  5973.76,
  6328.96,
  6705.28,
  7104.00,
  7526.40,
  7973.92,
];

#macro INDEX2NOTE global._index2note
INDEX2NOTE = {};
INDEX2NOTE[$ -2] = "---";
INDEX2NOTE[$ -1] = "..."; 
INDEX2NOTE[$ 0] = "   ";  

INDEX2NOTE[$ 1] = "c-1";
INDEX2NOTE[$ 2] = "c#1";
INDEX2NOTE[$ 3] = "d-1";
INDEX2NOTE[$ 4] = "d#1";
INDEX2NOTE[$ 5] = "e-1";
INDEX2NOTE[$ 6] = "f-1";
INDEX2NOTE[$ 7] = "f#1";
INDEX2NOTE[$ 8] = "g-1";
INDEX2NOTE[$ 9] = "g#1";
INDEX2NOTE[$ 10] = "a-1";
INDEX2NOTE[$ 11] = "a#1";
INDEX2NOTE[$ 12] = "b-1";

INDEX2NOTE[$ 13] = "c-2";
INDEX2NOTE[$ 14] = "c#2";
INDEX2NOTE[$ 15] = "d-2";
INDEX2NOTE[$ 16] = "d#2";
INDEX2NOTE[$ 17] = "e-2";
INDEX2NOTE[$ 18] = "f-2";
INDEX2NOTE[$ 19] = "f#2";
INDEX2NOTE[$ 20] = "g-2";
INDEX2NOTE[$ 21] = "g#2";
INDEX2NOTE[$ 22] = "a-2";
INDEX2NOTE[$ 23] = "a#2";
INDEX2NOTE[$ 24] = "b-2";

INDEX2NOTE[$ 25] = "c-3";
INDEX2NOTE[$ 26] = "c#3";
INDEX2NOTE[$ 27] = "d-3";
INDEX2NOTE[$ 28] = "d#3";
INDEX2NOTE[$ 29] = "e-3";
INDEX2NOTE[$ 30] = "f-3";
INDEX2NOTE[$ 31] = "f#3";
INDEX2NOTE[$ 32] = "g-3";
INDEX2NOTE[$ 33] = "g#3";
INDEX2NOTE[$ 34] = "a-3";
INDEX2NOTE[$ 35] = "a#3";
INDEX2NOTE[$ 36] = "b-3";

INDEX2NOTE[$ 37] = "c-4";
INDEX2NOTE[$ 38] = "c#4";
INDEX2NOTE[$ 39] = "d-4";
INDEX2NOTE[$ 40] = "d#4";
INDEX2NOTE[$ 41] = "e-4";
INDEX2NOTE[$ 42] = "f-4";
INDEX2NOTE[$ 43] = "f#4";
INDEX2NOTE[$ 44] = "g-4";
INDEX2NOTE[$ 45] = "g#4";
INDEX2NOTE[$ 46] = "a-4";
INDEX2NOTE[$ 47] = "a#4";
INDEX2NOTE[$ 48] = "b-4";

INDEX2NOTE[$ 49] = "c-5";
INDEX2NOTE[$ 50] = "c#5";
INDEX2NOTE[$ 51] = "d-5";
INDEX2NOTE[$ 52] = "d#5";
INDEX2NOTE[$ 53] = "e-5";
INDEX2NOTE[$ 54] = "f-5";
INDEX2NOTE[$ 55] = "f#5";
INDEX2NOTE[$ 56] = "g-5";
INDEX2NOTE[$ 57] = "g#5";
INDEX2NOTE[$ 58] = "a-5";
INDEX2NOTE[$ 59] = "a#5";
INDEX2NOTE[$ 60] = "b-5";

INDEX2NOTE[$ 61] = "c-6";
INDEX2NOTE[$ 62] = "c#6";
INDEX2NOTE[$ 63] = "d-6";
INDEX2NOTE[$ 64] = "d#6";
INDEX2NOTE[$ 65] = "e-6";
INDEX2NOTE[$ 66] = "f-6";
INDEX2NOTE[$ 67] = "f#6";
INDEX2NOTE[$ 68] = "g-6";
INDEX2NOTE[$ 69] = "g#6";
INDEX2NOTE[$ 70] = "a-6";
INDEX2NOTE[$ 71] = "a#6";
INDEX2NOTE[$ 72] = "b-6";

INDEX2NOTE[$ 73] = "c-7";
INDEX2NOTE[$ 74] = "c#7";
INDEX2NOTE[$ 75] = "d-7";
INDEX2NOTE[$ 76] = "d#7";
INDEX2NOTE[$ 77] = "e-7";
INDEX2NOTE[$ 78] = "f-7";
INDEX2NOTE[$ 79] = "f#7";
INDEX2NOTE[$ 80] = "g-7";
INDEX2NOTE[$ 81] = "g#7";
INDEX2NOTE[$ 82] = "a-7";
INDEX2NOTE[$ 83] = "a#7";
INDEX2NOTE[$ 84] = "b-7";

INDEX2NOTE[$ 85] = "c-8";
INDEX2NOTE[$ 86] = "c#8";
INDEX2NOTE[$ 87] = "d-8";
INDEX2NOTE[$ 88] = "d#8";
INDEX2NOTE[$ 89] = "e-8";
INDEX2NOTE[$ 90] = "f-8";
INDEX2NOTE[$ 91] = "f#8";
INDEX2NOTE[$ 92] = "g-8";
INDEX2NOTE[$ 93] = "g#8";
INDEX2NOTE[$ 94] = "a-8";
INDEX2NOTE[$ 95] = "a#8";
INDEX2NOTE[$ 96] = "b-8";