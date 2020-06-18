import 'dart:async';
import 'package:flutter/material.dart';
import 'package:save_dados/json-resul.dart';
import 'info.dart';
import 'my-storage.dart';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MyStorage _myStorage = new MyStorage();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final hobbyController = TextEditingController();
  List<Info> _listaTeste = new List<Info>();

  Future<void> _saveToFile(String json) async {
    await _myStorage.writeContent(json);
    _lerDados();
  }

  void _lerDados() {
    Future getSettings = _myStorage.readContent();
    getSettings.then((data) {
      if (data != null) {
        var resulJson = JsonResul.fromJson(jsonDecode(data));
        setState(() {
          _listaTeste.clear();
          resulJson.info.forEach((f) {
            _listaTeste.add(new Info(
              name: f.name,
              age: f.age,
              hobby: f.hobby,
            ));
          });
        });
      }
    });
  }

  _salvaNaLista() {
    _listaTeste.add(new Info(
      name: nameController.text,
      age: int.parse(ageController.text),
      hobby: hobbyController.text,
    ));
  }

  _saveJson() {
    JsonResul _jsonResul = new JsonResul();
    _jsonResul.info = _listaTeste;
    String json = '${_jsonResul.toJson()}';

    return json;
  }

  @override
  void initState() {
    super.initState();
    _lerDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('File Manager')),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          _customForm(),
          for (int i = 0; i < _listaTeste.length; i++) _customListUser(i),
        ],
      ),
    );
  }

  Widget _customForm() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: 'Nome'),
              controller: nameController,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Idade'),
              controller: ageController,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Hobby'),
              controller: hobbyController,
            ),
            _customRowButtons(),
          ],
        ),
      ),
    );
  }

  Widget _customRowButtons() {
    return Row(
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            onPressed: () async {
              _salvaNaLista();
              String resul = _saveJson();
              _saveToFile(resul);
            },
            child: Text('Save'),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: RaisedButton(
            onPressed: () async => _lerDados(),
            child: Text('Read'),
          ),
        ),
      ],
    );
  }

  Widget _customListUser(i) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text('${_listaTeste[i].name} | ${_listaTeste[i].age} anos'),
        subtitle: Text('${_listaTeste[i].hobby}'),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            setState(() {
              _listaTeste.remove(_listaTeste[i]);
              String json = _saveJson();
              _saveToFile(json);
            });
          },
        ),
      ),
    );
  }
}
