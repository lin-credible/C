const jsonTree = function(data, config) {
  let id = config.id || 'id',
      pid = config.pid || 'pid',
      children = config.children || 'children';

  let idMap = [],
      jsonTree = [];

  data.forEach(v => {
    idMap[v[id]] = v;
  });

  data.forEach(v => {
    let parent = idMap[v[pid]];
    if (parent) {
      !parent[children] && (parent[children] = []);
      parent[children].push(v);
    } else {
      jsonTree.push(v);
    }
  });
  
  return {data: jsonTree};
};

let data = [
    {id: 6, parent_id: 2, data: '这是其他数据'},
    {id: 7, parent_id: 3, data: '这是其他数据'},
    {id: 2, parent_id: 1, data: '这是其他数据'},
    {id: 4, parent_id: 2, data: '这是其他数据'},
    {id: 1, parent_id: 0, data: '这是其他数据'},
    {id: 9, parent_id: 5, data: '这是其他数据'},
    {id: 8, parent_id: 3, data: '这是其他数据'},
    {id: 3, parent_id: 1, data: '这是其他数据'},
    {id: 5, parent_id: 2, data: '这是其他数据'},
    {id: 10, parent_id:6, data: '这是其他数据'}
];

let result = jsonTree(data, {
    id: 'id',
    pid: 'parent_id',
    children: 'kids'
});

//console.log(result);

console.log(JSON.stringify(result, null, '  '));

