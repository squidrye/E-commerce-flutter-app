import 'package:flutter/material.dart';
import 'package:shopapp/widget/AppDrawer.dart';
import '../providers/order_provider.dart';
import 'package:provider/provider.dart';
import '../widget/OrderItem.dart';
class OrderScreen extends StatelessWidget{
static const String routeName='./orderscreen';
Widget build(BuildContext context){
  final orderData=Provider.of<Order>(context,listen:false);
  return Scaffold(
    appBar:AppBar(title:Text("Your Orders")),
    drawer:AppDrawer(),
    body:ListView.builder(
      itemCount:orderData.getLength(),
      itemBuilder:(BuildContext ctx, int index){
       return OrderItem(orderData.listOfOrders[index]);
      }

    ),
  );
}
}