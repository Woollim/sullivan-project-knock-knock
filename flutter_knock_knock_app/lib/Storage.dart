import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_knock_knock_app/Address.dart';
import 'package:flutter_knock_knock_app/AddressPage.dart';
import 'package:intl/intl.dart';

import 'KnockData.dart';

class Storage {
  static void sendKnockData(KnockData data) async {
    var address = await getAddress();
    var toAddress = Address(primaryAddress: address.primaryAddress, dong: address.dong, ho: address.ho - 1);

    Firestore.instance.collection("knock").document().setData({
      "state": toStateInt(data.state),
      "date": toDateString(data.date),
      "startTime": toTimeString(data.startTime),
      "endTime": toTimeString(data.endTime),
      "message": data.message,
      "fromAddress": address.toMap(),
      "toAddress": toAddress.toMap(),
    });
  }

  static Future<List<KnockData>> getKnockData() async {
    var address = await getAddress();

    return Firestore.instance.collection("knock").snapshots()
        .map((snapshots) {
          var list = List<KnockData>();
          for(var snapshot in snapshots.documents) {
            var toAddress = Address.fromMap(snapshot.data["toAddress"]);
            if(address != toAddress) {
              continue;
            }
            var data = KnockData(
              state: toState(snapshot.data["state"]),
              date: toDate(snapshot.data["date"]),
              startTime: toTime(snapshot.data["startTime"]),
              endTime: toTime(snapshot.data["endTime"]),
              message: snapshot.data["message"],
            );
            list.add(data);
          }
          return list;
        })
        .first;
  }
}

String toTimeString(TimeOfDay time) {
  var now = DateTime.now();
  var date = DateTime(now.year, now.month, now.day, time.hour, time.minute);
  var format = DateFormat("HH:mm");
  return format.format(date);
}

TimeOfDay toTime(String string) {
  var format = DateFormat("HH:mm");
  var date = format.parse(string);
  return TimeOfDay(hour: date.hour, minute: date.minute);
}

String toDateString(DateTime date) {
  DateFormat format = DateFormat("yyyy년 MM월 dd일");
  return format.format(date);
}

DateTime toDate(String string) {
  DateFormat format = DateFormat("yyyy년 MM월 dd일");
  return format.parse(string);
}

int toStateInt(KnockState state) {
  switch(state) {
    case KnockState.noise:
      return 0;
    case KnockState.quiet:
      return 1;
  }
}

KnockState toState(int state) {
  switch(state) {
    case 0:
      return KnockState.noise;
    case 1:
      return KnockState.quiet;
  }
}