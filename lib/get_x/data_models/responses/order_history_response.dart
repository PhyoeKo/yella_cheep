
class OrderHistoryResponse {
  int? id;
  String? name;
  String? shopName;
  String? phone;
  int? price;
  int? discountPrice;
  int? discount;
  int? status;
  String? orderDate;

  OrderHistoryResponse({
      this.id, 
      this.name, 
      this.phone, 
      this.shopName,
      this.price,
      this.discountPrice, 
      this.discount, 
      this.status, 
      this.orderDate});

  OrderHistoryResponse.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    name = json["shopName"];
    phone = json["phone"];
    price = json["price"];
    discountPrice = json["discountPrice"];
    discount = json["discount"];
    status = json["status"];
    orderDate = json["orderDate"];
  }


}