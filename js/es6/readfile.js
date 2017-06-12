let fs = require('fs');

function readFile(filename) {
  return new Promise(function(resolve, reject) {
    fs.readFile(filename, {encoding: 'utf8'}, function(err, contents) {
      if (err) {
        reject(err);
        return;
      }
      
      resolve(contents);
    });
  });
}

let promise = readFile('test.txt');

promise.then(function(contents) {
  console.log(contents);
}, function(err) {
  console.error(err.message);
});

/*
fs.readFile('test.txt', function(err, contents) {
    if (err) {
        throw err;
    }

    console.log(contents);
});
console.log('Hi!');
*/
