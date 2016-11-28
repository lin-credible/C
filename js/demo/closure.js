/* 返回函数 f 的近似导函数 */
function derivative(f) {
  /* dx 最好作为参数传入, 放在此处主要是为了说明闭包的用法, dx越小, 近似度越高 */
  var dx = 0.00001;
  return function(x) { 
    return (f(x + dx) - f(x)) / dx;
  }
}

/* 返回一个数的平方数 */
function square(x) {
  return x * x;
}

/* 返回一个数的双倍书 */
function double(x) {
  return 2 * x;
}

/* 对任何一个不大的数值变量 x (比如小于100), 下列函数的返回值应该非常接近于零  */
function testSquareDerivative(x) {
  return derivative(square)(x) - double(x);
}

console.log(testSquareDerivative(80));
