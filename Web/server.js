var express = require('express');
var bodyParser = require('body-parser');
var app = express();

app.use(express.static(__dirname + '/public')); 
app.use(bodyParser.urlencoded({extended: false}));

//routes
app.get('/dashboard', function(request,response){
    response.redirect('/dashboard.html');
});
app.get('/userDash', function(request,response){
    response.redirect('/userDash.html');
});
app.get('/', function(request,response){
    response.redirect('/index.html');
});
app.listen(3000,function(){
    console.log("server");
}); 