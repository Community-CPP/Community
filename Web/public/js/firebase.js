// web app's Firebase configuration goes here

var firebaseConfig = {
  apiKey: "AIzaSyAZErRY5kpVpD7C_sOtvj2waXVvu18Xd4Q",
  authDomain: "senpro-community.firebaseapp.com",
  databaseURL: "https://senpro-community.firebaseio.com",
  projectId: "senpro-community",
  storageBucket: "senpro-community.appspot.com",
  messagingSenderId: "319397189900",
  appId: "1:319397189900:web:f548fcb0d7f588728d9129"
};


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
async function initializeNewUserData(firstName, lastName, userCategory) {
  await firebase.auth().onAuthStateChanged(function(user) {
    if (user) {
      addUserToDB(user.uid, firstName, lastName, userCategory, user.email);
    };
  })
}

// add new user data to db
async function addUserToDB(uid, firstName, lastName, userCategory, userEmail) {
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
  try {
    await firebase.auth().onAuthStateChanged(function(user) {
      if (user) {
        if (window.location.pathname === "/login.html") {
          window.location.pathname = 'dashboard';
        }

        // on dashboard load
        if (window.location.pathname === "/dashboard.html") {
          document.getElementsByTagName('body')[0].hidden = false;
          db.collection("users").doc(user.uid).get().then(function(doc) {
            if (doc.exists) {
              var navText = document.getElementById('userName');
              navText.innerHTML = doc.data()['first'] + " " + doc.data()['last'];

              console.log(doc.data()['first']);
              console.log(doc.data()['last']);
              console.log(doc.data()['category']);

            } else {
              console.log("No such document!");
            }
            getCommunities();
          }).catch(function(error) {
            console.log("Error getting document: ", error);
          });
        }
      } else {
        console.log("Logged out");
        if (window.location.pathname === "/dashboard.html")
          window.location.pathname = "login";
      }
    });

  } catch (error) {
    this.console.log(error);
  }

  async function getCommunities() {
    var user = firebase.auth().currentUser;
    // console.log(user.uid);
    var communities = [];
    if (user) {
      await db.collection("users").doc(user.uid).get().then(function(doc) {
        if (doc.exists) {
          communities = doc.data()['communities'];
          // console.log(communities);
          getCommunityData(communities[0]);
          showCommunity(communities);
          // getCommunityData(communities[0]).then(function(map) {console.log(map.data())});
          // getCommunityData(communities[0]);
          // console.log(maps);
          // console.log(getCommunityData(communities[0]).then(val => {val}));
        } else {
          // doc.data() will be undefined in this case
          console.log("No such document!");
        }
      }).catch(function(error) {
        console.log("Error getting document:", error);
      });
    }
  }

  async function getCommunityData(commUID) {
    var document;
    await db.collection("communities").doc(commUID).get().then(function(doc) {
      if (doc.exists) {


      } else {

        console.log("No such document!");
      }
    }).catch(function(error) {
      console.log("Error getting document:", error);
    });
    return document;
  }


  async function showCommunity(communityList) {
    var comms = "";
    var thisComm = "";
    for (i = 0; i < communityList.length; i++) {
      await db.collection("communities").doc(communityList[i]).get().then(function(doc) {
        if (doc.exists) {
          comms += "<li>" + doc.data()['name'] + "</li>";
          console.log("COMM NAME = " + doc.data()['name']);
        } else {
          // doc.data() will be undefined in this case
          console.log("No such document!");
        }
      }).catch(function(error) {
        console.log("Error getting document:", error);
      });
    }
    var commListSection = document.getElementById("commList");
    commListSection.innerHTML = comms;

  }









};
