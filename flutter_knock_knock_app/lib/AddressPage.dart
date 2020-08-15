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
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(labelText: "주소를 입력해주세요"),
              onChanged: (text) {
                this.primaryAddress = text;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(labelText: "동을 입력해주세요 (동이 없다면 0을 입력)"),
              keyboardType: TextInputType.number,
              onChanged: (text) {
                this.dong = int.parse(text);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(labelText: "호수를 입력해주세요"),
              keyboardType: TextInputType.number,
              onChanged: (text) {
                this.ho = int.parse(text);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigate_next),
        onPressed: () {
          if(primaryAddress != null && dong != null && ho != null) {
            var address = Address(primaryAddress: primaryAddress, dong: dong, ho: ho);
            storeAddress(address);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => HistoryPage())
            );
          }
        },
      )
    );
  }
}
