import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/order_provider.dart';
import '../providers/cart_map_provider.dart';
import '../widget/cartItem.dart';
class CartScreen extends StatelessWidget {
  static const String routeName = './CartScreen';
  Widget build(BuildContext context) {
    var cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text("${cart.totalAmount().toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1!
                                .color)),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(child: Text("ORDER NOW"), onPressed: () {
                    Provider.of<Order>(context,listen:false).addOrder(cart.dummyModel.values.toList(), cart.totalAmount());
                  cart.clear();           
                  }),
                ],
              ),
            ),
          ),
          SizedBox(height:20),
          Expanded(
            child: ListView.builder(
              itemCount:cart.getItemCount(),
              itemBuilder: (BuildContext ctx, int index){
                return CartItem(
                  cartId:cart.getItems().values.toList()[index].id,
                  productId:cart.getItems().keys.toList()[index],
                  price:cart.getItems().values.toList()[index].price,
                  quantity: cart.getItems().values.toList()[index].quantity,
                  title:cart.getItems().values.toList()[index].title,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
