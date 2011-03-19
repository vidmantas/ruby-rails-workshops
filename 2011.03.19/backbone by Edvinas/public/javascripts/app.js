var Item = Backbone.Model.extend({
  validate  : function(attrs) {
    if(!attrs.name || attrs.name.length() < 30) {
      return "Name is too long."
    }
  }
});

var Items = Backbone.Collection.extend({
  url : "/items"
});

var items = new Items;
items.fetch(); // It fetches all the objects from server side

var item = new Item({
  name : "Edvinas"
});

items.add(item);
item.save(); // It actually saves it
