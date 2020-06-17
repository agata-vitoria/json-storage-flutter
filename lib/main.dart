import 'dart:async';
import 'package:flutter/material.dart';
import 'my-storage.dart';
import 'package:save_dados/teste.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'File Manager',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MyStorage _myStorage = new MyStorage();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final hobbyController = TextEditingController();

  String textRead = '';
  String idade = '';
  String hobby = '';

  List teste = new List();

  Future<void> _saveToFile(String json) async {
    await _myStorage.writeContent(json);
    // testeAaaa();
  }

  void testeAaaa() {
    Future getSettings = _myStorage.readContent();
    String a = '[{"name" : "Agata", "age" : 20, "hobby" : "Programacao"}, {"name" : "Teste", "age" : 20, "hobby" : "Programacao"}]';
    var teste = Teste.fromJson(jsonDecode(a));
    print(teste);
    getSettings.then((data) {
      if (data != null) {
        // print(data);
        // var jsonData = Teste.fromJson(jsonDecode(data));
        // print(jsonData.age);
        // Map<String, dynamic> jsonData = json.decode(data);
        // print(jsonData);
        // setState(() {
        //   textRead = jsonData['name'];
        //   idade = jsonData['age'].toString();
        //   hobby = jsonData['hobby'];
        // });
      }
    });
  }


  _saveJson() {
    Teste _teste = new Teste();
    _teste.name = nameController.text;
    _teste.age = int.parse(ageController.text); //mudar pra int
    _teste.hobby = hobbyController.text;
    String json = '{"name" : "Agata", "age" : 20, "hobby" : "Programacao"}';
    print(json);
    // String teste = '${_teste.toJson()}';
    return json;
  }

  @override
  void initState() {
    super.initState();
    testeAaaa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('File Manager')),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter name'),
                    controller: nameController,
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter age'),
                    controller: ageController,
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter hobby'),
                    controller: hobbyController,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          onPressed: () async {
                            String resul = _saveJson();
                            _saveToFile(resul);
                          },
                          child: Text('Save'),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: RaisedButton(
                          onPressed: () async => testeAaaa(),
                          child: Text('Read'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.data_usage),
              title: Text('$textRead | $idade anos'),
              subtitle: Text('$hobby'),
            ),
          ),
        ],
      ),
    );
  }
}
