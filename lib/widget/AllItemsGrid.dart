import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_list_provider.dart';
import 'EachItemInGrid.dart';
import '../providers/product_model_provider.dart';

class AllItemsGrid extends StatelessWidget {
  Widget build(BuildContext context) {
    var listClassInstance = Provider.of<ProductList>(context);
    var providedList = listClassInstance.getProducts();
    return GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2 / 3,
        ),
        itemCount: providedList.length,
        itemBuilder: (BuildContext ctx, int index) {
          return ChangeNotifierProvider.value(
              value: Product(
                  id: providedList[index].id,
                  title: providedList[index].title,
                  description: providedList[index].description,
                  imageUrl: providedList[index].imageUrl,
                  price: providedList[index].price,
                  isFav: providedList[index].isFav),
              child: EachItemInGrid());
        });
  }
}
