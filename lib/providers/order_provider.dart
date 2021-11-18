import 'package:flutter/material.dart';
import './cart_map_provider.dart';

class OrderModel {
  final List<CartModel> cartItems;
  final String id;
  final double amount;
  final DateTime dateTime;

  OrderModel(
      {required this.cartItems,
      required this.id,
      required this.amount,
      required this.dateTime});
}

class Order extends ChangeNotifier {
  List<OrderModel> listOfOrders = [];

  List<OrderModel> getOrders() {
    return [...listOfOrders];
  }

  void addOrder(List<CartModel> list, double total) {
    listOfOrders.insert(
        0,
        OrderModel(
            id: DateTime.now().toString(),
            amount: total,
            cartItems: list,
            dateTime: DateTime.now()));
        notifyListeners();
  }
  int getLength(){
    return listOfOrders.length;
  }

}
