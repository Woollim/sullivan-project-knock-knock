import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_knock_knock_app/Storage.dart';
import 'KnockData.dart';

class KnockPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => KnockPageState();
}

class KnockPageState extends State<StatefulWidget> {
  KnockState state;
  DateTime date;
  TimeOfDay startTime;
  TimeOfDay endTime;
  String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("요청하기")),
      body: throw UnimplementedError()
    );
  }
}
