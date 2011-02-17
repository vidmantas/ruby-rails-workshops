// Module pattern (public & private)

var meal = (function() {
    var pub = {},
        //private property
        amountOfOil = "1 Cup";
    
    // public property    
    pub.ingredient = "eggs";
    
    // public method
    pub.fry = function() {
        secretPart();
        console.log( "Frying " + pub.ingredient );
    };
    
    // private method
    function secretPart() {
        console.log("Adding secret ingredient..");
    }
    
    // return the public part
    return pub;
}());

// test public properties
console.log( meal.ingredient ); // eggs

// test public methods
meal.fry();

// add a public property
meal.quantity = 3;
console.log( meal.quantity ); // 3

// adding a public method
meal.toString = function() {
    console.log( meal.quantity + " " + 
                 meal.ingredient + " & " + 
                 amountOfOil + " of Oil" );
};

try {
    // can't access private variable
    meal.toString();
} catch( e ) {
    console.log( e.message ); // amountOfOil is not defined
}
