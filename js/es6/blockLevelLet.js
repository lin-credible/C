'use strict';

if (true) {
  console.log(typeof doSomething);
  let doSomething = function () {
    console.log('do');
  }
  doSomething();
}

console.log(typeof doSomething);
