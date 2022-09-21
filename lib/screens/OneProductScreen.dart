import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_list_provider.dart';
import '../providers/product_model_provider.dart';

class OneProductScreen extends StatelessWidget {
  static const String routeName = '/OneProductScreen';
  Widget build(BuildContext context) {
    String idFromRoute = ModalRoute.of(context)!.settings.arguments as String;
    var providedList = Provider.of<ProductList>(context);
    Product product = providedList.fetchProductById(idFromRoute);
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Column(
        children: [
          Image(
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height * (2 / 4),
              width: double.infinity),
          SizedBox(height: 20),
          Text(
            "Rs ${product.price}",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 20),
          Text(
            product.description,
            textAlign: TextAlign.center,
            style:TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
