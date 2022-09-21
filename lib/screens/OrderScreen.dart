import 'package:flutter/material.dart';
import 'package:shopapp/widget/AppDrawer.dart';
import '../providers/order_provider.dart';
import 'package:provider/provider.dart';
import '../widget/OrderItem.dart';

class OrderScreen extends StatefulWidget {
  static const String routeName = './orderscreen';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _isLoading = false;
  var _isInit = true;
  @override
  void didChangeDependencies() {
    if(_isInit){
    setState(() {
      _isLoading = true;
    });
     Provider.of<Order>(context, listen:false).fetchAndSetProducts();
     setState((){
       _isLoading=false;
     });
     _isInit=false;
    }
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return _isLoading?CircularProgressIndicator():Scaffold(
      appBar: AppBar(title: Text("Your Orders")),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: orderData.getLength(),
          itemBuilder: (BuildContext ctx, int index) {
            return OrderItem(orderData.listOfOrders[index]);
          }),
    );
  }
}
