// self-exec Anonymous function: (public & private)

(function( meal, $, undefined ) {
    // private property
    var isHot = true;
    
    // public property
    meal.ingredient = "bacon strips";
    
    // public method
    meal.fry = function() {
        var oil;
        
        addItem( "\n\n\nbutter\n\n\n" );
        addItem( oil );
        console.log( "Frying " + meal.ingredient );
    };
     
    // private method
    function addItem( item ) {
        if ( item !== undefined ) {
            console.log( "Adding " + $.trim(item) );
        }
    }    
}( window.meal = window.meal || {}, jQuery ));

// test public properties
console.log( meal.ingredient ); // bacon strips
 
// test public methods
meal.fry(); // Adding butter & Frying bacon strips
 
// adding a public property
meal.quantity = "12";
console.log( meal.quantity ); // 12
 
// ------ adding new functionality ------
(function( meal, $, undefined ) {
    // private Property
    var amountOfGrease = "1 Cup";
     
    // public Method
    meal.toString = function() {
        console.log( meal.quantity + " " + 
                     meal.ingredient + " & " + 
                     amountOfGrease + " of Grease" );
        console.log( isHot ? "Hot" : "Cold" );
    };    
}( window.meal = window.meal || {}, jQuery ));
 
try {
    // 12 Bacon Strips & 1 Cup of Grease
    meal.toString(); // throws exception
} catch( e ) {
    console.log( e.message ); // isHot is not defined
}
