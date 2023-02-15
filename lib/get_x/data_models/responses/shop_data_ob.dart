class ShopDataOb {
  ShopDataOb({
    this.weakData,
    this.monthData,
    this.yearData,
    this.countData,});

  ShopDataOb.fromJson(dynamic json) {
    weakData =
    json['weakData'] != null ? WeakData.fromJson(json['weakData']) : null;
    monthData =
    json['monthData'] != null ? MonthData.fromJson(json['monthData']) : null;
    yearData =
    json['yearData'] != null ? YearData.fromJson(json['yearData']) : null;
    countData =
    json['countData'] != null ? CountData.fromJson(json['countData']) : null;
  }

  WeakData? weakData;
  MonthData? monthData;
  YearData? yearData;
  CountData? countData;

}

class CountData {
  CountData({
    this.pending,
    this.confirm,
    this.completed,
    this.reject,
    this.totalOrder, this.totalProduct, this.todayOrder, this.todaySale,
    this.cancel});

  CountData.fromJson(dynamic json) {
    pending = json['pending'];
    confirm = json['confirm'];
    completed = json['completed'];
    reject = json['reject'];
    cancel = json['cancel'];
    totalOrder = int.parse(json['totalOrder'].toString());
    totalProduct = json['totalProduct'];
    todaySale = double.parse(json['todaySale'].toString());
    todayOrder = json['todayOrder'];

  }

  int? pending;
  int? confirm;
  int? completed;
  int? reject;
  int? cancel;
  int? totalProduct;
  int? totalOrder;
  double? todaySale;
  int? todayOrder;


}

class YearData {
  YearData({
    this.yearList,
    this.countList,});

  YearData.fromJson(dynamic json) {
    yearList = json['yearList'] != null ? json['yearList'].cast<String>() : [];
    countList = json['countList'] != null ? json['countList'].cast<int>() : [];
  }

  List<String>? yearList;
  List<int>? countList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['yearList'] = yearList;
    map['countList'] = countList;
    return map;
  }

}

class MonthData {
  MonthData({
    this.monthList,
    this.countList,});

  MonthData.fromJson(dynamic json) {
    monthList =
    json['monthList'] != null ? json['monthList'].cast<String>() : [];
    countList = json['countList'] != null ? json['countList'].cast<int>() : [];
  }

  List<String>? monthList;
  List<int>? countList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['monthList'] = monthList;
    map['countList'] = countList;
    return map;
  }

}

class WeakData {
  WeakData({
    this.dayList,
    this.countList,});

  WeakData.fromJson(dynamic json) {
    dayList = json['dayList'] != null ? json['dayList'].cast<String>() : [];
    countList = json['countList'] != null ? json['countList'].cast<int>() : [];
  }

  List<String>? dayList;
  List<int>? countList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dayList'] = dayList;
    map['countList'] = countList;
    return map;
  }

}