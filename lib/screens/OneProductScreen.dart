import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_list_provider.dart';
import '../providers/product_model_provider.dart';
class OneProductScreen extends StatelessWidget {
  static const String routeName = '/OneProductScreen';
  Widget build(BuildContext context) {

  String idFromRoute=ModalRoute.of(context)!.settings.arguments as String;
    var providedList = Provider.of<ProductList>(context);
    Product product=providedList.fetchProductById(idFromRoute);
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
    );
  }
}
