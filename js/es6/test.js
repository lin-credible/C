/* es6 behavior */

if (true) {
  console.log(typeof doSomething);
  
  function doSomething() {
    console.log('do');
  }
  
  doSomething();
}

console.log(typeof doSomething);
