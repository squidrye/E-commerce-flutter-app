import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CartModel {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartModel({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class CartProvider extends ChangeNotifier {
  Map<String, CartModel> dummyModel = {};

  Map<String, CartModel> getItems() {
    return {...dummyModel};
  }

  int getItemCount() {
    return dummyModel.length;
  }

  void addItems(String productId, double price,  String title) {
    if (dummyModel.containsKey(productId)) {
      //update quanitity
      dummyModel.update(productId, (existingItemInMapForKey) {
        return CartModel(
          id: existingItemInMapForKey.id,
          price: existingItemInMapForKey.price,
          quantity: existingItemInMapForKey.quantity + 1,
          title: existingItemInMapForKey.title,
        );
      });
    } else {
      //create new entry in map
      dummyModel.putIfAbsent(productId, () {
        return CartModel(
            id: DateTime.now().toString(),
            title: title,
            price: price,
            quantity: 1);
      });
    }
    notifyListeners();
  }
  void removeItem(String productId){
    dummyModel.remove(productId);
    notifyListeners();
  }
  double totalAmount(){
    var total=0.0;
    dummyModel.forEach((String key, CartModel item){
      total+=item.price*item.quantity;
    });
    return total;
  }
  void clear(){
    dummyModel={};
    notifyListeners();
  }
}
