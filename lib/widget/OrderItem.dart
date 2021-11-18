import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopapp/providers/order_provider.dart';
import 'package:intl/intl.dart';
class OrderItem extends StatefulWidget{
   final OrderModel order;
  OrderItem(this.order);
OrderItemState createState(){
return OrderItemState();
}
}
class OrderItemState extends State<OrderItem>{
 var _expanded=false;
  Widget build(BuildContext ctx){
    return Card(
      margin:EdgeInsets.all(10),
      child:Column(
        children:[
        ListTile(
          title:Text("${widget.order.amount}"),
          subtitle:Text( DateFormat('dd MM yyyy hh:mm').format(widget.order.dateTime),),
          trailing:IconButton(icon:Icon(Icons.expand_more), onPressed:(){
            setState((){
              _expanded=!_expanded;
            });
          })
        ),
        if(_expanded)
          Container(
               padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
               height: min(widget.order.cartItems.length*20.0+10.0 ,100),
               child:ListView.builder(
                 itemBuilder:(BuildContext ctx, int index){
                 return Row(
                   mainAxisAlignment:MainAxisAlignment.spaceBetween,
                   children:[
                     Text(widget.order.cartItems[index].title,style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),),
                      Text("${widget.order.cartItems[index].quantity} X ${widget.order.cartItems[index].price}",style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),)     

                   ],
                 );
               } 
               ,itemCount:widget.order.cartItems.length)
          ),
        
        ],
      ),
    );
  }
}