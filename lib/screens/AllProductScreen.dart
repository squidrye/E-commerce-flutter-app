import 'package:flutter/material.dart';
import 'package:shopapp/providers/cart_map_provider.dart';
import 'package:shopapp/screens/CartScreen.dart';
import 'package:shopapp/widget/AppDrawer.dart';
import 'package:shopapp/widget/Badge.dart';
import '../widget/AllItemsGrid.dart';
import 'package:provider/provider.dart';
import '../providers/product_list_provider.dart';

enum FilterValue {
  Favourite,
  All,
}

class AllProductsScreen extends StatefulWidget {
  AllProductsScreenState createState() {
    return AllProductsScreenState();
  }
}

class AllProductsScreenState extends State<AllProductsScreen> {
  var _showOnlyFavs = false;

  Widget build(BuildContext context) {
    return FutureBuilder(
      future:Provider.of<ProductList>(context,listen:false).fetchAndSetProducts(false),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? CircularProgressIndicator()
              : Scaffold(
                  appBar: AppBar(title: Text("Shop"), actions: <Widget>[
                    PopupMenuButton(
                        onSelected: (FilterValue value) {
                          setState(() {
                            if (value == FilterValue.Favourite) {
                              _showOnlyFavs = true;
                            } else
                              _showOnlyFavs = false;
                          });
                        },
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (_) {
                          return [
                            PopupMenuItem(
                              child: Text("Favourites"),
                              value: FilterValue.Favourite,
                            ),
                            PopupMenuItem(
                              child: Text("All Items"),
                              value: FilterValue.All,
                            ),
                          ];
                        }),
                    Consumer<CartProvider>(builder: (_, cartInstance, ch) {
                      return Badge(
                        itemCount: cartInstance.getItemCount(),
                        widget: IconButton(
                          icon: Icon(Icons.shopping_cart_rounded),
                          onPressed: () {
                            Navigator.pushNamed(context, CartScreen.routeName);
                          },
                        ),
                      );
                    })
                  ]),
                  drawer: AppDrawer(),
                  body: AllItemsGrid(_showOnlyFavs),
                ),
    );
  }
}
