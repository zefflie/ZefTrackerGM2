function Vector(_x, _y, z) constructor {
    self.x = round(_x);
    self.y = round(_y);
    self.z = round(z);
    
    sum = function(_other) {
        return new Vector(x + _other.x, y + _other.y, z + _other.z);
    }
    
    sub = function(_other) {
        return new Vector(x - _other.x, y - _other.y, z - _other.z);
    }
    
    divide = function(n) {
        return new Vector(x / n, y / n, z / n);
    }
    
    mul = function(n) {
        return new Vector(x * n, y * n, z * n);
    }
    
    length = function() {
        return point_distance_3d(0, 0, 0, x, y, z);
    }
    
    equal = function(_other) {
        return x == _other.x and y == _other.y and z == _other.z;
    }
}