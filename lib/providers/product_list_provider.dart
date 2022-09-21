import 'package:flutter/material.dart';
import './product_model_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
class ProductList with ChangeNotifier {
  List<Product> dummyProducts = [];
  String? authToken;
  String? userId;
  ProductList(this.authToken,this.userId, this.dummyProducts);
  List<Product> getProducts() {
    return [...dummyProducts];
  }

  Product fetchProductById(String id) {
    return dummyProducts.firstWhere((iterable) {
      if (iterable.id == id) {
        return true;
      } else
        return false;
    });
  }

  List<Product> getFavProducts() {
    return dummyProducts.where((iterableProduct) {
      print(iterableProduct.isFav);
      return iterableProduct.isFav;
    }).toList();
  }

  Future<void> fetchAndSetProducts(bool filterByUser) async {
    final filterStringSegment=filterByUser?'orderBy="userId"&equalTo="$userId"':'';
    try {
      var url = Uri.parse(
          "https://shopapp-457b8-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterStringSegment");
      final response = await http.get(url);
      var data = json.decode(response.body) as Map<String, dynamic>;
      if(data==null){
        return;
      }
      url=Uri.parse("https://shopapp-457b8-default-rtdb.firebaseio.com/favouriteProducts/$userId.json?auth=$authToken");
      final favouriteResponse=await http.get(url);
      var favouriteData=json.decode(favouriteResponse.body);
      final List<Product> loadedProducts = [];
      data.forEach((String id, dynamic productData) {
        loadedProducts.add(new Product(
            description: productData['description'],
            id: id,
            imageUrl: productData['imageUrl'],
            price:productData['price'],
            title: productData['title'],
            isFav:favouriteData==null?false:favouriteData[id] ?? false ));
      },);
      dummyProducts=loadedProducts;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addProducts(Map<String, dynamic> P) async {
    //database part
    try {
      final url = Uri.parse(
          "https://shopapp-457b8-default-rtdb.firebaseio.com/products.json?auth=$authToken");
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': P['title'],
            'description': P['description'],
            'price': P['price'],
            'imageUrl': P['imageUrl'],
            'userId': userId,
          },
        ),
      );
      dummyProducts.add(new Product(
          description: P['description'],
          id: json.decode(response.body)['name'],
          imageUrl: P['imageUrl'],
          price: P['price'],
          title: P['title'],
          isFav: false));
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }
  Future<void> updateProducts(Map<String, dynamic> P) async{
    final url=Uri.parse("https://shopapp-457b8-default-rtdb.firebaseio.com/products/${P['id']}.json?auth=$authToken");
    final index = dummyProducts.indexWhere((element) => element.id == P['id']);
            Product thisP=new Product(
            description: P['description'],
            id: P['id'],
            imageUrl: P['imageUrl'],
            price: P['price'],
            title: P['title'],
            isFav: P['isFav']);
        await http.patch(url,body:json.encode({
          'title':thisP.title,
          'imageUrl':thisP.imageUrl,
          'description':thisP.description,
          'price':thisP.price,
        }));
        dummyProducts[index] = thisP; 
  }
  Future<void> removeProduct(String id) async{
    final url=Uri.parse("https://shopapp-457b8-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken");
    int index=dummyProducts.indexWhere((product){
      return product.id==id;
    });
    Product backup=dummyProducts[index];
    dummyProducts.remove(backup);
    notifyListeners();
    final response= await http.delete(url);
    print(response.statusCode);
    if(response.statusCode>=400){
      dummyProducts.insert(index, backup);
      notifyListeners();
      throw HttpException('this product could not be deleted');
    }
  }
}
