class Teste {
  String name;
  int age;
  String hobby;

  Teste({this.name, this.age, this.hobby});

  Teste.fromJson(Map<String, dynamic> json) {
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
