import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_knock_knock_app/HistoryPage.dart';
import 'package:flutter_knock_knock_app/KnockData.dart';

import 'Address.dart';

class AddressPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddressPageState();
}

class AddressPageState extends State<StatefulWidget> {
  String primaryAddress;
  int dong;
  int ho;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("살고계신 주소를 입력해주세요")
      ),
      body: throw UnimplementedError(),
      floatingActionButton: throw UnimplementedError()
    );
  }
}
