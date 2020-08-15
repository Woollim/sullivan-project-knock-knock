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

  void reload() {
    Storage.getKnockData().then((data) {
      setState(() => this.history = data);
    });
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
      body: ListView.builder(
          itemCount: history.length,
          itemBuilder: (_, index) => cardWidget(history[index])
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => KnockPage())
        ),
      ),
    );
  }

  Widget cardWidget(KnockData data) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              stateText(data.state),
              SizedBox(height: 10),
              Text("${toDateString(data.date)}"),
              Text("${toTimeString(data.startTime)} ~ ${toTimeString(data.endTime)}"),
              SizedBox(height: 10),
              Text(data.message),
            ]
        ),
      ),
    );
  }

  Widget stateText(KnockState state) {
    switch(state) {
      case KnockState.noise:
        return Text("[양해요청] 조금 시끄럽게 할께요");
      case KnockState.quiet:
        return Text("[자제요청] 조금 조용히 해주세요");
    }
  }
}
