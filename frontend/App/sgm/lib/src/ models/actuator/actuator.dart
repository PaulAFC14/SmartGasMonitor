import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

import 'package:sgm/src/%20models/api/api.dart';

class Actuator {
  late int id;
  late String name;
  late int state;
  late int user_id;
  late String updated_at;

  Actuator({
    int? id,
    String? name,
    int? state,
    int? user_id,
    String? updated_at,
  }) {
    this.id = id ?? 0;
    this.name = name ?? '';
    this.state = state ?? 0;
    this.user_id = user_id ?? 0;
    this.updated_at = updated_at ?? '';
  }

  //Getters
  int get getId => id;
  String get getName => name;
  int get getState => state;
  int get getInt => user_id;
  String getUpdatedAt() {
    String date = updated_at.substring(0, 10);
    String hour = updated_at.substring(11, 19);
    return '$date $hour';
  }

  Color getColor(BuildContext context) {
    if (state == 1) {
      return Theme.of(context).primaryColor;
    } else {
      return Theme.of(context).secondaryHeaderColor;
    }
  }

  //Setter

  setState(int state) {
    this.state = state;
  }

  String getStateText() {
    if (state == 0) {
      return 'CERRADO';
    } else {
      return 'ABIERTO';
    }
  }

  String getSActionText() {
    if (state == 0) {
      return 'Abrir';
    } else {
      return 'Cerrar';
    }
  }

  //API
  Future<Actuator> getData() async {
    Actuator actuator = Actuator();

    var headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer 3|LyVKhbTIW1qFOpTsm5zpb8b6T8yRSA9Iaga2FBAT06cf923b'
    };
    var request =
        http.Request('GET', Uri.parse('${Api().getHost()}/api/actuators/1'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> answer =
          json.decode(await response.stream.bytesToString());
      print(answer);
      Map<String, dynamic> item = answer['data'] ?? {};
      actuator = Actuator(
        id: item['id'] ?? 0,
        name: item['name'] ?? '',
        state: item['state'] ?? 0,
        user_id: item['user_id'] ?? 0,
        updated_at: item['updated_at'] ?? '',
      );
    } else {
      print(response.reasonPhrase);
    }

    return actuator;
  }

  Future<bool> check() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer 3|LyVKhbTIW1qFOpTsm5zpb8b6T8yRSA9Iaga2FBAT06cf923b'
    };
    var request = http.Request(
        'GET', Uri.parse('${Api().getHost()}/api/values/check/$id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    return response.statusCode == 200;
  }

  Future<void> changeState(int change) async {
    print(change);
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer 3|LyVKhbTIW1qFOpTsm5zpb8b6T8yRSA9Iaga2FBAT06cf923b'
    };
    var request = http.Request(
        'GET', Uri.parse('${Api().getHost()}/api/actuators/change-status/1'));
    request.body = json.encode({"state": change});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(await response.stream.bytesToString());
    }
  }
}
