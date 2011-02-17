// The DCI Architecture: Account Example

// ------ Account: data class ------
function Account(amount) {
  console.log("New account: balance = " + amount);
  this.balance = amount;
}

Account.prototype.withdraw = function(amount) {
  this.balance -= amount;
}

Account.prototype.deposit = function(amount) {
  this.balance += amount;
}

// ------ Roles ------
// applies data object to the role, when context is created

function Role(context, object) {
  for (var i in this) {
    if (typeof this[i] == "function") {
      var temp = this[i];
      
      // make methods of 'this' (any role) to be called as methods of data object
      this[i] = function() {
        object.ctx = context;
        temp.apply(object, arguments);
        delete object.ctx;
      }
    }
  }
}

// ------ Money source role ------
function MoneySource() {
  Role.apply(this, arguments);
}

MoneySource.prototype.transferTo = function(amount) {
  if (this.balance >= amount) {
    this.withdraw(amount);
    this.ctx.sink.receive(amount);
  }
}

// Money sink role
function MoneyTarget() {
  Role.apply(this, arguments);
}

MoneyTarget.prototype.receive = function(amount) {
  this.deposit(amount);
}

// ------ Intercation -------
function MoneyTransfer(source, target) {
  var context = {};
  
  context.source = new MoneySource(context, source);
  context.target = new MoneyTarget(context, target);
  
  return function(amount) {
    context.source.transferTo(amount);
  }
}

// ------ Use case -------
var src = new Account(1000);
var dst = new Account(0);

var t = MoneyTransfer(src, dst);

t(100);

console.log(src.balance);
console.log(dst.balance);

