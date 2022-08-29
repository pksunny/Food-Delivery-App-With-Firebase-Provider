

class ReviewCartModel {

  String cartId;
  String cartName;
  String cartImage;
  int cartPrice;
  String cartCategory;
  int cartQuantity;
  var cartUnit;
  String userid;
  bool isAdd;

  ReviewCartModel({
    required this.cartId,
    required this.cartName,
    required this.cartImage,
    required this.cartPrice,
    required this.cartCategory,
    required this.cartQuantity,
    required this.cartUnit,
    required this.userid,
    required this.isAdd,
  });
  
}