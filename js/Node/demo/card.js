var arr=['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'];
console.log(arr);
var l = arr.length;

var genRandom = function(max){
  return Math.floor(Math.random() * max);
};

for(var j = 0; j < l; j++){
  var tmpKey= genRandom(l - j - 1);
  var tmpValue = arr[tmpKey];
  arr[tmpKey] = arr[l - 1];
  arr[l - 1] =  tmpValue;
}

console.log(arr);

