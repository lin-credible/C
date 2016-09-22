var net = require('net');
//var client = net.connect({path: '/tmp/echoo.sock'}, function(){
var client = net.connect({port: 8866}, function(){
  // 'connect' listener
  console.log('client connected');
  client.write('World\r\n');
});

client.on('data', function(data){
  console.log(data.toString());
  client.end();
});

client.on('end', function(){
  console.log('client disconneted');
});

