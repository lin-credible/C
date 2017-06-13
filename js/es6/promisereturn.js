let p1 = new Promise(function(resolve, reject) {
  resolve(42);
});

p1.then(function(value) {
  console.log(value);
  return value + 1;
}).then(function(value) {
  console.log(value);
});
