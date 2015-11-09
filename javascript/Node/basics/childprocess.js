var assert = require('assert');
var fs = require('fs');
var child_process = require('child_process');

child = child_process.spawn('ls', {
    stdio: [
        0,
        'pipe',
        fs.openSync('error.out', 'w')
    ]
});

assert.equal(child.stdio[0], null);
assert.equal(child.stdio[0], child.stdin);

assert(child.stdout);
assert.equal(child.stdio[1], child.stdout);

assert.equal(child.stdio[2], null);
assert.equal(child.stdio[2], child.stderr);
