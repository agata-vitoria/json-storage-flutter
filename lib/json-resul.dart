import 'info.dart';

class JsonResul {
  List<Info> info;

  JsonResul({this.info});

  JsonResul.fromJson(Map<String, dynamic> json) {
    if (json['info'] != null) {
      info = new List<Info>();
      json['info'].forEach((v) {
        info.add(new Info.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['"info"'] = this.info.map((v) => v.toJson()).toList();
    }
    return data;
  }
}