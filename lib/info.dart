class Info {
  String name;
  int age;
  String hobby;

  Info({this.name, this.age, this.hobby});

  Info.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    hobby = json['hobby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['"name"'] = '"${this.name}"';
    data['"age"'] = this.age;
    data['"hobby"'] = '"${this.hobby}"';
    return data;
  }
}
