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
                  OrderButton(cart),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: cart.getItemCount(),
              itemBuilder: (BuildContext ctx, int index) {
                return CartItem(
                  cartId: cart.getItems().values.toList()[index].id,
                  productId: cart.getItems().keys.toList()[index],
                  price: cart.getItems().values.toList()[index].price,
                  quantity: cart.getItems().values.toList()[index].quantity,
                  title: cart.getItems().values.toList()[index].title,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  @override
  OrderButton(this.cart);
  final CartProvider cart;
  OrderButtonState createState() {
    return OrderButtonState();
  }
}

class OrderButtonState extends State<OrderButton> {
  bool _isLoading=false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        child:_isLoading?CircularProgressIndicator(): Text("ORDER NOW"),
        onPressed: widget.cart.getItemCount() == 0
            ? null
            : () async {
              setState((){
                _isLoading=true;
              });
                await Provider.of<Order>(context, listen: false).addOrder(
                    widget.cart.dummyModel.values.toList(),
                    widget.cart.totalAmount());
                setState((){
                  _isLoading=false;
                });
                widget.cart.clear();
              });
  }
}
