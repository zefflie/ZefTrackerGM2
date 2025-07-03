//  Создание сетки
var grid = ds_grid_create(width, height);
ds_grid_clear(grid, " ");

//  Отрисовка вершин
for (var i = 0; i < array_length(mesh.vertices); i++) {
    var morepast = i > 1 ? mesh.vertices[i-2] : pointer_null;
    var past = i > 0 ? mesh.vertices[i-1] : pointer_null;
    var vertex = mesh.vertices[i];
    
    var pos = vertex.position.sum(mesh.position);
    grid[# round(pos.x), round(pos.y / 2)] = "@";
    
    if (past != pointer_null) paintline(grid, pos, past.position.sum(mesh.position));
    if (morepast != pointer_null) paintline(grid, pos, morepast.position.sum(mesh.position));
}

//  Запись сетки в вывод
output = "";

for (var j = 0; j < height; j++) {
    for (var i = 0; i < width; i++) {
        output += grid[# i, j];
    }
    
    output += "\n";
}

ds_grid_destroy(grid);