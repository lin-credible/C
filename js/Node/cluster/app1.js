var cluster = require('cluster');
var http = require('http');
var numCPUs = require('os').cpus().length;
if (cluster.isMaster) {
    console.log('[master] ' + "start master...");
    
    for (var i = 0; i < numCPUs; i++) {
            //根据CPUS创建worker
        var wk = cluster.fork();
            //master给新建的worker发送信息
        wk.send('[master] ' + 'hi worker' + wk.id);
    }
    //监听创建work的进程事件 即就是fork
    cluster.on('fork', function (worker) {
      console.log('[master] ' + 'fork: worker' + worker.id);
    });
    //成功创建work的进程事件
    cluster.on('online', function (worker) {
      console.log('[master] ' + 'online: worker' + worker.id);
    });
    //master监听worker创建服务
    cluster.on('listening', function (worker, address) {
      console.log('[master] ' + 'listening: worker' + worker.id + ',pid:' + worker.process.pid + ', Address:' + address.address + ":" + address.port);
    });
    //监听worder断线
    cluster.on('disconnect', function (worker) {
      console.log('[master] ' + 'disconnect: worker' + worker.id);
    });
    //监听work的退出
    cluster.on('exit', function (worker, code, signal) {
      console.log('[master] ' + 'exit worker' + worker.id + ' died');
    });
    function eachWorker(callback) {
      for (var id in cluster.workers) {
        callback(cluster.workers[id]);
      }
    }


} else if (cluster.isWorker) {
    console.log('[worker] ' + "start worker ..." + cluster.worker.id);

    http.createServer(function (req, res) {
            res.writeHead(200, {"content-type": "text/html"});
            res.end('worker'+cluster.worker.id+',PID:'+process.pid);
    }).listen(3000);

}
