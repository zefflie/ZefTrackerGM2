function ZTPattern() constructor {
    self.container = [];
    
    push = function(note) {
        array_push(container, note);
    }
    
    read = function(index) {
        return container[index];
    }
    
    length = function() {
        return array_length(container);
    }
}