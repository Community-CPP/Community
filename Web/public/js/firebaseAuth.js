
// web app's Firebase configuration goes here


// Initialize Firebase
firebase.initializeApp(firebaseConfig);

/////////ATHENTICATION//////////
 
// sign out
async function signOut() {
    await firebase.auth().signOut().then(function() {
        // Sign-out successful.
        window.location.pathname = '/';
      }).catch(function(error) {
        // An error happened.
      });
}

// sign in with email and password
async function signIn(email, password) {
    return await firebase.auth().signInWithEmailAndPassword(email, password);
}

// authenticate new user
 async function createNewUser(email, password) {
    return await firebase.auth().createUserWithEmailAndPassword(email, password);
}

/////////DATABASE//////////

//initialize firestore
var db = firebase.firestore();

// initialize new user
async function initializeNewUserData(firstName,lastName,userCategory) {
    await firebase.auth().onAuthStateChanged(function(user) {
         if(user) {
            addUserToDB(user.uid,firstName,lastName,userCategory,user.email);
        }; 
    })
}

// add new user data to db
async function addUserToDB(uid,firstName,lastName,userCategory,userEmail) {
    console.log("in add user")
    await db.collection("users").doc(uid).set({
        first: firstName,
        last: lastName,
        category: userCategory,
        email: userEmail
    })
    .then(function(docRef) {
        window.location.pathname = 'dashboard';
    })
    .catch(function(error) {
        // error adding user
    });
}

// on window load, check login state
window.onload = async function() {
    this.console.log(window.location.pathname);
    await firebase.auth().onAuthStateChanged(function(user) {
        if(user) {
            if(window.location.pathname === "/login.html") {
                window.location.pathname = 'dashboard';
            }
            if(window.location.pathname === "/dashboard.html")
                document.getElementsByTagName('body')[0].hidden = false;
        }
        else {
            console.log("Logged out");
            if(window.location.pathname === "/dashboard.html")
                window.location.pathname = "login"; 
        }
    }); 
};