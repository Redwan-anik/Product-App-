import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_product_app/db/db_helper.dart';
import 'package:flutter_product_app/models/product_model.dart';
import 'package:flutter_product_app/provider/product_provider.dart';
import 'package:flutter_product_app/utils/product_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
class NewProductPage extends StatefulWidget {
  static final routeName ='/new_product';
  @override
  _NewProductPageState createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  final _formKey = GlobalKey<FormState>();
  var product = Product();
  DateTime _selectedDate;
  String _imagePath;
  bool fromCamera =true;
  String category = null;
  _takePhoto(){
    ImagePicker()
        .getImage(source: fromCamera ?
        ImageSource.camera :
        ImageSource.gallery)
        .then((pickedFile) {
          setState(() {
            _imagePath = pickedFile.path;
            print(_imagePath);
          });
          product.image =_imagePath;
    });



  }
  _openCalendar(){
    var dt = DateTime.now();
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime.now(),
    ).then((dateTime) {
      setState(() {
        _selectedDate =dateTime;
      });
      product.formattedDate = DateFormat('dd/MM/yy').format(_selectedDate);
      product.timeStamp = _selectedDate.millisecondsSinceEpoch;
      product.uploadedMonth =_selectedDate.month;
      product.uploadedYear =_selectedDate.year;
    } );
  }
  _saveproduct(){
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      if(_selectedDate==null) return;
      if(_imagePath==null) return;
      if(category== null)return;
      //Save product to database
      Provider
          .of<ProductProvider>(context, listen:false)
          .addProduct(product);
      Navigator.pop(context);
      print(product);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Product Name'
                ),
                validator: (value){
                  if (value.length<2){
                    return 'Product name can not be empty';
                  }
                  if (value.isEmpty){
                    return 'Product name can not be empty';
                  }
                  return null;
                },
                  onSaved: (value){
                  product.name =value;

                  },
              ),//product_name
              SizedBox(height: 10),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(

                    border: OutlineInputBorder(),
                    labelText: 'Enter Product Description Between 3 line'

                ),
                validator: (value){
                  return null;
                },
                onSaved: (value){
                  product.description =value;

                },
              ),//Description
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Product price'
                ),
                validator: (value){
                  if (value.isEmpty){
                    return 'price name can not be empty';
                  }
                  if (double.parse(value) <=0.0){
                    return 'provide a valid price';
                  }
                  return null;
                },
                onSaved: (value){
                  product.price= double.parse(value);

                },
              ),//price
              SizedBox(height: 20),
              Text('Select Purchase Date'),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(_selectedDate == null ? 'No Date Choosen' : '${product.formattedDate}'),
                      FlatButton(onPressed:_openCalendar, child: Text('Select Date'))
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                  child: Center(
                    child: Column(
                      children: [
                        Text('Select category'),
                        DropdownButton(
                          value:category ,
                            items: categorylist.map((item) =>
                                DropdownMenuItem(
                                    value: item,
                                    child: Text(item)
                                )
                            ).toList(),

                            onChanged: (value){
                            setState(() {
                              category = value;
                            });
                            product.category =category;

                            }

                        )
                      ],
                    ),
                  ),

              ),

              Card(
                elevation: 5,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Choose image'),
                    ),
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Card(
                        elevation: 5,
                        child:_imagePath ==null ?
                        Image.asset('images/img.jpg') :
                        Image.file(File(_imagePath)) ,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                            textColor: Colors.white,
                            child: Text('Capture image'),
                            onPressed:(){
                              setState(() {
                                fromCamera = true;
                              });
                              _takePhoto();
                            },
                            color: Theme.of(context).primaryColor,

                          ),
                          RaisedButton(
                            textColor: Colors.white,
                            child: Text('Select From gallery'),
                            onPressed:() {
                              setState(() {
                                fromCamera = false;
                              });
                              _takePhoto();
                            },
                            color: Theme.of(context).primaryColorDark,

                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  onPressed: _saveproduct,
                  child: Text('Save'),
               ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
