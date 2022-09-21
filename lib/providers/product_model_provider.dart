import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Product with ChangeNotifier{
  final String title;
  final String id;
  final double price;
  final String imageUrl;
  final String description;
   bool isFav;
  Product(
      {required this.title,
      required this.id,
      required this.price,
      required this.description,
      required this.imageUrl,
       this.isFav=false,});
  Future<void> favouriteClicked(String? authToken, String? userID) async{
    final backup=isFav;
    isFav=!isFav;
    notifyListeners();
    final url=Uri.parse("https://shopapp-457b8-default-rtdb.firebaseio.com/favouriteProducts/$userID/$id.json?auth=$authToken");
    final response=await http.put(url, body:json.encode(isFav));
    if(response.statusCode>=400){
      isFav=backup;
      notifyListeners();
    }
  }
}
