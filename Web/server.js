var express = require('express');
var app = express();

//routes
app.get('/', function(request, response) {
    response.send('Hello world!');
});
app.listen(3000,function(){
    console.log("server is running on port 3000")
});