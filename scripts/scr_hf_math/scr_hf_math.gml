function hf_math_looprange(n, _min, _max) {
    var delta = _max - _min;
    if (_min == _max) return _min;
    while (n < _min) n += delta;
    while (n >= _max) n -= delta;   
    return n;    
}
