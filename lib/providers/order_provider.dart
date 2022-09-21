import 'package:flutter/material.dart';
import './cart_map_provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
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
      final String? userId;
  List<OrderModel> listOfOrders = [];
  String? authToken;
  Order(this.authToken, this.listOfOrders,this.userId);
  List<OrderModel> getOrders() {
    return [...listOfOrders];
  }
  Future<void> fetchAndSetProducts()async{
    final url=Uri.parse("https://shopapp-457b8-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken");
    final response= await http.get(url);
    final List<OrderModel> loadedOrders=[];
    final extractedData=json.decode(response.body) as Map<String, dynamic>;
    print(extractedData);
    extractedData.forEach((String id, dynamic values){
      loadedOrders.add(
        new OrderModel(amount: values['amount'],
        dateTime:DateTime.parse(values['dateTime']),
        id:id,
        cartItems: (values['products'] as List<dynamic>).map((iterable){
          return CartModel(
            id:iterable['id'],
            price:iterable['price'],
            quantity:iterable['quantity'],
            title:iterable['title'],
          );
        }).toList()
        )
      );
    });
    listOfOrders=loadedOrders.reversed.toList();
    print(listOfOrders);
    notifyListeners();
  }
  Future<void> addOrder(List<CartModel> list, double total) async{
    final url=Uri.parse("https://shopapp-457b8-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken");
    final timestamp=DateTime.now();

    final response=await http.post(url, body:json.encode({
      'amount':total,
      'dateTime':timestamp.toIso8601String(),
      'products':list.map((iterableCart){
        return {
          'id':iterableCart.id,
          'title':iterableCart.title,
          'quantity':iterableCart.quantity,
          'price':iterableCart.price,
        };
      }).toList()
    }));
    listOfOrders.insert(
        0,
        OrderModel(
            id: json.decode(response.body)['name'],
            amount: total,
            cartItems: list,
            dateTime: DateTime.now()));
        notifyListeners();
  }
  int getLength(){
    return listOfOrders.length;
  }

}
