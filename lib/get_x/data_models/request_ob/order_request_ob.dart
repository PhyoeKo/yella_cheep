class OrderRequestOb {
  int? orderDetailId;
  String? status;

  OrderRequestOb({this.orderDetailId, this.status});

  OrderRequestOb.fromJson(Map<String, dynamic> json) {
    orderDetailId = json['orderDetailId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderDetailId'] = this.orderDetailId;
    data['status'] = this.status;
    return data;
  }
}