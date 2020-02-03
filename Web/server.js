var express = require('express');
var app = express();
var sqlite3 = require('sqlite3');
var db = new sqlite3.Database('/home/pedro/Desktop/Community_App/Community/Database/complexes.db');

//app.use('/home/pedro/Desktop/Community_App/Community/Web/Public');

//routes
app.get('/', function(request, response) {
    db.all('SELECT * FROM complexes', function(err,rows) {
        if(err) {
            console.log('Error: '+err);
        }
        else {
            response.send(rows);
        }
    });
});

app.get('/complexes', function(request, response) {
    console.log('GET request recieeved at /complexes');
});

app.post('/complexes', function(request, response) {
    console.log('POST request recieeved at /complexes');
});

app.listen(3000,function(){
    console.log("server is running on port 3000")
});