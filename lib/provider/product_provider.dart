import 'package:flutter/cupertino.dart';
import 'package:flutter_product_app/db/db_helper.dart';
import 'package:flutter_product_app/models/product_model.dart';

class ProductProvider extends ChangeNotifier{
 List<Product> _products = [];
 List<Product> get productList => _products;

  void addProduct(Product product){
      DBSQLiteHelper.insertNewProduct(product).then((_) {
        _products.add(product);
        notifyListeners();
      });
}
    void fetchAllProducts() {
    DBSQLiteHelper.getAllProducts().then((mapList) {
      _products =mapList.map((m) => Product.fromMap(m)).toList();
      notifyListeners();
    });
    }
    void removeProduct(int id) {
     DBSQLiteHelper.deleteProduct(id).then((value) {
       _products.removeWhere((product) => product.id == id);
        notifyListeners();
     });
    }
}