var fs = require('fs');

var contents = fs.readFileSync('test.json').toString();

console.log(contents);

fs.readFile('test.json', function(err, buf){
   console.log(buf.toString());
});
