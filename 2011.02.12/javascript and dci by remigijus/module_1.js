// Global variables

var iAmGlobal = "No way";
 
iAmGlobalToo = "Very bad";
 
function oldSchool() {
    iAmGlobalAlso = "Really Bad"; 
    
    console.log("Bad oldSchool() function");
}

// prefixed namespace
function namespace_oldSchool() {
    console.log("Also bad namespace_oldSchool() function");
}


// test functions 
window.oldSchool();
window.namespace_oldSchool();

// global variables all available
console.log( window.iAmGlobal );
console.log( window.iAmGlobalToo );
console.log( window.iAmGlobalAlso );
