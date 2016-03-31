var uniqueInteger = (function() {
    var counter = 0;
    return function() { return counter++;};
}());
console.log(uniqueInteger);
