buf = new Buffer(1234);

console.log(buf.length);
buf.write("some string", 0, "ascii");
console.log(buf.length);
