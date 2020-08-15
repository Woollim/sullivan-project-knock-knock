import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Address extends Equatable {
  String primaryAddress;
  // 동
  int dong;
  // 호
  int ho;

  Address({this.primaryAddress, this.dong, this.ho});

  @override
  List<Object> get props => [this.primaryAddress, this.dong, this.ho];

  Map<String, dynamic> toMap() => {
    "primaryAddress": primaryAddress,
    "dong": dong,
    "ho": ho,
  };

  static Address fromMap(Map map) => Address(
      primaryAddress: map["primaryAddress"],
      dong: map["dong"],
      ho: map["ho"],
  );
}

void storeAddress(Address address) async {
  var pref = await SharedPreferences.getInstance();
  pref.setString("primaryAddress", address.primaryAddress);
  pref.setInt("dong", address.dong);
  pref.setInt("ho", address.ho);
}

Future<Address> getAddress() async {
  var pref = await SharedPreferences.getInstance();
  var primary = pref.get("primaryAddress");
  var dong = pref.get("dong");
  var ho = pref.get("ho");
  if(primary != null && dong != null && ho != null) {
    return Address(primaryAddress: primary, dong: dong, ho: ho);
  } else {
    return null;
  }
}