import 'package:flutter/material.dart';

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
  void favouriteClicked(){
    isFav=!isFav;
    notifyListeners();
  }
}
