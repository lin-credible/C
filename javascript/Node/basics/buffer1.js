var buf1 = new Buffer(10);
var buf2 = new Buffer(14);
var buf3 = new Buffer(18);

buf1.fill(0);
buf2.fill(0);
buf3.fill(0);

var buffers = [buf1, buf2, buf3];

var totalLength = 0;

for (var i = 0; i < buffers.length; i++) {
    totalLength += buffers[i].length;
}

var bufA = Buffer.concat(buffers, totalLength);
console.log(totalLength);
console.log('-------------------------------');
console.log(buffers);
console.log('-------------------------------');
console.log(bufA);
console.log('-------------------------------');
console.log(bufA.length);
