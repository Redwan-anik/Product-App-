import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final String TABLE_PRODUCT = 'tbl_product';
final String COL_PRODUCT_ID = 'product_id';
final String COL_PRODUCT_NAME = 'product_name';
final String COL_PRODUCT_CATEGORY= 'product_category';
final String COL_PRODUCT_DESCRIPTION = 'product_description';
final String COL_PRODUCT_PRICE = 'product_price';
final String COL_PRODUCT_FAV= 'product_fav';
final String COL_PRODUCT_FORMATTED_DATE= 'product_formatted_date';
final String COL_PRODUCT_TIMESTAMP = 'product_timestamp';
final String COL_PRODUCT_MONTH = 'product_month';
final String COL_PRODUCT_YEAR = 'product_year';
final String COL_PRODUCT_RATING = 'product_rating';
final String COL_PRODUCT_IMAGE = 'product_image';

class Product{
  int id;
  String name;
  String category;
  String description;
  double price;
  bool isFavorite;
  String formattedDate;
  int uploadedMonth;
  int uploadedYear;
  int timeStamp;
  double rating;
  String image;

  Map<String, dynamic> toMap(){
    var map = <String,dynamic>{
      COL_PRODUCT_NAME : name,
      COL_PRODUCT_CATEGORY:category,
      COL_PRODUCT_DESCRIPTION:description,
      COL_PRODUCT_PRICE:price,
      COL_PRODUCT_RATING:rating,
      COL_PRODUCT_FORMATTED_DATE: formattedDate,
      COL_PRODUCT_TIMESTAMP: timeStamp,
      COL_PRODUCT_MONTH:uploadedMonth,
      COL_PRODUCT_YEAR:uploadedYear,
      COL_PRODUCT_IMAGE:image,
      COL_PRODUCT_FAV: isFavorite ? 1 : 0,

    };
    if(id != null ){
      map[COL_PRODUCT_ID] = id;
    }return map;
  }
Product.fromMap(Map<String,dynamic>map){
    id= map[COL_PRODUCT_ID];
    name =map[COL_PRODUCT_NAME];
    category=map[COL_PRODUCT_CATEGORY];
    description=map[COL_PRODUCT_DESCRIPTION];
    price=map[COL_PRODUCT_PRICE];
    image=map[COL_PRODUCT_IMAGE];
    formattedDate=map[COL_PRODUCT_FORMATTED_DATE];
    timeStamp=map[COL_PRODUCT_TIMESTAMP];
    uploadedMonth=map[COL_PRODUCT_MONTH];
    uploadedYear=map[COL_PRODUCT_YEAR];
    rating=map[COL_PRODUCT_RATING];
    isFavorite=map[COL_PRODUCT_ID] == 1 ? true : false ;


}
  Product(
  {
      this.id,
      @required this.name,

      @required this.category,
      this.description,
      @required this.price  ,
      this.isFavorite = false,
      this.formattedDate,
      this.rating = 0.0,
      this.image,

});

  @override
  String toString() {
    return 'Product{id: $id, name: $name, category: $category, description: $description, price: $price, favourite: $isFavorite, formattedDate: $formattedDate, uploadedMonth: $uploadedMonth, uploadedYear: $uploadedYear, timeStamp: $timeStamp, rating: $rating, image: $image}';
  }
}
