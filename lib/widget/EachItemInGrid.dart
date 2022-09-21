import 'package:flutter/material.dart';
import 'package:shopapp/providers/auth_provider.dart';
import 'package:shopapp/providers/cart_map_provider.dart';
import 'package:shopapp/screens/OneProductScreen.dart';
import '../providers/product_model_provider.dart';
import 'package:provider/provider.dart';
import '../providers/product_list_provider.dart'; 
class EachItemInGrid extends StatelessWidget {
  Widget build(BuildContext context) {
    Product providedValue = Provider.of<Product>(context, listen: false);
    ProductList inst=Provider.of<ProductList>(context);
    CartProvider cartValue = Provider.of<CartProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(OneProductScreen.routeName, arguments: providedValue.id);
      },
      child: GridTile(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(providedValue.imageUrl, fit: BoxFit.cover)),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(builder: (ctx, providedValue, _) {
            return IconButton(
                icon: providedValue.isFav
                    ? Icon(Icons.favorite_rounded,
                        color: Theme.of(context).accentColor)
                    : Icon(Icons.favorite_border_outlined,
                        color: Theme.of(context).accentColor),
                onPressed: () {
                  providedValue.favouriteClicked(inst.authToken, Provider.of<Auth>(context,listen:false).returnUserId());
                });
          }),
          title: Text(
            providedValue.title,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          trailing: IconButton(
              icon: Icon(Icons.shopping_cart_outlined,
                  color: Theme.of(context).accentColor),
              onPressed: () {
                cartValue.addItems(
                    providedValue.id, providedValue.price, providedValue.title);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Added Item to cart"),action:SnackBarAction(
                      label:"Undo",
                      onPressed:(){
                        cartValue.removeItem(providedValue.id);
                      }
                    )));
              }),
        ),
      ),
    );
  }
}
