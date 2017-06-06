var data = [5, 8, 10, 3, 2, 18, 17, 9];

function quick_sort(data) {
  var len = data.length,
    base_num = data[0],
    left_arr = [],
    right_arr = [];

  if (len <= 0) {
    return [];
  }

  for (var $i = 1; $i < len; $i++) {
    if (base_num > data[$i]) {
      left_arr.push(data[$i]);
    } else {
      right_arr.push(data[$i]);
    }
  }

  left_arr = quick_sort(left_arr);
  right_arr = quick_sort(right_arr);
  
  return [...left_arr, base_num, ...right_arr];
};

var sorted = quick_sort(data);

console.log(sorted);

