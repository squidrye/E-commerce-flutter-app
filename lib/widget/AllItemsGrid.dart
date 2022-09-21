import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_list_provider.dart';
import 'EachItemInGrid.dart';

class AllItemsGrid extends StatelessWidget {
  final _showOnlyFavs;

  AllItemsGrid(this._showOnlyFavs);

  Widget build(BuildContext context) {
    var listClassInstance = Provider.of<ProductList>(context);
    var providedList = _showOnlyFavs?listClassInstance.getFavProducts():listClassInstance.getProducts();
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
              value: providedList[index],
              child: EachItemInGrid());
        });
  }
}
