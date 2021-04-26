import 'package:flutter/material.dart';
import 'package:flutter_product_app/pages/home_page.dart';
import 'package:flutter_product_app/pages/new_product_page.dart';
import 'package:flutter_product_app/pages/product_details_page.dart';
import 'package:flutter_product_app/provider/product_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      routes: {
         // HomePage.routeName:(context) =>HomePage(),
          NewProductPage.routeName:(context) =>NewProductPage(),
          ProductDetailsPage.routeName:(context) =>ProductDetailsPage(),
      },

      ),
    );
  }
}
