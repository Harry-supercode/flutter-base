class CheckExistingReq {
  String? field;
  String? value;

  CheckExistingReq({this.field, this.value});

  CheckExistingReq.fromJson(Map<String, dynamic> json) {
    field = json['field'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['field'] = field;
    data['value'] = value;
    return data;
  }
}
