output = "";
width = 40;
height = 20;

mesh = new Mesh(6, 2, 0, pr_trianglestrip, [
    new Vertex(0, 0, 0, c_white),
    new Vertex(9, 0, 0, c_white),
    new Vertex(0, 9, 0, c_white),
    new Vertex(9, 9, 0, c_white),
    new Vertex(15, 9, 0, c_white),
]);

paintline = function(grid, from, to) {
    var vec = from.sub(to);
    var part = vec.divide(vec.length());
    
    for (var j = 1; j < vec.length(); j++) {
        var delta = part.mul(j);
        var pos = to.sum(delta);
        
        if (pos.equal(from) or pos.equal(to)) continue; 
            
        grid[# round(pos.x), round(pos.y / 2)] = "-";
    }
}