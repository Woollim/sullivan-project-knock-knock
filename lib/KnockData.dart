import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KnockData {
  KnockState state;
  DateTime date;
  TimeOfDay startTime;
  TimeOfDay endTime;
  String message;

  String fromAddress, toAddress;

  KnockData({this.message, this.state, this.date, this.startTime, this.endTime});
}

enum KnockState {
  quiet, noise
}