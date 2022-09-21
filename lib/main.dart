import 'package:flutter/material.dart';
import 'package:shopapp/providers/auth_provider.dart';
import 'package:shopapp/providers/product_list_provider.dart';
import 'package:shopapp/screens/CartScreen.dart';
import 'package:shopapp/screens/OrderScreen.dart';
import 'screens/AllProductScreen.dart';
import 'package:provider/provider.dart';
import 'screens/OneProductScreen.dart';
import 'providers/cart_map_provider.dart';
import 'providers/order_provider.dart';
import 'screens/YourProductScreen.dart';
import './screens/add_product_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
            create: (BuildContext ctx) {
          return ProductList(null, null, []);
        }, update: (BuildContext ctx, Auth auth, ProductList? previousProduct) {
          return ProductList(auth.returnToken(), auth.userId,
              previousProduct == null ? [] : previousProduct.dummyProducts);
        }),
        ChangeNotifierProvider(create: (BuildContext ctx) {
          return CartProvider();
        }),
        ChangeNotifierProxyProvider<Auth, Order>(create: (BuildContext ctx) {
          return Order(null, [], null);
        }, update: (BuildContext ctx, Auth auth, Order? previousOrder) {
          return Order(
              auth.token,
              previousOrder == null ? [] : previousOrder.listOfOrders,
              auth.userId);
        }),
      ],
      child: Consumer<Auth>(
        builder: (ctx, obj, _) => MaterialApp(
            title: "ShopApp",
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.red,
            ),
            home: obj.isAuth()
                ? AllProductsScreen()
                : FutureBuilder(
                    future: obj.tryAutoLogin(),
                    builder: (ctx, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? CircularProgressIndicator()
                            : LoginScreen()),
            routes: {
              OneProductScreen.routeName: (BuildContext ctx) {
                return OneProductScreen();
              },
              CartScreen.routeName: (BuildContext ctx) {
                return CartScreen();
              },
              OrderScreen.routeName: (BuildContext ctx) {
                return OrderScreen();
              },
              YourProductScreen.routeName: (BuildContext ctx) {
                return YourProductScreen();
              },
              AddProduct.routeName: (BuildContext ctx) {
                return AddProduct();
              }
            }),
      ),
    );
  }
}
