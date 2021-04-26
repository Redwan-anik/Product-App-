import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_product_app/models/product_model.dart';
import 'package:flutter_product_app/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductGridItem extends StatefulWidget {
  final Product product;
  final Function deleteCallback;
  ProductGridItem(this.product, this.deleteCallback);

  @override
  _ProductGridItemState createState() => _ProductGridItemState();
}

class _ProductGridItemState extends State<ProductGridItem> {
  ProductProvider provider;
  bool isVisible = false;
  double topPosOfContainer = -115.0;
  double containerOpacity = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    provider = Provider.of(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isVisible = ! isVisible;
          topPosOfContainer = isVisible ? 0 : -115 ;
          containerOpacity  = isVisible ? 1.0 : 0.0 ;
        });
      },
      child: LayoutBuilder(
        builder: (context, contraint) => Card(
          elevation: 5,
          color: Colors.amber,
          child: Stack(
            children: [
              Column(
                children: [
                  Flexible(flex: 6, child: Image.file(File(widget.product.image),width: double.infinity, fit: BoxFit.cover,)),
                  Spacer(),
                  Flexible(child: Text(widget.product.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),)),
                  Flexible(child: Text('BDT ${widget.product.price}',style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),)),
                ],
              ),
               AnimatedPositioned(
                  duration: const Duration(milliseconds: 300) ,
                  top: topPosOfContainer,
                  child: AnimatedOpacity(
                    opacity: containerOpacity,
                    duration: const Duration(milliseconds: 300) ,
                    child: Container(
                      width:  contraint.maxWidth,

                      color: Colors.black.withOpacity(0.5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FlatButton(onPressed: () {}, child: Text('Details'),textColor: Colors.white,),
                          Divider(color: Colors.white,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              IconButton(icon: Icon(Icons.shopping_cart_sharp, color: Colors.white,), onPressed: () {}),
                              IconButton(icon: Icon(Icons.favorite, color: Colors.white,), onPressed: () {}),
                              IconButton(icon: Icon(Icons.delete, color: Colors.white,), onPressed: () {
                                showDialog(context: context,
                                builder:(context) => AlertDialog(
                                  title: Text('Delete ${widget.product.name}?'),
                                  content: Text('Are you sure to delete this item ?'),
                                  actions: [
                                    FlatButton(onPressed: () => Navigator.pop(context), child: Text('cancel')
                                    ),
                                    RaisedButton(
                                      color: Theme.of(context).primaryColor,
                                        textColor: Colors.white,
                                        onPressed: () {
                                         widget.deleteCallback(widget.product.id);
                                          Navigator.pop(context);
                                        },
                                        child: Text('Delete')),
                                  ],
                                )
                                );
                              }),
                            ],

                          ),
                        ],
                      ),
                    ),
                  ),
                ),


            ],
          ),
        ),
      ),
    );
  }

}
