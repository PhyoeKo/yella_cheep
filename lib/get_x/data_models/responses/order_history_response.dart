
class OrderHistoryResponse {
  int? id;
  String? name;
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
      this.price, 
      this.discountPrice, 
      this.discount, 
      this.status, 
      this.orderDate});

  OrderHistoryResponse.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    phone = json["phone"];
    price = json["price"];
    discountPrice = json["discountPrice"];
    discount = json["discount"];
    status = json["status"];
    orderDate = json["orderDate"];
  }


}