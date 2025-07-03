function Mesh(_x, _y, z, order, vertices) constructor {
    self.position = new Vector(_x, _y, z);
    self.order = order;
    self.vertices = vertices;
}