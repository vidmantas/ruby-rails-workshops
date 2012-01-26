// self-exec Anonymous function (all private)

(function() {
    // private variable
    var ingredient = "eggs";
    
    // private function
    function fry() {
        console.log( "Now frying " + ingredient );
    }
    
    fry();
}());
 
// variables not accessible
console.log( window.ingredient ); // undefined
 
// functions not accessible
try {
    window.fry(); // throws Exception
} catch( e ) {
    // Object [object DOMWindow] has no method 'fry'
    console.log( e.message ); 
}
 
// can't add anything
