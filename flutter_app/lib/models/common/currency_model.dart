class CurrencyModel {
  int? id;
  String? name;
  String? code;
  String? symbol;

  CurrencyModel({this.id, this.name, this.code, this.symbol});

  CurrencyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['symbol'] = symbol;
    return data;
  }
}
