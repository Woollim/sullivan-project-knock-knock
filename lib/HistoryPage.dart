import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_knock_knock_app/KnockData.dart';
import 'package:flutter_knock_knock_app/KnockPage.dart';
import 'package:flutter_knock_knock_app/Storage.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HistoryPageState();
}

class HistoryPageState extends State<StatefulWidget> {
  List<KnockData> history = [];

  @override
  void initState() {
    super.initState();
    reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("오늘 받은 똑똑요청"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: reload)
        ],
      ),
      body: throw UnimplementedError(),
      floatingActionButton: throw UnimplementedError(),
    );
  }

  void reload() {
    Storage.getKnockData().then((data) {
      setState(() => this.history = data);
    });
  }
}
