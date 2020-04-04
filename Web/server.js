var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var admin = require('firebase-admin'); 

var serviceAccount = require('./community-91b9d-firebase-adminsdk-1f3ly-805d889055.json');

var firebaseAdmin = admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: 'https://community-91b9d.firebaseio.com'
})


app.use(express.static(__dirname + '/public')); 
app.use(bodyParser.urlencoded({extended: false}));

// authentication middelware
function isAuthenticated(request, response, next) {
    // check if user is logged in

    //if they are, attach them to the request obj

    // if they are not, send to login page

    // with error saying login 

}
//routes
app.get('/dashboard', function(request,response){
    response.redirect('/dashboard.html');
});

app.get('/log-in', function(request,response){
    response.redirect('/log-in.html');
});

app.get('/', function(request,response){
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

app.get('/database',function(request,response){
    console.log('GET request received at /comments');
    db.all('SELECT * FROM comments',function(err,rows){
        if (err){
            console.log("Error " + err);
        }else{
            response.send(rows);
        }    
    });

});
app.post('/database',function(request,response){
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