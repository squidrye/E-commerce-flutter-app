import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_map_provider.dart';

class CartItem extends StatelessWidget {
  final String cartId;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  CartItem(
      {required this.cartId,
      required this.price,
      required this.title,
      required this.productId,
      required this.quantity});
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(cartId),
      direction: DismissDirection.endToStart,
      onDismissed: (dir) {
        Provider.of<CartProvider>(context, listen: false).removeItem(productId);
      },
      confirmDismiss: (DismissDirection direction) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("Are you sure"),
                content: Text("Do you want to remove the item from the cart "),
                actions: [
                  TextButton(
                      child: Text("Yes"),
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                      }),
                  TextButton(
                      child: Text("No"),
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      })
                ],
              );
            });
      },
      background: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).errorColor),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 10),
          margin: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
          child: Icon(Icons.delete, color: Colors.white, size: 40)),
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: ListTile(
            leading: CircleAvatar(
                child: FittedBox(
                    child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(price.toString())))),
            title: Text(title),
            subtitle: Text("Total: ${price * quantity}"),
            trailing: Text("$quantity X")),
      ),
    );
  }
}
