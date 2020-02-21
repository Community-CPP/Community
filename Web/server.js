var express = require('express');
var app = express();
var sqlite3 = require('sqlite3');
var db = new sqlite3.Database('db/comments.db');
var bodyParser = require('body-parser');

app.use(express.static(__dirname + '/public')); 
app.use(bodyParser.urlencoded({extended: false}));

//routes
app.get('/', function(request,response){
    response.redirect('/index.html');
});
app.get('/index', function(request,response){
    response.redirect('/index.html');
});
app.get('/about', function(request,response){
    response.redirect('/about.html');
});
app.get('/payments', function(request,response){
    response.redirect('/payments.html');
});
app.get('/contactManagement', function(request,response){
    response.redirect('/contactManagement.html');
});
app.get('/services', function(request,response){
    response.redirect('/services.html');
});
app.get('/profile', function(request,response){
    response.redirect('/profile.html');
});
app.get('/maintenance', function(request,response){
    response.redirect('/maintenance.html');
});
app.get('/history', function(request,response){
    response.redirect('/history.html');
});
app.get('/contact', function(request,response){
    response.redirect('/contact.html');
});
app.get('/signUp', function(request,response){
    response.redirect('/signUp.html');
});
app.get('/login', function(request,response){
    response.redirect('/login.html');
});
app.get('/communityPage', function(request,response){
    response.redirect('/communityPage.html');
});

app.get('/comments',function(request,response){
    console.log('GET request received at /comments');
    db.all('SELECT * FROM comments',function(err,rows){
        if (err){
            console.log("Error " + err);
        }else{
            response.send(rows);
        }    
    });

});
app.post('/comments',function(request,response){
    console.log('POST request received at /comments');
    db.run('INSERT INTO comments VALUES(?,?)',[request.body.name, request.body.comment], function(err){
        if(err){
            console.log("Error "+err);
        }else{
            response.status(200).redirect('mainPage.html');
        }
    });
});
app.listen(3000,function(){
    console.log("server");
}); 