var net = require('net');

var server = net.createServer(function (socket){
  // new connection
  socket.on('data', function(data){
    socket.write('Hello');
  });

  socket.on('end', function() {
    console.log('Connection closed.');
  });

  socket.write("Welcome this example: \n");
});

/*
server.listen('/tmp/echoo.sock', function() {
  console.log('Server ing...');
});
*/

server.listen(8866, function() {
  console.log('Server ing...');
});

/********************************************
  var server = net.createServer(); 
  server.on('connection', function(socket){
    //new...
  }); 
  server.listen(8866);
********************************************/

