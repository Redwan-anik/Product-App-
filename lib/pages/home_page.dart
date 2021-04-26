import 'package:flutter/material.dart';
import 'package:flutter_product_app/models/product_model.dart';
import 'package:flutter_product_app/pages/new_product_page.dart';
import 'package:flutter_product_app/provider/product_provider.dart';
import 'package:flutter_product_app/widgets/product_grid_item.dart';
import 'package:provider/provider.dart';
class HomePage extends StatefulWidget {
  static final routeName ='/';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductProvider provider;

  @override
  void initState() {
    provider = Provider.of(context, listen: false);
    provider.fetchAllProducts();
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  _deleteProduct( int id) {
    provider.removeProduct(id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) =>
            GridView.count(
              childAspectRatio: .80,
          crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            children: provider.productList.map((product) => ProductGridItem(product, _deleteProduct)).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, NewProductPage.routeName),
        child: Icon(Icons.add),
      ),
    );
  }
}
