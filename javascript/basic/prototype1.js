//Prototype test1
function Point(x, y){
    this.x = x;
    this.y = y;
}

var p = new Point(2, 2);

Point.prototype.r = function() {
    return Math.sqrt(
            this.x * this.x + this.y * this.y);
}

var distance = p.r();

console.log(distance);
