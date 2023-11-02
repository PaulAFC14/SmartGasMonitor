import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

class Sensor {
  //Campos
  late int id;
  late String name;
  late int gas;
  late double temperature;
  late String updated_at;

  //Constructor
  Sensor({
    int? id,
    String? name,
    int? gas,
    double? temperature,
    String? updated_at,
  }) {
    this.id = id ?? 0;
    this.name = name ?? '';
    this.gas = gas ?? 0;
    this.temperature = temperature ?? 0;
    this.updated_at = updated_at ?? '';
  }

  //Getters
  int get getId => id;
  String get getName => name;
  int get getGas => gas;
  double get getTemperature => temperature;
  String getUpdatedAt() {
    String date = updated_at.substring(0, 10);
    String hour = updated_at.substring(11, 19);
    return '$date $hour';
  }

  Color getColor(BuildContext context) {
    if (gas < 31) {
      return Theme.of(context).primaryColor;
    } else if (gas < 61) {
      return Theme.of(context).primaryColorLight;
    } else {
      return Theme.of(context).secondaryHeaderColor;
    }
  }

  //API
  Future<List<Sensor>> getAll() async {
    List<Sensor> sensors = [];

    var headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer 3|LyVKhbTIW1qFOpTsm5zpb8b6T8yRSA9Iaga2FBAT06cf923b'
    };
    var request = http.Request(
        'GET', Uri.parse('http://127.0.0.1:8000/api/sensors/by-user/1'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> answer =
          json.decode(await response.stream.bytesToString());
      print(answer);
      List<dynamic> data = answer['data'] ?? [];
      for (Map<String, dynamic> item in data) {
        print(item);
        Sensor sensor = Sensor(
          id: item['sensor_id'] ?? 0,
          name: item['sensor'] ?? '',
          gas: item['gas'] ?? 0,
          temperature: item['temperature'].toDouble() ?? 0,
          updated_at: item['updated_at'] ?? '',
        );
        sensors.add(sensor);
      }
    } else {
      print(response.reasonPhrase);
    }
    return sensors;
  }

  Future<Sensor> getById($id) async {
    Sensor sensor = Sensor();

    var headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer 3|LyVKhbTIW1qFOpTsm5zpb8b6T8yRSA9Iaga2FBAT06cf923b'
    };
    var request =
        http.Request('GET', Uri.parse('http://127.0.0.1:8000/api/sensors/1'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> answer =
          json.decode(await response.stream.bytesToString());
      print(answer);
      Map<String, dynamic> item = answer['data'] ?? {};
      sensor = Sensor(
        id: item['sensor_id'] ?? 0,
        name: item['sensor'] ?? '',
        gas: item['gas'] ?? 0,
        temperature: item['temperature'].toDouble() ?? 0,
        updated_at: item['updated_at'] ?? '',
      );
    } else {
      print(response.reasonPhrase);
    }

    return sensor;
  }
}
