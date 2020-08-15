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
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  RadioListTile(
                    value: KnockState.quiet,
                    groupValue: state,
                    title: Text("자제요청"),
                    subtitle: Text("이 시간에는 조용히 해주세요"),
                    onChanged: (state) {
                      setState(() => this.state = state);
                    },
                  ),
                  RadioListTile(
                    value: KnockState.noise,
                    groupValue: state,
                    title: Text("양해요청"),
                    subtitle: Text("이 시간은 조금 시끄러울 것 같아요"),
                    onChanged: (state) {
                      setState(() => this.state = state);
                    },
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: dateWidget(context)
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      minLines: 10,
                      maxLines: 15,
                      decoration: InputDecoration(
                        hintText: "여기에 사유를 입력해주세요",
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      ),
                      onChanged: (message) {
                        setState(() => this.message = message);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            color: Colors.blue,
            child: FlatButton(
              child: Text("요청하기"),
              textColor: Colors.white,
              onPressed: () => send(),
            ),
          )
        ],
      ),
    );
  }

  Widget dateWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RaisedButton(
          child: Text(date == null ? "날짜를 선택해주세요" : toDateString(date)),
          onPressed: () {
            var now = DateTime.now();
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(now.year + 1)
            ).then((date) => {
                setState(() => this.date = date)
            });
          },
        ),
        Row(children: <Widget>[
          RaisedButton(
            child: Text(startTime == null ? "시작 시간을 선택해주세요" : toTimeString(startTime)),
            onPressed: () {
              showTimePicker(
                context: context,
                initialTime: TimeOfDay.now()
              ).then((time) => {
                  setState(() => this.startTime = time)
              });
            },
          ),
          Container(width: 20),
          RaisedButton(
            child: Text(endTime == null ? "종료 시간을 선택해주세요" : toTimeString(endTime)),
            onPressed: () {
              showTimePicker(
                context: context,
                initialTime: TimeOfDay.now()
              ).then((time) => {
                  setState(() => this.endTime = time)
              });
            },
          ),
        ])
      ],
    );
  }

  void send() {
    if(state != null && date != null && startTime != null && endTime != null && message != null) {
      var data = KnockData(date: date, state: state, startTime: startTime, endTime: endTime, message: message);
      Storage.sendKnockData(data);
      Navigator.of(context).pop();
    }
  }
}
