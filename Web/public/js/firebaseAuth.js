
// web app's Firebase configuration goes here


// Initialize Firebase
firebase.initializeApp(firebaseConfig);

function checkIfLoggedIn() {
    
        console.log('not log in page');
    firebase.auth().onAuthStateChanged(function(user) {
        if(user) {
            console.log(user);
            
        }
        else {
            console.log("signed out");
            if(!window.location.href.includes('log-in'))
                window.location = 'log-in';
        }
    });  
}    

window.onload = function () {
   this.checkIfLoggedIn(); 
}

window.onpaint = checkIfLoggedIn();

function signOut() {
    firebase.auth().signOut();
    document.getElementById("profile-pic").setAttribute('src',"");
    document.getElementById("display-name").setAttribute('style',"visibility: hidden");
    document.getElementById("google-email").setAttribute('style',"visibility: hidden");
    checkIfLoggedIn();
}

// sign in with pop up using Google Auth
function signIn() {
    var provider = new firebase.auth.GoogleAuthProvider();
    provider.addScope('profile');
    provider.addScope('email');
    firebase.auth().signInWithPopup(provider).then(function(result) {
        window.location = 'dashboard';
    })
    .catch(function(error) {
        console.log(error);
    });
    checkIfLoggedIn();
}