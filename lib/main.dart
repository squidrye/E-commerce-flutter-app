import 'package:flutter/material.dart';
import 'package:shopapp/providers/product_list_provider.dart';
import 'screens/AllProductScreen.dart';
import 'package:provider/provider.dart';
import 'screens/OneProductScreen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext ctx) {
         return ProductList();
      },
      child:MaterialApp(
          title: "ShopApp",
          theme: ThemeData(
            primaryColor: Colors.purple,
            accentColor: Colors.red,
          ),
          home: AllProductsScreen(),
          routes:{
            OneProductScreen.routeName:(BuildContext ctx){
              return OneProductScreen();
            },
          }
        ),
    );
  }
}
