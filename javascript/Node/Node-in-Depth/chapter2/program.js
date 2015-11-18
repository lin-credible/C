//program.js

var math = require('./math.js');
exports.increment = function(val) {
    return math.add(val, 1);
}

