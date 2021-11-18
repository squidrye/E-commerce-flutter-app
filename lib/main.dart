import 'package:flutter/material.dart';
import 'package:shopapp/providers/product_list_provider.dart';
import 'package:shopapp/screens/CartScreen.dart';
import 'package:shopapp/screens/OrderScreen.dart';
import 'screens/AllProductScreen.dart';
import 'package:provider/provider.dart';
import 'screens/OneProductScreen.dart';
import 'providers/cart_map_provider.dart';
import 'providers/order_provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (BuildContext ctx){
          return ProductList();
        }),
        ChangeNotifierProvider(create:(BuildContext ctx){
          return CartProvider();
        }),
        ChangeNotifierProvider(create:(BuildContext ctx){
          return Order();
        }),
      ],
      child:MaterialApp(
          title: "ShopApp",
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.red,
          ),
          home: AllProductsScreen(),
          routes:{
            OneProductScreen.routeName:(BuildContext ctx){
              return OneProductScreen();
            },
            CartScreen.routeName:(BuildContext ctx){
              return CartScreen();
            },
            OrderScreen.routeName:(BuildContext ctx){
              return OrderScreen();
            }
          }
        ),
    );
  }
}
