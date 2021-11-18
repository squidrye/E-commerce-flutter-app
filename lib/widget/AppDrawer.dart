import 'package:flutter/material.dart';
import '../screens/OrderScreen.dart';
class AppDrawer extends StatelessWidget{
  Widget build(BuildContext context){
    return Drawer(
      child:Column(
        children:[
        AppBar(title:Text("Hi there!")),
        Divider(),
        ListTile(leading: Icon(Icons.shop),title:Text("Shop App"),onTap:(){
          Navigator.of(context).pushReplacementNamed('/');
        }),
        Divider(),
        ListTile(leading:Icon(Icons.payment), title:Text("Orders"), onTap:(){
          Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
        }),
        ]
      ),
    );
  }
}