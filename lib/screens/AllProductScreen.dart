import 'package:flutter/material.dart';
import '../widget/AllItemsGrid.dart';
class AllProductsScreen extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:Text("Shop"),
      ),
      body:AllItemsGrid(),
    );
  }
}