
class ProductModel {

  String productId;
  String productName;
  String productImage;
  int productPrice;
  String productCategory;
  List<dynamic> productUnit;

  ProductModel({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productCategory,
    required this.productUnit
  });
  
}