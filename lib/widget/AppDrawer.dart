import 'package:flutter/material.dart';
import 'package:shopapp/providers/auth_provider.dart';
import '../screens/OrderScreen.dart';
import '../screens/YourProductScreen.dart';
import 'package:provider/provider.dart';
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
        Divider(),
        ListTile(leading:Icon(Icons.mode_edit_rounded), title:Text("Your Products"), onTap:(){
          Navigator.of(context).pushReplacementNamed(YourProductScreen.routeName);
        }),
        Divider(),
        ListTile(leading:Icon(Icons.exit_to_app), title:Text("Exit"), onTap:(){
          Provider.of<Auth>(context,listen:false).logOut();
          Navigator.pushReplacementNamed(context,'/');                                                                                                                                                                                                                                            
        })
        ]
      ),
    );
  }
}