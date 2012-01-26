// Object literal

var meal = {
    // public property
    ingredient: "eggs",
     
    // public method
    fry: function() {
        console.log( "Now frying " + this.ingredient );
    }
};

console.log( meal.ingredient );
meal.fry();


// add public property
meal.quantity = 4;
console.log( meal.quantity ); // 4

// add public method
meal.toString = function() {
    console.log( this.quantity + " " + 
                 this.ingredient );
};

meal.toString(); // 4 eggs?
