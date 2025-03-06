class Item {
  //Attribute
  int id;
  String name;

  //Constructor
  Item(this.id, this.name);

  //Getter
  int get itemID => id;
  String get itemName => name;

  //Override toString
  @override
  String toString(){
    return '$id: $name';
  }
}