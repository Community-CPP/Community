// web app's Firebase configuration goes here

// Initialize Firebase

firebase.initializeApp(firebaseConfig);


/////////ATHENTICATION//////////

// sign out
async function signOut() {
  await firebase.auth().signOut().then(function() {
    localStorage.clear();
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
      email: userEmail,
      communities: [],
    })
    .then(function(docRef) {
      window.location.pathname = 'dashboard';
    })
    .catch(function(error) {
      // error adding user
    });
}

async function getCommunities() {
  var user = firebase.auth().currentUser;
  var communities = [];
  if (user) {
    await db.collection("users").doc(user.uid).get().then(function(doc) {
      if (doc.exists) {
        communities = doc.data()['communities'];
        getCommunityData(communities[0]);
        showCommunity(communities);
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
  await db.collection("communities").doc(commUID).get().then(function(doc) {
    if (doc.exists) {
      showCommunityInfo(commUID);
      showTokens(commUID);
      getMessages("publicMessages");
      console.log(doc.data);
    } else {
      console.log("No such document!");
    }
  }).catch(function(error) {
    console.log("Error getting document:", error);
  });
}

async function showCommunityInfo(commUID) {

  var body = document.getElementById('infoCardBody');
  body.innerHTML = "";

  await db.collection('communities').doc(commUID).get().then(async function(doc){
    body.innerHTML += "<h5><u><strong>"+doc.data()['name'].toUpperCase()+"</strong></u><h5/>";
    body.innerHTML += "<h7>"+doc.data()['street'].toUpperCase()+
      ", "+doc.data()['city'].toUpperCase()+", "+doc.data()['zip']+"</h7>";
    body.innerHTML += "<hr class=\"bg-light\">";
    body.innerHTML += "<h7>Vacancies: "+(doc.data()['capacity'] - doc.data()['tenants'].length)+"</h7>";
    body.innerHTML += "<hr class=\"bg-light\">";
    body.innerHTML += "<h7>Tenants:</h7>";

    for(var i = 0; i < doc.data()['tenants'].length; i++) {
      body.innerHTML += "<div class=\"accodion\" id=\"accordion"+i+"\">";
      await db.collection('users').doc(doc.data()['tenants'][i]).get().then(function(userDoc){
        body.innerHTML +=   "<button class=\"btn btn-link text-white tenantCollapseLink\" id=\"tenant"+i+
          "\" data-toggle=\"collapse\" data-target=\"#collapse"+i+"\" aria-expanded=\"true\" aria-controls=\"collapse"+i+"\" >"+
          userDoc.data()['first']+" "+userDoc.data()['last']+"</button>";
        body.innerHTML +=   "<div id=\"collapse"+i+"\" class=\"collapse\" data-parent=\"#accordion"+i+
          "\"><div class=\"d-flex justify-content-between\"><div class=\"col\"><p>Unit: "+userDoc.data()['unit']+"</p></div>"+
          "<div class=\"col\"><svg onclick=\"alert('clicked')\" class=\"bi bi-chat-square-fill iconButton\" width=\"1em\" height=\"1em\" viewBox=\"0 0 16 16\" fill=\"currentColor\" xmlns=\"http://www.w3.org/2000/svg\">"+
          "<path fill-rule=\"evenodd\" d=\"M2 0a2 2 0 00-2 2v8a2 2 0 002 2h2.5a1 1 0 01.8.4l1.9 2.533a1 1 0 001.6 0l1.9-2.533a1 1 0 01.8-.4H14a2 2 0 002-2V2a2 2 0 00-2-2H2z\" clip-rule=\"evenodd\"/>"+
          "</svg></div></div></div>";
      });
      body.innerHTML += "</div>";
    }
  });
}

async function showCommunity(communityList) {
  var comms = "<div class=\"buttonContainer\">";
  var thisComm = "";
  for (i = 0; i < communityList.length; i++) {
    await db.collection("communities").doc(communityList[i]).get().then(function(doc) {
      if (doc.exists) {
        comms += "<li><button id=\"btn"+ i +"\" onClick=\"btnInfo(this.id)\" class=\"linkBtn\" value="+ communityList[i] +">" + doc.data()['name'] + "</button></li>";
      } else {
        // doc.data() will be undefined in this case
        console.log("No such document!");
      }
    }).catch(function(error) {
      console.log("Error getting document:", error);
    });
  }
  comms += "</div>";
  var commListSection = document.getElementById("commList");
  commListSection.innerHTML = comms;
}

async function btnInfo(id) {
      var commUID = document.getElementById(id).value;
      getCommunityData(commUID);
      getMessages("publicMessages");
}


// function to create new community
async function submitCreateForm() {
  var name = document.getElementById('communityNameField').value;
  var capacity = document.getElementById('comunnityUnits').value;
  var street = document.getElementById('communityStreet').value;
  var city = document.getElementById('communityCity').value;
  var zip = document.getElementById('communityZip').value;
  document.getElementById('createError').hidden = true;

  if(name != "" && capacity != "" && street != ""
    && city != "" && zip != "") {
      await db.collection("communities").add({
        capacity: capacity,
        city: city,
        street: street,
        zip: zip,
        name: name,
        tenants: [],
        tokenIDs:[],
      })
      .then(function(docRef) {
        console.log(docRef.id);
        addCommunityToAdmin(docRef.id);
      })
      .catch(function(error) {
        // error adding user
      });
    }
    else {
      document.getElementById('createError').hidden = false;
      document.getElementById('createError').innerHTML = "Please fill in all fields.";
    }
}

async function addCommunityToAdmin(communityID) {
  var user = firebase.auth().currentUser;
  var communities;
  await db.collection("users").doc(user.uid).get().then(function(doc) {
    if (doc.exists) {
      communities = doc.data()['communities'];
      communities.push(communityID);
      db.collection("users").doc(user.uid).update({
        communities: communities,
      })
      .then(function(val) {
        window.location.pathname = 'dashboard';
      })
      .catch(function(error) {
        console.log("Error updating user communities:", error);
      });
    } else {
      // doc.data() will be undefined in this case
      console.log("No such user");
    }
  }).catch(function(error) {
    console.log("Error getting user data:", error);
  });

}

async function generateToken(commUID) {
  var token = Math.random().toString(36).substring(2, 6) + Math.random().toString(36).substring(2, 6);
  var date = ""+ new Date();

  await db.collection("tokens").doc(token).get().then(async function(doc) {
    if (doc.exists) {
      // if generated token exists, regenerate
      generateToken();
    }
    else {
      var tokenIDs = [];
      // get current list
      await db.collection("communities").doc(commUID).get().then(function(doc){
          if(doc.data()['tokenIDs'].length > 0) {
            tokenIDs = doc.data()['tokenIDs'];
          }
        })
        .catch(function(error) {
          // error
        }
      );

      //push new token
      tokenIDs.push(token);

      // update community token ids
      await db.collection("communities").doc(commUID).update({
        tokenIDs:tokenIDs
      })
      .catch(function(error) {
        // error
        }
      );

      // update tokens db
      await db.collection("tokens").doc(token).set({
        community: commUID,
        time: date,
        inuse: false,
      })
      .catch(function(error) {
        // error
        }
      );

      // regenerate list
      showTokens(commUID);
    }
  });
}

async function showTokens(commUID) {
  //set add token button to current community
  document.getElementById('addTokenBtn').onclick = function(){
    generateToken(commUID)
  };
  var user = firebase.auth().currentUser;
  var tokenContainer = document.getElementById('tokensContainer');
  var tokenIDs;

  //clear current list
  tokenContainer.innerHTML = "";

  // get token ids
  await db.collection('communities').doc(commUID).get().then(function(doc){
    tokenIDs = doc.data()['tokenIDs'];
  });
  console.log(tokenIDs);

  // check length
  if(tokenIDs.length < 1) {
    tokenContainer.innerHTML += "No active tokens.";
  }
  else {
    var code = "";
    // get token data by id
    for(var i = 0; i < tokenIDs.length; i++) {

      await db.collection('tokens').doc(tokenIDs[i]).get().then(function(doc){
        if(doc.data()['inuse']) {
          code += "<div class=\"d-flex justify-content-between w-100 \"> "+
                  "<a data-toggle=\"tooltip\" data-placement=\"top\" title=\"toggle use\"" +
                    "class=\"nav-link tokenLinks\" onclick=\"return false;\">"+
                    tokenIDs[i]+
                  "</a>";
          code += "<div class=\"col w-100\">in use</div>";
        }
        else {
          code += "<div class=\"d-flex justify-content-between w-100 \"> "+
                  "<a data-toggle=\"tooltip\" data-placement=\"top\" title=\"toggle use\"" +
                    "class=\"nav-link tokenLinks inuse\" onclick=\"toggleToken('"+tokenIDs[i]+"','"+commUID+"')\">"+
                    tokenIDs[i]+
                  "</a>";
          code += "<div class=\"col w-100\">not in use</div>";
        }
      });
      code += "</div><hr class=\"bg-light\"/>";
      tokenContainer.innerHTML = code;
    }
  }
}

async function toggleToken(tokenID,commUID) {
  // toggle inuse
  await db.collection('tokens').doc(tokenID).update({
    inuse: true,
  }).then(function(doc) {
    // regenerate token list
    showTokens(commUID);
  });
}

// async function getUser(userUID) {
//   var name = "";
//   await db.collection("users").doc(userUID).get().then(function(doc) {
//     if (doc.exists) {
//       name = doc.data()['first'];
//       name += " " + doc.data()['last'];
//     } else {
//       console.log("No such user");
//     }
//   }).catch(function(error) {
//     console.log("Error getting user data:", error);
//   });
//   return name;
// }

// async function getMessages(msgType) {
//   var msg = document.getElementById("messages");
//   var data = "";
//   var name = "";
//   var userUID = "";
//   var commUID = localStorage.getItem("currentCommunity")
//   console.log("this community: " + commUID);
//   var i = 0;
//   await db.collection("communities").doc(commUID).collection(msgType).get().then(function(snapshot) {
//       snapshot.forEach(async function(doc) {
//         if(JSON.stringify(doc.data()) != '{}') { //might want to change the condition if the database for communities doesn't have the collection for messages yet
//           userUID = doc.data()['senderId'];
//           await getUser(userUID).then(function(val) {
//             if(val != name)
//             {
//               name = val;
//               data += "<li><button id=\"sender" + i + "\" onClick=\"showMessages('" + doc.data()['senderId'] + "','" + msgType + "','" + commUID +"')\" class=\"linkBtn\">" + name + "</button></li>";
//               msg.innerHTML = data;
//               i++;
//             }
//           });
//         } else {
//           console.log("No Data");
//           data += "<h6> No Messages </h6>";
//           msg.innerHTML = data;
//         }
//       });
//     })
//     .catch(function(error) {
//       console.log("Error getting documents: ", error);
//     });
// }

// async function showMessages(userUID, msgType, commUID) {
//   var arr = [];
//   await db.collection("users").doc(userUID).get().then(function(doc) {
//     if (doc.exists) {
//       arr = doc.data()[msgType]
//       for(var i in arr) {
//         getUserMsg(msgType, commUID, arr[i])
//       }
//     } else {
//       console.log("No messages");
//     }
//   }).catch(function(error) {
//     console.log("Error getting user data:", error);
//   });
//   //toggle isRead to true when opened
// }

// async function getUserMsg(msgType, commUID, msgUID) {
//   await db.collection("communities").doc(commUID).collection(msgType).doc(msgUID).get().then(function(doc) {
//     if (doc.exists) {
//       console.log(doc.data()); //was thinking of putting this on a modal of some sort instead of showing
//       // console.log(doc.data()["subject"]);
//       // console.log(doc.data()["message"]);
//       // console.log(doc.data()["isRead"]);
//     } else {
//       console.log("No");
//     }
//   }).catch(function(error) {
//     console.log("Error getting user data:", error);
//   });
// }
