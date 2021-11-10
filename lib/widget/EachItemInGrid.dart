import 'package:flutter/material.dart';
import 'package:shopapp/screens/OneProductScreen.dart';
import '../providers/product_model_provider.dart';
import 'package:provider/provider.dart';

class EachItemInGrid extends StatelessWidget {
  Widget build(BuildContext context) {
    Product providedValue = Provider.of<Product>(context,listen:false);
    return GestureDetector(
      onTap:(){
        Navigator.of(context).pushNamed(OneProductScreen.routeName,arguments:providedValue.id);
      },
      child: GridTile(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(providedValue.imageUrl,fit:BoxFit.cover)),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder:(ctx,providedValue,_){
              return IconButton(
                icon: providedValue.isFav
                    ? Icon(Icons.favorite_rounded)
                    : Icon(Icons.favorite_border_outlined),
                onPressed: () {
                  providedValue.favouriteClicked();
                });}
            
          ),
          title: Text(providedValue.title),
          trailing:
              IconButton(icon: Icon(Icons.card_travel_rounded), onPressed: () {}),
        ),
      ),
    );
  }
}
