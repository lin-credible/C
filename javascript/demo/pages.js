var display = 8,
    pages = 30,
    current = 3;
var start = 0,
    end = display;

var start = Math.max(current - Math.floor(display / 2), 0);
var end = Math.min(current + Math.floor(display / 2), pages);
