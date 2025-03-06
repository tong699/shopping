import 'package:flutter/material.dart';
import 'item.dart';

class CartProvider extends ChangeNotifier{
  final List<Item> itemList = [];

  void add(Item item){
    itemList.add(item);
    notifyListeners();
  }

  void remove(Item item){
    itemList.remove(item);
    notifyListeners();
  }
}