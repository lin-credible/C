var express = require('express');
var app = express();

app.get('/', function(req, res) {
    res.json({message: 'Hi, welcome to our API!'});
});

app.listen(process.env.PORT || 8080);
